package me.pgtech.web.servlets.session.filters;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import me.pgtech.web.client.ProyectoApiClient;
import me.pgtech.web.dto.PlayerDetailDTO;
import me.pgtech.web.dto.ProyectoDetailDTO;

@WebFilter({"/proyectos/solicitudes", "/proyectos/solicitudes/aceptar", "/proyectos/solicitudes/rechazar", "/proyectos/finalizar", "/proyectos/actualizar"})
public class LiderAccessFilter implements Filter {

    private final ProyectoApiClient client = new ProyectoApiClient();

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("player") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        PlayerDetailDTO player = (PlayerDetailDTO) session.getAttribute("player");
        String proyectoId = req.getParameter("proyectoId");
        if (proyectoId == null) {
            proyectoId = req.getParameter("id");
            if (proyectoId == null) {
                throw new IllegalArgumentException("Falta el parámetro: proyectoId");
            }
        }
        ProyectoDetailDTO proyecto = client.obtener(proyectoId);
        if (!player.getId().equals(proyecto.getLider().getId())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "No tenés permisos para acceder a esta sección");
            return;
        }

        chain.doFilter(req, res);
    }

}
