<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="me.pgtech.web.dto.DivisionDetailDTO" %>
<%@ page import="me.pgtech.web.dto.PaisDetailDTO" %>
<%
    DivisionDetailDTO divisionEditar = (DivisionDetailDTO) request.getAttribute("division");
    List<PaisDetailDTO> paises = (List<PaisDetailDTO>) request.getAttribute("paises");
    boolean esNuevo = (divisionEditar == null);
    request.setAttribute("tituloPagina", esNuevo ? "Nueva División" : "Editar División");

    Long paisIdParam = null;
    String paisIdQs = request.getParameter("paisId");
    if (paisIdQs != null) {
        paisIdParam = Long.valueOf(paisIdQs);
    }

    Long paisIdSeleccionado = null;
    if (!esNuevo && divisionEditar.getPais() != null) {
        paisIdSeleccionado = divisionEditar.getPais().getId();
    } else if (paisIdParam != null) {
        paisIdSeleccionado = paisIdParam;
    }
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex flex-column align-items-center">
    <h1 class="text-center mb-4"><%= esNuevo ? "Nueva División" : "Editar División" %></h1>

    <div class="card" style="max-width: 500px; width: 100%;">
        <div class="card-body">
            <form method="post"
                  action="<%= request.getContextPath() %>/divisiones/<%= esNuevo ? "crear" : "actualizar" %>">

                <% if (!esNuevo) { %>
                    <input type="hidden" name="id" value="<%= divisionEditar.getId() %>"/>
                <% } %>

                <div class="mb-3">
                    <label for="paisId" class="form-label">País</label>
                    <select class="form-select" id="paisId" name="paisId" required>
                        <option value="" disabled <%= paisIdSeleccionado == null ? "selected" : "" %>>Seleccioná un país</option>
                        <%
                            if (paises != null) {
                                for (PaisDetailDTO paisItem : paises) {
                                    boolean seleccionado = paisIdSeleccionado != null && paisIdSeleccionado.equals(paisItem.getId());
                        %>
                                    <option value="<%= paisItem.getId() %>" <%= seleccionado ? "selected" : "" %>>
                                        <%= paisItem.getNombrePublico() %>
                                    </option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre</label>
                    <input type="text" class="form-control" id="nombre" name="nombre"
                           value="<%= esNuevo ? "" : divisionEditar.getNombre() %>" required maxlength="100">
                </div>

                <div class="mb-3">
                    <label for="nam" class="form-label">NAM</label>
                    <input type="text" class="form-control" id="nam" name="nam"
                           value="<%= esNuevo ? "" : divisionEditar.getNam() %>">
                </div>

                <div class="mb-3">
                    <label for="gna" class="form-label">GNA</label>
                    <input type="text" class="form-control" id="gna" name="gna"
                           value="<%= esNuevo ? "" : divisionEditar.getGna() %>">
                </div>

                <div class="mb-3">
                    <label for="fna" class="form-label">FNA</label>
                    <input type="text" class="form-control" id="fna" name="fna"
                           value="<%= esNuevo ? "" : divisionEditar.getFna() %>">
                </div>

                <div class="mb-3">
                    <label for="contexto" class="form-label">Contexto</label>
                    <textarea class="form-control" id="contexto" name="contexto" rows="2"><%= esNuevo ? "" : divisionEditar.getContexto() %></textarea>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">Guardar</button>
                    <a href="<%= request.getContextPath() %>/paises/divisiones?paisId=<%= paisIdSeleccionado %>" class="btn btn-outline-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>