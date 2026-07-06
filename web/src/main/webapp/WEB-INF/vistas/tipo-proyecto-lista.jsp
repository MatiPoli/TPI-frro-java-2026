<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="me.pgtech.web.dto.TipoProyectoDTO" %>
<%
    request.setAttribute("tituloPagina", "Tipos de Proyecto");
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="mb-0">Tipos de Proyecto</h1>
    <div class="d-flex gap-2">
        <a href="<%= request.getContextPath() %>/admin" class="btn btn-outline-secondary">Volver al panel</a>
        <a href="<%= request.getContextPath() %>/tipos-proyecto/nuevo" class="btn btn-primary">+ Nuevo</a>
    </div>
</div>

<div class="card">
    <div class="card-body">
        <%
            List<TipoProyectoDTO> tiposProyecto = (List<TipoProyectoDTO>) request.getAttribute("tiposProyecto");
            if (tiposProyecto == null || tiposProyecto.isEmpty()) {
        %>
                <p class="text-muted mb-0">No hay tipos de proyecto cargados todavía.</p>
        <%
            } else {
        %>
                <table class="table table-striped align-middle mb-0">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Máx. miembros</th>
                            <th>Tamaño mínimo</th>
                            <th>Tamaño máximo</th>
                            <th class="text-end">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (TipoProyectoDTO tipoProyecto : tiposProyecto) {
                        %>
                                <tr>
                                    <td><%= tipoProyecto.getId() %></td>
                                    <td><%= tipoProyecto.getNombre() %></td>
                                    <td><%= tipoProyecto.getMaxMiembros() %></td>
                                    <td><%= tipoProyecto.getTamanoMin() %></td>
                                    <td><%= tipoProyecto.getTamanoMax() %></td>
                                    <td class="text-end">
                                        <a href="<%= request.getContextPath() %>/tipos-proyecto?id=<%= tipoProyecto.getId() %>" class="btn btn-sm btn-outline-primary">Editar</a>

                                        <form method="post" action="<%= request.getContextPath() %>/tipos-proyecto/eliminar" class="d-inline" onsubmit="return confirm('¿Seguro que querés eliminar este tipo de proyecto?');">
                                            <input type="hidden" name="id" value="<%= tipoProyecto.getId() %>"/>
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