package me.pgtech.web.client;

import java.io.IOException;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import me.pgtech.web.dto.PaisDetailDTO;
import me.pgtech.web.dto.RegionPaisDetailDTO;
import me.pgtech.web.dto.RegionPaisSummaryDTO;
import me.pgtech.web.dto.DivisionSummaryDTO;
import me.pgtech.web.dto.PaginaDTO;

public class PaisApiClient {

    private static final String BASE_URL = "http://localhost:7070/api/pais";

    private final ApiHttpClient http = new ApiHttpClient();
    private final Gson gson = new Gson();

    public List<PaisDetailDTO> listar() throws IOException {
        String json = http.get(BASE_URL);
        return gson.fromJson(json, new TypeToken<List<PaisDetailDTO>>(){}.getType());
    }

    public PaisDetailDTO obtener(Long id) throws IOException {
        String json = http.get(BASE_URL + "/" + id);
        return gson.fromJson(json, PaisDetailDTO.class);
    }

    public PaisDetailDTO crear(PaisDetailDTO dto) throws IOException {
        String json = http.post(BASE_URL, gson.toJson(dto));
        return gson.fromJson(json, PaisDetailDTO.class);
    }

    public PaisDetailDTO actualizar(Long id, PaisDetailDTO dto) throws IOException {
        String json = http.put(BASE_URL + "/" + id, gson.toJson(dto));
        return gson.fromJson(json, PaisDetailDTO.class);
    }

    public void eliminar(Long id) throws IOException {
        http.delete(BASE_URL + "/" + id);
    }

    public PaginaDTO<RegionPaisSummaryDTO> listar(Long paisId, int page, int size) throws IOException {
        StringBuilder url = new StringBuilder(BASE_URL + "/" + paisId + "/regiones" + "?page=" + page + "&size=" + size);
        String json = http.get(url.toString());
        return gson.fromJson(json, new TypeToken<PaginaDTO<RegionPaisSummaryDTO>>(){}.getType());
    }

    public RegionPaisDetailDTO obtener(Long paisId, Long regionId) throws IOException {
        StringBuilder url = new StringBuilder(BASE_URL + "/" + paisId + "/regiones/" + regionId);
        String json = http.get(url.toString());
        return gson.fromJson(json, RegionPaisDetailDTO.class);
    }

    public RegionPaisDetailDTO añadir(Long paisId, RegionPaisDetailDTO dto) throws IOException {
        StringBuilder url = new StringBuilder(BASE_URL + "/" + paisId + "/regiones");
        String json = http.put(url.toString(), gson.toJson(dto));
        return gson.fromJson(json, RegionPaisDetailDTO.class);
    }

    public void eliminar(Long paisId, Long regionId) throws IOException {
        StringBuilder url = new StringBuilder(BASE_URL + "/" + paisId + "/regiones/" + regionId);
        http.delete(url.toString());
    }

    public PaginaDTO<DivisionSummaryDTO> listarDivisiones(Long paisId, int page, int size) throws IOException {
        StringBuilder url = new StringBuilder(BASE_URL + "/" + paisId + "/divisiones" + "?page=" + page + "&size=" + size);
        String json = http.get(url.toString());
        return gson.fromJson(json, new TypeToken<PaginaDTO<DivisionSummaryDTO>>(){}.getType());
    }

}
