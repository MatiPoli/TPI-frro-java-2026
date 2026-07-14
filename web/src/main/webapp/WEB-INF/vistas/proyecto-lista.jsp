<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="me.pgtech.web.dto.ProyectoSummaryDTO" %>
<%@ page import="me.pgtech.web.dto.PaginaDTO" %>
<%
    request.setAttribute("tituloPagina", "Proyectos");
    request.setAttribute("anchoCompleto", true);
    PaginaDTO<ProyectoSummaryDTO> pagina = (PaginaDTO<ProyectoSummaryDTO>) request.getAttribute("pagina");
    SimpleDateFormat sdfLista = new SimpleDateFormat("dd/MM/yyyy");
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>


<div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="mb-0">Proyectos</h1>
</div>

<%
    String idFiltro = (String) request.getAttribute("idFiltro");
    String idFiltroVal = (idFiltro != null) ? idFiltro : "";
    String filtroQs = (idFiltro != null && !idFiltro.isBlank())
        ? "&idFiltro=" + java.net.URLEncoder.encode(idFiltro, java.nio.charset.StandardCharsets.UTF_8)
        : "";
%>

<div class="card mb-3">
    <div class="card-body">
        <form method="get" action="<%= request.getContextPath() %>/proyectos" class="d-flex align-items-center gap-2">
            <label for="idFiltro" class="form-label mb-0 text-nowrap">Buscar por ID:</label>
            <input type="text" class="form-control w-auto" id="idFiltro" name="idFiltro" value="<%= idFiltroVal %>"
                   placeholder="Ej: AB12CD" maxlength="6">
            <button type="submit" class="btn btn-outline-primary">Buscar</button>
            <a href="<%= request.getContextPath() %>/proyectos" class="btn btn-outline-secondary">Limpiar</a>
        </form>
    </div>
</div>

<div class="card">
    <div class="card-body">
        <%
            List<ProyectoSummaryDTO> proyectos = (pagina != null) ? pagina.getContent() : null;
            if (proyectos == null || proyectos.isEmpty()) {
        %>
            <p class="text-muted mb-0">No hay proyectos para mostrar.</p>
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
                                        <td><%= proyectoItem.getDescripcion() != null && !proyectoItem.getDescripcion().isBlank() ? proyectoItem.getDescripcion() : "-" %></td>
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
                    <a class="page-link" href="<%= request.getContextPath() %>/proyectos?page=0<%= filtroQs %>">&laquo;&laquo;</a>
                </li>
                <li class="page-item <%= paginaActual == 0 ? "disabled" : "" %>">
                    <a class="page-link" href="<%= request.getContextPath() %>/proyectos?page=<%= paginaActual - 1 %><%= filtroQs %>">Anterior</a>
                </li>
                <% if (desde > 0) { %>
                    <li class="page-item disabled"><span class="page-link">...</span></li>
                <% } %>
                <%
                    for (int i = desde; i <= hasta; i++) {
                %>
                        <li class="page-item <%= i == paginaActual ? "active" : "" %>">
                            <a class="page-link" href="<%= request.getContextPath() %>/proyectos?page=<%= i %><%= filtroQs %>"><%= i + 1 %></a>
                        </li>
                <%
                    }
                %>
                <% if (hasta < totalPaginas - 1) { %>
                    <li class="page-item disabled"><span class="page-link">...</span></li>
                <% } %>
                <li class="page-item <%= paginaActual >= totalPaginas - 1 ? "disabled" : "" %>">
                    <a class="page-link" href="<%= request.getContextPath() %>/proyectos?page=<%= paginaActual + 1 %><%= filtroQs %>">Siguiente</a>
                </li>
                <li class="page-item <%= paginaActual >= totalPaginas - 1 ? "disabled" : "" %>">
                    <a class="page-link" href="<%= request.getContextPath() %>/proyectos?page=<%= totalPaginas - 1 %><%= filtroQs %>">&raquo;&raquo;</a>
                </li>
            </ul>
            <p class="text-center text-muted small">
                Página <%= paginaActual + 1 %> de <%= totalPaginas %> - <%= pagina.getTotalElements() %> proyectos en total
            </p>
        </nav>
<%
    }
%>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>