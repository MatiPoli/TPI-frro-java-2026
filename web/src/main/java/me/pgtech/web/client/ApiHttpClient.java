package me.pgtech.web.client;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;

public class ApiHttpClient {

    private final HttpClient client = HttpClient.newBuilder()
        .connectTimeout(Duration.ofSeconds(8))
        .build();

    public String get(String url) throws IOException {
        return enviar(url, "GET", null);
    }

    public String post(String url, String body) throws IOException {
        return enviar(url, "POST", body);
    }

    public String put(String url, String body) throws IOException {
        return enviar(url, "PUT", body);
    }

    public String delete(String url) throws IOException {
        return enviar(url, "DELETE", null);
    }

    private String enviar(String url, String metodo, String body) throws IOException {
        try {
            HttpRequest.Builder builder = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .timeout(Duration.ofSeconds(30))
                .header("Content-Type", "application/json; charset=UTF-8");

            builder = (body != null)
                ? builder.method(metodo, HttpRequest.BodyPublishers.ofString(body, StandardCharsets.UTF_8))
                : builder.method(metodo, HttpRequest.BodyPublishers.noBody());

            HttpResponse<String> resp = client.send(builder.build(),
                HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));

            if (resp.statusCode() >= 400) {
                throw new IOException("API respondió con status " + resp.statusCode() + ": " + resp.body());
            }

            return resp.body();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new IOException("Petición interrumpida", e);
        }
    }
}
