<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="me.pgtech.web.dto.TipoProyectoDTO" %>
<%
    TipoProyectoDTO tipoProyecto = (TipoProyectoDTO) request.getAttribute("tipoProyecto");
    boolean esNuevo = (tipoProyecto == null);
    request.setAttribute("tituloPagina", esNuevo ? "Nuevo Tipo de Proyecto" : "Editar Tipo de Proyecto");
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex flex-column align-items-center">
    <h1 class="text-center mb-4"><%= esNuevo ? "Nuevo Tipo de Proyecto" : "Editar Tipo de Proyecto" %></h1>

    <div class="card" style="max-width: 500px; width: 100%;">
        <div class="card-body">
            <form method="post" action="<%= request.getContextPath() %>/tipos-proyecto/<%= esNuevo ? "crear" : "actualizar" %>">

                <% if (!esNuevo) { %>
                    <input type="hidden" name="id" value="<%= tipoProyecto.getId() %>"/>
                <% } %>

                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre</label>
                    <input type="text" class="form-control" id="nombre" name="nombre" value="<%= esNuevo ? "" : tipoProyecto.getNombre() %>" required maxlength="50">
                </div>

                <div class="mb-3">
                    <label for="maxMiembros" class="form-label">Máx. miembros</label>
                    <input type="number" class="form-control" id="maxMiembros" name="maxMiembros" value="<%= esNuevo ? "" : tipoProyecto.getMaxMiembros() %>" required min="0">
                </div>

                <div class="mb-3">
                    <label for="tamanoMin" class="form-label">Tamaño mínimo</label>
                    <input type="number" class="form-control" id="tamanoMin" name="tamanoMin" value="<%= esNuevo ? "" : tipoProyecto.getTamanoMin() %>" required min="0">
                </div>

                <div class="mb-3">
                    <label for="tamanoMax" class="form-label">Tamaño máximo</label>
                    <input type="number" class="form-control" id="tamanoMax" name="tamanoMax" value="<%= esNuevo ? "" : tipoProyecto.getTamanoMax() %>" required min="0">
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">Guardar</button>
                    <a href="<%= request.getContextPath() %>/tipos-proyecto" class="btn btn-outline-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>