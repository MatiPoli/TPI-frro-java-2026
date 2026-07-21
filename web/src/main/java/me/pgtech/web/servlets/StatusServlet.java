package me.pgtech.web.servlets;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Map;
import com.google.gson.Gson;

@WebServlet("/status")
public class StatusServlet extends HttpServlet {
    private final HttpClient client = HttpClient.newHttpClient();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json;charset=UTF-8");
        try {
            HttpRequest apiRequest = HttpRequest.newBuilder()
                .uri(URI.create("http://209.192.185.15:25643/api/status"))
                .GET()
                .build();
            client.send(apiRequest, HttpResponse.BodyHandlers.ofString());
            resp.getWriter().write(gson.toJson(Map.of("mensaje", "API disponible")));
        } catch (Exception e) {
            resp.getWriter().write(gson.toJson(Map.of("mensaje", "API no disponible")));
        }
    }
}

//TODO: Mejorar validaciones: de tipo y de jerarquia, (Solicitud de Unión a Proyecto)
