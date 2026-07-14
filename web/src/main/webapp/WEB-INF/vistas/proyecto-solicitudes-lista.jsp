<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="me.pgtech.web.dto.PlayerSummaryDTO" %>
<%@ page import="me.pgtech.web.dto.ProyectoDetailDTO" %>
<%
    ProyectoDetailDTO proyecto = (ProyectoDetailDTO) request.getAttribute("proyecto");
    List<PlayerSummaryDTO> solicitudes = (List<PlayerSummaryDTO>) request.getAttribute("solicitudes");
    request.setAttribute("tituloPagina", "Solicitudes de " + proyecto.getId());
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="mb-0">Solicitudes de unión a <%= proyecto.getId() %></h1>
    <a href="<%= request.getContextPath() %>/proyectos?id=<%= proyecto.getId() %>" class="btn btn-outline-secondary">Volver al proyecto</a>
</div>

<div class="card">
    <div class="card-body">
        <%
            if (solicitudes == null || solicitudes.isEmpty()) {
        %>
                <p class="text-muted mb-0">No hay solicitudes pendientes.</p>
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
                                <th>País</th>
                                <th class="text-end">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (PlayerSummaryDTO solicitanteItem : solicitudes) {
                            %>
                                    <tr>
                                        <td><%= solicitanteItem.getNombre() %></td>
                                        <td><%= solicitanteItem.getNombrePublico() %></td>
                                        <td><%= solicitanteItem.getTipoUsuario() != null ? solicitanteItem.getTipoUsuario().getNombre() : "-" %></td>
                                        <td><%= solicitanteItem.getPaisPrefix() != null ? solicitanteItem.getPaisPrefix().getNombrePublico() : "-" %></td>
                                        <td class="text-end">
                                            <div class="d-flex gap-1 justify-content-end">
                                                <form method="post" action="<%= request.getContextPath() %>/proyectos/solicitudes/aceptar" class="d-inline">
                                                    <input type="hidden" name="proyectoId" value="<%= proyecto.getId() %>"/>
                                                    <input type="hidden" name="playerId" value="<%= solicitanteItem.getId() %>"/>
                                                    <button type="submit" class="btn btn-sm btn-outline-success">Aceptar</button>
                                                </form>
                                                <form method="post" action="<%= request.getContextPath() %>/proyectos/solicitudes/rechazar" class="d-inline"
                                                      onsubmit="return confirm('¿Rechazar esta solicitud?');">
                                                    <input type="hidden" name="proyectoId" value="<%= proyecto.getId() %>"/>
                                                    <input type="hidden" name="playerId" value="<%= solicitanteItem.getId() %>"/>
                                                    <button type="submit" class="btn btn-sm btn-outline-danger">Rechazar</button>
                                                </form>
                                            </div>
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