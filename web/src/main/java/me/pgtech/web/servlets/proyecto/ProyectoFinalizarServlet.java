package me.pgtech.web.servlets.proyecto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import me.pgtech.web.client.ProyectoApiClient;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/proyectos/finalizar")
public class ProyectoFinalizarServlet extends BaseApiServlet {

    private final ProyectoApiClient client = new ProyectoApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String proyectoId = req.getParameter("proyectoId");
            client.finalizarProyecto(proyectoId);

            String baseUrl = req.getContextPath() + "/proyectos?id=" + proyectoId;
            resp.sendRedirect(proyectoFormUrlCheck(req, baseUrl));
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }
}