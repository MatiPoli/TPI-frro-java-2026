<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="me.pgtech.web.dto.PlayerDetailDTO" %>
<%@ page import="me.pgtech.web.dto.PaisDetailDTO" %>
<%
    request.setAttribute("tituloPagina", "Mi Perfil");
    PlayerDetailDTO player = (PlayerDetailDTO) request.getAttribute("player");
    List<PaisDetailDTO> paises = (List<PaisDetailDTO>) request.getAttribute("paises");
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");

    Long paisIdActual = (player.getPaisPrefix() != null) ? player.getPaisPrefix().getId() : null;
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex flex-column align-items-center">
    <h1 class="text-center mb-4">Mi Perfil</h1>

    <div class="card mb-3" style="max-width: 500px; width: 100%;">
        <div class="card-body">
            <dl class="row mb-0">
                <dt class="col-sm-5">Nombre (Minecraft)</dt>
                <dd class="col-sm-7"><%= player.getNombre() %></dd>

                <dt class="col-sm-5">Tipo de Usuario</dt>
                <dd class="col-sm-7"><%= player.getTipoUsuario() != null ? player.getTipoUsuario().getNombre() : "-" %></dd>

                <dt class="col-sm-5">Rango</dt>
                <dd class="col-sm-7"><%= player.getRangoUsuario() != null ? player.getRangoUsuario().getNombre() : "-" %></dd>

                <dt class="col-sm-5">Ingreso</dt>
                <dd class="col-sm-7"><%= player.getFechaIngreso() != null ? sdf.format(player.getFechaIngreso()) : "-" %></dd>

                <dt class="col-sm-5">Última conexión</dt>
                <dd class="col-sm-7"><%= player.getFechaUltimaConexion() != null ? sdf.format(player.getFechaUltimaConexion()) : "-" %></dd>
            </dl>
        </div>
    </div>

    <div class="card" style="max-width: 500px; width: 100%;">
        <div class="card-body">
            <h5 class="card-title mb-3">Editar perfil</h5>
            <form method="post" action="<%= request.getContextPath() %>/perfil/actualizar">
                <div class="mb-3">
                    <label for="nombrePublico" class="form-label">Nombre Público</label>
                    <input type="text" class="form-control" id="nombrePublico" name="nombrePublico"
                           value="<%= player.getNombrePublico() %>" required maxlength="50">
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

                <button type="submit" class="btn btn-primary">Guardar</button>
            </form>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>