package me.pgtech.web.servlets.proyecto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.UUID;

import me.pgtech.web.client.ProyectoApiClient;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/proyectos/solicitudes/rechazar")
public class ProyectoSolicitudRechazarServlet extends BaseApiServlet {

    private final ProyectoApiClient client = new ProyectoApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String proyectoId = req.getParameter("proyectoId");
            UUID playerId = UUID.fromString(req.getParameter("playerId"));

            client.rechazarSolicitud(proyectoId, playerId);
            resp.sendRedirect(req.getContextPath() + "/proyectos/solicitudes?proyectoId=" + proyectoId);
        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}