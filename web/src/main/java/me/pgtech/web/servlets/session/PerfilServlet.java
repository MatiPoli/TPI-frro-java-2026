package me.pgtech.web.servlets.session;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import me.pgtech.web.client.PaisApiClient;
import me.pgtech.web.client.PlayerApiClient;
import me.pgtech.web.dto.PlayerDetailDTO;

@WebServlet("/perfil")
public class PerfilServlet extends HttpServlet {

    private final PlayerApiClient client = new PlayerApiClient();
    private final PaisApiClient paisClient = new PaisApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("player") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        PlayerDetailDTO playerSesion = (PlayerDetailDTO) session.getAttribute("player");

        try {
            PlayerDetailDTO playerActual = client.obtener(playerSesion.getId());
            req.setAttribute("player", playerActual);
            req.setAttribute("paises", paisClient.listar());
            req.getRequestDispatcher("/WEB-INF/vistas/perfil.jsp").forward(req, resp);
        } catch (IOException e) {
            req.setAttribute("error", "No se pudo cargar tu perfil");
            req.getRequestDispatcher("/WEB-INF/vistas/error.jsp").forward(req, resp);
        }
    }
}