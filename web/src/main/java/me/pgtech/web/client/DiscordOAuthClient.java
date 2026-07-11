package me.pgtech.web.client;

import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;

import com.google.gson.Gson;
import me.pgtech.web.dto.DiscordTokenResponse;
import me.pgtech.web.dto.DiscordUser;

public class DiscordOAuthClient {

    private static final String CLIENT_ID = System.getenv("DISCORD_CLIENT_ID");
    private static final String CLIENT_SECRET = System.getenv("DISCORD_CLIENT_SECRET");
    private static final String REDIRECT_URI = System.getenv("DISCORD_REDIRECT_URI");

    private final HttpClient client = HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(5)).build();
    private final Gson gson = new Gson();

    public String construirUrlAutorizacion() {
        try {
            return "https://discord.com/api/oauth2/authorize"
                + "?client_id=" + CLIENT_ID
                + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, StandardCharsets.UTF_8)
                + "&response_type=code"
                + "&scope=identify";
        } catch (Exception e) {
            throw new RuntimeException("Error construyendo URL de autorización", e);
        }
    }

    public String intercambiar(String code) throws IOException {
        try {
            String body = "client_id=" + URLEncoder.encode(CLIENT_ID, StandardCharsets.UTF_8)
                + "&client_secret=" + URLEncoder.encode(CLIENT_SECRET, StandardCharsets.UTF_8)
                + "&grant_type=authorization_code"
                + "&code=" + URLEncoder.encode(code, StandardCharsets.UTF_8)
                + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, StandardCharsets.UTF_8);

            HttpRequest req = HttpRequest.newBuilder()
                .uri(URI.create("https://discord.com/api/oauth2/token"))
                .timeout(Duration.ofSeconds(10))
                .header("Content-Type", "application/x-www-form-urlencoded")
                .POST(HttpRequest.BodyPublishers.ofString(body))
                .build();

            HttpResponse<String> resp = client.send(req, HttpResponse.BodyHandlers.ofString());
            if (resp.statusCode() >= 400) {
                throw new IOException("Discord token exchange falló: " + resp.statusCode() + " " + resp.body());
            }

            DiscordTokenResponse tokenResponse = gson.fromJson(resp.body(), DiscordTokenResponse.class);
            return tokenResponse.getAccessToken();

        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new IOException("Petición interrumpida", e);
        }
    }

    public DiscordUser obtenerUsuario(String accessToken) throws IOException {
        try {
            HttpRequest req = HttpRequest.newBuilder()
                .uri(URI.create("https://discord.com/api/users/@me"))
                .timeout(Duration.ofSeconds(10))
                .header("Authorization", "Bearer " + accessToken)
                .GET()
                .build();

            HttpResponse<String> resp = client.send(req, HttpResponse.BodyHandlers.ofString());
            if (resp.statusCode() >= 400) {
                throw new IOException("Discord user fetch falló: " + resp.statusCode());
            }

            return gson.fromJson(resp.body(), DiscordUser.class);

        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new IOException("Petición interrumpida", e);
        }
    }

}