package me.pgtech.web.servlets.division;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import me.pgtech.web.client.DivisionApiClient;
import me.pgtech.web.dto.DivisionDetailDTO;
import me.pgtech.web.dto.PaginaDTO;
import me.pgtech.web.dto.RegionDivisionDetailDTO;
import me.pgtech.web.dto.RegionDivisionSummaryDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet({"/divisiones/regiones", "/divisiones/regiones/nuevo"})
public class RegionDivisionServlet extends BaseApiServlet {

    private static final int TAMAÑO_PAGINA = 20;

    private final DivisionApiClient client = new DivisionApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String path = req.getServletPath();

        try {
            String divisionIdParam = req.getParameter("divisionId");
            if (divisionIdParam == null) {
                throw new IllegalArgumentException("Falta el parámetro: divisionId");
            }
            Long divisionId = parsearId(req, "divisionId");
            DivisionDetailDTO division = client.obtener(divisionId);
            req.setAttribute("division", division);

            if (path.endsWith("/nuevo")) {
                req.setAttribute("regionesContexto", client.listarRegionesMapaDeDivision(divisionId));
                req.getRequestDispatcher("/WEB-INF/vistas/region-division-form.jsp").forward(req, resp);
                return;
            }

            String regionIdParam = req.getParameter("regionId");
            if (regionIdParam != null) {
                Long regionId = parsearId(req, "regionId");
                RegionDivisionDetailDTO region = client.obtener(divisionId, regionId);
                req.setAttribute("region", region);
                req.getRequestDispatcher("/WEB-INF/vistas/region-division-form.jsp").forward(req, resp);
                return;
            }

            int page = obtenerEntero(req, "page", 0);

            PaginaDTO<RegionDivisionSummaryDTO> pagina = client.listar(divisionId, page, TAMAÑO_PAGINA);
            req.setAttribute("pagina", pagina);
            req.getRequestDispatcher("/WEB-INF/vistas/region-division-lista.jsp").forward(req, resp);

        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}