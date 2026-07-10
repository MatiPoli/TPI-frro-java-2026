<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="me.pgtech.web.dto.ProyectoDetailDTO" %>
<%@ page import="me.pgtech.web.dto.TipoProyectoDTO" %>
<%
    ProyectoDetailDTO proyecto = (ProyectoDetailDTO) request.getAttribute("proyecto");
    List<TipoProyectoDTO> tiposProyecto = (List<TipoProyectoDTO>) request.getAttribute("tipos");
    Boolean yaSolicitoUnion = (Boolean) request.getAttribute("yaSolicitoUnion");
    request.setAttribute("tituloPagina", "Proyecto: " + proyecto.getId());

    SimpleDateFormat sdfForm = new SimpleDateFormat("dd/MM/yyyy HH:mm");

    boolean sinFinalizacion = (proyecto.getEstado() == me.pgtech.web.dto.Estado.ACTIVO
            || proyecto.getEstado() == me.pgtech.web.dto.Estado.EDITANDO);
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex flex-column align-items-center">
    <h1 class="text-center mb-4">Proyecto: <%= proyecto.getId() %></h1>

    <div class="card mb-3" style="max-width: 650px; width: 100%;">
        <div class="card-body">
            <form method="post" action="<%= request.getContextPath() %>/proyectos/actualizar">
                <input type="hidden" name="id" value="<%= proyecto.getId() %>"/>

                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre</label>
                    <input type="text" class="form-control" id="nombre" name="nombre"
                           value="<%= proyecto.getNombre() %>" required maxlength="100">
                </div>

                <div class="mb-3">
                    <label for="descripcion" class="form-label">Descripción</label>
                    <textarea class="form-control" id="descripcion" name="descripcion" rows="3"><%= proyecto.getDescripcion() %></textarea>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">Guardar</button>
                    <a href="<%= request.getContextPath() %>/proyectos" class="btn btn-outline-secondary">Volver</a>
                </div>
            </form>
        </div>
    </div>

    <div class="card mb-3" style="max-width: 650px; width: 100%;">
        <div class="card-body">
            <h5 class="card-title mb-3">Información general</h5>
            <dl class="row mb-0">
                <dt class="col-sm-4">Estado</dt>
                <dd class="col-sm-8"><span class="badge bg-secondary"><%= proyecto.getEstado() %></span></dd>

                <dt class="col-sm-4">Tamaño</dt>
                <dd class="col-sm-8"><%= proyecto.getTamaño() %></dd>

                <dt class="col-sm-4">Fecha de creación</dt>
                <dd class="col-sm-8"><%= proyecto.getFechaCreado() != null ? sdfForm.format(proyecto.getFechaCreado()) : "-" %></dd>

                <dt class="col-sm-4">Fecha de finalización</dt>
                <dd class="col-sm-8"><%= proyecto.getFechaTerminado() != null ? sdfForm.format(proyecto.getFechaTerminado()) : "-" %></dd>

                <dt class="col-sm-4">Tipo de proyecto</dt>
                <dd class="col-sm-8"><%= proyecto.getTipoProyecto() != null ? proyecto.getTipoProyecto().getNombre() : "-" %></dd>

                <dt class="col-sm-4">Líder</dt>
                <dd class="col-sm-8"><%= proyecto.getLider() != null ? proyecto.getLider().getNombrePublico() : "-" %></dd>

                <dt class="col-sm-4">División</dt>
                <dd class="col-sm-8"><%= proyecto.getDivision() != null ? proyecto.getDivision().getNombre() : "-" %></dd>

                <dt class="col-sm-4">País</dt>
                <dd class="col-sm-8">
                    <%= (proyecto.getDivision() != null && proyecto.getDivision().getPais() != null)
                            ? proyecto.getDivision().getPais().getNombre() : "-" %>
                </dd>
            </dl>
        </div>
    </div>

    <div class="card" style="max-width: 650px; width: 100%;">
        <div class="card-body">
            <h5 class="card-title mb-3">Acciones</h5>
            <div class="d-flex flex-wrap gap-2">
                <a href="<%= request.getContextPath() %>/proyectos/miembros?proyectoId=<%= proyecto.getId() %>"
                   class="btn btn-outline-primary">Ver miembros</a>

                <a href="<%= request.getContextPath() %>/proyectos/solicitudes?proyectoId=<%= proyecto.getId() %>"
                   class="btn btn-outline-primary">Ver solicitudes</a>

                <% if (Boolean.TRUE.equals(yaSolicitoUnion)) { %>
                    <button class="btn btn-outline-secondary" disabled>Ya solicitaste unirte</button>
                <% } else { %>
                    <form method="post" action="<%= request.getContextPath() %>/proyectos/unirse" class="d-inline">
                        <input type="hidden" name="proyectoId" value="<%= proyecto.getId() %>"/>
                        <button type="submit" class="btn btn-outline-success">Solicitar unión</button>
                    </form>
                <% } %>

                <% if (sinFinalizacion) { %>
                    <form method="post" action="<%= request.getContextPath() %>/proyectos/finalizar" class="d-inline"
                          onsubmit="return confirm('¿Marcar este proyecto como finalizado? Quedará pendiente de revisión.');">
                        <input type="hidden" name="proyectoId" value="<%= proyecto.getId() %>"/>
                        <button type="submit" class="btn btn-outline-warning">Marcar como finalizado</button>
                    </form>
                <% } %>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>