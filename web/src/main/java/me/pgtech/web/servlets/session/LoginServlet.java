package me.pgtech.web.servlets.session;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import me.pgtech.web.client.DiscordOAuthClient;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final DiscordOAuthClient discordClient = new DiscordOAuthClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.sendRedirect(discordClient.construirUrlAutorizacion());
    }

}