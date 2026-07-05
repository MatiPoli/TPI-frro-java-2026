<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setAttribute("tituloPagina", "Error");
    String mensajeError = (String) request.getAttribute("error");
    if (mensajeError == null || mensajeError.isBlank()) {
        mensajeError = "No se pudo completar la operación solicitada.";
    }
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex justify-content-center">
    <div class="card border-danger" style="max-width: 500px; width: 100%;">
        <div class="card-body text-center py-5">
            <div class="mb-3">
                <span class="error-icon">&#9888;</span>
            </div>
            <h4 class="card-title mb-3">Ocurrió un error</h4>
            <p class="card-text text-muted mb-4"><%= mensajeError %></p>
            <a href="<%= request.getContextPath() %>/" class="btn btn-primary">Volver al inicio</a>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>