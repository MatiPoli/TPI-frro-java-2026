<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setAttribute("tituloPagina", "Inicio");
%>
<%@ include file="/WEB-INF/vistas/fragmentos/header.jsp" %>

<div class="hero-landing mb-5">
    <div id="heroCarousel" class="carousel slide carousel-fade" data-bs-ride="carousel" data-bs-interval="4000">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="<%= request.getContextPath() %>/img/landing-1.jpg" class="d-block w-100 hero-img" alt="Construcción BTE">
            </div>
            <div class="carousel-item">
                <img src="<%= request.getContextPath() %>/img/landing-2.jpg" class="d-block w-100 hero-img" alt="Construcción BTE">
            </div>
            <div class="carousel-item">
                <img src="<%= request.getContextPath() %>/img/landing-3.jpg" class="d-block w-100 hero-img" alt="Construcción BTE">
            </div>
            <div class="carousel-item">
                <img src="<%= request.getContextPath() %>/img/landing-4.jpg" class="d-block w-100 hero-img" alt="Construcción BTE">
            </div>
        </div>
    </div>

    <div class="hero-overlay">
        <div class="hero-content text-center">
            <h1 class="display-5 fw-bold mb-3">Build The Earth: Cono Sur</h1>
            <p class="lead mb-4">Recreamos Sudamérica en Minecraft, a escala 1:1, entre Argentina, Chile, Perú, Bolivia, Paraguay y Uruguay.</p>
            <% if (loggedIn) { %>
                <a href="<%= request.getContextPath() %>/home" class="btn btn-primary btn-lg">Ir a Home</a>
            <% } else { %>
                <a href="<%= request.getContextPath() %>/login" class="btn btn-primary btn-lg">Ingresar con Discord</a>
            <% } %>
        </div>
    </div>
</div>

<div class="row g-4 mb-5">
    <div class="col-md-6 col-lg-3">
        <div class="card h-100">
            <div class="card-body">
                <h5 class="card-title">¿Qué es BTE?</h5>
                <p class="card-text text-muted">
                    Build The Earth es un proyecto global y colaborativo que busca recrear el planeta Tierra
                    en Minecraft en escala 1:1, dividido principalmente por países.
                </p>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-lg-3">
        <div class="card h-100">
            <div class="card-body">
                <h5 class="card-title">El servidor</h5>
                <p class="card-text text-muted">
                    Servidor 100% vanilla, sin mods, corriendo Minecraft 1.21.10. Usamos Terra+- para
                    generar el terreno real con altura ampliada.
                </p>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-lg-3">
        <div class="card h-100">
            <div class="card-body">
                <h5 class="card-title">Cómo funciona</h5>
                <p class="card-text text-muted">
                    Cada constructor crea proyectos: regiones poligonales donde construir. Empezás como
                    Visitante, pasás a Postulante con tu primer proyecto aceptado, y a Constructor al
                    completar varios.
                </p>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-lg-3">
        <div class="card h-100">
            <div class="card-body">
                <h5 class="card-title">Revisión y calidad</h5>
                <p class="card-text text-muted">
                    Cada país tiene su propio equipo de Reviewers, que aprueba proyectos nuevos y
                    validaciones de finalización antes de darlos por completados.
                </p>
            </div>
        </div>
    </div>
</div>

<div class="card mb-5">
    <div class="card-body">
        <h5 class="card-title mb-3">Nuestros Discords</h5>
        <div class="row g-2">
            <div class="col-6 col-md-4 col-lg-2">
                <a href="https://discord.gg/5rRczgyb9F" target="_blank" class="btn btn-outline-primary w-100">
                    <img src="<%= request.getContextPath() %>/img/ar132x.png" alt="Bandera de Argentina" class="flag-icon me-2"> Argentina
                </a>
            </div>
            <div class="col-6 col-md-4 col-lg-2">
                <a href="https://discord.gg/buildtheearth-chile-847192126122229890" target="_blank" class="btn btn-outline-primary w-100">
                    <img src="<%= request.getContextPath() %>/img/cl132x105.png" alt="Bandera de Chile" class="flag-icon me-2"> Chile
                </a>
            </div>
            <div class="col-6 col-md-4 col-lg-2">
                <a href="https://discord.gg/Z8HH2bSXx" target="_blank" class="btn btn-outline-primary w-100">
                    <img src="<%= request.getContextPath() %>/img/pe132x105.png" alt="Bandera de Perú" class="flag-icon me-2"> Perú
                </a>
            </div>
            <div class="col-6 col-md-4 col-lg-2">
                <a href="https://discord.gg/jzTYYpA5pS" target="_blank" class="btn btn-outline-primary w-100">
                    <img src="<%= request.getContextPath() %>/img/bo132x105.png" alt="Bandera de Bolivia" class="flag-icon me-2"> Bolivia
                </a>
            </div>
            <div class="col-6 col-md-4 col-lg-2">
                <a href="https://discord.gg/3VvrFeMVgu" target="_blank" class="btn btn-outline-primary w-100">
                    <img src="<%= request.getContextPath() %>/img/py132x105.png" alt="Bandera de Paraguay" class="flag-icon me-2"> Paraguay
                </a>
            </div>
            <div class="col-6 col-md-4 col-lg-2">
                <a href="https://discord.gg/3VvrFeMVgu" target="_blank" class="btn btn-outline-primary w-100">
                    <img src="<%= request.getContextPath() %>/img/uy132x105.png" alt="Bandera de Uruguay" class="flag-icon me-2"> Uruguay
                </a>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/vistas/fragmentos/footer.jsp" %>