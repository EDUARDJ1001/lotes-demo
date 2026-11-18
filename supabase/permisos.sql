-- Permisos de la API de datos. Los proyectos nuevos de Supabase no los dan solos a las tablas creadas por SQL:
-- sin ellos el sitio recibe "permission denied for table lotes". Las políticas de schema.sql siguen decidiendo
-- qué filas se ven y quién edita (lectura pública; edición solo administradores).
-- Ya va incluido al final de schema.sql; este archivo sirve para aplicarlo solo en una base ya creada.
grant usage on schema public to anon, authenticated;
grant select on public.lotes to anon, authenticated;
grant update on public.lotes to authenticated;
grant select on public.administradores to authenticated;
grant execute on function public.es_admin() to anon, authenticated;
