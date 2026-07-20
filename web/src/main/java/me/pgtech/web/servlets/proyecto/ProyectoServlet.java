package me.pgtech.web.servlets.proyecto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import me.pgtech.web.client.PlayerApiClient;
import me.pgtech.web.client.ProyectoApiClient;
import me.pgtech.web.client.TipoProyectoApiClient;
import me.pgtech.web.dto.Estado;
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
    private final PlayerApiClient playerClient = new PlayerApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String idParam = req.getParameter("id");
            if (idParam != null) {
                ProyectoDetailDTO proyecto = client.obtener(idParam);
                req.setAttribute("proyecto", proyecto);
                req.setAttribute("tipos", tipoClient.listar());

                HttpSession session = req.getSession(false);
                PlayerDetailDTO player = (PlayerDetailDTO) session.getAttribute("player");
                PlayerDetailDTO playerLogueado = playerClient.obtener(player.getId());

                List<PlayerSummaryDTO> solicitudes = client.obtenerSolicitudes(idParam);
                boolean yaSolicito = solicitudes.stream().anyMatch(p -> p.getId().equals(playerLogueado.getId()));
                req.setAttribute("yaSolicitoUnion", yaSolicito);

                List<PlayerSummaryDTO> miembros = client.listarMiembros(idParam);
                boolean esMiembro = miembros.stream().anyMatch(p -> p.getId().equals(playerLogueado.getId()));
                req.setAttribute("esMiembro", esMiembro);

                boolean esLider = proyecto.getLider() != null && proyecto.getLider().getId().equals(playerLogueado.getId());
                req.setAttribute("esLider", esLider);

                List<ProyectoSummaryDTO> proyectosDelJugador = playerClient.listarProyectos(playerLogueado.getId());
                int cantMaxProyectosTipo = playerLogueado.getTipoUsuario().getCantProyecSim();
                long cantProyectos = proyectosDelJugador.stream().filter(p -> p.getEstado() == Estado.ACTIVO || p.getEstado() == Estado.EDITANDO).count();
                boolean tieneEspacio = cantProyectos < cantMaxProyectosTipo;
                req.setAttribute("tieneEspacio", tieneEspacio);
                req.setAttribute("cantMaxProyectosTipo", cantMaxProyectosTipo);
                req.setAttribute("cantProyectos", cantProyectos);

                long cantMaxMiembros = proyecto.getTipoProyecto().getMaxMiembros();
                boolean proyectoLleno = miembros.size() >= cantMaxMiembros;
                req.setAttribute("proyectoLleno", proyectoLleno);

                proyectoFormAtrributeCheck(req);
                req.getRequestDispatcher("/WEB-INF/vistas/proyecto-form.jsp").forward(req, resp);
                return;
            }

            int page = obtenerEntero(req, "page", 0);
            String idFiltro = req.getParameter("idFiltro");
            PaginaDTO<ProyectoSummaryDTO> pagina = client.listar(page, TAMANO_PAGINA, idFiltro);
            req.setAttribute("pagina", pagina);
            req.setAttribute("idFiltro", idFiltro);
            req.getRequestDispatcher("/WEB-INF/vistas/proyecto-lista.jsp").forward(req, resp);

        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}