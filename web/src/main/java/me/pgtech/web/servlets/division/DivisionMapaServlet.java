package me.pgtech.web.servlets.division;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import me.pgtech.web.client.DivisionApiClient;
import me.pgtech.web.client.PaisApiClient;
import me.pgtech.web.dto.RegionDivisionMapaDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/divisiones/mapa")
public class DivisionMapaServlet extends BaseApiServlet {

    private final DivisionApiClient client = new DivisionApiClient();
    private final PaisApiClient paisClient = new PaisApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long paisId = parsearId(req, "paisId");

            List<RegionDivisionMapaDTO> regiones = client.listarTodasLasRegionesMapa(paisId);

            req.setAttribute("regiones", regiones);
            req.setAttribute("paises", paisClient.listar());
            req.setAttribute("paisIdSeleccionado", paisId);
            req.getRequestDispatcher("/WEB-INF/vistas/division-mapa.jsp").forward(req, resp);
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }
}