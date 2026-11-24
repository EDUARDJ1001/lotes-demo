// Genera supabase/seed.sql con todos los lotes del plano (geometría de data/lotes.json + inventario de data/inventario.json)
// node tools/seed-supabase.mjs  →  pegar supabase/seed.sql en el SQL Editor de Supabase
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

const root = path.resolve(import.meta.dirname, '..');
const read = f => JSON.parse(fs.readFileSync(path.join(root, f), 'utf8'));
const lotes = read('data/lotes.json');
const inv = read('data/inventario.json');
// Tarifa por vara² de ejemplo: la de js/config.js
const precioVara = Number(fs.readFileSync(path.join(root, 'js/config.js'), 'utf8').match(/precioVara:\s*([\d.]+)/)[1]);

const q = v => v == null ? 'null' : typeof v === 'number' ? String(v) : `'${String(v).replaceAll("'", "''")}'`;
const arr = a => `array[${a.map(q).join(', ')}]::text[]`;

const filas = lotes.map(l => {
  const i = inv[l.id] || {};
  // Las fotos de data/inventario.json ('fotos/demo/…') son archivos del sitio y se guardan tal cual
  const fotos = i.fotos || [];
  return `  (${[q(l.id), q(l.sector || ''), q(l.bloque), l.numero, l.area_m2, l.area_vrs2,
    q(i.estado || 'disponible'), q(i.precio ?? null), q(i.descripcion || ''), q(i.medidas ?? null), arr(fotos)].join(', ')})`;
});

const sql = `-- Generado por tools/seed-supabase.mjs — carga inicial de los ${lotes.length} lotes.
-- Si un lote ya existe solo se actualizan sus áreas; estado, precio y fotos editados en Supabase se conservan.
insert into public.lotes (id, sector, bloque, numero, area_m2, area_vrs2, estado, precio, descripcion, medidas, fotos) values
${filas.join(',\n')}
on conflict (id) do update set area_m2 = excluded.area_m2, area_vrs2 = excluded.area_vrs2;
`;

fs.writeFileSync(path.join(root, 'supabase/seed.sql'), sql);
console.log(`supabase/seed.sql: ${lotes.length} lotes`);

// ---------- Contabilidad de ejemplo para reiniciar.sql ----------
// Clientes ficticios que compraron los lotes vendidos, con ventas de contado y a cuotas, pagos y gastos.
// Las fechas son relativas al día en que se ejecuta el SQL (current_date), para que los estados (al día, atrasado,
// pagado) se mantengan cada vez que se reinicia la demo.
const uuid = clave => {
  const h = crypto.createHash('md5').update(`lotificacion-demo:${clave}`).digest('hex');
  return `${h.slice(0, 8)}-${h.slice(8, 12)}-4${h.slice(13, 16)}-a${h.slice(17, 20)}-${h.slice(20, 32)}`;
};
const r2 = n => Math.round(n * 100) / 100;
// Día "dia" del mes desplazado "k" meses desde el actual (k negativo = meses atrás)
const mes = (k, dia = 1) => `(date_trunc('month', current_date) + interval '${k} months' + interval '${dia - 1} days')::date`;
const hace = dias => `(current_date - ${dias})`;

