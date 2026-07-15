package me.pgtech.web.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.UUID;

public abstract class BaseApiServlet extends HttpServlet {

    private static final String VISTA_ERROR = "/WEB-INF/vistas/error.jsp";

    protected void manejarError(HttpServletRequest req, HttpServletResponse resp, Exception e, String mensajeUsuario) throws ServletException, IOException {
        getServletContext().log("Error en " + req.getRequestURI(), e);
        req.setAttribute("error", mensajeUsuario);
        req.getRequestDispatcher(VISTA_ERROR).forward(req, resp);
    }

    protected void manejarErrorApi(HttpServletRequest req, HttpServletResponse resp, Exception e) throws ServletException, IOException {
        manejarError(req, resp, e, "No se pudo conectar con el servidor de Minecraft. Intentá nuevamente en unos minutos.");
    }

    protected Long parsearId(HttpServletRequest req, String paramName) {
        String valor = req.getParameter(paramName);
        if (valor == null || valor.isBlank()) {
            throw new IllegalArgumentException("Falta el parámetro: " + paramName);
        }
        try {
            return Long.valueOf(valor);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("El parámetro " + paramName + " debe ser numérico");
        }
    }

    protected int obtenerEntero(HttpServletRequest req, String param, int porDefecto) {
        String valor = req.getParameter(param);
        if (valor == null || valor.isBlank()) return porDefecto;
        try {
            return Integer.parseInt(valor);
        } catch (NumberFormatException e) {
            return porDefecto;
        }
    }

    protected UUID parsearUUID(HttpServletRequest req, String param) {
        String valor = req.getParameter(param);
        if (valor == null || valor.isBlank()) {
            throw new IllegalArgumentException("Falta el parámetro: " + param);
        }
        try {
            return UUID.fromString(valor);
        } catch (IllegalArgumentException e) {
            throw new IllegalArgumentException("El parámetro " + param + " no es un UUID válido");
        }
    }

    protected void proyectoFormAtrributeCheck(HttpServletRequest req) {
        String volverParam = req.getParameter("volverA");
        if (volverParam == null) return;
        req.setAttribute("volverA", volverParam);
    }

    protected String proyectoFormUrlCheck(HttpServletRequest req, String baseUrl) {
        String volverA = req.getParameter("volverA");
        if (volverA == null || volverA.isBlank()) {
            return baseUrl;
        }
        String conector = baseUrl.contains("?") ? "&" : "?";
        return baseUrl + conector + "volverA=" + volverA;
    }
    
}
