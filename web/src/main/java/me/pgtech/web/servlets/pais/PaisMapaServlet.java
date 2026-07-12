package me.pgtech.web.servlets.pais;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import me.pgtech.web.client.PaisApiClient;
import me.pgtech.web.dto.RegionPaisMapaDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/paises/mapa")
public class PaisMapaServlet extends BaseApiServlet {

    private final PaisApiClient client = new PaisApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<RegionPaisMapaDTO> regiones = client.listarTodasLasRegionesMapa();
            req.setAttribute("regiones", regiones);
            req.getRequestDispatcher("/WEB-INF/vistas/pais-mapa.jsp").forward(req, resp);
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }
}