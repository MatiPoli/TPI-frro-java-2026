<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setAttribute("tituloPagina", "Panel de Revisión");
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<h1 class="mb-4">Panel de Revisión</h1>

<div class="row g-3">
    <div class="col-md-6 col-lg-4">
        <div class="card h-100">
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">Finalizaciones Pendientes</h5>
                <p class="card-text text-muted">Proyectos de tu país esperando aprobación o rechazo de finalización.</p>
                <a href="<%= request.getContextPath() %>/reviewer/finalizaciones" class="btn btn-outline-primary btn-sm mt-auto align-self-start">Revisar</a>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>