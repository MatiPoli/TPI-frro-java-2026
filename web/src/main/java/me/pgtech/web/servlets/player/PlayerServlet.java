package me.pgtech.web.servlets.player;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.UUID;

import me.pgtech.web.client.PaisApiClient;
import me.pgtech.web.client.PlayerApiClient;
import me.pgtech.web.client.RangoUsuarioApiClient;
import me.pgtech.web.client.TipoUsuarioApiClient;
import me.pgtech.web.dto.PaginaDTO;
import me.pgtech.web.dto.PlayerDetailDTO;
import me.pgtech.web.dto.PlayerSummaryDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/players")
public class PlayerServlet extends BaseApiServlet {

    private static final int TAMANO_PAGINA = 20;

    private final PlayerApiClient client = new PlayerApiClient();
    private final RangoUsuarioApiClient rangoClient = new RangoUsuarioApiClient();
    private final TipoUsuarioApiClient tipoClient = new TipoUsuarioApiClient();
    private final PaisApiClient paisClient = new PaisApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String idParam = req.getParameter("id");
            if (idParam != null) {
                UUID id = parsearUUID(req, "id");
                PlayerDetailDTO player = client.obtener(id);
                req.setAttribute("player", player);
                req.setAttribute("rangos", rangoClient.listar());
                req.setAttribute("tipos", tipoClient.listar());
                req.setAttribute("paises", paisClient.listar());
                req.getRequestDispatcher("/WEB-INF/vistas/player-form.jsp").forward(req, resp);
                return;
            }

            int page = obtenerEntero(req, "page", 0);
            String nombreFiltro = req.getParameter("nombre");
            PaginaDTO<PlayerSummaryDTO> pagina = client.listar(page, TAMANO_PAGINA, nombreFiltro);
            req.setAttribute("pagina", pagina);
            req.setAttribute("nombreFiltro", nombreFiltro);
            req.getRequestDispatcher("/WEB-INF/vistas/player-lista.jsp").forward(req, resp);

        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }
//TODO: Mejorar redireccionamiento
}
