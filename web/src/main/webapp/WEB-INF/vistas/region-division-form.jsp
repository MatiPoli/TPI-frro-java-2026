<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="me.pgtech.web.dto.RegionDivisionDetailDTO" %>
<%@ page import="me.pgtech.web.dto.DivisionDetailDTO" %>
<%
    RegionDivisionDetailDTO regionEditar = (RegionDivisionDetailDTO) request.getAttribute("region");
    DivisionDetailDTO division = (DivisionDetailDTO) request.getAttribute("division");
    boolean esNuevo = (regionEditar == null);
    request.setAttribute("tituloPagina", esNuevo ? "Nueva Región de División" : "Editar Región de División");

    String polygonInicial = (!esNuevo && regionEditar.getPolygon() != null)
        ? regionEditar.getPolygon().replace("\"", "\\\"")
        : "";
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex flex-column align-items-center">
    <h1 class="text-center mb-4"><%= esNuevo ? "Nueva Región de " + division.getNombre() : "Editar Región de " + division.getNombre() %></h1>

    <div class="card mb-3" style="max-width: 700px; width: 100%;">
        <div class="card-body">
            <form method="post" id="formRegion"
                  action="<%= request.getContextPath() %>/divisiones/regiones/<%= esNuevo ? "añadir" : "actualizar" %>?divisionId=<%= division.getId() %>">

                <% if (!esNuevo) { %>
                    <input type="hidden" name="id" value="<%= regionEditar.getId() %>"/>
                <% } %>
                <input type="hidden" name="divisionId" value="<%= division.getId() %>"/>

                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre</label>
                    <input type="text" class="form-control" id="nombre" name="nombre"
                           value="<%= esNuevo ? "" : regionEditar.getNombre() %>" required maxlength="50">
                </div>

                <div class="mb-3">
                    <label class="form-label">Polígono</label>
                    <div id="mapaPoligono"></div>
                    <small class="text-muted">Usá las herramientas de dibujo del mapa para trazar la región.</small>
                    <input type="hidden" id="polygon" name="polygon" required/>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">Guardar</button>
                    <a href="<%= request.getContextPath() %>/divisiones/regiones?divisionId=<%= division.getId() %>" class="btn btn-outline-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    initMapaPoligono({
        mapElementId: 'mapaPoligono',
        inputPolygonId: 'polygon',
        geoJsonInicial: "<%= polygonInicial %>" || null
    });

    document.getElementById('formRegion').addEventListener('submit', function (e) {
        const input = document.getElementById('polygon');
        if (!input.value) {
            e.preventDefault();
            alert('Tenés que dibujar un polígono antes de guardar.');
        }
    });
</script>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>