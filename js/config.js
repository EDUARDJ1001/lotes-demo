// Configuración compartida por el landing (index.html) y el mapa (mapa.html)
window.SITIO = {
  whatsapp: '', // número con código de país, p.ej. '50499999999'; vacío oculta los botones de WhatsApp
  moneda: 'L',
  precioVara: 950, // lempiras por vara²: precio aproximado de los lotes que no tienen "precio" en el inventario
  coordenadas: { lat: 15.419750, lng: -87.883960 }, // centro del proyecto (landing y Google Maps)
  // Ubicación del plano ficticio sobre el mapa: el punto "origen" del plano (metros, X al este, Y al norte) cae en
  // lat/lng y el plano se gira "rotacion" grados en sentido antihorario. Mover lat/lng: 0.00001° ≈ 1.1 m.
  // Terreno de ejemplo: un campo vacío al oeste de La Lima (Cortés); el bulevar sale a la calle existente del este.
  plano: { origen: [0, 0], lat: 15.418977, lng: -87.885130, rotacion: 0 },
  radioMapaKm: 5, // el mapa no deja alejarse ni moverse más allá de este radio alrededor del proyecto
  // Supabase (Project Settings → API): URL del proyecto y clave pública "anon"/"publishable".
  // Vacío = se usa data/inventario.json. Nunca poner aquí la clave "service_role"/"secret".
  supabase: {
    url: 'https://olreqhhpfgsvwvzgfgni.supabase.co',
    anonKey: 'sb_publishable_kEzlpb6e6YnPd6meqlycAw_nVkLli7t',
  },
};
