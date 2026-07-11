package me.pgtech.web.servlets.session;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/login-error")
public class LoginErrorServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String motivo = req.getParameter("motivo");
        String mensaje = switch (motivo != null ? motivo : "") {
            case "no-vinculado" -> "Tu cuenta de Discord no está vinculada a ningún jugador. Ingresá al servidor de Minecraft y vinculá tu cuenta primero.";
            case "denegado" -> "Cancelaste el inicio de sesión con Discord.";
            case "api-caida" -> "No se pudo verificar tu cuenta en este momento. Intentá más tarde.";
            default -> "Ocurrió un error al iniciar sesión.";
        };
        req.setAttribute("error", mensaje);
        req.getRequestDispatcher("/WEB-INF/vistas/error.jsp").forward(req, resp);
    }

}