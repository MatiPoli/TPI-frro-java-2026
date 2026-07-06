<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="me.pgtech.web.dto.PaisDetailDTO" %>
<%
    PaisDetailDTO pais = (PaisDetailDTO) request.getAttribute("pais");
    boolean esNuevo = (pais == null);
    request.setAttribute("tituloPagina", esNuevo ? "Nuevo País" : "Editar País");
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex flex-column align-items-center">
    <h1 class="text-center mb-4"><%= esNuevo ? "Nuevo País" : "Editar País" %></h1>

    <div class="card" style="max-width: 500px; width: 100%;">
        <div class="card-body">
            <form method="post" action="<%= request.getContextPath() %>/paises/<%= esNuevo ? "crear" : "actualizar" %>">

                <% if (!esNuevo) { %>
                    <input type="hidden" name="id" value="<%= pais.getId() %>"/>
                <% } %>

                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre</label>
                    <input type="text" class="form-control" id="nombre" name="nombre" value="<%= esNuevo ? "" : pais.getNombre() %>" required maxlength="50">
                </div>

                <div class="mb-3">
                    <label for="nombrePublico" class="form-label">Nombre Público</label>
                    <input type="text" class="form-control" id="nombrePublico" name="nombrePublico" value="<%= esNuevo ? "" : pais.getNombrePublico() %>" required maxlength="50">
                </div>

                <div class="mb-3">
                    <label for="dsIdGuild" class="form-label">DsId Guild</label>
                    <input type="number" class="form-control" id="dsIdGuild" name="dsIdGuild" value="<%= esNuevo ? "" : pais.getDsIdGuild() %>" required min="1" max="9223372036854775807" step="1">
                </div>

                <div class="mb-3">
                    <label for="dsIdGlobalChat" class="form-label">DsId GlobalChat</label>
                    <input type="number" class="form-control" id="dsIdGlobalChat" name="dsIdGlobalChat" value="<%= esNuevo ? "" : pais.getDsIdGlobalChat() %>" required min="1" max="9223372036854775807" step="1">
                </div>

                <div class="mb-3">
                    <label for="dsIdCountryChat" class="form-label">DsId CountryChat</label>
                    <input type="number" class="form-control" id="dsIdCountryChat" name="dsIdCountryChat" value="<%= esNuevo ? "" : pais.getDsIdCountryChat() %>" required min="1" max="9223372036854775807" step="1">
                </div>

                <div class="mb-3">
                    <label for="dsIdLog" class="form-label">DsId Log</label>
                    <input type="number" class="form-control" id="dsIdLog" name="dsIdLog" value="<%= esNuevo ? "" : pais.getDsIdLog() %>" required min="1" max="9223372036854775807" step="1">
                </div>

                <div class="mb-3">
                    <label for="dsIdRequest" class="form-label">DsId Request</label>
                    <input type="number" class="form-control" id="dsIdRequest" name="dsIdRequest" value="<%= esNuevo ? "" : pais.getDsIdRequest() %>" required min="1" max="9223372036854775807" step="1">
                </div>

                <div class="mb-3">
                    <label for="webId" class="form-label">Web Id</label>
                    <input type="text" class="form-control" id="webId" name="webId" value="<%= esNuevo ? "" : pais.getWebId() %>" required maxlength="128">
                </div>

                <div class="mb-3">
                    <label for="webToken" class="form-label">Web Token</label>
                    <input type="text" class="form-control" id="webToken" name="webToken" value="<%= esNuevo ? "" : pais.getWebToken() %>" required maxlength="512">
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">Guardar</button>
                    <a href="<%= request.getContextPath() %>/paises" class="btn btn-outline-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>