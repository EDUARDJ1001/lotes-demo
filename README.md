# Lotificación Demo — mapa de lotes

Versión de demostración, sin marca, de una web de lotificación: landing, mapa interactivo de lotes con cotizador y panel de administración.

## Ver la web

```bash
node tools/serve.mjs
```

Abrir http://localhost:5180.

- `index.html`: landing.
- `mapa.html`: mapa interactivo de lotes (`/mapa`).
- `admin.html`: panel de administración (`/admin`, requiere Supabase).

## Configuración — `js/config.js`

- `whatsapp`: número con código de país. Vacío oculta el botón "Contáctame".
- `coordenadas`: ubicación del proyecto (landing y Google Maps).
- `plano` / `plano2`: dónde se coloca cada plano sobre el mapa (`origen` en metros del plano, `lat`/`lng` y `rotacion` en grados antihorario).
- `supabase`: URL del proyecto y clave pública (*publishable*/*anon*). Vacío = se usa `data/inventario.json`.

## Plano ficticio

El plano es inventado: 87 lotes en 6 manzanas (A a F), 4 locales frente al bulevar y un área verde.
Está colocado sobre un campo vacío real, al oeste de La Lima (Cortés), y el bulevar sale a la calle existente del lado este.

Para cambiar el trazado, editar `tools/generar-demo.mjs` y volver a generar:

```bash
node tools/generar-demo.mjs
```

El script escribe:

- `data/lotes.json`: la geometría de los lotes.
- `data/plano-base.json`: calles, área verde y textos.
- `data/inventario.json`: estados de ejemplo. Al regenerar se sobreescriben los cambios hechos a mano.

En `data/inventario.json` cada lote tiene un estado (`disponible`, `reservado`, `vendido` o `no_disponible`), precio (`null` = se calcula con `precioVara`), descripción, medidas opcionales y fotos.

Las fotos de ejemplo están en `fotos/demo/`: 7 fotos de Wikimedia Commons, reducidas a 1280 px. El generador le asigna 3 a cada lote. Sus licencias son dominio público o CC BY / CC BY-SA, que piden dar crédito al autor; los créditos están en `creditos.html`, enlazada desde el pie del landing. Si se agregan o cambian fotos, hay que actualizar esa página.

La foto de portada del landing es `media/hero.jpg` (la misma de *Loteamento Jardim Eldorado*, con su crédito en `creditos.html`). Tiene un acercamiento lento, que se desactiva si el sistema pide reducir movimiento.

Para moverlo a otro terreno, cambiar `plano` y `coordenadas` en `js/config.js`.

## Miniaturas para compartir

`og/` está vacío en la demo. Se generan con Chrome o Edge:

```bash
node tools/og-lotes.mjs
```

## Supabase

Para montar el proyecto de Supabase, en el SQL Editor:

1. Ejecutar `supabase/schema.sql`.
2. Ejecutar `supabase/seed.sql` (lo regenera `node tools/seed-supabase.mjs`).

Si el sitio recibe *permission denied for table lotes*, ejecutar `supabase/permisos.sql`: los proyectos nuevos no dan permisos automáticos a las tablas creadas por SQL. Ya va incluido al final de `schema.sql`.

La tarifa por vara² (precio aproximado de los lotes sin precio propio) se edita en `/admin` → *Tarifa general* y se guarda en la tabla `ajustes`. En una base creada antes de ese cambio, ejecutar `supabase/ajustes.sql`. Sin esa tabla, el mapa usa `precioVara` de `js/config.js`.

Para dejar la demo como nueva (por ejemplo, después de una presentación), ejecutar `supabase/reiniciar.sql`: borra todos los lotes, los vuelve a cargar con los estados, precios y fotos de ejemplo, y deja la tarifa en L 950.

Las fotos `fotos/demo/…` se sirven desde el sitio. Las que se suben desde `/admin` van al bucket `fotos`.
