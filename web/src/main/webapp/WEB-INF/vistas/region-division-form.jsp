<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="me.pgtech.web.dto.RegionDivisionDetailDTO" %>
<%@ page import="me.pgtech.web.dto.DivisionDetailDTO" %>
<%
    RegionDivisionDetailDTO regionEditar = (RegionDivisionDetailDTO) request.getAttribute("region");
    DivisionDetailDTO division = (DivisionDetailDTO) request.getAttribute("division");
    boolean esNuevo = (regionEditar == null);
    request.setAttribute("tituloPagina", esNuevo ? "Nueva Región de División" : "Editar Región de División");
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex flex-column align-items-center">
    <h1 class="text-center mb-4"><%= esNuevo ? "Nueva Región de " + division.getNombre() : "Editar Región de " + division.getNombre() %></h1>

    <div class="card" style="max-width: 500px; width: 100%;">
        <div class="card-body">
            <form method="post"
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

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">Guardar</button>
                    <a href="<%= request.getContextPath() %>/divisiones/regiones?divisionId=<%= division.getId() %>" class="btn btn-outline-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>