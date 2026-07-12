<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="me.pgtech.web.dto.PlayerDetailDTO" %>
<%
    Object tituloObj = request.getAttribute("tituloPagina");
    String tituloPagina = (tituloObj != null) ? tituloObj.toString() : "BTE Cono Sur";

    String rango = (String) session.getAttribute("rango");
    PlayerDetailDTO sessionPlayer = (PlayerDetailDTO) session.getAttribute("player");
    String nombrePublico = (sessionPlayer != null) ? sessionPlayer.getNombrePublico() : "";

    boolean esAdmin = "Admin".equals(rango);
    boolean esAdminOReviewer = "Admin".equals(rango) || "Reviewer".equals(rango);

    boolean anchoCompleto = Boolean.TRUE.equals(request.getAttribute("anchoCompleto"));
    String claseContenedor = anchoCompleto ? "container-fluid px-4" : "container";

    String discordAvatarUrl = (String) session.getAttribute("discordAvatarUrl");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><%= tituloPagina %></title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;600;700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <link rel="stylesheet" href="https://unpkg.com/leaflet-draw@1.0.4/dist/leaflet.draw.css" />

    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script src="https://unpkg.com/leaflet-draw@1.0.4/dist/leaflet.draw.js"></script>
    <script src="<%= request.getContextPath() %>/js/mapa-poligono.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/estilos.css" rel="stylesheet">
</head>
<body>

<script>
    const contextPath = "<%= request.getContextPath() %>";
</script>

<nav class="navbar navbar-expand-lg navbar-dark sticky-top">
    <div class="container">
        <a class="navbar-brand" href="<%= request.getContextPath() %>/">
            <img src="<%= request.getContextPath() %>/img/logo3.png" alt="BTE Cono Sur">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarMain">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/proyectos">Proyectos</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                        Mapas
                    </a>
                    <ul class="dropdown-menu dropdown-menu-dark">
                        <li><a class="dropdown-item" href="<%= request.getContextPath() %>/proyectos/mapa">Mapa de Proyectos</a></li>
                        <li><a class="dropdown-item" href="<%= request.getContextPath() %>/paises/mapa">Mapa de Países</a></li>
                        <li><a class="dropdown-item" href="<%= request.getContextPath() %>/divisiones/mapa">Mapa de Divisiones</a></li>
                    </ul>
                </li>

                <% if (esAdminOReviewer) { %>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/players">Jugadores</a>
                    </li>
                <% } %>

                <% if ("Reviewer".equals(rango)) { %>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/reviewer">Revisión</a>
                    </li>
                <% } %>

                <% if (esAdmin) { %>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                            Administración
                        </a>
                        <ul class="dropdown-menu dropdown-menu-dark">
                            <li><a class="dropdown-item" href="<%= request.getContextPath() %>/tipos-usuario">Tipos de Usuario</a></li>
                            <li><a class="dropdown-item" href="<%= request.getContextPath() %>/rangos">Rangos</a></li>
                            <li><a class="dropdown-item" href="<%= request.getContextPath() %>/tipos-proyecto">Tipos de Proyecto</a></li>
                            <li><a class="dropdown-item" href="<%= request.getContextPath() %>/paises">Países</a></li>
                        </ul>
                    </li>
                <% } %>
            </ul>

            <% if (sessionPlayer != null) { %>
                <div class="d-flex align-items-center gap-2 me-3">
                    <% if (discordAvatarUrl != null) { %>
                        <img src="<%= discordAvatarUrl %>" alt="Avatar" class="avatar-discord">
                    <% } %>
                    <a href="<%= request.getContextPath() %>/perfil" class="navbar-text text-light d-flex align-items-center gap-2 mb-0 text-decoration-none">
                        <span class="badge bg-secondary"><%= rango %></span>
                        <%= nombrePublico %>
                    </a>
                </div>
                <a href="<%= request.getContextPath() %>/logout" class="btn btn-outline-light btn-sm">Salir</a>
            <% } else { %>
                <a href="<%= request.getContextPath() %>/login" class="btn btn-primary btn-sm">Ingresar con Discord</a>
            <% } %>
        </div>
    </div>
</nav>

<main class="<%= claseContenedor %> mt-4 mb-5">