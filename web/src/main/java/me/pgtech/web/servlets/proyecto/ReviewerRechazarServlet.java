package me.pgtech.web.servlets.proyecto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.UUID;

import me.pgtech.web.client.ProyectoApiClient;
import me.pgtech.web.servlets.BaseApiServlet;
import me.pgtech.web.servlets.TestLoginServlet;

@WebServlet("/reviewer/finalizaciones/rechazar")
public class ReviewerRechazarServlet extends BaseApiServlet {

    private static final UUID STAFF_ID_HARDCODEADO = TestLoginServlet.UUID_REVIEWER;

    private final ProyectoApiClient client = new ProyectoApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String proyectoId = req.getParameter("proyectoId");
            String comentario = req.getParameter("comentario");

            client.rechazarFinalizacion(proyectoId, STAFF_ID_HARDCODEADO, comentario);
            resp.sendRedirect(req.getContextPath() + "/reviewer/finalizaciones");
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}