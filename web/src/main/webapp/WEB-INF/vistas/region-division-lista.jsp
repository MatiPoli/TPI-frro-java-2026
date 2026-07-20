<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="me.pgtech.web.dto.RegionDivisionSummaryDTO" %>
<%@ page import="me.pgtech.web.dto.DivisionDetailDTO" %>
<%@ page import="me.pgtech.web.dto.PaginaDTO" %>
<%
    request.setAttribute("tituloPagina", "Regiones");
    PaginaDTO<RegionDivisionSummaryDTO> pagina = (PaginaDTO<RegionDivisionSummaryDTO>) request.getAttribute("pagina");
    DivisionDetailDTO division = (DivisionDetailDTO) request.getAttribute("division");
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="mb-0">Regiones de <%= division.getNombre() %></h1>
    <div class="d-flex gap-2">
        <a href="<%= request.getContextPath() %>/paises/divisiones?paisId=<%= division.getPais().getId() %>" class="btn btn-outline-secondary">Volver</a>
        <a href="<%= request.getContextPath() %>/divisiones/regiones/nuevo?divisionId=<%= division.getId() %>" class="btn btn-primary">+ Nueva</a>
    </div>
</div>

<div class="card">
    <div class="card-body">
        <%
            List<RegionDivisionSummaryDTO> regiones = (pagina != null) ? pagina.getContent() : null;
            if (regiones == null || regiones.isEmpty()) {
        %>
            <p class="text-muted mb-0">No hay regiones para mostrar.</p>
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
                            for (RegionDivisionSummaryDTO regionItem : regiones) {
                        %>
                                <tr>
                                    <td><%= regionItem.getId() %></td>
                                    <td><%= regionItem.getNombre() %></td>
                                    <td class="text-end">
                                       <!-- <a href="<%= request.getContextPath() %>/divisiones/regiones?divisionId=<%= division.getId() %>&regionId=<%= regionItem.getId() %>"
                                           class="btn btn-sm btn-outline-primary">Editar</a> -->

                                        <form method="post"
                                              action="<%= request.getContextPath() %>/divisiones/regiones/eliminar"
                                              class="d-inline"
                                              onsubmit="return confirm('¿Seguro que querés eliminar esta región?');">
                                            <input type="hidden" name="divisionId" value="<%= division.getId() %>"/>
                                            <input type="hidden" name="regionId" value="<%= regionItem.getId() %>"/>
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

<%
    if (pagina != null && pagina.getTotalPages() > 1) {
        int paginaActual = pagina.getPage();
        int totalPaginas = pagina.getTotalPages();
        int rangoPaginas = 2; // cuántas páginas mostrar a cada lado de la actual

        int desde = Math.max(0, paginaActual - rangoPaginas);
        int hasta = Math.min(totalPaginas - 1, paginaActual + rangoPaginas);
%>
        <nav class="mt-3">
            <ul class="pagination justify-content-center flex-wrap">
                <li class="page-item <%= paginaActual == 0 ? "disabled" : "" %>">
                    <a class="page-link" href="<%= request.getContextPath() %>/divisiones/regiones?page=0&divisionId=<%= division.getId() %>">&laquo;&laquo;</a>
                </li>
                <li class="page-item <%= paginaActual == 0 ? "disabled" : "" %>">
                    <a class="page-link" href="<%= request.getContextPath() %>/divisiones/regiones?page=<%= paginaActual - 1 %>&divisionId=<%= division.getId() %>">Anterior</a>
                </li>

                <% if (desde > 0) { %>
                    <li class="page-item disabled"><span class="page-link">...</span></li>
                <% } %>

                <%
                    for (int i = desde; i <= hasta; i++) {
                %>
                        <li class="page-item <%= i == paginaActual ? "active" : "" %>">
                            <a class="page-link" href="<%= request.getContextPath() %>/divisiones/regiones?page=<%= i %>&divisionId=<%= division.getId() %>"><%= i + 1 %></a>
                        </li>
                <%
                    }
                %>

                <% if (hasta < totalPaginas - 1) { %>
                    <li class="page-item disabled"><span class="page-link">...</span></li>
                <% } %>

                <li class="page-item <%= paginaActual >= totalPaginas - 1 ? "disabled" : "" %>">
                    <a class="page-link" href="<%= request.getContextPath() %>/divisiones/regiones?page=<%= paginaActual + 1 %>&divisionId=<%= division.getId() %>">Siguiente</a>
                </li>
                <li class="page-item <%= paginaActual >= totalPaginas - 1 ? "disabled" : "" %>">
                    <a class="page-link" href="<%= request.getContextPath() %>/divisiones/regiones?page=<%= totalPaginas - 1 %>&divisionId=<%= division.getId() %>">&raquo;&raquo;</a>
                </li>
            </ul>
            <p class="text-center text-muted small">
                Página <%= paginaActual + 1 %> de <%= totalPaginas %> - <%= pagina.getTotalElements() %> divisiones en total
            </p>
        </nav>
<%
    }
%>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>