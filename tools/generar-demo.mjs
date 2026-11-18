// Genera el plano ficticio de la demo: data/lotes.json, data/plano-base.json y data/inventario.json
// node tools/generar-demo.mjs
// Coordenadas en metros (X al este, Y al norte), origen en la esquina suroeste del plano.
// js/config.js (SITIO.plano) dice dónde cae ese origen sobre el mapa real.
import fs from 'node:fs';
import path from 'node:path';

const root = path.resolve(import.meta.dirname, '..');
const VRS_POR_M2 = 1 / 0.698896; // 1 vara² = 0.698896 m²
const r2 = n => Math.round(n * 100) / 100;

// ---------- Trazado ----------
// Calles verticales (de 10 m) entre x = 0–10, 120–130 y 240–250; calles horizontales:
const CALLE_SUR = [28, 38], BULEVAR = [94, 106], CALLE_NORTE = [162, 172];
const ANCHO = 250, ALTO = CALLE_NORTE[1], ENTRADA = 300; // el bulevar sigue al este hasta la calle existente
const COLUMNAS = [[10, 120], [130, 240]]; // franjas de manzanas, oeste y este
const POR_FILA = 9; // lotes por fila en cada manzana (≈12.2 m de frente)

// Filas de lotes: [y0, y1] y la manzana de cada columna
const FILAS = [
  { y: [0, 28], bloques: ['A', 'B'] },
  { y: [38, 66], bloques: ['C', 'D'] },
  { y: [66, 94], bloques: ['C', 'D'] },
  { y: [106, 134], bloques: ['E', 'F'] },
  { y: [134, 162], bloques: ['E', 'F'] },
];
const VERDE = { bloque: 'E', fila: 4, desde: 0, cuantos: 3 }; // tres lotes del noroeste son parque
const LOCALES = { bloque: 'F', fila: 3, desde: 5 }; // los lotes del este frente al bulevar, junto a la entrada

const lotes = [], verdes = [], arboles = [];
const numeros = {};
FILAS.forEach((fila, f) => {
  COLUMNAS.forEach(([x0, x1], c) => {
    const bloque = fila.bloques[c];
    const paso = (x1 - x0) / POR_FILA;
    for (let i = 0; i < POR_FILA; i++) {
      const xa = r2(x0 + i * paso), xb = r2(x0 + (i + 1) * paso);
      const [ya, yb] = fila.y;
      const poligono = [[xa, ya], [xb, ya], [xb, yb], [xa, yb]];
      if (bloque === VERDE.bloque && f === VERDE.fila && i >= VERDE.desde && i < VERDE.desde + VERDE.cuantos) {
        if (i === VERDE.desde) verdes.push([[xa, ya], [r2(x0 + VERDE.cuantos * paso), ya], [r2(x0 + VERDE.cuantos * paso), yb], [xa, yb]]);
        continue;
      }
      const local = bloque === LOCALES.bloque && f === LOCALES.fila && i >= LOCALES.desde;
      const b = local ? 'L' : bloque;
      const numero = (numeros[b] = (numeros[b] || 0) + 1);
      const area = r2((xb - xa) * (yb - ya));
      lotes.push({
        id: `${b}-${numero}`, bloque: b, numero, ...(local ? { tipo: 'local' } : {}),
        area_m2: area, area_vrs2: r2(area * VRS_POR_M2), area_dibujo_m2: area,
        lados_m: [r2(xb - xa), r2(yb - ya), r2(xb - xa), r2(yb - ya)].map(n => Math.round(n * 10) / 10),
        poligono,
      });
    }
  });
});

// Árboles del parque: círculos pequeños
const [[px0, py0], [px1], , [, py1]] = verdes[0];
for (let x = px0 + 4; x < px1 - 2; x += 6) for (let y = py0 + 4; y < py1 - 2; y += 6) {
  const rr = 1.4 + ((x * 7 + y * 3) % 5) / 10;
  arboles.push(Array.from({ length: 13 }, (_, k) => [r2(x + rr * Math.cos(k * Math.PI / 6)), r2(y + rr * Math.sin(k * Math.PI / 6))]));
}

// ---------- Calles ----------
const rect = (x0, y0, x1, y1) => [[x0, y0], [x1, y0], [x1, y1], [x0, y1]];
const superficies = [
  rect(0, 0, 10, ALTO), rect(120, 0, 130, ALTO), rect(240, 0, ANCHO, ALTO), // verticales
  rect(10, CALLE_SUR[0], 240, CALLE_SUR[1]),
  rect(10, BULEVAR[0], 240, BULEVAR[1]), rect(ANCHO, BULEVAR[0], ENTRADA, BULEVAR[1]), // bulevar y entrada
  rect(10, CALLE_NORTE[0], 240, CALLE_NORTE[1]),
];
const mid = ([a, b]) => (a + b) / 2;
const ejes = [
  [[5, 0], [5, ALTO]], [[125, 0], [125, ALTO]], [[245, 0], [245, ALTO]],
  [[0, mid(CALLE_SUR)], [ANCHO, mid(CALLE_SUR)]],
  [[0, mid(BULEVAR)], [ENTRADA, mid(BULEVAR)]],
  [[0, mid(CALLE_NORTE)], [ANCHO, mid(CALLE_NORTE)]],
];
// Bordes de calle: el contorno de cada superficie, sin los tramos que quedan dentro de otra calle
const bordes = [];
// (todas son rectángulos alineados a los ejes: se recorre cada lado cada 0.5 m)
const tapado = ([x, y], propia) => superficies.some(o => o !== propia &&
  x >= o[0][0] - .01 && x <= o[1][0] + .01 && y >= o[0][1] - .01 && y <= o[2][1] + .01);
