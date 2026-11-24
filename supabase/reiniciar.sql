-- Generado por tools/seed-supabase.mjs — REINICIA la demo: borra todos los lotes y la contabilidad, y carga los
-- 87 lotes del plano (estados, precios y fotos de data/inventario.json) con su contabilidad de ejemplo.
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
  ('A-1', '', 'A', 1, 342.16, 489.57, 'disponible', null, 'Lote plano al sur del proyecto, frente a la Calle 1.', null, array['fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/lote-goiania.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('A-2', '', 'A', 2, 342.16, 489.57, 'disponible', null, 'Lote plano al sur del proyecto, frente a la Calle 1.', null, array['fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/terreno-wukari.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('A-3', '', 'A', 3, 342.44, 489.97, 'disponible', null, 'Lote plano al sur del proyecto, frente a la Calle 1.', null, array['fotos/demo/lote-goiania.jpg', 'fotos/demo/potrero-honduras.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('A-4', '', 'A', 4, 342.16, 489.57, 'disponible', null, 'Lote plano al sur del proyecto, frente a la Calle 1.', null, array['fotos/demo/terreno-wukari.jpg', 'fotos/demo/arbol-lote.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('A-5', '', 'A', 5, 342.16, 489.57, 'reservado', null, 'Lote plano al sur del proyecto, frente a la Calle 1.', null, array['fotos/demo/potrero-honduras.jpg', 'fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('A-6', '', 'A', 6, 342.16, 489.57, 'disponible', null, 'Lote plano al sur del proyecto, frente a la Calle 1.', null, array['fotos/demo/arbol-lote.jpg', 'fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('A-7', '', 'A', 7, 342.44, 489.97, 'disponible', null, 'Lote plano al sur del proyecto, frente a la Calle 1.', null, array['fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/lote-goiania.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('A-8', '', 'A', 8, 342.16, 489.57, 'disponible', null, 'Lote plano al sur del proyecto, frente a la Calle 1.', null, array['fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/terreno-wukari.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('A-9', '', 'A', 9, 342.16, 489.57, 'disponible', null, 'Lote plano al sur del proyecto, frente a la Calle 1.', null, array['fotos/demo/lote-goiania.jpg', 'fotos/demo/potrero-honduras.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('B-1', '', 'B', 1, 342.16, 489.57, 'reservado', null, 'Lote plano al sur del proyecto, frente a la Calle 1.', null, array['fotos/demo/terreno-wukari.jpg', 'fotos/demo/arbol-lote.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('B-2', '', 'B', 2, 342.16, 489.57, 'disponible', null, 'Lote plano al sur del proyecto, frente a la Calle 1.', null, array['fotos/demo/potrero-honduras.jpg', 'fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('B-3', '', 'B', 3, 342.44, 489.97, 'vendido', null, 'Lote plano al sur del proyecto, frente a la Calle 1.', null, array['fotos/demo/arbol-lote.jpg', 'fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('B-4', '', 'B', 4, 342.16, 489.57, 'disponible', null, 'Lote plano al sur del proyecto, frente a la Calle 1.', null, array['fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/lote-goiania.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('B-5', '', 'B', 5, 342.16, 489.57, 'disponible', null, 'Lote plano al sur del proyecto, frente a la Calle 1.', null, array['fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/terreno-wukari.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('B-6', '', 'B', 6, 342.16, 489.57, 'reservado', null, 'Lote plano al sur del proyecto, frente a la Calle 1.', null, array['fotos/demo/lote-goiania.jpg', 'fotos/demo/potrero-honduras.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('B-7', '', 'B', 7, 342.44, 489.97, 'disponible', null, 'Lote plano al sur del proyecto, frente a la Calle 1.', null, array['fotos/demo/terreno-wukari.jpg', 'fotos/demo/arbol-lote.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('B-8', '', 'B', 8, 342.16, 489.57, 'vendido', null, 'Lote plano al sur del proyecto, frente a la Calle 1.', null, array['fotos/demo/potrero-honduras.jpg', 'fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('B-9', '', 'B', 9, 342.16, 489.57, 'disponible', null, 'Lote plano al sur del proyecto, frente a la Calle 1.', null, array['fotos/demo/arbol-lote.jpg', 'fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('C-1', '', 'C', 1, 342.16, 489.57, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/lote-goiania.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('C-2', '', 'C', 2, 342.16, 489.57, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/terreno-wukari.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('C-3', '', 'C', 3, 342.44, 489.97, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/lote-goiania.jpg', 'fotos/demo/potrero-honduras.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('C-4', '', 'C', 4, 342.16, 489.57, 'vendido', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/terreno-wukari.jpg', 'fotos/demo/arbol-lote.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('C-5', '', 'C', 5, 342.16, 489.57, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/potrero-honduras.jpg', 'fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('C-6', '', 'C', 6, 342.16, 489.57, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/arbol-lote.jpg', 'fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('C-7', '', 'C', 7, 342.44, 489.97, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/lote-goiania.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('C-8', '', 'C', 8, 342.16, 489.57, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/terreno-wukari.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('C-9', '', 'C', 9, 342.16, 489.57, 'vendido', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/lote-goiania.jpg', 'fotos/demo/potrero-honduras.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('D-1', '', 'D', 1, 342.16, 489.57, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/terreno-wukari.jpg', 'fotos/demo/arbol-lote.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('D-2', '', 'D', 2, 342.16, 489.57, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/potrero-honduras.jpg', 'fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('D-3', '', 'D', 3, 342.44, 489.97, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/arbol-lote.jpg', 'fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('D-4', '', 'D', 4, 342.16, 489.57, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/lote-goiania.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('D-5', '', 'D', 5, 342.16, 489.57, 'vendido', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/terreno-wukari.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('D-6', '', 'D', 6, 342.16, 489.57, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/lote-goiania.jpg', 'fotos/demo/potrero-honduras.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('D-7', '', 'D', 7, 342.44, 489.97, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/terreno-wukari.jpg', 'fotos/demo/arbol-lote.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('D-8', '', 'D', 8, 342.16, 489.57, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/potrero-honduras.jpg', 'fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('D-9', '', 'D', 9, 342.16, 489.57, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/arbol-lote.jpg', 'fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('C-10', '', 'C', 10, 342.16, 489.57, 'vendido', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/lote-goiania.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('C-11', '', 'C', 11, 342.16, 489.57, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/terreno-wukari.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('C-12', '', 'C', 12, 342.44, 489.97, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/lote-goiania.jpg', 'fotos/demo/potrero-honduras.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('C-13', '', 'C', 13, 342.16, 489.57, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/terreno-wukari.jpg', 'fotos/demo/arbol-lote.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('C-14', '', 'C', 14, 342.16, 489.57, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/potrero-honduras.jpg', 'fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('C-15', '', 'C', 15, 342.16, 489.57, 'vendido', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/arbol-lote.jpg', 'fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('C-16', '', 'C', 16, 342.44, 489.97, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/lote-goiania.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('C-17', '', 'C', 17, 342.16, 489.57, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/terreno-wukari.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('C-18', '', 'C', 18, 342.16, 489.57, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/lote-goiania.jpg', 'fotos/demo/potrero-honduras.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('D-10', '', 'D', 10, 342.16, 489.57, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/terreno-wukari.jpg', 'fotos/demo/arbol-lote.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('D-11', '', 'D', 11, 342.16, 489.57, 'reservado', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/potrero-honduras.jpg', 'fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('D-12', '', 'D', 12, 342.44, 489.97, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/arbol-lote.jpg', 'fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('D-13', '', 'D', 13, 342.16, 489.57, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/lote-goiania.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('D-14', '', 'D', 14, 342.16, 489.57, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/terreno-wukari.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('D-15', '', 'D', 15, 342.16, 489.57, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/lote-goiania.jpg', 'fotos/demo/potrero-honduras.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('D-16', '', 'D', 16, 342.44, 489.97, 'reservado', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/terreno-wukari.jpg', 'fotos/demo/arbol-lote.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('D-17', '', 'D', 17, 342.16, 489.57, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/potrero-honduras.jpg', 'fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('D-18', '', 'D', 18, 342.16, 489.57, 'disponible', null, 'Lote plano, a pocos metros del bulevar principal.', null, array['fotos/demo/arbol-lote.jpg', 'fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('E-1', '', 'E', 1, 342.16, 489.57, 'disponible', null, 'Lote plano junto al área verde.', null, array['fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/lote-goiania.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('E-2', '', 'E', 2, 342.16, 489.57, 'disponible', null, 'Lote plano junto al área verde.', null, array['fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/terreno-wukari.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('E-3', '', 'E', 3, 342.44, 489.97, 'disponible', null, 'Lote plano junto al área verde.', null, array['fotos/demo/lote-goiania.jpg', 'fotos/demo/potrero-honduras.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('E-4', '', 'E', 4, 342.16, 489.57, 'disponible', null, 'Lote plano junto al área verde.', null, array['fotos/demo/terreno-wukari.jpg', 'fotos/demo/arbol-lote.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('E-5', '', 'E', 5, 342.16, 489.57, 'vendido', null, 'Lote plano junto al área verde.', null, array['fotos/demo/potrero-honduras.jpg', 'fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('E-6', '', 'E', 6, 342.16, 489.57, 'disponible', null, 'Lote plano junto al área verde.', null, array['fotos/demo/arbol-lote.jpg', 'fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('E-7', '', 'E', 7, 342.44, 489.97, 'disponible', null, 'Lote plano junto al área verde.', null, array['fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/lote-goiania.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('E-8', '', 'E', 8, 342.16, 489.57, 'disponible', null, 'Lote plano junto al área verde.', null, array['fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/terreno-wukari.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('E-9', '', 'E', 9, 342.16, 489.57, 'disponible', null, 'Lote plano junto al área verde.', null, array['fotos/demo/lote-goiania.jpg', 'fotos/demo/potrero-honduras.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('F-1', '', 'F', 1, 342.16, 489.57, 'vendido', null, 'Lote plano cerca de la entrada del proyecto.', null, array['fotos/demo/terreno-wukari.jpg', 'fotos/demo/arbol-lote.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('F-2', '', 'F', 2, 342.16, 489.57, 'disponible', null, 'Lote plano cerca de la entrada del proyecto.', null, array['fotos/demo/potrero-honduras.jpg', 'fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('F-3', '', 'F', 3, 342.44, 489.97, 'disponible', null, 'Lote plano cerca de la entrada del proyecto.', null, array['fotos/demo/arbol-lote.jpg', 'fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('F-4', '', 'F', 4, 342.16, 489.57, 'disponible', null, 'Lote plano cerca de la entrada del proyecto.', null, array['fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/lote-goiania.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('F-5', '', 'F', 5, 342.16, 489.57, 'disponible', null, 'Lote plano cerca de la entrada del proyecto.', null, array['fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/terreno-wukari.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('L-1', '', 'L', 1, 342.16, 489.57, 'disponible', 650000, 'Local comercial frente al bulevar, en la entrada del proyecto.', null, array['fotos/demo/calle-lotificacion.jpg', 'fotos/demo/lote-goiania.jpg', 'fotos/demo/potrero-honduras.jpg']::text[]),
  ('L-2', '', 'L', 2, 342.44, 489.97, 'disponible', 650000, 'Local comercial frente al bulevar, en la entrada del proyecto.', null, array['fotos/demo/calle-lotificacion.jpg', 'fotos/demo/terreno-wukari.jpg', 'fotos/demo/arbol-lote.jpg']::text[]),
  ('L-3', '', 'L', 3, 342.16, 489.57, 'reservado', 650000, 'Local comercial frente al bulevar, en la entrada del proyecto.', null, array['fotos/demo/calle-lotificacion.jpg', 'fotos/demo/potrero-honduras.jpg', 'fotos/demo/lotes-villa-flora.jpg']::text[]),
  ('L-4', '', 'L', 4, 342.16, 489.57, 'disponible', 650000, 'Local comercial frente al bulevar, en la entrada del proyecto.', null, array['fotos/demo/calle-lotificacion.jpg', 'fotos/demo/arbol-lote.jpg', 'fotos/demo/lotes-jardim-eldorado.jpg']::text[]),
  ('E-10', '', 'E', 10, 342.16, 489.57, 'disponible', null, 'Lote plano junto al área verde.', null, array['fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/lote-goiania.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('E-11', '', 'E', 11, 342.16, 489.57, 'vendido', null, 'Lote plano junto al área verde.', null, array['fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/terreno-wukari.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('E-12', '', 'E', 12, 342.16, 489.57, 'disponible', null, 'Lote plano junto al área verde.', null, array['fotos/demo/lote-goiania.jpg', 'fotos/demo/potrero-honduras.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('E-13', '', 'E', 13, 342.44, 489.97, 'disponible', null, 'Lote plano junto al área verde.', null, array['fotos/demo/terreno-wukari.jpg', 'fotos/demo/arbol-lote.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('E-14', '', 'E', 14, 342.16, 489.57, 'disponible', null, 'Lote plano junto al área verde.', null, array['fotos/demo/potrero-honduras.jpg', 'fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('E-15', '', 'E', 15, 342.16, 489.57, 'disponible', null, 'Lote plano junto al área verde.', null, array['fotos/demo/arbol-lote.jpg', 'fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('F-6', '', 'F', 6, 342.16, 489.57, 'disponible', null, 'Lote plano cerca de la entrada del proyecto.', null, array['fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/lote-goiania.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('F-7', '', 'F', 7, 342.16, 489.57, 'vendido', null, 'Lote plano cerca de la entrada del proyecto.', null, array['fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/terreno-wukari.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('F-8', '', 'F', 8, 342.44, 489.97, 'disponible', null, 'Lote plano cerca de la entrada del proyecto.', null, array['fotos/demo/lote-goiania.jpg', 'fotos/demo/potrero-honduras.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('F-9', '', 'F', 9, 342.16, 489.57, 'disponible', null, 'Lote plano cerca de la entrada del proyecto.', null, array['fotos/demo/terreno-wukari.jpg', 'fotos/demo/arbol-lote.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('F-10', '', 'F', 10, 342.16, 489.57, 'reservado', null, 'Lote plano cerca de la entrada del proyecto.', null, array['fotos/demo/potrero-honduras.jpg', 'fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('F-11', '', 'F', 11, 342.16, 489.57, 'disponible', null, 'Lote plano cerca de la entrada del proyecto.', null, array['fotos/demo/arbol-lote.jpg', 'fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('F-12', '', 'F', 12, 342.44, 489.97, 'vendido', null, 'Lote plano cerca de la entrada del proyecto.', null, array['fotos/demo/lotes-villa-flora.jpg', 'fotos/demo/lote-goiania.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('F-13', '', 'F', 13, 342.16, 489.57, 'disponible', null, 'Lote plano cerca de la entrada del proyecto.', null, array['fotos/demo/lotes-jardim-eldorado.jpg', 'fotos/demo/terreno-wukari.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]),
  ('F-14', '', 'F', 14, 342.16, 489.57, 'disponible', null, 'Lote plano cerca de la entrada del proyecto.', null, array['fotos/demo/lote-goiania.jpg', 'fotos/demo/potrero-honduras.jpg', 'fotos/demo/calle-lotificacion.jpg']::text[]);
-- Tarifa general por vara² (tabla "ajustes", si ya existe) a su valor de ejemplo
do $$ begin
  if to_regclass('public.ajustes') is not null then
    insert into public.ajustes (id, precio_vara) values (1, 950)
    on conflict (id) do update set precio_vara = excluded.precio_vara;
  end if;
end $$;
-- Contabilidad de ejemplo (tablas de supabase/contabilidad.sql, si ya existen): 9 clientes ficticios
-- que compraron los 12 lotes vendidos, sus pagos, gastos del proyecto y saldo inicial del banco
do $$ begin
  if to_regclass('public.ventas') is not null then
    insert into public.clientes (id, nombre, telefono, identidad, nota) values
      ('c594d05c-c43c-4eac-aefe-2c2cc4a78348', 'Ana Martínez', '', '', 'Cliente de ejemplo'),
      ('ffab2e60-0be0-44bf-ae01-a7b3efea507c', 'Carlos Rivera', '', '', 'Cliente de ejemplo'),
      ('83020a23-6d18-4ba9-a9e4-7088499f2090', 'Lucía Hernández', '', '', 'Cliente de ejemplo'),
      ('53e7e525-ccd1-4495-ae40-8cf08a359e1d', 'José Mejía', '', '', 'Cliente de ejemplo'),
      ('0d6a8195-4377-4f6e-a0b0-9624f38e017f', 'Sofía Castillo', '', '', 'Cliente de ejemplo'),
      ('10ac1152-1186-4a8e-a93b-e7bdb4c7d915', 'Miguel Ortega', '', '', 'Cliente de ejemplo'),
      ('ac691dea-4e6c-4445-adb5-29db16f3a0ba', 'Daniela Flores', '', '', 'Cliente de ejemplo'),
      ('85fff5ee-1470-4c22-aa7c-b01f71a9ae26', 'Roberto Aguilar', '', '', 'Cliente de ejemplo'),
      ('07c0c953-7c64-4246-a749-dac007c8c94f', 'Gabriela Paz', '', '', 'Cliente de ejemplo');
    insert into public.ventas (id, cliente_id, fecha, tipo, prima, meses, cuota, inicio_cuotas, nota) values
      ('ff5ee957-5622-45a6-addd-93071b19fd86', 'c594d05c-c43c-4eac-aefe-2c2cc4a78348', (current_date - 400), 'contado', 0, 0, null, null, ''),
      ('ba578b49-f033-4bb0-ae35-4cf22165976e', 'ffab2e60-0be0-44bf-ae01-a7b3efea507c', (current_date - 250), 'contado', 0, 0, null, null, ''),
      ('e280da93-7212-4b2f-a338-d52704b0dbe4', '83020a23-6d18-4ba9-a9e4-7088499f2090', (date_trunc('month', current_date) + interval '-11 months' + interval '0 days')::date, 'cuotas', 186036.8, 36, null, (date_trunc('month', current_date) + interval '-10 months' + interval '0 days')::date, ''),
      ('20148cff-de06-429b-aea8-53e88cb3588f', '53e7e525-ccd1-4495-ae40-8cf08a359e1d', (date_trunc('month', current_date) + interval '-9 months' + interval '0 days')::date, 'cuotas', 69763.8, 24, null, (date_trunc('month', current_date) + interval '-8 months' + interval '0 days')::date, ''),
      ('82520ef3-bab6-4b66-a65d-b992f0fe9b23', '0d6a8195-4377-4f6e-a0b0-9624f38e017f', (date_trunc('month', current_date) + interval '-4 months' + interval '0 days')::date, 'cuotas', 232546, 48, null, (date_trunc('month', current_date) + interval '-3 months' + interval '0 days')::date, ''),
      ('d4479c62-94f3-4892-a467-3a8ab2c8f562', '10ac1152-1186-4a8e-a93b-e7bdb4c7d915', (date_trunc('month', current_date) + interval '-14 months' + interval '0 days')::date, 'cuotas', 139527.6, 12, null, (date_trunc('month', current_date) + interval '-13 months' + interval '0 days')::date, ''),
      ('b288faec-3c61-4a8b-a9b9-3ed44a8b9a93', 'ac691dea-4e6c-4445-adb5-29db16f3a0ba', (current_date - 40), 'contado', 0, 0, null, null, ''),
      ('38d3a237-727b-466a-a852-3aeb379f2a44', '85fff5ee-1470-4c22-aa7c-b01f71a9ae26', (date_trunc('month', current_date) + interval '-7 months' + interval '0 days')::date, 'cuotas', 93018.4, 36, null, (date_trunc('month', current_date) + interval '-6 months' + interval '0 days')::date, ''),
      ('2c3367fb-2507-43e8-abef-8ff71285f5a1', '07c0c953-7c64-4246-a749-dac007c8c94f', (date_trunc('month', current_date) + interval '0 months' + interval '0 days')::date, 'cuotas', 93094.4, 24, null, (date_trunc('month', current_date) + interval '1 months' + interval '0 days')::date, '');
    insert into public.venta_lotes (lote_id, venta_id, precio_vara, precio) values
      ('B-3', 'ff5ee957-5622-45a6-addd-93071b19fd86', 950, 465472),
      ('B-8', 'ff5ee957-5622-45a6-addd-93071b19fd86', 950, 465092),
      ('C-4', 'ba578b49-f033-4bb0-ae35-4cf22165976e', 950, 465092),
      ('C-9', 'e280da93-7212-4b2f-a338-d52704b0dbe4', 950, 465092),
      ('D-5', 'e280da93-7212-4b2f-a338-d52704b0dbe4', 950, 465092),
      ('C-10', '20148cff-de06-429b-aea8-53e88cb3588f', 950, 465092),
      ('C-15', '82520ef3-bab6-4b66-a65d-b992f0fe9b23', 950, 465092),
      ('E-5', '82520ef3-bab6-4b66-a65d-b992f0fe9b23', 950, 465092),
      ('F-1', 'd4479c62-94f3-4892-a467-3a8ab2c8f562', 950, 465092),
      ('E-11', 'b288faec-3c61-4a8b-a9b9-3ed44a8b9a93', 950, 465092),
      ('F-7', '38d3a237-727b-466a-a852-3aeb379f2a44', 950, 465092),
      ('F-12', '2c3367fb-2507-43e8-abef-8ff71285f5a1', 950, 465472);
    insert into public.pagos (id, cliente_id, fecha, monto, forma, nota) values
      ('bf39322c-7b8b-4614-ab35-2c3eadfa9679', 'c594d05c-c43c-4eac-aefe-2c2cc4a78348', (current_date - 400), 930564, 'Transferencia', 'Pago completo'),
      ('8eec82ba-0408-4de9-a7f5-68e567bd4895', 'ffab2e60-0be0-44bf-ae01-a7b3efea507c', (current_date - 250), 465092, 'Depósito', 'Pago completo'),
      ('7878b120-6190-4b37-ab0f-87c280c36a40', '83020a23-6d18-4ba9-a9e4-7088499f2090', (date_trunc('month', current_date) + interval '-11 months' + interval '0 days')::date, 186036.8, 'Efectivo', 'Prima'),
      ('873fba62-8a01-4926-a393-51175c1d2bd4', '83020a23-6d18-4ba9-a9e4-7088499f2090', (date_trunc('month', current_date) + interval '-10 months' + interval '0 days')::date, 20670.76, 'Transferencia', 'Cuota 1 de 36'),
      ('4d8d79ea-5467-49d0-a69d-0e85afb0f720', '83020a23-6d18-4ba9-a9e4-7088499f2090', (date_trunc('month', current_date) + interval '-9 months' + interval '0 days')::date, 20670.76, 'Depósito', 'Cuota 2 de 36'),
      ('15c3f3e6-57cb-464b-aa16-915e381d623c', '83020a23-6d18-4ba9-a9e4-7088499f2090', (date_trunc('month', current_date) + interval '-8 months' + interval '0 days')::date, 20670.76, 'Efectivo', 'Cuota 3 de 36'),
      ('876301e2-71bb-4489-a316-b97d69acea10', '83020a23-6d18-4ba9-a9e4-7088499f2090', (date_trunc('month', current_date) + interval '-7 months' + interval '0 days')::date, 20670.76, 'Transferencia', 'Cuota 4 de 36'),
      ('2097b0e1-bca7-4d57-a1ee-d6c02e20a65b', '83020a23-6d18-4ba9-a9e4-7088499f2090', (date_trunc('month', current_date) + interval '-6 months' + interval '0 days')::date, 20670.76, 'Depósito', 'Cuota 5 de 36'),
      ('f9d27965-c3d4-4423-a4c5-adcc4a537058', '83020a23-6d18-4ba9-a9e4-7088499f2090', (date_trunc('month', current_date) + interval '-5 months' + interval '0 days')::date, 20670.76, 'Efectivo', 'Cuota 6 de 36'),
      ('dbd2c323-fee3-4831-a20f-f087e602acdb', '83020a23-6d18-4ba9-a9e4-7088499f2090', (date_trunc('month', current_date) + interval '-4 months' + interval '0 days')::date, 20670.76, 'Transferencia', 'Cuota 7 de 36'),
      ('3c7aff2c-bb6b-4ad4-a3b8-1a07fd96d7d1', '83020a23-6d18-4ba9-a9e4-7088499f2090', (date_trunc('month', current_date) + interval '-3 months' + interval '0 days')::date, 20670.76, 'Depósito', 'Cuota 8 de 36'),
      ('cb61fc60-69d9-4971-a411-18e32f14b2ac', '83020a23-6d18-4ba9-a9e4-7088499f2090', (date_trunc('month', current_date) + interval '-2 months' + interval '0 days')::date, 20670.76, 'Efectivo', 'Cuota 9 de 36'),
      ('10bbc586-57c4-475d-a5f8-cfd007cf2247', '83020a23-6d18-4ba9-a9e4-7088499f2090', (date_trunc('month', current_date) + interval '-1 months' + interval '0 days')::date, 20670.76, 'Transferencia', 'Cuota 10 de 36'),
      ('a69ef81b-4594-4f5e-ae6a-da70ef5edc37', '83020a23-6d18-4ba9-a9e4-7088499f2090', (date_trunc('month', current_date) + interval '0 months' + interval '0 days')::date, 20670.76, 'Depósito', 'Cuota 11 de 36'),
      ('a5ecd0f4-cd0f-478f-a654-60568e61fe50', '53e7e525-ccd1-4495-ae40-8cf08a359e1d', (date_trunc('month', current_date) + interval '-9 months' + interval '0 days')::date, 69763.8, 'Transferencia', 'Prima'),
      ('cfccbcc9-c9ae-4b9e-a414-0a2cdbc1ae94', '53e7e525-ccd1-4495-ae40-8cf08a359e1d', (date_trunc('month', current_date) + interval '-8 months' + interval '0 days')::date, 16472.01, 'Depósito', 'Cuota 1 de 24'),
      ('f1c1ef27-cd51-452b-a54d-97a34243b1b2', '53e7e525-ccd1-4495-ae40-8cf08a359e1d', (date_trunc('month', current_date) + interval '-7 months' + interval '0 days')::date, 16472.01, 'Efectivo', 'Cuota 2 de 24'),
      ('3b0e05ca-f119-43f5-af71-ce61e8464e17', '53e7e525-ccd1-4495-ae40-8cf08a359e1d', (date_trunc('month', current_date) + interval '-6 months' + interval '0 days')::date, 16472.01, 'Transferencia', 'Cuota 3 de 24'),
      ('dd4ddaaf-47d0-42d2-a9cd-fe3fc0cd3eb6', '53e7e525-ccd1-4495-ae40-8cf08a359e1d', (date_trunc('month', current_date) + interval '-5 months' + interval '0 days')::date, 16472.01, 'Depósito', 'Cuota 4 de 24'),
      ('00ae7510-5dc1-4b80-ad47-ca19c8942548', '53e7e525-ccd1-4495-ae40-8cf08a359e1d', (date_trunc('month', current_date) + interval '-4 months' + interval '0 days')::date, 16472.01, 'Efectivo', 'Cuota 5 de 24'),
      ('3ade1c26-ae20-4ac3-ad17-e65fb7e7b086', '0d6a8195-4377-4f6e-a0b0-9624f38e017f', (date_trunc('month', current_date) + interval '-4 months' + interval '0 days')::date, 232546, 'Depósito', 'Prima'),
      ('142f84b1-a97b-4374-a468-13b0c1361cdd', '0d6a8195-4377-4f6e-a0b0-9624f38e017f', (date_trunc('month', current_date) + interval '-3 months' + interval '0 days')::date, 14534.13, 'Efectivo', 'Cuota 1 de 48'),
      ('dae5d751-ac51-4bf0-ae64-f29ea793bec8', '0d6a8195-4377-4f6e-a0b0-9624f38e017f', (date_trunc('month', current_date) + interval '-2 months' + interval '0 days')::date, 14534.13, 'Transferencia', 'Cuota 2 de 48'),
      ('85de8467-9d4a-422d-a3b8-1609f7a9eb65', '0d6a8195-4377-4f6e-a0b0-9624f38e017f', (date_trunc('month', current_date) + interval '-1 months' + interval '0 days')::date, 14534.13, 'Depósito', 'Cuota 3 de 48'),
      ('07880f3e-3c09-4c3e-a479-1fad4d5aefd2', '0d6a8195-4377-4f6e-a0b0-9624f38e017f', (date_trunc('month', current_date) + interval '0 months' + interval '0 days')::date, 14534.13, 'Efectivo', 'Cuota 4 de 48'),
      ('22c1a9d1-077d-4076-a095-3a57286d5291', '10ac1152-1186-4a8e-a93b-e7bdb4c7d915', (date_trunc('month', current_date) + interval '-14 months' + interval '0 days')::date, 139527.6, 'Efectivo', 'Prima'),
      ('6b55e904-8ff5-4f95-aca5-460bcea156d5', '10ac1152-1186-4a8e-a93b-e7bdb4c7d915', (date_trunc('month', current_date) + interval '-13 months' + interval '0 days')::date, 27130.37, 'Transferencia', 'Cuota 1 de 12'),
      ('8087e31a-d3f3-446e-a131-672763c66a40', '10ac1152-1186-4a8e-a93b-e7bdb4c7d915', (date_trunc('month', current_date) + interval '-12 months' + interval '0 days')::date, 27130.37, 'Depósito', 'Cuota 2 de 12'),
      ('a1954bf7-737f-4560-af60-1c683e09b373', '10ac1152-1186-4a8e-a93b-e7bdb4c7d915', (date_trunc('month', current_date) + interval '-11 months' + interval '0 days')::date, 27130.37, 'Efectivo', 'Cuota 3 de 12'),
      ('77f43629-04b4-4bc3-aa26-a5b323b839a2', '10ac1152-1186-4a8e-a93b-e7bdb4c7d915', (date_trunc('month', current_date) + interval '-10 months' + interval '0 days')::date, 27130.37, 'Transferencia', 'Cuota 4 de 12'),
      ('53f62284-c416-44c4-a6d7-033a3ca1a4b8', '10ac1152-1186-4a8e-a93b-e7bdb4c7d915', (date_trunc('month', current_date) + interval '-9 months' + interval '0 days')::date, 27130.37, 'Depósito', 'Cuota 5 de 12'),
      ('41c679f2-6c2b-47f8-a370-e55ab262cd78', '10ac1152-1186-4a8e-a93b-e7bdb4c7d915', (date_trunc('month', current_date) + interval '-8 months' + interval '0 days')::date, 27130.37, 'Efectivo', 'Cuota 6 de 12'),
      ('75149151-e19d-4af6-ab64-9bb79f1fcf26', '10ac1152-1186-4a8e-a93b-e7bdb4c7d915', (date_trunc('month', current_date) + interval '-7 months' + interval '0 days')::date, 27130.37, 'Transferencia', 'Cuota 7 de 12'),
      ('bd41cea4-9623-4314-aaa5-fd5e2649c6a7', '10ac1152-1186-4a8e-a93b-e7bdb4c7d915', (date_trunc('month', current_date) + interval '-6 months' + interval '0 days')::date, 27130.37, 'Depósito', 'Cuota 8 de 12'),
      ('3a627128-9c5d-4324-a8a2-1f0a7f367c3b', '10ac1152-1186-4a8e-a93b-e7bdb4c7d915', (date_trunc('month', current_date) + interval '-5 months' + interval '0 days')::date, 27130.37, 'Efectivo', 'Cuota 9 de 12'),
      ('f14e1b39-b6a3-4594-af25-67e491ff8bfb', '10ac1152-1186-4a8e-a93b-e7bdb4c7d915', (date_trunc('month', current_date) + interval '-4 months' + interval '0 days')::date, 27130.37, 'Transferencia', 'Cuota 10 de 12'),
      ('01ef6f9d-a275-413a-a635-55719a2cd387', '10ac1152-1186-4a8e-a93b-e7bdb4c7d915', (date_trunc('month', current_date) + interval '-3 months' + interval '0 days')::date, 27130.37, 'Depósito', 'Cuota 11 de 12'),
      ('7ed8a3de-59f9-452e-ac4e-350881fec3f4', '10ac1152-1186-4a8e-a93b-e7bdb4c7d915', (date_trunc('month', current_date) + interval '-2 months' + interval '0 days')::date, 27130.37, 'Efectivo', 'Cuota 12 de 12'),
      ('748c75d3-9ae0-4e83-ac26-0ce81446ecd4', 'ac691dea-4e6c-4445-adb5-29db16f3a0ba', (current_date - 40), 279055.2, 'Transferencia', 'Abono'),
      ('f09dbc0b-d475-47d1-a1a8-aecfb12b7951', '85fff5ee-1470-4c22-aa7c-b01f71a9ae26', (date_trunc('month', current_date) + interval '-7 months' + interval '0 days')::date, 93018.4, 'Depósito', 'Prima'),
      ('f8eab5b1-5110-49be-a94f-cd64bb702e00', '85fff5ee-1470-4c22-aa7c-b01f71a9ae26', (date_trunc('month', current_date) + interval '-6 months' + interval '0 days')::date, 10335.38, 'Efectivo', 'Cuota 1 de 36'),
      ('0281ddba-f677-4d76-a64d-f1a8ac236bc2', '85fff5ee-1470-4c22-aa7c-b01f71a9ae26', (date_trunc('month', current_date) + interval '-5 months' + interval '0 days')::date, 10335.38, 'Transferencia', 'Cuota 2 de 36'),
      ('fccecd77-ae7c-4e0b-abc9-774ffddb399c', '85fff5ee-1470-4c22-aa7c-b01f71a9ae26', (date_trunc('month', current_date) + interval '-4 months' + interval '0 days')::date, 10335.38, 'Depósito', 'Cuota 3 de 36'),
      ('8610618c-cef6-4356-aa2c-2680cdf4e0d0', '85fff5ee-1470-4c22-aa7c-b01f71a9ae26', (date_trunc('month', current_date) + interval '-3 months' + interval '0 days')::date, 10335.38, 'Efectivo', 'Cuota 4 de 36'),
      ('be15a677-67e6-44ec-a8e9-add11b87e511', '85fff5ee-1470-4c22-aa7c-b01f71a9ae26', (date_trunc('month', current_date) + interval '-2 months' + interval '0 days')::date, 10335.38, 'Transferencia', 'Cuota 5 de 36'),
      ('9d6f00f1-6cc6-47c9-a4c1-b4237bb4969a', '85fff5ee-1470-4c22-aa7c-b01f71a9ae26', (date_trunc('month', current_date) + interval '-1 months' + interval '0 days')::date, 10335.38, 'Depósito', 'Cuota 6 de 36'),
      ('3bc94f30-305e-4fdf-a670-8c070ae05e20', '85fff5ee-1470-4c22-aa7c-b01f71a9ae26', (date_trunc('month', current_date) + interval '0 months' + interval '0 days')::date, 10335.38, 'Efectivo', 'Cuota 7 de 36'),
      ('f0096365-50c8-40f6-a67c-0d16f5dfeafa', '07c0c953-7c64-4246-a749-dac007c8c94f', (date_trunc('month', current_date) + interval '0 months' + interval '0 days')::date, 93094.4, 'Efectivo', 'Prima');
    insert into public.gastos (id, fecha, descripcion, categoria, monto, nota) values
      ('e51388f0-022d-4d70-a1ec-578b191657c8', (date_trunc('month', current_date) + interval '-14 months' + interval '14 days')::date, 'Levantamiento topográfico', 'Topografía', 45000, 'Gasto de ejemplo'),
      ('59ced6ae-3f88-4421-a002-0a1a7ef6da81', (date_trunc('month', current_date) + interval '-13 months' + interval '14 days')::date, 'Diseño del plano de lotificación', 'Planos', 60000, 'Gasto de ejemplo'),
      ('a3c187a0-caa6-4581-addb-12da8ea0bf9a', (date_trunc('month', current_date) + interval '-12 months' + interval '14 days')::date, 'Permiso municipal de lotificación', 'Trámites', 38000, 'Gasto de ejemplo'),
      ('41757db7-451c-4d19-a2df-7eb277f119e9', (date_trunc('month', current_date) + interval '-11 months' + interval '14 days')::date, 'Movimiento de tierra y nivelación', 'Obra', 185000, 'Gasto de ejemplo'),
      ('f05a8646-e364-4607-acb9-78dd22532d91', (date_trunc('month', current_date) + interval '-9 months' + interval '14 days')::date, 'Apertura de calles', 'Obra', 120000, 'Gasto de ejemplo'),
      ('d70ad151-fad1-4044-a8a7-7e6c649ec0dd', (date_trunc('month', current_date) + interval '-6 months' + interval '14 days')::date, 'Rótulo y publicidad en redes', 'Publicidad', 18500, 'Gasto de ejemplo'),
      ('10b6e528-1200-43df-a4b4-70841d6ac921', (date_trunc('month', current_date) + interval '-4 months' + interval '14 days')::date, 'Comisión de venta', 'Comisiones', 22000, 'Gasto de ejemplo'),
      ('3856fa58-6a72-4e6c-a211-12e90ae75946', (date_trunc('month', current_date) + interval '-1 months' + interval '14 days')::date, 'Limpieza del terreno', 'Mantenimiento', 9500, 'Gasto de ejemplo');
    update public.ajustes set saldo_inicial = 150000 where id = 1;
  end if;
end $$;
commit;
