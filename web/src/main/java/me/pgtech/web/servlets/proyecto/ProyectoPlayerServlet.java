package me.pgtech.web.servlets.proyecto;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import me.pgtech.web.client.PlayerApiClient;
import me.pgtech.web.dto.PlayerDetailDTO;
import me.pgtech.web.dto.ProyectoSummaryDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/proyectos/player")
public class ProyectoPlayerServlet extends BaseApiServlet {

    private final PlayerApiClient client = new PlayerApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            HttpSession session = req.getSession(false);
            if (session == null || session.getAttribute("player") == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }
            PlayerDetailDTO sessionPlayer = (PlayerDetailDTO) session.getAttribute("player");
            List<ProyectoSummaryDTO> proyectos = client.listarProyectos(sessionPlayer.getId());

            req.setAttribute("player", sessionPlayer);
            req.setAttribute("proyectos", proyectos);
            req.getRequestDispatcher("/WEB-INF/vistas/player-proyectos-lista.jsp").forward(req, resp);

        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}
