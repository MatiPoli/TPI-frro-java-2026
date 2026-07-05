<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="me.pgtech.web.dto.TipoUsuarioDTO" %>
<%
    request.setAttribute("tituloPagina", "Tipos de Usuario");
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="mb-0">Tipos de Usuario</h1>
    <a href="<%= request.getContextPath() %>/tipos-usuario/nuevo" class="btn btn-primary">+ Nuevo</a>
</div>

<div class="card">
    <div class="card-body">
        <%
            List<TipoUsuarioDTO> tipos = (List<TipoUsuarioDTO>) request.getAttribute("tipos");
            if (tipos == null || tipos.isEmpty()) {
        %>
                <p class="text-muted mb-0">No hay tipos de usuario cargados todavía.</p>
        <%
            } else {
        %>
                <table class="table table-striped align-middle mb-0">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Descripción</th>
                            <th>Máx. proyectos simultáneos</th>
                            <th class="text-end">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (TipoUsuarioDTO tipo : tipos) {
                        %>
                                <tr>
                                    <td><%= tipo.getId() %></td>
                                    <td><%= tipo.getNombre() %></td>
                                    <td><%= tipo.getDescripcion() %></td>
                                    <td><%= tipo.getCantProyecSim() %></td>
                                    <td class="text-end">
                                        <a href="<%= request.getContextPath() %>/tipos-usuario?id=<%= tipo.getId() %>"
                                           class="btn btn-sm btn-outline-primary">Editar</a>

                                        <form method="post"
                                              action="<%= request.getContextPath() %>/tipos-usuario/eliminar"
                                              class="d-inline"
                                              onsubmit="return confirm('¿Seguro que querés eliminar este tipo de usuario?');">
                                            <input type="hidden" name="id" value="<%= tipo.getId() %>"/>
                                            <button type="submit" class="btn btn-sm btn-outline-danger">Eliminar</button>
                                        </form>
                                    </td>
                                </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
        <%
            }
        %>
    </div>
</div>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>