package me.pgtech.web.servlets.player;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import me.pgtech.web.client.PlayerApiClient;
import me.pgtech.web.dto.PlayerDetailDTO;
import me.pgtech.web.dto.ProyectoSummaryDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/players/proyectos")
public class PlayerProyectoServlet extends BaseApiServlet {

    private final PlayerApiClient client = new PlayerApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            UUID id = parsearUUID(req, "playerId");

            PlayerDetailDTO player = client.obtener(id);
            List<ProyectoSummaryDTO> proyectos = client.listarProyectos(id);

            req.setAttribute("player", player);
            req.setAttribute("proyectos", proyectos);
            req.getRequestDispatcher("/WEB-INF/vistas/player-proyectos-lista.jsp").forward(req, resp);

        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}
