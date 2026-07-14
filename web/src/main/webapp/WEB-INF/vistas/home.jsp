<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setAttribute("tituloPagina", "Home");
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="mb-4">
    <h1>Bienvenido, <%= nombrePublico %></h1>
    <p class="text-muted">Panel de acceso rápido a BTE Cono Sur.</p>
</div>

<div class="row g-3">
    <div class="col-md-6 col-lg-4">
        <div class="card h-100">
            <div class="card-body d-flex flex-column">
                <div class="d-flex align-items-center justify-content-between mb-2">
                    <h5 class="card-title mb-0">Estado de la API</h5>
                    <span id="statusDot" class="status-dot status-dot-pendiente"></span>
                </div>
                
                <p class="card-text text-muted small mb-3">
                    API del plugin principal que provee y sincroniza los datos de toda la página.
                </p>
                
                <p class="card-text mb-3" id="statusText">Consultando...</p>
                <button class="btn btn-primary btn-sm mt-auto align-self-start" onclick="consultarStatus()">Refrescar</button>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-lg-4">
        <div class="card h-100">
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">Proyectos</h5>
                <p class="card-text text-muted">Ver el listado completo de proyectos del servidor.</p>
                <a href="<%= request.getContextPath() %>/proyectos" class="btn btn-outline-primary btn-sm mt-auto align-self-start">Ver proyectos</a>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-lg-4">
        <div class="card h-100">
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">Mapas</h5>
                <p class="card-text text-muted">Mapa de proyectos, países y divisiones. Pueden tardar en cargar.</p>
                
                <div class="dropdown mt-auto align-self-start">
                    <button class="btn btn-outline-primary btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Ver mapas
                    </button>
                    <ul class="dropdown-menu dropdown-menu-dark">
                        <li><a class="dropdown-item" href="<%= request.getContextPath() %>/proyectos/mapa">Mapa de Proyectos</a></li>
                        <li><a class="dropdown-item" href="<%= request.getContextPath() %>/paises/mapa">Mapa de Países</a></li>
                        <li><a class="dropdown-item" href="<%= request.getContextPath() %>/divisiones/mapa?paisId=1">Mapa de Divisiones</a></li>
                    </ul>
                </div>
                </div>
        </div>
    </div>

    <div class="col-md-6 col-lg-4">
        <div class="card h-100">
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">Mi Perfil</h5>
                <p class="card-text text-muted">Ver y editar tu información de jugador.</p>
                <a href="<%= request.getContextPath() %>/perfil" class="btn btn-outline-primary btn-sm mt-auto align-self-start">Ir a mi perfil</a>
            </div>
        </div>
    </div>

    <% if (esReviewer) { %>
        <div class="col-md-6 col-lg-4">
            <div class="card h-100">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">Panel de Revisión</h5>
                    <p class="card-text text-muted">Finalizaciones pendientes de los países que revisás.</p>
                    <a href="<%= request.getContextPath() %>/reviewer" class="btn btn-outline-primary btn-sm mt-auto align-self-start">Ir al panel</a>
                </div>
            </div>
        </div>
    <% } %>

    <% if (esAdmin) { %>
        <div class="col-md-6 col-lg-4">
            <div class="card h-100">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">Panel de Administración</h5>
                    <p class="card-text text-muted">Gestioná tipos de usuario, rangos, países y divisiones.</p>
                    <a href="<%= request.getContextPath() %>/admin" class="btn btn-outline-primary btn-sm mt-auto align-self-start">Ir al panel</a>
                </div>
            </div>
        </div>
    <% } %>
</div>

<script>
    async function consultarStatus() {
        const statusEl = document.getElementById('statusText');
        const dotEl = document.getElementById('statusDot');
        statusEl.innerText = 'Consultando...';
        dotEl.className = 'status-dot status-dot-pendiente';
        try {
            const resp = await fetch(contextPath + '/status');
            const data = await resp.json();
            statusEl.innerText = data.mensaje;
            dotEl.className = data.mensaje.includes('no') ? 'status-dot status-dot-error' : 'status-dot status-dot-ok';
        } catch (e) {
            statusEl.innerText = 'Error al consultar el status';
            dotEl.className = 'status-dot status-dot-error';
        }
    }
    consultarStatus();
</script>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>