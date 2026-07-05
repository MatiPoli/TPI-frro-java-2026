<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setAttribute("tituloPagina", "Inicio");
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="mb-4">
    <h1>Bienvenido</h1>
    <p class="text-muted">Panel de administración de proyectos y jugadores de BTE Cono Sur.</p>
</div>

<div class="row g-3">
    <div class="col-md-6 col-lg-4">
        <div class="card h-100">
            <div class="card-body">
                <div class="d-flex align-items-center justify-content-between mb-2">
                    <h5 class="card-title mb-0">Estado de la API</h5>
                    <span id="statusDot" class="status-dot status-dot-pendiente"></span>
                </div>
                <p class="card-text" id="statusText">Consultando...</p>
                <button class="btn btn-primary btn-sm" onclick="consultarStatus()">Refrescar</button>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-lg-4">
        <div class="card h-100">
            <div class="card-body">
                <h5 class="card-title">Proyectos activos</h5>
                <p class="card-text text-muted">Consultá el listado completo de proyectos del servidor.</p>
                <a href="<%= request.getContextPath() %>/proyectos" class="btn btn-outline-primary btn-sm">Ver proyectos</a>
            </div>
        </div>
    </div>

    <% if (esAdmin) { %>
        <div class="col-md-6 col-lg-4">
            <div class="card h-100">
                <div class="card-body">
                    <h5 class="card-title">Panel de Administración</h5>
                    <p class="card-text text-muted">Gestioná tipos de usuario, rangos, países y divisiones.</p>
                    <a href="<%= request.getContextPath() %>/admin" class="btn btn-outline-primary btn-sm">Ir al panel</a>
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
            dotEl.className = data.mensaje.includes('OK')
                ? 'status-dot status-dot-ok'
                : 'status-dot status-dot-error';
        } catch (e) {
            statusEl.innerText = 'Error al consultar el status';
            dotEl.className = 'status-dot status-dot-error';
        }
    }
    consultarStatus();
</script>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>