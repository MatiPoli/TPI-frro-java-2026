<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="me.pgtech.web.dto.PaisDetailDTO" %>
<%
    request.setAttribute("tituloPagina", "Países");
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="mb-0">Países</h1>
    <div class="d-flex gap-2">
        <a href="<%= request.getContextPath() %>/admin" class="btn btn-outline-secondary">Volver al panel</a>
        <a href="<%= request.getContextPath() %>/paises/nuevo" class="btn btn-primary">+ Nuevo</a>
    </div>
</div>

<div class="card">
    <div class="card-body">
        <%
            List<PaisDetailDTO> paises = (List<PaisDetailDTO>) request.getAttribute("paises");
            if (paises == null || paises.isEmpty()) {
        %>
                <p class="text-muted mb-0">No hay países cargados todavía.</p>
        <%
            } else {
        %>
                <table class="table table-striped align-middle mb-0">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Nombre Público</th>
                            <th>DsId Guild</th>
                            <th>GlobalChat</th>
                            <th>CountryChat</th>
                            <th>Log</th>
                            <th>Request</th>
                            <th>Web Id</th>
                            <th>WebToken</th>
                            <th class="text-end">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (PaisDetailDTO pais : paises) {
                        %>
                                <tr>
                                    <td><%= pais.getId() %></td>
                                    <td><%= pais.getNombre() %></td>
                                    <td><%= pais.getNombrePublico() %></td>
                                    <td><%= pais.getDsIdGuild() %></td>
                                    <td><%= pais.getDsIdGlobalChat() %></td>
                                    <td><%= pais.getDsIdCountryChat() %></td>
                                    <td><%= pais.getDsIdLog() %></td>
                                    <td><%= pais.getDsIdRequest() %></td>
                                    <td><%= pais.getWebId() %></td>
                                    <td><%= pais.getWebToken() %></td>
                                    <td class="text-end">
                                        <a href="<%= request.getContextPath() %>/paises/regiones?paisId=<%= pais.getId() %>" class="btn btn-sm btn-outline-primary">Regiones</a>
                                        <a href="<%= request.getContextPath() %>/paises?id=<%= pais.getId() %>" class="btn btn-sm btn-outline-primary">Editar</a>

                                        <form method="post" action="<%= request.getContextPath() %>/paises/eliminar" class="d-inline" onsubmit="return confirm('¿Seguro que querés eliminar este país?');">
                                            <input type="hidden" name="id" value="<%= pais.getId() %>"/>
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