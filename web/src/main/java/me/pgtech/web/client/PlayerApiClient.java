package me.pgtech.web.client;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.UUID;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import me.pgtech.web.dto.PaginaDTO;
import me.pgtech.web.dto.PlayerDetailDTO;
import me.pgtech.web.dto.PlayerSummaryDTO;
import me.pgtech.web.dto.ProyectoSummaryDTO;

public class PlayerApiClient {

    private static final String BASE_URL = "http://209.192.185.15:25643/api/player";

    private final ApiHttpClient http = new ApiHttpClient();
    private final Gson gson = new Gson();

    public PlayerDetailDTO obtenerPorDiscordId(Long discordId) throws IOException {
        String json = http.get(BASE_URL + "/discord/" + discordId);
        return gson.fromJson(json, PlayerDetailDTO.class);
    }

    public PaginaDTO<PlayerSummaryDTO> listar(int page, int size, String nombreFiltro) throws IOException {
        StringBuilder url = new StringBuilder(BASE_URL + "?page=" + page + "&size=" + size);
        if (nombreFiltro != null && !nombreFiltro.isBlank()) {
            url.append("&nombre=").append(URLEncoder.encode(nombreFiltro, StandardCharsets.UTF_8));
        }
        String json = http.get(url.toString());
        return gson.fromJson(json, new TypeToken<PaginaDTO<PlayerSummaryDTO>>(){}.getType());
    }

    public PlayerDetailDTO obtener(UUID id) throws IOException {
        String json = http.get(BASE_URL + "/" + id);
        return gson.fromJson(json, PlayerDetailDTO.class);
    }

    public PlayerDetailDTO actualizar(UUID id, PlayerDetailDTO dto) throws IOException {
        String json = http.put(BASE_URL + "/" + id, gson.toJson(dto));
        return gson.fromJson(json, PlayerDetailDTO.class);
    }

    public void eliminar(UUID id) throws IOException {
        http.delete(BASE_URL + "/" + id);
    }

    public List<ProyectoSummaryDTO> listarProyectos(UUID playerId) throws IOException {
        StringBuilder url = new StringBuilder(BASE_URL + "/" + playerId + "/proyectos");
        String json = http.get(url.toString());
        return gson.fromJson(json, new TypeToken<List<ProyectoSummaryDTO>>(){}.getType());
    }

}
