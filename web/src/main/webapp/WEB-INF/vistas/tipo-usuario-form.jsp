<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="me.pgtech.web.dto.TipoUsuarioDTO" %>
<%
    TipoUsuarioDTO tipo = (TipoUsuarioDTO) request.getAttribute("tipo");
    boolean esNuevo = (tipo == null);
    request.setAttribute("tituloPagina", esNuevo ? "Nuevo Tipo de Usuario" : "Editar Tipo de Usuario");
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex flex-column align-items-center">
    <h1 class="text-center mb-4"><%= esNuevo ? "Nuevo Tipo de Usuario" : "Editar Tipo de Usuario" %></h1>

    <div class="card" style="max-width: 500px; width: 100%;">
        <div class="card-body">
            <form method="post"
                  action="<%= request.getContextPath() %>/tipos-usuario/<%= esNuevo ? "crear" : "actualizar" %>">

                <% if (!esNuevo) { %>
                    <input type="hidden" name="id" value="<%= tipo.getId() %>"/>
                <% } %>

                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre</label>
                    <input type="text" class="form-control" id="nombre" name="nombre"
                           value="<%= esNuevo ? "" : tipo.getNombre() %>" required maxlength="50">
                </div>

                <div class="mb-3">
                    <label for="descripcion" class="form-label">Descripción</label>
                    <textarea class="form-control" id="descripcion" name="descripcion" rows="2"><%= esNuevo ? "" : tipo.getDescripcion() %></textarea>
                </div>

                <div class="mb-3">
                    <label for="cantProyecSim" class="form-label">Máx. proyectos simultáneos</label>
                    <input type="number" class="form-control" id="cantProyecSim"
                           name="cantProyecSim" value="<%= esNuevo ? "" : tipo.getCantProyecSim() %>"
                           required min="0">
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">Guardar</button>
                    <a href="<%= request.getContextPath() %>/tipos-usuario" class="btn btn-outline-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>