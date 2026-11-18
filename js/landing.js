// Landing: enlaces de ubicación y conteo de lotes disponibles
const { lat, lng } = window.SITIO.coordenadas;

document.getElementById('mapa-google').src = `https://www.google.com/maps?q=${lat},${lng}&z=15&output=embed`;
document.getElementById('coords').textContent = `${lat.toFixed(6)}, ${lng.toFixed(6)}`;
document.getElementById('btn-ruta').href = `https://www.google.com/maps/dir/?api=1&destination=${lat},${lng}`;

window.cargarInventario().then(inv => {
  document.getElementById('stat-disponibles').textContent =
    Object.values(inv).filter(l => l.estado === 'disponible').length;
}).catch(() => {});

// "Desde" y "Área total" salen de la geometría de los lotes
fetch('data/lotes.json').then(r => r.json()).then(lotes => {
  const m2 = n => `${Math.round(n).toLocaleString('en-US')} m²`;
  document.getElementById('stat-desde').textContent = m2(Math.min(...lotes.map(l => l.area_m2)));
  document.getElementById('stat-area').textContent = m2(lotes.reduce((s, l) => s + l.area_m2, 0));
}).catch(() => {});