const vendidos = lotes.filter(l => inv[l.id]?.estado === 'vendido').map(l => l.id);
const precioDe = id => {
  const l = lotes.find(x => x.id === id);
  return inv[id]?.precio ?? r2(Math.round(l.area_vrs2 * precioVara));
};
// Cada caso: cuántos lotes compra, cómo paga y cuánto lleva pagado
const CASOS = [
  { nombre: 'Ana Martínez', lotes: 2, tipo: 'contado', fecha: hace(400), pagos: 'todo' },
  { nombre: 'Carlos Rivera', lotes: 1, tipo: 'contado', fecha: hace(250), pagos: 'todo' },
  { nombre: 'Lucía Hernández', lotes: 2, tipo: 'cuotas', prima: .2, meses: 36, inicio: -10, pagadas: 11 },
  { nombre: 'José Mejía', lotes: 1, tipo: 'cuotas', prima: .15, meses: 24, inicio: -8, pagadas: 5 },
  { nombre: 'Sofía Castillo', lotes: 2, tipo: 'cuotas', prima: .25, meses: 48, inicio: -3, pagadas: 4 },
  { nombre: 'Miguel Ortega', lotes: 1, tipo: 'cuotas', prima: .3, meses: 12, inicio: -13, pagadas: 12 },
  { nombre: 'Daniela Flores', lotes: 1, tipo: 'contado', fecha: hace(40), pagos: .6 },
  { nombre: 'Roberto Aguilar', lotes: 1, tipo: 'cuotas', prima: .2, meses: 36, inicio: -6, pagadas: 7 },
  { nombre: 'Gabriela Paz', lotes: 1, tipo: 'cuotas', prima: .2, meses: 24, inicio: 1, pagadas: 0 },
];
const FORMAS = ['Transferencia', 'Depósito', 'Efectivo'];
const clientes = [], ventas = [], ventaLotes = [], pagos = [];
let cola = [...vendidos];
CASOS.forEach((c, i) => {
  const ids = cola.splice(0, c.lotes);
  if (!ids.length) return;
  const cid = uuid(`cliente-${i}`), vid = uuid(`venta-${i}`);
  const total = r2(ids.reduce((s, id) => s + precioDe(id), 0));
  clientes.push(`(${q(cid)}, ${q(c.nombre)}, '', '', 'Cliente de ejemplo')`);
  ids.forEach(id => ventaLotes.push(`(${q(id)}, ${q(vid)}, ${inv[id]?.precio ? 'null' : precioVara}, ${precioDe(id)})`));
  const pago = (n, fecha, monto, nota) => pagos.push(`(${q(uuid(`pago-${i}-${n}`))}, ${q(cid)}, ${fecha}, ${r2(monto)}, ${q(FORMAS[(i + n) % FORMAS.length])}, ${q(nota)})`);
  if (c.tipo === 'contado') {
    ventas.push(`(${q(vid)}, ${q(cid)}, ${c.fecha}, 'contado', 0, 0, null, null, '')`);
    pago(0, c.fecha, c.pagos === 'todo' ? total : total * c.pagos, c.pagos === 'todo' ? 'Pago completo' : 'Abono');
  } else {
    const prima = r2(total * c.prima), cuota = r2((total - prima) / c.meses);
    // La prima se paga el día 1 del mes anterior al inicio de las cuotas; cada cuota vence y se paga el día 1 de su mes
    // (así ninguna fecha queda en el futuro, sea cual sea el día en que se reinicie)
    ventas.push(`(${q(vid)}, ${q(cid)}, ${mes(c.inicio - 1)}, 'cuotas', ${prima}, ${c.meses}, null, ${mes(c.inicio)}, '')`);
    if (c.inicio - 1 <= 0) pago(0, mes(c.inicio - 1), prima, 'Prima');
    for (let k = 0; k < c.pagadas; k++) pago(k + 1, mes(c.inicio + k), cuota, `Cuota ${k + 1} de ${c.meses}`);
  }
});
const gastos = [
  ['Levantamiento topográfico', 'Topografía', 45000, -14], ['Diseño del plano de lotificación', 'Planos', 60000, -13],
  ['Permiso municipal de lotificación', 'Trámites', 38000, -12], ['Movimiento de tierra y nivelación', 'Obra', 185000, -11],
  ['Apertura de calles', 'Obra', 120000, -9], ['Rótulo y publicidad en redes', 'Publicidad', 18500, -6],
  ['Comisión de venta', 'Comisiones', 22000, -4], ['Limpieza del terreno', 'Mantenimiento', 9500, -1],
].map(([d, c, m, k], i) => `(${q(uuid(`gasto-${i}`))}, ${mes(k, 15)}, ${q(d)}, ${q(c)}, ${m}, 'Gasto de ejemplo')`);

const contabilidad = `-- Contabilidad de ejemplo (tablas de supabase/contabilidad.sql, si ya existen): ${clientes.length} clientes ficticios
-- que compraron los ${vendidos.length} lotes vendidos, sus pagos, gastos del proyecto y saldo inicial del banco
do $$ begin
  if to_regclass('public.ventas') is not null then
    insert into public.clientes (id, nombre, telefono, identidad, nota) values
${clientes.map(x => `      ${x}`).join(',\n')};
    insert into public.ventas (id, cliente_id, fecha, tipo, prima, meses, cuota, inicio_cuotas, nota) values
${ventas.map(x => `      ${x}`).join(',\n')};
    insert into public.venta_lotes (lote_id, venta_id, precio_vara, precio) values
${ventaLotes.map(x => `      ${x}`).join(',\n')};
    insert into public.pagos (id, cliente_id, fecha, monto, forma, nota) values
${pagos.map(x => `      ${x}`).join(',\n')};
    insert into public.gastos (id, fecha, descripcion, categoria, monto, nota) values
${gastos.map(x => `      ${x}`).join(',\n')};
    update public.ajustes set saldo_inicial = 150000 where id = 1;
  end if;
end $$;`;

// reiniciar.sql: deja la demo como nueva (borra todos los lotes y los vuelve a cargar con estados, precios y fotos de ejemplo).
// Las fotos subidas al bucket desde /admin no se borran, pero dejan de estar asignadas a los lotes.
const reinicio = `-- Generado por tools/seed-supabase.mjs — REINICIA la demo: borra todos los lotes y la contabilidad, y carga los
-- ${lotes.length} lotes del plano (estados, precios y fotos de data/inventario.json) con su contabilidad de ejemplo.
-- Se pierden los cambios hechos desde /admin.
begin;
-- Primero la contabilidad (si existe): una venta no deja borrar sus lotes
do $$ begin
  if to_regclass('public.ventas') is not null then
    delete from public.pagos;
    delete from public.venta_lotes;
    delete from public.ventas;
    delete from public.gastos;
    delete from public.clientes;
  end if;
end $$;
delete from public.lotes;
-- Bloques de la demo (por si la tabla se creó con un esquema anterior que solo aceptaba A, B, C y L)
alter table public.lotes drop constraint if exists lotes_bloque_check;
alter table public.lotes add constraint lotes_bloque_check check (bloque in ('A', 'B', 'C', 'D', 'E', 'F', 'L'));
insert into public.lotes (id, sector, bloque, numero, area_m2, area_vrs2, estado, precio, descripcion, medidas, fotos) values
${filas.join(',\n')};
-- Tarifa general por vara² (tabla "ajustes", si ya existe) a su valor de ejemplo
do $$ begin
  if to_regclass('public.ajustes') is not null then
    insert into public.ajustes (id, precio_vara) values (1, ${precioVara})
    on conflict (id) do update set precio_vara = excluded.precio_vara;
  end if;
end $$;
${contabilidad}
commit;
`;
fs.writeFileSync(path.join(root, 'supabase/reiniciar.sql'), reinicio);
console.log(`supabase/reiniciar.sql: ${lotes.length} lotes`);
