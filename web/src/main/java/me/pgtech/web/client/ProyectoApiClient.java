package me.pgtech.web.client;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.UUID;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import me.pgtech.web.dto.PaginaDTO;
import me.pgtech.web.dto.FinishRequestDTO;
import me.pgtech.web.dto.PlayerSummaryDTO;
import me.pgtech.web.dto.ProyectoDetailDTO;
import me.pgtech.web.dto.ProyectoSummaryDTO;

public class ProyectoApiClient {

    private static final String BASE_URL = "http://192.168.1.8:8080/api/proyecto";

    private final ApiHttpClient http = new ApiHttpClient();
    private final Gson gson = new Gson();

    public PaginaDTO<ProyectoSummaryDTO> listar(int page, int size, String idFiltro) throws IOException {
        StringBuilder url = new StringBuilder(BASE_URL + "?page=" + page + "&size=" + size);
        if (idFiltro != null && !idFiltro.isBlank()) {
            url.append("&id=").append(URLEncoder.encode(idFiltro, StandardCharsets.UTF_8));
        }
        String json = http.get(url.toString());
        return gson.fromJson(json, new TypeToken<PaginaDTO<ProyectoSummaryDTO>>(){}.getType());
    }

    public PaginaDTO<ProyectoSummaryDTO> listarFinalizaciones(int page, int size) throws IOException {
        String json = http.get(BASE_URL + "/finalizaciones?page=" + page + "&size=" + size);
        return gson.fromJson(json, new TypeToken<PaginaDTO<ProyectoSummaryDTO>>(){}.getType());
    }

    public ProyectoDetailDTO obtener(String id) throws IOException {
        String json = http.get(BASE_URL + "/" + id);
        return gson.fromJson(json, ProyectoDetailDTO.class);
    }

    public ProyectoDetailDTO actualizar(String id, ProyectoDetailDTO dto) throws IOException {
        String json = http.put(BASE_URL + "/" + id, gson.toJson(dto));
        return gson.fromJson(json, ProyectoDetailDTO.class);
    }

    public void eliminar(String id) throws IOException {
        http.delete(BASE_URL + "/" + id);
    }

    public List<PlayerSummaryDTO> listarMiembros(String proyectoId) throws IOException {
        String json = http.get(BASE_URL + "/" + proyectoId + "/miembros");
        return gson.fromJson(json, new TypeToken<List<PlayerSummaryDTO>>(){}.getType());
    }

    public void enviarSolicitud(String proyectoId, UUID playerId) throws IOException {
        http.post(BASE_URL + "/" + proyectoId + "/solicitudes?playerId=" + playerId, "");
    }

    public List<PlayerSummaryDTO> obtenerSolicitudes(String proyectoId) throws IOException {
        String json = http.get(BASE_URL + "/" + proyectoId + "/solicitudes");
        return gson.fromJson(json, new TypeToken<List<PlayerSummaryDTO>>(){}.getType());
    }

    public void aceptarSolicitud(String proyectoId, UUID playerId) throws IOException {
        http.post(BASE_URL + "/" + proyectoId + "/solicitudes/" + playerId, "");
    }

    public void rechazarSolicitud(String proyectoId, UUID playerId) throws IOException {
        http.delete(BASE_URL + "/" + proyectoId + "/solicitudes/" + playerId);
    }

    public void finalizarProyecto(String proyectoId) throws IOException {
        http.post(BASE_URL + "/" + proyectoId + "/finalizar", "");
    }

    public void aprobarFinalizacion(String proyectoId, UUID staffId, String comentario, boolean promote) throws IOException {
        String body = gson.toJson(new FinishRequestDTO(staffId, comentario, promote));
        http.post(BASE_URL + "/" + proyectoId + "/aprobar", body);
    }

    public void rechazarFinalizacion(String proyectoId, UUID staffId, String comentario) throws IOException {
        String body = gson.toJson(new FinishRequestDTO(staffId, comentario, null));
        http.post(BASE_URL + "/" + proyectoId + "/rechazar", body);
    }

}
