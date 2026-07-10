<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="me.pgtech.web.dto.ProyectoDetailDTO" %>
<%
    ProyectoDetailDTO proyecto = (ProyectoDetailDTO) request.getAttribute("proyecto");
    request.setAttribute("tituloPagina", "Revisar: " + proyecto.getNombre());
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex flex-column align-items-center">
    <h1 class="text-center mb-4">Revisar finalización</h1>

    <div class="card mb-3" style="max-width: 600px; width: 100%;">
        <div class="card-body">
            <h5 class="card-title mb-3"><%= proyecto.getNombre() %></h5>
            <dl class="row mb-0">
                <dt class="col-sm-4">Descripción</dt>
                <dd class="col-sm-8"><%= proyecto.getDescripcion() %></dd>

                <dt class="col-sm-4">Tamaño</dt>
                <dd class="col-sm-8"><%= proyecto.getTamaño() %></dd>

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

    <div class="card" style="max-width: 600px; width: 100%;">
        <div class="card-body">
            <div class="mb-3">
                <label for="comentario" class="form-label">Comentario</label>
                <textarea class="form-control" id="comentario" form="formAprobar" name="comentario" rows="3"
                          placeholder="Opcional: motivo de aprobación o rechazo"></textarea>
            </div>

            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="promote" form="formAprobar" name="promote">
                <label class="form-check-label" for="promote">Ascender al líder al aprobar</label>
            </div>

            <div class="d-flex gap-2">
                <form method="post" id="formAprobar" action="<%= request.getContextPath() %>/reviewer/finalizaciones/aprobar">
                    <input type="hidden" name="proyectoId" value="<%= proyecto.getId() %>"/>
                    <button type="submit" class="btn btn-success">Aprobar</button>
                </form>

                <form method="post" action="<%= request.getContextPath() %>/reviewer/finalizaciones/rechazar"
                      onsubmit="return confirm('¿Rechazar la finalización de este proyecto?');">
                    <input type="hidden" name="proyectoId" value="<%= proyecto.getId() %>"/>
                    <input type="hidden" name="comentario" id="comentarioRechazo"/>
                    <button type="submit" class="btn btn-outline-danger"
                            onclick="document.getElementById('comentarioRechazo').value = document.getElementById('comentario').value;">
                        Rechazar
                    </button>
                </form>

                <a href="<%= request.getContextPath() %>/reviewer/finalizaciones" class="btn btn-outline-secondary">Cancelar</a>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>