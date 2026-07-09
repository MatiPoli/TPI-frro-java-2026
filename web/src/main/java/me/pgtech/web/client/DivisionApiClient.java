package me.pgtech.web.client;

import java.io.IOException;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import me.pgtech.web.dto.DivisionDetailDTO;
import me.pgtech.web.dto.DivisionSummaryDTO;
import me.pgtech.web.dto.PaginaDTO;
import me.pgtech.web.dto.RegionDivisionDetailDTO;
import me.pgtech.web.dto.RegionDivisionSummaryDTO;

public class DivisionApiClient {

    private static final String BASE_URL = "http://localhost:7070/api/division";

    private final ApiHttpClient http = new ApiHttpClient();
    private final Gson gson = new Gson();

    public PaginaDTO<DivisionSummaryDTO> listar(int page, int size) throws IOException {
        StringBuilder url = new StringBuilder(BASE_URL + "?page=" + page + "&size=" + size);
        String json = http.get(url.toString());
        return gson.fromJson(json, new TypeToken<PaginaDTO<DivisionSummaryDTO>>(){}.getType());
    }

    public DivisionDetailDTO obtener(Long id) throws IOException {
        String json = http.get(BASE_URL + "/" + id);
        return gson.fromJson(json, DivisionDetailDTO.class);
    }

    public DivisionDetailDTO crear(DivisionDetailDTO dto) throws IOException {
        String json = http.post(BASE_URL, gson.toJson(dto));
        return gson.fromJson(json, DivisionDetailDTO.class);
    }

    public DivisionDetailDTO actualizar(Long id, DivisionDetailDTO dto) throws IOException {
        String json = http.put(BASE_URL + "/" + id, gson.toJson(dto));
        return gson.fromJson(json, DivisionDetailDTO.class);
    }

    public void eliminar(Long id) throws IOException {
        http.delete(BASE_URL + "/" + id);
    }

    public PaginaDTO<RegionDivisionSummaryDTO> listar(Long divisionId, int page, int size) throws IOException {
        StringBuilder url = new StringBuilder(BASE_URL + "/" + divisionId + "/regiones" + "?page=" + page + "&size=" + size);
        String json = http.get(url.toString());
        return gson.fromJson(json, new TypeToken<PaginaDTO<RegionDivisionSummaryDTO>>(){}.getType());
    }

    public RegionDivisionDetailDTO obtener(Long divisionId, Long regionId) throws IOException {
        StringBuilder url = new StringBuilder(BASE_URL + "/" + divisionId + "/regiones/" + regionId);
        String json = http.get(url.toString());
        return gson.fromJson(json, RegionDivisionDetailDTO.class);
    }

    public RegionDivisionDetailDTO añadir(Long divisionId, RegionDivisionDetailDTO dto) throws IOException {
        StringBuilder url = new StringBuilder(BASE_URL + "/" + divisionId + "/regiones");
        String json = http.put(url.toString(), gson.toJson(dto));
        return gson.fromJson(json, RegionDivisionDetailDTO.class);
    }

    public void eliminar(Long divisionId, Long regionId) throws IOException {
        StringBuilder url = new StringBuilder(BASE_URL + "/" + divisionId + "/regiones/" + regionId);
        http.delete(url.toString());
    }

}
