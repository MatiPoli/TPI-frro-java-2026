<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="me.pgtech.web.dto.PlayerSummaryDTO" %>
<%@ page import="me.pgtech.web.dto.ProyectoDetailDTO" %>
<%
    ProyectoDetailDTO proyecto = (ProyectoDetailDTO) request.getAttribute("proyecto");
    List<PlayerSummaryDTO> miembros = (List<PlayerSummaryDTO>) request.getAttribute("miembros");
    request.setAttribute("tituloPagina", "Miembros de " + proyecto.getId());
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>
<%@ include file="/WEB-INF/vistas/fragmentos/volver-check.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="mb-0">Miembros de <%= proyecto.getId() %></h1>
    <a href="<%= urlConVolver(request.getContextPath() + "/proyectos?id=" + proyecto.getId(), volverA) %>" class="btn btn-outline-secondary">Volver al proyecto</a>
</div>
<div class="card">
    <div class="card-body">
        <%
            if (miembros == null || miembros.isEmpty()) {
        %>
                <p class="text-muted mb-0">Este proyecto no tiene miembros todavía.</p>
        <%
            } else {
        %>
                <div class="table-responsive">
                    <table class="table table-striped align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Nombre</th>
                                <th>Nombre Público</th>
                                <th>Tipo de Usuario</th>
                                <th>Rango</th>
                                <th>País</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (PlayerSummaryDTO miembroItem : miembros) {
                            %>
                                    <tr>
                                        <td><%= miembroItem.getNombre() %></td>
                                        <td><%= miembroItem.getNombrePublico() %></td>
                                        <td><%= miembroItem.getTipoUsuario() != null ? miembroItem.getTipoUsuario().getNombre() : "-" %></td>
                                        <td><%= miembroItem.getRangoUsuario() != null ? miembroItem.getRangoUsuario().getNombre() : "-" %></td>
                                        <td><%= miembroItem.getPaisPrefix() != null ? miembroItem.getPaisPrefix().getNombre() : "-" %></td>
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