package me.pgtech.web.servlets.proyecto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import me.pgtech.web.client.ProyectoApiClient;
import me.pgtech.web.dto.PlayerDetailDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/proyectos/unirse")
public class ProyectoUnirseServlet extends BaseApiServlet {

    private final ProyectoApiClient client = new ProyectoApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String proyectoId = req.getParameter("proyectoId");

            HttpSession session = req.getSession(false);
            if (session == null || session.getAttribute("player") == null) {
                manejarError(req, resp, new IllegalStateException(), "Tenés que iniciar sesión para solicitar unirte a un proyecto");
                return;
            }
            PlayerDetailDTO playerLogueado = (PlayerDetailDTO) session.getAttribute("player");

            client.enviarSolicitud(proyectoId, playerLogueado.getId());
            resp.sendRedirect(req.getContextPath() + "/proyectos?id=" + proyectoId);
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }
    
}
