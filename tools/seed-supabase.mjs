// Genera supabase/seed.sql con todos los lotes del plano (geometría de data/lotes.json + inventario de data/inventario.json)
// node tools/seed-supabase.mjs  →  pegar supabase/seed.sql en el SQL Editor de Supabase
import fs from 'node:fs';
import path from 'node:path';

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

// reiniciar.sql: deja la demo como nueva (borra todos los lotes y los vuelve a cargar con estados, precios y fotos de ejemplo).
// Las fotos subidas al bucket desde /admin no se borran, pero dejan de estar asignadas a los lotes.
const reinicio = `-- Generado por tools/seed-supabase.mjs — REINICIA la demo: borra todos los lotes y carga los ${lotes.length} del plano
-- con los estados, precios y fotos de data/inventario.json. Se pierden los cambios hechos desde /admin.
begin;
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
commit;
`;
fs.writeFileSync(path.join(root, 'supabase/reiniciar.sql'), reinicio);
console.log(`supabase/reiniciar.sql: ${lotes.length} lotes`);
