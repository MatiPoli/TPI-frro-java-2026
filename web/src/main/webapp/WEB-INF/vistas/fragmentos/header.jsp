<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Object tituloObj = request.getAttribute("tituloPagina");
    String tituloPagina = (tituloObj != null) ? tituloObj.toString() : "BTE Cono Sur";

    String rango = (String) session.getAttribute("rango");
    Object sessionPlayer = session.getAttribute("player");
    String nombrePublico = (sessionPlayer != null) ? request.getAttribute("nombrePublico") + "" : "";
    // Si guardás el nombre directo en sesión (como en el test-login), usá esto en su lugar:
    // String nombrePublico = (String) session.getAttribute("nombreJugador");

    boolean esAdmin = "Admin".equals(rango);
    boolean esAdminOReviewer = "Admin".equals(rango) || "Reviewer".equals(rango);
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

                <% if (esAdminOReviewer) { %>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/players">Jugadores</a>
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
                <span class="navbar-text text-light me-3">
                    <%= nombrePublico %>
                    <span class="badge bg-secondary"><%= rango %></span>
                </span>
                <a href="<%= request.getContextPath() %>/logout" class="btn btn-outline-light btn-sm">Salir</a>
            <% } %>
        </div>
    </div>
</nav>

<%
    boolean anchoCompleto = Boolean.TRUE.equals(request.getAttribute("anchoCompleto"));
    String claseContenedor = anchoCompleto ? "container-fluid px-4" : "container";
%>

<main class="<%= claseContenedor %> mt-4 mb-5">