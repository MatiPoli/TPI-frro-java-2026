<%
    String volverA = (String) request.getAttribute("volverA");
    boolean volverPerfil = "perfil".equals(volverA);
    boolean volverMapa = "mapa".equals(volverA);
    boolean volverProyectos = "proyectos".equals(volverA);
%>

<%!
    private String urlConVolver(String url, String volverA) {
        if (volverA == null || volverA.isBlank()) {
            return url;
        }
        String conector = url.contains("?") ? "&" : "?";
        return url + conector + "volverA=" + volverA;
    }
%>