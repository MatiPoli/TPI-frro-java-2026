<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="me.pgtech.web.dto.RangoUsuarioDTO" %>
<%
    RangoUsuarioDTO rangoItem = (RangoUsuarioDTO) request.getAttribute("rango");
    boolean esNuevo = (rangoItem == null);
    request.setAttribute("tituloPagina", esNuevo ? "Nuevo Rango" : "Editar Rango");
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex flex-column align-items-center">
    <h1 class="text-center mb-4"><%= esNuevo ? "Nuevo Rango" : "Editar Rango" %></h1>

    <div class="card" style="max-width: 500px; width: 100%;">
        <div class="card-body">
            <form method="post" action="<%= request.getContextPath() %>/rangos-usuario/<%= esNuevo ? "crear" : "actualizar" %>">

                <% if (!esNuevo) { %>
                    <input type="hidden" name="id" value="<%= rangoItem.getId() %>"/>
                <% } %>

                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre</label>
                    <input type="text" class="form-control" id="nombre" name="nombre" value="<%= esNuevo ? "" : rangoItem.getNombre() %>" required maxlength="50">
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">Guardar</button>
                    <a href="<%= request.getContextPath() %>/rangos-usuario" class="btn btn-outline-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>