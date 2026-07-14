package me.pgtech.web.servlets.proyecto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import me.pgtech.web.client.ProyectoApiClient;
import me.pgtech.web.dto.PlayerDetailDTO;
import me.pgtech.web.dto.ProyectoSummaryDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/reviewer/finalizaciones")
public class ReviewerFinalizacionesServlet extends BaseApiServlet {

    private final ProyectoApiClient client = new ProyectoApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            HttpSession session = req.getSession(false);
            PlayerDetailDTO player = (PlayerDetailDTO) session.getAttribute("player");
            
            List<ProyectoSummaryDTO> finalizaciones = client.listarFinalizaciones(player.getId());
            req.setAttribute("finalizaciones", finalizaciones);
            req.getRequestDispatcher("/WEB-INF/vistas/reviewer-finalizaciones-lista.jsp").forward(req, resp);

        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}
