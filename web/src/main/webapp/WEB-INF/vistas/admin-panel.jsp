<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setAttribute("tituloPagina", "Panel de Administración");
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<h1 class="mb-4">Panel de Administración</h1>

<div class="row g-3">
    <div class="col-md-6 col-lg-4">
        <div class="card h-100">
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">Tipos de Usuario</h5>
                <p class="card-text text-muted">Visitante, Postulante, Constructor y sus límites de proyectos.</p>
                <a href="<%= request.getContextPath() %>/tipos-usuario" class="btn btn-outline-primary btn-sm mt-auto align-self-start">Gestionar</a>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-lg-4">
        <div class="card h-100">
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">Rangos</h5>
                <p class="card-text text-muted">Roles de staff: Usuario, Reviewer, Moderador, Admin.</p>
                <a href="<%= request.getContextPath() %>/rangos-usuario" class="btn btn-outline-primary btn-sm mt-auto align-self-start">Gestionar</a>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-lg-4">
        <div class="card h-100">
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">Tipos de Proyecto</h5>
                <p class="card-text text-muted">Categorización de proyectos según tamaño.</p>
                <a href="<%= request.getContextPath() %>/tipos-proyecto" class="btn btn-outline-primary btn-sm mt-auto align-self-start">Gestionar</a>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-lg-4">
        <div class="card h-100">
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">Países</h5>
                <p class="card-text text-muted">Argentina, Chile, Perú, Bolivia, Paraguay, Uruguay y sus regiones.</p>
                <a href="<%= request.getContextPath() %>/paises" class="btn btn-outline-primary btn-sm mt-auto align-self-start">Gestionar</a>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-lg-4">
        <div class="card h-100">
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">Divisiones</h5>
                <p class="card-text text-muted">Provincias, comunas, barrios. Dependientes de cada país.</p>
                <a href="<%= request.getContextPath() %>/divisiones" class="btn btn-outline-primary btn-sm mt-auto align-self-start">Gestionar</a>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-lg-4">
        <div class="card h-100">
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">Jugadores</h5>
                <p class="card-text text-muted">Consultar y modificar jugadores registrados.</p>
                <a href="<%= request.getContextPath() %>/players" class="btn btn-outline-primary btn-sm mt-auto align-self-start">Gestionar</a>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>