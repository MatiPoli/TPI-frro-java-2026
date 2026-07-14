package me.pgtech.web.servlets.proyecto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import me.pgtech.web.client.ProyectoApiClient;
import me.pgtech.web.dto.PlayerSummaryDTO;
import me.pgtech.web.dto.ProyectoDetailDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/reviewer/finalizaciones/revisar")
public class ReviewerRevisarServlet extends BaseApiServlet {

    private final ProyectoApiClient client = new ProyectoApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String proyectoId = req.getParameter("proyectoId");
            if (proyectoId == null) {
                throw new IllegalArgumentException("Falta el parámetro: proyectoId");
            }

            ProyectoDetailDTO proyecto = client.obtener(proyectoId);
            PlayerSummaryDTO player = proyecto.getLider();
            boolean esPostulante = player.getTipoUsuario().getNombre().equals("Postulante") ;
            req.setAttribute("proyecto", proyecto);
            req.setAttribute("esPostulante", esPostulante);
            req.getRequestDispatcher("/WEB-INF/vistas/reviewer-revisar-form.jsp").forward(req, resp);

        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }
    
}