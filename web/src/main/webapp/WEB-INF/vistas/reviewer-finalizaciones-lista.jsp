<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="me.pgtech.web.dto.ProyectoSummaryDTO" %>

<%
    request.setAttribute("tituloPagina", "Finalizaciones Pendientes");
    List<ProyectoSummaryDTO> proyectos = (List<ProyectoSummaryDTO>) request.getAttribute("finalizaciones");
    SimpleDateFormat sdfFin = new SimpleDateFormat("dd/MM/yyyy");
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="mb-0">Finalizaciones Pendientes</h1>
    <a href="<%= request.getContextPath() %>/reviewer" class="btn btn-outline-secondary">Volver al panel</a>
</div>

<div class="card">
    <div class="card-body">
        <%
            if (proyectos == null || proyectos.isEmpty()) {
        %>
                <p class="text-muted mb-0">No hay finalizaciones pendientes para los países que sos Reviewer.</p>
        <%
            } else {
        %>
                <div class="table-responsive">
                    <table class="table table-striped align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Nombre</th>
                                <th>Estado</th>
                                <th>Tamaño</th>
                                <th>Creado</th>
                                <th>Líder</th>
                                <th>División</th>
                                <th class="text-end">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (ProyectoSummaryDTO proyectoItem : proyectos) {
                            %>
                                    <tr>
                                        <td><%= proyectoItem.getNombre() %></td>
                                        <td><span class="badge bg-secondary"><%= proyectoItem.getEstado() %></span></td>
                                        <td><%= proyectoItem.getTamaño() %></td>
                                        <td><%= proyectoItem.getFechaCreado() != null ? sdfFin.format(proyectoItem.getFechaCreado()) : "-" %></td>
                                        <td><%= proyectoItem.getLider() != null ? proyectoItem.getLider().getNombrePublico() : "-" %></td>
                                        <td><%= proyectoItem.getDivision() != null ? proyectoItem.getDivision().getNombre() : "-" %></td>
                                        <td class="text-end">
                                            <a href="<%= request.getContextPath() %>/reviewer/finalizaciones/revisar?proyectoId=<%= proyectoItem.getId() %>"
                                               class="btn btn-sm btn-outline-primary">Revisar</a>
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