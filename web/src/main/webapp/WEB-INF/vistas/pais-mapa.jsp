<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="me.pgtech.web.dto.RegionPaisMapaDTO" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="com.google.gson.JsonArray" %>
<%@ page import="com.google.gson.JsonParser" %>
<%
    request.setAttribute("tituloPagina", "Mapa de Países");
    request.setAttribute("anchoCompleto", true);

    List<RegionPaisMapaDTO> regiones = (List<RegionPaisMapaDTO>) request.getAttribute("regiones");

    JsonArray features = new JsonArray();
    if (regiones != null) {
        for (RegionPaisMapaDTO r : regiones) {
            if (r.getPolygon() == null) continue;
            try {
                JsonObject geometry = JsonParser.parseString(r.getPolygon()).getAsJsonObject();
                JsonObject properties = new JsonObject();
                properties.addProperty("nombre", r.getNombre());
                properties.addProperty("pais", r.getPaisNombre());

                JsonObject feature = new JsonObject();
                feature.addProperty("type", "Feature");
                feature.add("geometry", geometry);
                feature.add("properties", properties);
                features.add(feature);
            } catch (Exception e) { /* se salta polígonos mal formados */ }
        }
    }

    JsonObject featureCollection = new JsonObject();
    featureCollection.addProperty("type", "FeatureCollection");
    featureCollection.add("features", features);
    String geoJsonRegiones = featureCollection.toString();
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="mb-0 h3">Mapa de Países</h1>
    <a href="<%= request.getContextPath() %>/paises" class="btn btn-outline-secondary">Volver al listado</a>
</div>

<% if (regiones == null || regiones.isEmpty()) { %>
    <div class="card"><div class="card-body"><p class="text-muted mb-0">No hay regiones de país cargadas todavía.</p></div></div>
<% } else { %>
    <div class="card"><div class="card-body p-0"><div id="mapaRegionesPais" style="height: 600px;"></div></div></div>
<% } %>

<script id="geoJsonRegionesData" type="application/json"><%= geoJsonRegiones %></script>

<script>
    const dataRegionesPais = JSON.parse(document.getElementById('geoJsonRegionesData').textContent);

    const map = L.map('mapaRegionesPais').setView([-32.94, -60.65], 4);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', { attribution: '&copy; OpenStreetMap' }).addTo(map);

    const geoJsonLayer = L.geoJSON(dataRegionesPais, {
        style: { color: '#2f6fed', weight: 2, fillOpacity: 0.15 },
        onEachFeature: (feature, layer) => {
            const p = feature.properties;
            layer.bindPopup('<strong>' + p.pais + '</strong><br>' + p.nombre);
        }
    }).addTo(map);

    if (dataRegionesPais.features.length > 0) {
        map.fitBounds(geoJsonLayer.getBounds());
    }
</script>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>