for (const s of superficies) s.forEach((a, i) => {
  const b = s[(i + 1) % 4], n = Math.round(Math.hypot(b[0] - a[0], b[1] - a[1]) * 2);
  const punto = k => [a[0] + (b[0] - a[0]) * k / n, a[1] + (b[1] - a[1]) * k / n];
  let ini = null;
  for (let k = 0; k <= n; k++) {
    // Un punto del lado es borde si no toca otra calle (en los cruces, el lado se corta)
    const libre = !tapado(punto(k), s);
    if (libre && ini === null) ini = k;
    if ((!libre || k === n) && ini !== null) {
      const fin = libre ? k : k - 1;
      if (fin > ini) bordes.push([punto(ini), punto(fin)].map(q => q.map(r2)));
      ini = null;
    }
  }
});

const plano = {
  lineas: [[[0, 0], [ANCHO, 0], [ANCHO, BULEVAR[0]], [ENTRADA, BULEVAR[0]]], [[ENTRADA, BULEVAR[1]], [ANCHO, BULEVAR[1]], [ANCHO, ALTO], [0, ALTO], [0, 0]]],
  calles: { superficies, ejes, bordes },
  verdes,
  arboles,
  textos: [
    { texto: 'BULEVAR PRINCIPAL', p: [60, mid(BULEVAR)], angulo: 0, alto: 2.4 },
    { texto: 'ENTRADA', p: [275, mid(BULEVAR)], angulo: 0, alto: 2 },
    { texto: 'CALLE 1', p: [65, mid(CALLE_SUR)], angulo: 0, alto: 2 },
    { texto: 'CALLE 2', p: [65, mid(CALLE_NORTE)], angulo: 0, alto: 2 },
    { texto: 'AV. OESTE', p: [5, 60], angulo: 90, alto: 2 },
    { texto: 'AV. CENTRAL', p: [125, 60], angulo: 90, alto: 2 },
    { texto: 'AV. ESTE', p: [245, 60], angulo: 90, alto: 2 },
    { texto: 'ÁREA VERDE', p: [mid([px0, px1]), mid([py0, py1])], angulo: 0, alto: 2.2 },
  ],
};

// ---------- Inventario de ejemplo ----------
// Estados repartidos de forma fija (siempre igual al regenerar): la mayoría disponibles
const DESCRIPCIONES = {
  A: 'Lote plano al sur del proyecto, frente a la Calle 1.',
  B: 'Lote plano al sur del proyecto, frente a la Calle 1.',
  C: 'Lote plano, a pocos metros del bulevar principal.',
  D: 'Lote plano, a pocos metros del bulevar principal.',
  E: 'Lote plano junto al área verde.',
  F: 'Lote plano cerca de la entrada del proyecto.',
  L: 'Local comercial frente al bulevar, en la entrada del proyecto.',
};
// Fotos de ejemplo (fotos/demo/, de Wikimedia Commons; créditos en creditos.html): cada lote lleva tres,
// con una portada distinta según el lote, y los locales empiezan por la calle
const PORTADAS = ['lotes-villa-flora', 'lotes-jardim-eldorado', 'lote-goiania', 'terreno-wukari', 'potrero-honduras', 'arbol-lote'];
const foto = n => `fotos/demo/${n}.jpg`;
const fotosDe = (l, i) => {
  const p = PORTADAS[i % PORTADAS.length], otra = PORTADAS[(i + 2) % PORTADAS.length];
  return (l.tipo === 'local' ? ['calle-lotificacion', p, otra] : [p, otra, 'calle-lotificacion']).map(foto);
};
const inventario = {};
lotes.forEach((l, i) => {
  const h = (i * 37 + l.numero * 11) % 20;
  const estado = h < 3 ? 'vendido' : h < 5 ? 'reservado' : 'disponible';
  inventario[l.id] = {
    estado,
    precio: l.tipo === 'local' ? 650000 : null,
    descripcion: DESCRIPCIONES[l.bloque],
    fotos: fotosDe(l, i),
  };
});

const escribir = (f, d) => fs.writeFileSync(path.join(root, f), JSON.stringify(d, null, 2) + '\n');
escribir('data/lotes.json', lotes);
escribir('data/plano-base.json', plano);
escribir('data/inventario.json', inventario);
const cuenta = s => Object.values(inventario).filter(x => x.estado === s).length;
console.log(`${lotes.length} lotes (${lotes.filter(l => l.tipo === 'local').length} locales): ` +
  `${cuenta('disponible')} disponibles, ${cuenta('reservado')} reservados, ${cuenta('vendido')} vendidos`);
