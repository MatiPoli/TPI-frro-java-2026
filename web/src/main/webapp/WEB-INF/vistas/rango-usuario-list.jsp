<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="me.pgtech.web.dto.RangoUsuarioDTO" %>
<%
    request.setAttribute("tituloPagina", "Rangos");
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="mb-0">Rangos</h1>
    <a href="<%= request.getContextPath() %>/rangos-usuario/nuevo" class="btn btn-primary">+ Nuevo</a>
</div>

<div class="card">
    <div class="card-body">
        <%
            List<RangoUsuarioDTO> rangos = (List<RangoUsuarioDTO>) request.getAttribute("rangos");
            if (rangos == null || rangos.isEmpty()) {
        %>
                <p class="text-muted mb-0">No hay rangos cargados todavía.</p>
        <%
            } else {
        %>
                <table class="table table-striped align-middle mb-0">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th class="text-end">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (RangoUsuarioDTO rango : rangos) {
                        %>
                                <tr>
                                    <td><%= rango.getId() %></td>
                                    <td><%= rango.getNombre() %></td>
                                    <td class="text-end">
                                        <a href="<%= request.getContextPath() %>/rangos-usuario?id=<%= rango.getId() %>" class="btn btn-sm btn-outline-primary">Editar</a>
                                        <form method="post" action="<%= request.getContextPath() %>/rangos-usuario/eliminar" class="d-inline" onsubmit="return confirm('¿Seguro que querés eliminar este rango?');">
                                            <input type="hidden" name="id" value="<%= rango.getId() %>"/>
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