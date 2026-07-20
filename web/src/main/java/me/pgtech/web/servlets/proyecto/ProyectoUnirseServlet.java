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
import me.pgtech.web.dto.Estado;
import me.pgtech.web.dto.PlayerDetailDTO;
import me.pgtech.web.dto.PlayerSummaryDTO;
import me.pgtech.web.dto.ProyectoDetailDTO;
import me.pgtech.web.dto.ProyectoSummaryDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/proyectos/unirse")
public class ProyectoUnirseServlet extends BaseApiServlet {

    private final ProyectoApiClient client = new ProyectoApiClient();
    private final PlayerApiClient playerClient = new PlayerApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String proyectoId = req.getParameter("proyectoId");

            HttpSession session = req.getSession(false);
            if (session == null || session.getAttribute("player") == null) {
                manejarError(req, resp, new IllegalStateException(), "Tenés que iniciar sesión para solicitar unirte a un proyecto");
                return;
            }
            PlayerDetailDTO playerLogueado = (PlayerDetailDTO) session.getAttribute("player");
            ProyectoDetailDTO proyecto = client.obtener(proyectoId);

            if (proyecto.getEstado() != Estado.ACTIVO && proyecto.getEstado() != Estado.EDITANDO) {
                manejarError(req, resp, new IllegalStateException(), "No se puede solicitar unirse a un proyecto que no está activo");
                return;
            }

            List<ProyectoSummaryDTO> proyectosDelJugador = playerClient.listarProyectos(playerLogueado.getId());
            int cantMaxProyectosTipo = playerLogueado.getTipoUsuario().getCantProyecSim();
            long cantProyectos = proyectosDelJugador.stream().filter(p -> p.getEstado() == Estado.ACTIVO || p.getEstado() == Estado.EDITANDO).count();
            boolean tieneEspacio = cantProyectos < cantMaxProyectosTipo;

            if (!tieneEspacio) {
                manejarError(req, resp, new IllegalStateException(), "No tenés espacio para unirte a más proyectos. Actualmente tenés " + cantProyectos + " proyectos activos o en edición, y tu tipo de usuario permite un máximo de " + cantMaxProyectosTipo);
                return;
            }            

            List<PlayerSummaryDTO> solicitudes = client.obtenerSolicitudes(proyectoId);
            boolean yaSolicito = solicitudes.stream().anyMatch(p -> p.getId().equals(playerLogueado.getId()));
            if (yaSolicito) {
                manejarError(req, resp, new IllegalStateException(), "Ya enviaste una solicitud para unirte a este proyecto");
                return;
            }
            List<PlayerSummaryDTO> miembros = client.listarMiembros(proyectoId);
            boolean esMiembro = miembros.stream().anyMatch(p -> p.getId().equals(playerLogueado.getId()));
            if (esMiembro || proyecto.getLider().getId().equals(playerLogueado.getId())) {
                manejarError(req, resp, new IllegalStateException(), "Ya sos miembro de este proyecto");
                return;
            }

            long cantMaxMiembros = proyecto.getTipoProyecto().getMaxMiembros();
            if (miembros.size() >= cantMaxMiembros) {
                manejarError(req, resp, new IllegalStateException(), "Este proyecto ya tiene el máximo de miembros permitidos");
                return;
            }

            client.enviarSolicitud(proyectoId, playerLogueado.getId());
            String baseUrl = req.getContextPath() + "/proyectos?id=" + proyectoId;
            resp.sendRedirect(proyectoFormUrlCheck(req, baseUrl));
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }
    
}
