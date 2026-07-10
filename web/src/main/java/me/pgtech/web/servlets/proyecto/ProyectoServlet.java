package me.pgtech.web.servlets.proyecto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import me.pgtech.web.client.ProyectoApiClient;
import me.pgtech.web.client.TipoProyectoApiClient;
import me.pgtech.web.dto.PaginaDTO;
import me.pgtech.web.dto.PlayerDetailDTO;
import me.pgtech.web.dto.PlayerSummaryDTO;
import me.pgtech.web.dto.ProyectoDetailDTO;
import me.pgtech.web.dto.ProyectoSummaryDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/proyectos")
public class ProyectoServlet extends BaseApiServlet {

    private static final int TAMANO_PAGINA = 20;

    private final ProyectoApiClient client = new ProyectoApiClient();
    private final TipoProyectoApiClient tipoClient = new TipoProyectoApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String idParam = req.getParameter("id");
            if (idParam != null) {
                ProyectoDetailDTO proyecto = client.obtener(idParam);
                req.setAttribute("proyecto", proyecto);
                req.setAttribute("tipos", tipoClient.listar());

                // Chequeo de solicitud pendiente propia
                HttpSession session = req.getSession(false);
                if (session != null && session.getAttribute("player") != null) {
                    PlayerDetailDTO playerLogueado = (PlayerDetailDTO) session.getAttribute("player");
                    List<PlayerSummaryDTO> solicitudes = client.obtenerSolicitudes(idParam);
                    boolean yaSolicito = solicitudes.stream()
                        .anyMatch(p -> p.getId().equals(playerLogueado.getId()));
                    req.setAttribute("yaSolicitoUnion", yaSolicito);
                }

                req.getRequestDispatcher("/WEB-INF/vistas/proyecto-form.jsp").forward(req, resp);
                return;
            }

            int page = obtenerEntero(req, "page", 0);
            PaginaDTO<ProyectoSummaryDTO> pagina = client.listar(page, TAMANO_PAGINA);
            req.setAttribute("pagina", pagina);
            req.getRequestDispatcher("/WEB-INF/vistas/proyecto-lista.jsp").forward(req, resp);

        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}