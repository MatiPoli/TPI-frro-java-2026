package me.pgtech.web.servlets.session;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import me.pgtech.web.client.DiscordOAuthClient;
import me.pgtech.web.client.PlayerApiClient;
import me.pgtech.web.dto.DiscordUser;
import me.pgtech.web.dto.PlayerDetailDTO;

@WebServlet("/callback")
public class CallbackServlet extends HttpServlet {

    private final DiscordOAuthClient discordClient = new DiscordOAuthClient();
    private final PlayerApiClient playerClient = new PlayerApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String code = req.getParameter("code");

        if (code == null) {
            resp.sendRedirect(req.getContextPath() + "/login-error?motivo=denegado");
            return;
        }

        try {
            String accessToken = discordClient.intercambiar(code);
            DiscordUser discordUser = discordClient.obtenerUsuario(accessToken);

            String avatarUrl = discordUser.getAvatar() != null
                ? "https://cdn.discordapp.com/avatars/" + discordUser.getId() + "/" + discordUser.getAvatar() + ".png" : null;

            Long discordId = Long.valueOf(discordUser.getId());
            PlayerDetailDTO player = playerClient.obtenerPorDiscordId(discordId);

            HttpSession session = req.getSession();
            session.setAttribute("discordAvatarUrl", avatarUrl);
            session.setAttribute("player", player);
            session.setAttribute("rango", player.getRangoUsuario() != null ? player.getRangoUsuario().getNombre() : null);
            session.setAttribute("paisReviewerId", player.getPaisPrefix() != null ? player.getPaisPrefix().getId() : null);

            resp.sendRedirect(req.getContextPath() + "/");

        } catch (IOException e) {
            // Puede ser 404 (no vinculado) u otro error de red/API
            if (e.getMessage() != null && e.getMessage().contains("404")) {
                resp.sendRedirect(req.getContextPath() + "/login-error?motivo=no-vinculado");
            } else {
                resp.sendRedirect(req.getContextPath() + "/login-error?motivo=api-caida");
            }
        }
    }

}