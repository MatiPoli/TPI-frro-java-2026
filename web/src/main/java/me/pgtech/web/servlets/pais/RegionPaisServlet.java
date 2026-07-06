package me.pgtech.web.servlets.pais;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import me.pgtech.web.client.PaisApiClient;
import me.pgtech.web.dto.PaginaDTO;
import me.pgtech.web.dto.PaisDetailDTO;
import me.pgtech.web.dto.RegionPaisDetailDTO;
import me.pgtech.web.dto.RegionPaisSummaryDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet({"/paises/regiones", "/paises/regiones/nuevo"})
public class RegionPaisServlet extends BaseApiServlet {

    private static final int TAMAÑO_PAGINA = 20;

    private final PaisApiClient client = new PaisApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String path = req.getServletPath();

        try {
            String paisidParam = req.getParameter("paisId");
            if (paisidParam == null) {
                throw new IllegalArgumentException("Falta el parámetro: paisId");
            }
            Long paisId = parsearId(req, "paisId");
            PaisDetailDTO pais = client.obtener(paisId);
            req.setAttribute("pais", pais);

            if (path.endsWith("/nuevo")) {
                req.getRequestDispatcher("/WEB-INF/vistas/region-pais-form.jsp").forward(req, resp);
                return;
            }

            String regionidParam = req.getParameter("regionId");
            if (regionidParam != null) {
                
                Long regionId = parsearId(req, "regionId");
                RegionPaisDetailDTO region = client.obtener(paisId, regionId);
                req.setAttribute("region", region);
                req.getRequestDispatcher("/WEB-INF/vistas/region-pais-form.jsp").forward(req, resp);
                return;
            }

            int page = obtenerEntero(req, "page", 0);

            PaginaDTO<RegionPaisSummaryDTO> pagina = client.listar(paisId, page, TAMAÑO_PAGINA);
            req.setAttribute("pagina", pagina);
            req.getRequestDispatcher("/WEB-INF/vistas/region-pais-lista.jsp").forward(req, resp);

        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}
