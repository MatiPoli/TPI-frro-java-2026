package me.pgtech.web.servlets.session;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import me.pgtech.web.client.PlayerApiClient;
import me.pgtech.web.dto.PaisSummaryDTO;
import me.pgtech.web.dto.PlayerDetailDTO;

@WebServlet("/perfil/actualizar")
public class PerfilActualizarServlet extends HttpServlet {

    private final PlayerApiClient client = new PlayerApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("player") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        PlayerDetailDTO playerSesion = (PlayerDetailDTO) session.getAttribute("player");

        try {
            PlayerDetailDTO playerActual = client.obtener(playerSesion.getId());

            String nuevoNombrePublico = req.getParameter("nombrePublico");
            if (nuevoNombrePublico == null || nuevoNombrePublico.isBlank()) {
                req.setAttribute("error", "El nombre público no puede estar vacío");
                req.getRequestDispatcher("/WEB-INF/vistas/error.jsp").forward(req, resp);
                return;
            }
            playerActual.setNombrePublico(nuevoNombrePublico);

            String paisIdParam = req.getParameter("paisId");
            if (paisIdParam != null && !paisIdParam.isBlank()) {
                PaisSummaryDTO pais = new PaisSummaryDTO();
                pais.setId(Long.valueOf(paisIdParam));
                playerActual.setPaisPrefix(pais);
            } else {
                playerActual.setPaisPrefix(null);
            }

            client.actualizar(playerSesion.getId(), playerActual);

            session.setAttribute("player", playerActual);
            resp.sendRedirect(req.getContextPath() + "/perfil");

        } catch (IOException e) {
            req.setAttribute("error", "No se pudo actualizar tu perfil");
            req.getRequestDispatcher("/WEB-INF/vistas/error.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            req.setAttribute("error", "País inválido");
            req.getRequestDispatcher("/WEB-INF/vistas/error.jsp").forward(req, resp);
        }
    }
}