package me.pgtech.web.client;

import java.io.IOException;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import me.pgtech.web.dto.TipoProyectoDTO;

public class TipoProyectoApiClient {

    private static final String BASE_URL = "http://209.192.185.15:25643/api/tipo-proyecto";
    private final ApiHttpClient http = new ApiHttpClient();
    private final Gson gson = new Gson();

    public List<TipoProyectoDTO> listar() throws IOException {
        String json = http.get(BASE_URL);
        return gson.fromJson(json, new TypeToken<List<TipoProyectoDTO>>(){}.getType());
    }

    public TipoProyectoDTO obtener(Long id) throws IOException {
        String json = http.get(BASE_URL + "/" + id);
        return gson.fromJson(json, TipoProyectoDTO.class);
    }

    public TipoProyectoDTO crear(TipoProyectoDTO dto) throws IOException {
        String json = http.post(BASE_URL, gson.toJson(dto));
        return gson.fromJson(json, TipoProyectoDTO.class);
    }

    public TipoProyectoDTO actualizar(Long id, TipoProyectoDTO dto) throws IOException {
        String json = http.put(BASE_URL + "/" + id, gson.toJson(dto));
        return gson.fromJson(json, TipoProyectoDTO.class);
    }

    public void eliminar(Long id) throws IOException {
        http.delete(BASE_URL + "/" + id);
    }

}
