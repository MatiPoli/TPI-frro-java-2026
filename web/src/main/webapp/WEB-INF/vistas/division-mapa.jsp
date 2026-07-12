<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="me.pgtech.web.dto.RegionDivisionMapaDTO" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="com.google.gson.JsonArray" %>
<%@ page import="com.google.gson.JsonParser" %>
<%
    request.setAttribute("tituloPagina", "Mapa de Divisiones");
    request.setAttribute("anchoCompleto", true);

    List<RegionDivisionMapaDTO> regiones = (List<RegionDivisionMapaDTO>) request.getAttribute("regiones");

    JsonArray features = new JsonArray();
    if (regiones != null) {
        for (RegionDivisionMapaDTO r : regiones) {
            if (r.getPolygon() == null) continue;
            try {
                JsonObject geometry = JsonParser.parseString(r.getPolygon()).getAsJsonObject();
                JsonObject properties = new JsonObject();
                properties.addProperty("nombre", r.getNombre());
                properties.addProperty("division", r.getDivisionNombre());

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
    <h1 class="mb-0">Mapa de Divisiones</h1>
    <a href="<%= request.getContextPath() %>/divisiones" class="btn btn-outline-secondary">Volver al listado</a>
</div>

<% if (regiones == null || regiones.isEmpty()) { %>
    <div class="card"><div class="card-body"><p class="text-muted mb-0">No hay regiones de división cargadas todavía.</p></div></div>
<% } else { %>
    <div class="card"><div class="card-body p-0"><div id="mapaRegionesDivision" style="height: 600px;"></div></div></div>
<% } %>

<script id="geoJsonRegionesData" type="application/json"><%= geoJsonRegiones %></script>

<script>
    const dataRegionesDivision = JSON.parse(document.getElementById('geoJsonRegionesData').textContent);

    const map = L.map('mapaRegionesDivision').setView([-32.94, -60.65], 4);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', { attribution: '&copy; OpenStreetMap' }).addTo(map);

    const geoJsonLayer = L.geoJSON(dataRegionesDivision, {
        style: { color: '#3fb950', weight: 2, fillOpacity: 0.15 },
        onEachFeature: (feature, layer) => {
            const p = feature.properties;
            layer.bindPopup('<strong>' + p.division + '</strong><br>' + p.nombre);
        }
    }).addTo(map);

    if (dataRegionesDivision.features.length > 0) {
        map.fitBounds(geoJsonLayer.getBounds());
    }
</script>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>