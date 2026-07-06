package me.pgtech.web.servlets.tipoproyecto;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import me.pgtech.web.client.TipoProyectoApiClient;
import me.pgtech.web.dto.TipoProyectoDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/tipos-proyecto/crear")
public class TipoProyectoCrearServlet extends BaseApiServlet {

    private final TipoProyectoApiClient client = new TipoProyectoApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            TipoProyectoDTO dto = new TipoProyectoDTO();
            dto.setNombre(req.getParameter("nombre"));
            dto.setMaxMiembros(Integer.valueOf(req.getParameter("maxMiembros")));
            dto.setTamanoMin(Integer.valueOf(req.getParameter("tamanoMin")));
            dto.setTamanoMax(Integer.valueOf(req.getParameter("tamanoMax")));

            client.crear(dto);
            resp.sendRedirect(req.getContextPath() + "/tipos-proyecto");
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}
