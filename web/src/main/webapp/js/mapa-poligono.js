function initMapaPoligono(config) {
    const {
        mapElementId,
        inputPolygonId,
        geoJsonInicial,
        capasContexto = [], // array de GeoJSON Geometry, se dibujan de fondo sin edición
        lat = -32.94,
        lon = -60.65,
        zoom = 12
    } = config;

    const map = L.map(mapElementId).setView([lat, lon], zoom);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; OpenStreetMap'
    }).addTo(map);

    // Capas de contexto: regiones ya existentes del mismo país/división, solo lectura
    if (capasContexto.length > 0) {
        capasContexto.forEach(geo => {
            L.geoJSON(geo, {
                style: { color: '#9aa4b2', weight: 1, dashArray: '4', fillOpacity: 0.05 },
                interactive: false
            }).addTo(map);
        });
    }

    const drawnItems = new L.FeatureGroup();
    map.addLayer(drawnItems);

    if (geoJsonInicial) {
        try {
            const geoJsonLayer = L.geoJSON(JSON.parse(geoJsonInicial));
            geoJsonLayer.eachLayer(layer => drawnItems.addLayer(layer));
        } catch (e) {
            console.error('No se pudo parsear el polígono inicial:', e);
        }
    }

    // Si hay capas de contexto o polígono inicial, ajustamos el zoom a todo lo visible
    const grupoTotal = new L.FeatureGroup([...drawnItems.getLayers()]);
    if (capasContexto.length > 0 || drawnItems.getLayers().length > 0) {
        try {
            const bounds = L.geoJSON({ type: 'FeatureCollection', features: capasContexto.map(g => ({ type: 'Feature', geometry: g, properties: {} })) }).getBounds();
            if (drawnItems.getLayers().length > 0) {
                map.fitBounds(drawnItems.getBounds());
            } else if (bounds.isValid()) {
                map.fitBounds(bounds);
            }
        } catch (e) { /* si no hay bounds válidos, se queda con el setView default */ }
    }

    const drawControl = new L.Control.Draw({
        edit: { featureGroup: drawnItems },
        draw: {
            polygon: true,
            marker: false,
            polyline: false,
            circle: false,
            circlemarker: false,
            rectangle: false
        }
    });
    map.addControl(drawControl);

    map.on(L.Draw.Event.CREATED, e => {
        drawnItems.clearLayers();
        drawnItems.addLayer(e.layer);
        actualizarInput();
    });
    map.on(L.Draw.Event.EDITED, actualizarInput);
    map.on(L.Draw.Event.DELETED, actualizarInput);

    function actualizarInput() {
        const input = document.getElementById(inputPolygonId);
        if (drawnItems.getLayers().length === 0) {
            input.value = '';
            return;
        }
        const geoJson = drawnItems.toGeoJSON();
        input.value = JSON.stringify(geoJson.features[0].geometry);
    }

    return map;
}