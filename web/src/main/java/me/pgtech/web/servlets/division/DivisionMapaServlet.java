package me.pgtech.web.servlets.division;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import me.pgtech.web.client.DivisionApiClient;
import me.pgtech.web.dto.RegionDivisionMapaDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/divisiones/mapa")
public class DivisionMapaServlet extends BaseApiServlet {

    private final DivisionApiClient client = new DivisionApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<RegionDivisionMapaDTO> regiones = client.listarTodasLasRegionesMapa();
            req.setAttribute("regiones", regiones);
            req.getRequestDispatcher("/WEB-INF/vistas/division-mapa.jsp").forward(req, resp);
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }
}