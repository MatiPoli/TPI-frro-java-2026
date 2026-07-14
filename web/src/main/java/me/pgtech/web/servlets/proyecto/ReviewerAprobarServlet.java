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

@WebServlet("/reviewer/finalizaciones/aprobar")
public class ReviewerAprobarServlet extends BaseApiServlet {

    private final ProyectoApiClient client = new ProyectoApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String proyectoId = req.getParameter("proyectoId");
            String comentario = req.getParameter("comentario");
            boolean promote = "on".equals(req.getParameter("promote"));

            HttpSession session = req.getSession(false);
            PlayerDetailDTO player = (PlayerDetailDTO) session.getAttribute("player");
            client.aprobarFinalizacion(proyectoId, player.getId(), comentario, promote);
            resp.sendRedirect(req.getContextPath() + "/reviewer/finalizaciones");
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }
    
}