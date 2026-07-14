<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="me.pgtech.web.dto.RegionPaisDetailDTO" %>
<%@ page import="me.pgtech.web.dto.PaisDetailDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="me.pgtech.web.dto.RegionPaisMapaDTO" %>
<%@ page import="com.google.gson.JsonArray" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="com.google.gson.JsonParser" %>
<%
    RegionPaisDetailDTO regionEditar = (RegionPaisDetailDTO) request.getAttribute("region");
    PaisDetailDTO pais = (PaisDetailDTO) request.getAttribute("pais");
    boolean esNuevo = (regionEditar == null);
    request.setAttribute("tituloPagina", esNuevo ? "Nueva Región de País" : "Editar Región de País");

    String polygonInicial = (!esNuevo && regionEditar.getPolygon() != null)
        ? regionEditar.getPolygon().replace("\"", "\\\"")
        : "";
%>
<%
    List<RegionPaisMapaDTO> regionesContexto = (List<RegionPaisMapaDTO>) request.getAttribute("regionesContexto");
    JsonArray capasContexto = new JsonArray();
    if (regionesContexto != null) {
        for (RegionPaisMapaDTO r : regionesContexto) {
            // no mostramos como contexto la región que se está editando actualmente
            if (!esNuevo && r.getId() == regionEditar.getId()) continue;
            if (r.getPolygon() == null) continue;
            try {
                capasContexto.add(JsonParser.parseString(r.getPolygon()).getAsJsonObject());
            } catch (Exception e) { /* se salta */ }
        }
    }
    String capasContextoJson = capasContexto.toString();
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex flex-column align-items-center">
    <h1 class="text-center mb-4"><%= esNuevo ? "Nueva Región de " + pais.getNombrePublico() : "Editar Región de " + pais.getNombrePublico() %></h1>

    <div class="card mb-3" style="max-width: 700px; width: 100%;">
        <div class="card-body">
            <form method="post" id="formRegion"
                  action="<%= request.getContextPath() %>/paises/regiones/<%= esNuevo ? "añadir" : "actualizar" %>?paisId=<%= pais.getId() %>">

                <% if (!esNuevo) { %>
                    <input type="hidden" name="id" value="<%= regionEditar.getId() %>"/>
                <% } %>
                <input type="hidden" name="paisId" value="<%= pais.getId() %>"/>

                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre</label>
                    <input type="text" class="form-control" id="nombre" name="nombre"
                           value="<%= esNuevo ? "" : regionEditar.getNombre() %>" required maxlength="50">
                </div>

                <div class="mb-3">
                    <label class="form-label">Polígono</label>
                    <div id="mapaPoligono"></div>
                    <small class="text-muted">Usá las herramientas de dibujo del mapa (ícono de polígono a la izquierda) para trazar la región.</small>
                    <input type="hidden" id="polygon" name="polygon" required/>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">Guardar</button>
                    <a href="<%= request.getContextPath() %>/paises/regiones?paisId=<%= pais.getId() %>" class="btn btn-outline-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script id="capasContextoData" type="application/json"><%= capasContextoJson %></script>
<script>
    const capasContextoParsed = JSON.parse(document.getElementById('capasContextoData').textContent);

    initMapaPoligono({
        mapElementId: 'mapaPoligono',
        inputPolygonId: 'polygon',
        geoJsonInicial: "<%= polygonInicial %>" || null,
        capasContexto: capasContextoParsed
    });

    // Validación simple: no dejar enviar el form sin polígono dibujado
    document.getElementById('formRegion').addEventListener('submit', function (e) {
        const input = document.getElementById('polygon');
        if (!input.value) {
            e.preventDefault();
            alert('Tenés que dibujar un polígono antes de guardar.');
        }
    });
</script>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>