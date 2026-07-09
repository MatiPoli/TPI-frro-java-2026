<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="me.pgtech.web.dto.PlayerDetailDTO" %>
<%@ page import="me.pgtech.web.dto.ProyectoSummaryDTO" %>
<%
    PlayerDetailDTO player = (PlayerDetailDTO) request.getAttribute("player");
    List<ProyectoSummaryDTO> proyectos = (List<ProyectoSummaryDTO>) request.getAttribute("proyectos");
    request.setAttribute("tituloPagina", "Proyectos de " + player.getNombrePublico());
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="mb-0">Proyectos de <%= player.getNombrePublico() %></h1>
    <a href="<%= request.getContextPath() %>/players?id=<%= player.getId() %>" class="btn btn-outline-secondary">Volver al jugador</a>
</div>

<div class="card">
    <div class="card-body">
        <%
            if (proyectos == null || proyectos.isEmpty()) {
        %>
                <p class="text-muted mb-0">Este jugador no tiene proyectos.</p>
        <%
            } else {
        %>
                <div class="table-responsive">
                    <table class="table table-striped align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Nombre</th>
                                <th>Descripción</th>
                                <th>Estado</th>
                                <th>Tipo</th>
                                <th>Tamaño</th>
                                <th class="text-end">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (ProyectoSummaryDTO proyectoItem : proyectos) {
                            %>
                                    <tr>
                                        <td><%= proyectoItem.getNombre() %></td>
                                        <td><%= proyectoItem.getDescripcion() %></td>
                                        <td><span class="badge bg-secondary"><%= proyectoItem.getEstado() %></span></td>
                                        <td><%= proyectoItem.getTipoProyecto() != null ? proyectoItem.getTipoProyecto().getNombre() : "-" %></td>
                                        <td><%= proyectoItem.getTamaño() %></td>
                                        <td class="text-end">
                                            <a href="<%= request.getContextPath() %>/proyectos?id=<%= proyectoItem.getId() %>"
                                               class="btn btn-sm btn-outline-primary">Ver</a>
                                        </td>
                                    </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
        <%
            }
        %>
    </div>
</div>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>