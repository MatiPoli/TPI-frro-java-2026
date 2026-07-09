<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="me.pgtech.web.dto.PlayerDetailDTO" %>
<%@ page import="me.pgtech.web.dto.RangoUsuarioDTO" %>
<%@ page import="me.pgtech.web.dto.TipoUsuarioDTO" %>
<%@ page import="me.pgtech.web.dto.PaisDetailDTO" %>
<%@ page import="me.pgtech.web.dto.ProyectoSummaryDTO" %>
<%@ page import="java.util.Date" %>
<%
    request.setAttribute("tituloPagina", "Editar Jugador");

    PlayerDetailDTO playerEditar = (PlayerDetailDTO) request.getAttribute("player");
    List<RangoUsuarioDTO> rangos = (List<RangoUsuarioDTO>) request.getAttribute("rangos");
    List<TipoUsuarioDTO> tipos = (List<TipoUsuarioDTO>) request.getAttribute("tipos");
    List<PaisDetailDTO> paises = (List<PaisDetailDTO>) request.getAttribute("paises");
    List<ProyectoSummaryDTO> proyectos = (List<ProyectoSummaryDTO>) request.getAttribute("proyectos");

    Long rangoIdActual = (playerEditar.getRangoUsuario() != null) ? playerEditar.getRangoUsuario().getId() : null;
    Long tipoIdActual = (playerEditar.getTipoUsuario() != null) ? playerEditar.getTipoUsuario().getId() : null;
    Long paisIdActual = (playerEditar.getPaisPrefix() != null) ? playerEditar.getPaisPrefix().getId() : null;

%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex flex-column align-items-center">
    <h1 class="text-center mb-4">Editar Jugador</h1>

    <div class="card mb-4" style="max-width: 600px; width: 100%;">
        <div class="card-body">
            <form method="post" action="<%= request.getContextPath() %>/players/actualizar">

                <input type="hidden" name="id" value="<%= playerEditar.getId() %>"/>

                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre</label>
                    <input type="text" class="form-control" id="nombre" name="nombre"
                           value="<%= playerEditar.getNombre() %>" required maxlength="50">
                </div>

                <div class="mb-3">
                    <label for="nombrePublico" class="form-label">Nombre Público</label>
                    <input type="text" class="form-control" id="nombrePublico" name="nombrePublico"
                           value="<%= playerEditar.getNombrePublico() %>" required maxlength="50">
                </div>

                <div class="mb-3">
                    <label for="dsIdUsuario" class="form-label">Discord ID</label>
                    <input type="text" class="form-control" id="dsIdUsuario" name="dsIdUsuario"
                           value="<%= playerEditar.getDsIdUsuario() != null ? playerEditar.getDsIdUsuario() : "" %>">
                </div>

                <div class="mb-3">
                    <label for="tipoUsuarioId" class="form-label">Tipo de Usuario</label>
                    <select class="form-select" id="tipoUsuarioId" name="tipoUsuarioId" required>
                        <%
                            if (tipos != null) {
                                for (TipoUsuarioDTO tipoItem : tipos) {
                                    boolean sel = tipoIdActual != null && tipoIdActual.equals(tipoItem.getId());
                        %>
                                    <option value="<%= tipoItem.getId() %>" <%= sel ? "selected" : "" %>><%= tipoItem.getNombre() %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="rangoUsuarioId" class="form-label">Rango</label>
                    <select class="form-select" id="rangoUsuarioId" name="rangoUsuarioId" required>
                        <%
                            if (rangos != null) {
                                for (RangoUsuarioDTO rangoItem : rangos) {
                                    boolean sel = rangoIdActual != null && rangoIdActual.equals(rangoItem.getId());
                        %>
                                    <option value="<%= rangoItem.getId() %>" <%= sel ? "selected" : "" %>><%= rangoItem.getNombre() %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="paisId" class="form-label">País</label>
                    <select class="form-select" id="paisId" name="paisId">
                        <option value="">Sin asignar</option>
                        <%
                            if (paises != null) {
                                for (PaisDetailDTO paisItem : paises) {
                                    boolean sel = paisIdActual != null && paisIdActual.equals(paisItem.getId());
                        %>
                                    <option value="<%= paisItem.getId() %>" <%= sel ? "selected" : "" %>><%= paisItem.getNombre() %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Fecha de ingreso</label>
                        <input type="text" class="form-control" disabled
                               value="<%= playerEditar.getFechaIngreso() != null ? new Date(playerEditar.getFechaIngreso()) : "-" %>">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Última conexión</label>
                        <input type="text" class="form-control" disabled
                               value="<%= playerEditar.getFechaUltimaConexion() != null ? new Date(playerEditar.getFechaUltimaConexion()) : "-" %>">
                    </div>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">Guardar</button>
                    <a href="<%= request.getContextPath() %>/players" class="btn btn-outline-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </div>

</div>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>