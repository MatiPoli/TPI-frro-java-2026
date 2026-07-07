<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="me.pgtech.web.dto.DivisionSummaryDTO" %>
<%@ page import="me.pgtech.web.dto.PaginaDTO" %>
<%
    request.setAttribute("tituloPagina", "Divisiones");
    PaginaDTO<DivisionSummaryDTO> pagina = (PaginaDTO<DivisionSummaryDTO>) request.getAttribute("pagina");
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="mb-0">Divisiones</h1>
    <div class="d-flex gap-2">
        <a href="<%= request.getContextPath() %>/admin" class="btn btn-outline-secondary">Volver al panel</a>
        <a href="<%= request.getContextPath() %>/divisiones/nuevo" class="btn btn-primary">+ Nueva</a>
    </div>
</div>

<div class="card">
    <div class="card-body">
        <%
            List<DivisionSummaryDTO> divisiones = (pagina != null) ? pagina.getContent() : null;
            if (divisiones == null || divisiones.isEmpty()) {
        %>
            <p class="text-muted mb-0">No hay divisiones para mostrar.</p>
        <%
            } else {
        %>
                <div class="table-responsive">
                    <table class="table table-striped align-middle mb-0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>NAM</th>
                                <th>GNA</th>
                                <th>FNA</th>
                                <th>Contexto</th>
                                <th class="text-end">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (DivisionSummaryDTO divisionItem : divisiones) {
                            %>
                                    <tr>
                                        <td><%= divisionItem.getId() %></td>
                                        <td><%= divisionItem.getNombre() %></td>
                                        <td><%= divisionItem.getNam() %></td>
                                        <td><%= divisionItem.getGna() %></td>
                                        <td><%= divisionItem.getFna() %></td>
                                        <td><%= divisionItem.getContexto() %></td>
                                        <td class="text-end">
                                            <a href="<%= request.getContextPath() %>/divisiones/regiones?divisionId=<%= divisionItem.getId() %>"
                                               class="btn btn-sm btn-outline-primary">Regiones</a>
                                            <a href="<%= request.getContextPath() %>/divisiones?id=<%= divisionItem.getId() %>"
                                               class="btn btn-sm btn-outline-primary">Editar</a>

                                            <form method="post"
                                                  action="<%= request.getContextPath() %>/divisiones/eliminar"
                                                  class="d-inline"
                                                  onsubmit="return confirm('¿Seguro que querés eliminar esta división?');">
                                                <input type="hidden" name="id" value="<%= divisionItem.getId() %>"/>
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
        int rangoPaginas = 2; // cuántas páginas mostrar a cada lado de la actual

        int desde = Math.max(0, paginaActual - rangoPaginas);
        int hasta = Math.min(totalPaginas - 1, paginaActual + rangoPaginas);
%>
        <nav class="mt-3">
            <ul class="pagination justify-content-center flex-wrap">
                <li class="page-item <%= paginaActual == 0 ? "disabled" : "" %>">
                    <a class="page-link" href="<%= request.getContextPath() %>/divisiones?page=0">&laquo;&laquo;</a>
                </li>
                <li class="page-item <%= paginaActual == 0 ? "disabled" : "" %>">
                    <a class="page-link" href="<%= request.getContextPath() %>/divisiones?page=<%= paginaActual - 1 %>">Anterior</a>
                </li>

                <% if (desde > 0) { %>
                    <li class="page-item disabled"><span class="page-link">...</span></li>
                <% } %>

                <%
                    for (int i = desde; i <= hasta; i++) {
                %>
                        <li class="page-item <%= i == paginaActual ? "active" : "" %>">
                            <a class="page-link" href="<%= request.getContextPath() %>/divisiones?page=<%= i %>"><%= i + 1 %></a>
                        </li>
                <%
                    }
                %>

                <% if (hasta < totalPaginas - 1) { %>
                    <li class="page-item disabled"><span class="page-link">...</span></li>
                <% } %>

                <li class="page-item <%= paginaActual >= totalPaginas - 1 ? "disabled" : "" %>">
                    <a class="page-link" href="<%= request.getContextPath() %>/divisiones?page=<%= paginaActual + 1 %>">Siguiente</a>
                </li>
                <li class="page-item <%= paginaActual >= totalPaginas - 1 ? "disabled" : "" %>">
                    <a class="page-link" href="<%= request.getContextPath() %>/divisiones?page=<%= totalPaginas - 1 %>">&raquo;&raquo;</a>
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