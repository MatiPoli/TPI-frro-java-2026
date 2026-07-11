<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%
    request.setAttribute("tituloPagina", "Acceso denegado");
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="d-flex justify-content-center">
    <div class="card border-danger" style="max-width: 500px; width: 100%;">
        <div class="card-body text-center py-5">
            <div class="mb-3">
                <span class="error-icon">&#128274;</span>
            </div>
            <h4 class="card-title mb-3">Acceso denegado</h4>
            <p class="card-text text-muted mb-4">
                No tenés permisos para acceder a esta sección, o no iniciaste sesión.
            </p>
            <a href="<%= request.getContextPath() %>/" class="btn btn-primary">Volver al inicio</a>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>