<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="me.pgtech.web.dto.PlayerDetailDTO" %>
<%@ page import="me.pgtech.web.dto.ProyectoSummaryDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>

<% request.setAttribute("anchoCompleto", true); %>

<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>
<%
    
    PlayerDetailDTO player = (PlayerDetailDTO) request.getAttribute("player");
    boolean esMismoJugador = (sessionPlayer != null && sessionPlayer.getId().equals(player.getId()));
    List<ProyectoSummaryDTO> proyectos = (List<ProyectoSummaryDTO>) request.getAttribute("proyectos");
    request.setAttribute("tituloPagina", "Proyectos de " + player.getNombrePublico());

    SimpleDateFormat sdfLista = new SimpleDateFormat("dd/MM/yyyy");
%>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="mb-0">Proyectos de <%= player.getNombrePublico() %></h1>
    <% if (esMismoJugador) { %>
        <a href="<%= request.getContextPath() %>/perfil" class="btn btn-outline-secondary">Volver a mi perfil</a>
    <% } else { %>
        <a href="<%= request.getContextPath() %>/players?id=<%= player.getId() %>" class="btn btn-outline-secondary">Volver al jugador</a>
    <% } %>
</div>

<div class="card">
    <div class="card-body">
        <%
            if (proyectos == null || proyectos.isEmpty()) {
        %>
            <% if (esMismoJugador) { %>
                <p class="text-muted mb-0">No tenés proyectos creados.</p>
            <% } else { %>
                <p class="text-muted mb-0">Este jugador no tiene proyectos creados.</p>
            <% } %>
        <%
            } else {
        %>
                <div class="table-responsive">
                    <table class="table table-striped align-middle mb-0">
                        <thead>
                        <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Descripción</th>
                                <th>Estado</th>
                                <th>Tamaño</th>
                                <th>Creado</th>
                                <th>Terminado</th>
                                <th>Tipo</th>
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
                                        <td><%= proyectoItem.getId() %></td>
                                        <td><%= proyectoItem.getNombre() %></td>
                                        <td><%= proyectoItem.getDescripcion() %></td>
                                        <td><span class="badge bg-secondary"><%= proyectoItem.getEstado() %></span></td>
                                        <td><%= proyectoItem.getTamaño() %></td>
                                        <td><%= proyectoItem.getFechaCreado() != null ? sdfLista.format(proyectoItem.getFechaCreado()) : "-" %></td>
                                        <td><%= proyectoItem.getFechaTerminado() != null ? sdfLista.format(proyectoItem.getFechaTerminado()) : "-" %></td>
                                        <td><%= proyectoItem.getTipoProyecto() != null ? proyectoItem.getTipoProyecto().getNombre() : "-" %></td>
                                        <td><%= proyectoItem.getLider() != null ? proyectoItem.getLider().getNombrePublico() : "-" %></td>
                                        <td><%= proyectoItem.getDivision() != null ? proyectoItem.getDivision().getContexto() + ", " + proyectoItem.getDivision().getNam() : "-" %></td>
                                        <td class="text-end">
                                            <div class="d-flex flex-wrap gap-1 justify-content-end">
                                                <a href="<%= request.getContextPath() %>/proyectos?id=<%= proyectoItem.getId() %>"
                                                   class="btn btn-sm btn-outline-primary">Ver</a>
                                                <a href="<%= request.getContextPath() %>/proyectos/miembros?proyectoId=<%= proyectoItem.getId() %>"
                                                   class="btn btn-sm btn-outline-primary">Miembros</a>
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