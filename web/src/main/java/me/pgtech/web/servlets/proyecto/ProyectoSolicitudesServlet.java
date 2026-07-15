package me.pgtech.web.servlets.proyecto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import me.pgtech.web.client.ProyectoApiClient;
import me.pgtech.web.dto.PlayerSummaryDTO;
import me.pgtech.web.dto.ProyectoDetailDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/proyectos/solicitudes")
public class ProyectoSolicitudesServlet extends BaseApiServlet {

    private final ProyectoApiClient client = new ProyectoApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String proyectoId = req.getParameter("proyectoId");
            if (proyectoId == null) {
                throw new IllegalArgumentException("Falta el parámetro: proyectoId");
            }

            ProyectoDetailDTO proyecto = client.obtener(proyectoId);
            List<PlayerSummaryDTO> solicitudes = client.obtenerSolicitudes(proyectoId);

            proyectoFormAtrributeCheck(req);
            req.setAttribute("proyecto", proyecto);
            req.setAttribute("solicitudes", solicitudes);
            req.getRequestDispatcher("/WEB-INF/vistas/proyecto-solicitudes-lista.jsp").forward(req, resp);

        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}