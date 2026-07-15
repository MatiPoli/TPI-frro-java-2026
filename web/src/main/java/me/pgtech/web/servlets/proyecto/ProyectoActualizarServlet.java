package me.pgtech.web.servlets.proyecto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import me.pgtech.web.client.ProyectoApiClient;
import me.pgtech.web.dto.ProyectoDetailDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/proyectos/actualizar")
public class ProyectoActualizarServlet extends BaseApiServlet {

    private final ProyectoApiClient client = new ProyectoApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String id = req.getParameter("id");
            ProyectoDetailDTO dto = new ProyectoDetailDTO();
            dto.setNombre(req.getParameter("nombre"));
            dto.setDescripcion(req.getParameter("descripcion"));

            client.actualizar(id, dto);

            String baseUrl = req.getContextPath() + "/proyectos?id=" + id;
            resp.sendRedirect(proyectoFormUrlCheck(req, baseUrl));
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }
}
