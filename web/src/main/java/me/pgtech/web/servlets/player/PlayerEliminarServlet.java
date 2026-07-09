package me.pgtech.web.servlets.player;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.UUID;

import me.pgtech.web.client.PlayerApiClient;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/players/eliminar")
public class PlayerEliminarServlet extends BaseApiServlet {

    private final PlayerApiClient client = new PlayerApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            UUID id = UUID.fromString(req.getParameter("id"));
            client.eliminar(id);
            resp.sendRedirect(req.getContextPath() + "/players");
        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }
}
