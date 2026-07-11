<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="me.pgtech.web.dto.PlayerSummaryDTO" %>
<%@ page import="me.pgtech.web.dto.PaginaDTO" %>
<%
    request.setAttribute("tituloPagina", "Jugadores");
    request.setAttribute("anchoCompleto", true);
    PaginaDTO<PlayerSummaryDTO> pagina = (PaginaDTO<PlayerSummaryDTO>) request.getAttribute("pagina");
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="mb-0">Jugadores</h1>
    <a href="<%= request.getContextPath() %>/admin" class="btn btn-outline-secondary">Volver al panel</a>
</div>

<%
    String nombreFiltro = (String) request.getAttribute("nombreFiltro");
    String nombreFiltroVal = (nombreFiltro != null) ? nombreFiltro : "";
    String filtroQs = (nombreFiltro != null && !nombreFiltro.isBlank())
        ? "&nombre=" + java.net.URLEncoder.encode(nombreFiltro, java.nio.charset.StandardCharsets.UTF_8)
        : "";
%>

<div class="card mb-3">
    <div class="card-body">
        <form method="get" action="<%= request.getContextPath() %>/players" class="row g-2 align-items-end">
            <div class="col-auto">
                <label for="nombre" class="form-label mb-1">Buscar por nombre</label>
                <input type="text" class="form-control" id="nombre" name="nombre" value="<%= nombreFiltroVal %>" placeholder="Nombre de Minecraft">
            </div>
            <div class="col-auto">
                <button type="submit" class="btn btn-outline-primary">Buscar</button>
                <a href="<%= request.getContextPath() %>/players" class="btn btn-outline-secondary">Limpiar</a>
            </div>
        </form>
    </div>
</div>

<div class="card">
    <div class="card-body">
        <%
            List<PlayerSummaryDTO> players = (pagina != null) ? pagina.getContent() : null;
            if (players == null || players.isEmpty()) {
        %>
            <p class="text-muted mb-0">No hay jugadores para mostrar.</p>
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
                                <th class="text-end">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (PlayerSummaryDTO playerItem : players) {
                            %>
                                    <tr>
                                        <td><%= playerItem.getNombre() %></td>
                                        <td><%= playerItem.getNombrePublico() %></td>
                                        <td><%= playerItem.getTipoUsuario() != null ? playerItem.getTipoUsuario().getNombre() : "-" %></td>
                                        <td><%= playerItem.getRangoUsuario() != null ? playerItem.getRangoUsuario().getNombre() : "-" %></td>
                                        <td><%= playerItem.getPaisPrefix() != null ? playerItem.getPaisPrefix().getNombre() : "-" %></td>
                                        <td class="text-end">
                                            <a href="<%= request.getContextPath() %>/players?id=<%= playerItem.getId() %>" class="btn btn-sm btn-outline-primary">Ver / Editar</a>
                                            <a href="<%= request.getContextPath() %>/players/proyectos?playerId=<%= playerItem.getId() %>"
                                               class="btn btn-sm btn-outline-primary">Proyectos</a>
                                            <form method="post"
                                                action="<%= request.getContextPath() %>/players/eliminar"
                                                class="d-inline"
                                                onsubmit="return confirm('¿Seguro que querés eliminar este jugador? Esta acción no se puede deshacer.');">
                                                <input type="hidden" name="id" value="<%= playerItem.getId() %>"/>
                                                <button type="submit" class="btn btn-sm btn-outline-danger">Eliminar</button>
                                            </form>
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

<%
    if (pagina != null && pagina.getTotalPages() > 1) {
        int paginaActual = pagina.getPage();
        int totalPaginas = pagina.getTotalPages();
        int rangoPaginas = 2;

        int desde = Math.max(0, paginaActual - rangoPaginas);
        int hasta = Math.min(totalPaginas - 1, paginaActual + rangoPaginas);
%>
        <nav class="mt-3">
            <ul class="pagination justify-content-center flex-wrap">
                <li class="page-item <%= paginaActual == 0 ? "disabled" : "" %>">
                    <a class="page-link" href="<%= request.getContextPath() %>/players?page=0<%= filtroQs %>">&laquo;&laquo;</a>
                </li>
                <li class="page-item <%= paginaActual == 0 ? "disabled" : "" %>">
                    <a class="page-link" href="<%= request.getContextPath() %>/players?page=<%= paginaActual - 1 %><%= filtroQs %>">Anterior</a>
                </li>

                <% if (desde > 0) { %>
                    <li class="page-item disabled"><span class="page-link">...</span></li>
                <% } %>

                <%
                    for (int i = desde; i <= hasta; i++) {
                %>
                        <li class="page-item <%= i == paginaActual ? "active" : "" %>">
                            <a class="page-link" href="<%= request.getContextPath() %>/players?page=<%= i %><%= filtroQs %>"><%= i + 1 %></a>
                        </li>
                <%
                    }
                %>

                <% if (hasta < totalPaginas - 1) { %>
                    <li class="page-item disabled"><span class="page-link">...</span></li>
                <% } %>

                <li class="page-item <%= paginaActual >= totalPaginas - 1 ? "disabled" : "" %>">
                    <a class="page-link" href="<%= request.getContextPath() %>/players?page=<%= paginaActual + 1 %><%= filtroQs %>">Siguiente</a>
                </li>
                <li class="page-item <%= paginaActual >= totalPaginas - 1 ? "disabled" : "" %>">
                    <a class="page-link" href="<%= request.getContextPath() %>/players?page=<%= totalPaginas - 1 %><%= filtroQs %>">&raquo;&raquo;</a>
                </li>
            </ul>
            <p class="text-center text-muted small">
                Página <%= paginaActual + 1 %> de <%= totalPaginas %> - <%= pagina.getTotalElements() %> jugadores en total
            </p>
        </nav>
<%
    }
%>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>