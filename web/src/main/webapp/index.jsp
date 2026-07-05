<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>BTE Cono Sur - Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-dark bg-dark">
        <div class="container">
            <span class="navbar-brand mb-0 h1">BTE Cono Sur</span>
        </div>
    </nav>

    <div class="container mt-4">
        <h1>Bienvenido</h1>
        <p class="text-muted">Panel de administración de proyectos y jugadores.</p>

        <div class="card" style="max-width: 400px;">
            <div class="card-body">
                <h5 class="card-title">Estado de la API</h5>
                <p class="card-text" id="statusText">Consultando...</p>
                <button class="btn btn-primary" onclick="consultarStatus()">Refrescar</button>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const contextPath = "${pageContext.request.contextPath}";

        async function consultarStatus() {
            const resp = await fetch(contextPath + '/status');
            const data = await resp.json();
            document.getElementById('statusText').innerText = data.mensaje;
        }
        consultarStatus();
    </script>
</body>
</html>