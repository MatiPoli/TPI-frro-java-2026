package me.pgtech.web.servlets.pais;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import me.pgtech.web.client.PaisApiClient;
import me.pgtech.web.dto.DivisionSummaryDTO;
import me.pgtech.web.dto.PaginaDTO;
import me.pgtech.web.dto.PaisDetailDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/paises/divisiones")
public class PaisDivisionServlet extends BaseApiServlet {

    private static final int TAMAÑO_PAGINA = 20;

    private final PaisApiClient client = new PaisApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long paisId = parsearId(req, "paisId");
            PaisDetailDTO pais = client.obtener(paisId);
            req.setAttribute("pais", pais);

            int page = obtenerEntero(req, "page", 0);

            PaginaDTO<DivisionSummaryDTO> pagina = client.listarDivisiones(paisId, page, TAMAÑO_PAGINA);
            req.setAttribute("pagina", pagina);
            req.getRequestDispatcher("/WEB-INF/vistas/pais-division-lista.jsp").forward(req, resp);

        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}
