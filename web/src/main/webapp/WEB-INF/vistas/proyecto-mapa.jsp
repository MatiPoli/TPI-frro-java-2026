<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="me.pgtech.web.dto.ProyectoMapaDTO" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="com.google.gson.JsonArray" %>
<%@ page import="com.google.gson.JsonParser" %>
<%
    request.setAttribute("tituloPagina", "Mapa de Proyectos");
    request.setAttribute("anchoCompleto", true);

    List<ProyectoMapaDTO> proyectos = (List<ProyectoMapaDTO>) request.getAttribute("proyectos");

    JsonArray features = new JsonArray();
    if (proyectos != null) {
        for (ProyectoMapaDTO p : proyectos) {
            try {
                JsonObject geometry = JsonParser.parseString(p.getPoligono()).getAsJsonObject();

                JsonObject properties = new JsonObject();
                properties.addProperty("id", p.getId());
                properties.addProperty("nombre", p.getNombre());
                properties.addProperty("estado", p.getEstado().toString());
                properties.addProperty("lider", p.getLiderNombre() != null ? p.getLiderNombre() : "-");

                JsonObject feature = new JsonObject();
                feature.addProperty("type", "Feature");
                feature.add("geometry", geometry);
                feature.add("properties", properties);

                features.add(feature);
            } catch (Exception e) {
                // Polígono mal formado: se salta sin romper el resto del mapa
            }
        }
    }

    JsonObject featureCollection = new JsonObject();
    featureCollection.addProperty("type", "FeatureCollection");
    featureCollection.add("features", features);

    String geoJsonProyectos = featureCollection.toString();
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="mb-0 h3">Mapa de Proyectos</h1>
    <a href="<%= request.getContextPath() %>/proyectos" class="btn btn-outline-secondary">Volver al listado</a>
</div>

<% if (proyectos == null || proyectos.isEmpty()) { %>
    <div class="card">
        <div class="card-body">
            <p class="text-muted mb-0">No hay proyectos con polígono cargado para mostrar.</p>
        </div>
    </div>
<% } else { %>
    <div class="card">
        <div class="card-body p-0">
            <div id="mapaProyectos" style="height: 600px;"></div>
        </div>
    </div>
    <p class="text-muted small mt-2">Mostrando <%= proyectos.size() %> proyecto(s) con polígono cargado.</p>
<% } %>

<script id="geoJsonProyectosData" type="application/json"><%= geoJsonProyectos %></script>

<script>
    const dataProyectos = JSON.parse(document.getElementById('geoJsonProyectosData').textContent);
    const isLoggedIn = "<%= loggedIn %>" === "true";
    const coloresPorEstado = {
        'ACTIVO': '#3fb950',
        'EN_CREACION': '#7ec8f5',
        'EDITANDO': '#e6b800',
        'EN_FINALIZACION': '#e6b800',
        'EN_FINALIZACION_EDICION': '#e6b800',
        'COMPLETADO': '#2f6fed',
        'REDEFINIENDO': '#e6b800',
        'ABANDONADO': '#e0334f'
    };

    const map = L.map('mapaProyectos').setView([-32.94, -60.65], 5);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; OpenStreetMap'
    }).addTo(map);

    const geoJsonLayer = L.geoJSON(dataProyectos, {
        style: feature => ({
            color: coloresPorEstado[feature.properties.estado] || '#9aa4b2',
            weight: 2,
            fillOpacity: 0.25
        }),
        onEachFeature: (feature, layer) => {
            const p = feature.properties;
            let popupContent = '<strong>' + p.id + '</strong><br>' +
                               '<strong>' + p.nombre + '</strong><br>' +
                               'Estado: ' + p.estado + '<br>' +
                               'Líder: ' + p.lider + '<br>';

            if (isLoggedIn) {
                popupContent += '<a href="<%= request.getContextPath() %>/proyectos?id=' + p.id + '&volverA=mapa">Ver proyecto</a>';
            }

            layer.bindPopup(popupContent);
        }
    }).addTo(map);

    if (dataProyectos.features.length > 0) {
        map.fitBounds(geoJsonLayer.getBounds());
    }
</script>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>