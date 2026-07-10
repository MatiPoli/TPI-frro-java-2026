package me.pgtech.web.client;

import java.io.IOException;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import me.pgtech.web.dto.TipoUsuarioDTO;

public class TipoUsuarioApiClient {

    private static final String BASE_URL = "http://192.168.1.8:8080/api/tipo-usuario";
    private final ApiHttpClient http = new ApiHttpClient();
    private final Gson gson = new Gson();

    public List<TipoUsuarioDTO> listar() throws IOException {
        String json = http.get(BASE_URL);
        return gson.fromJson(json, new TypeToken<List<TipoUsuarioDTO>>(){}.getType());
    }

    public TipoUsuarioDTO obtener(Long id) throws IOException {
        String json = http.get(BASE_URL + "/" + id);
        return gson.fromJson(json, TipoUsuarioDTO.class);
    }

    public TipoUsuarioDTO crear(TipoUsuarioDTO dto) throws IOException {
        String json = http.post(BASE_URL, gson.toJson(dto));
        return gson.fromJson(json, TipoUsuarioDTO.class);
    }

    public TipoUsuarioDTO actualizar(Long id, TipoUsuarioDTO dto) throws IOException {
        String json = http.put(BASE_URL + "/" + id, gson.toJson(dto));
        return gson.fromJson(json, TipoUsuarioDTO.class);
    }

    public void eliminar(Long id) throws IOException {
        http.delete(BASE_URL + "/" + id);
    }
}
