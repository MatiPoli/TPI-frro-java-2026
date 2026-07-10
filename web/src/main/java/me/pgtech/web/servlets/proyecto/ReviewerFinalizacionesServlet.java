package me.pgtech.web.servlets.proyecto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import me.pgtech.web.client.ProyectoApiClient;
import me.pgtech.web.dto.PaginaDTO;
import me.pgtech.web.dto.ProyectoSummaryDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/reviewer/finalizaciones")
public class ReviewerFinalizacionesServlet extends BaseApiServlet {

    private static final int TAMANO_PAGINA = 20;

    private final ProyectoApiClient client = new ProyectoApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // TODO: cuando haya login real, esto debería filtrar server-side
            // según los países de los que el Player logueado es reviewer/manager.
            // Por ahora devuelve TODAS las finalizaciones pendientes, sin distinción de país.

            int page = obtenerEntero(req, "page", 0);
            PaginaDTO<ProyectoSummaryDTO> pagina = client.listarFinalizaciones(page, TAMANO_PAGINA);
            req.setAttribute("pagina", pagina);
            req.getRequestDispatcher("/WEB-INF/vistas/reviewer-finalizaciones-lista.jsp").forward(req, resp);

        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}
