package me.pgtech.web.servlets.proyecto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import me.pgtech.web.client.ProyectoApiClient;
import me.pgtech.web.dto.ProyectoMapaDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/proyectos/mapa")
public class ProyectoMapaServlet extends BaseApiServlet {

    private final ProyectoApiClient client = new ProyectoApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            List<ProyectoMapaDTO> proyectos = client.listarParaMapa();
            req.setAttribute("proyectos", proyectos);
            req.getRequestDispatcher("/WEB-INF/vistas/proyecto-mapa.jsp").forward(req, resp);
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }
}