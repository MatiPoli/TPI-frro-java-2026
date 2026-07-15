package me.pgtech.web.servlets.tipoproyecto;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import me.pgtech.web.client.TipoProyectoApiClient;
import me.pgtech.web.dto.TipoProyectoDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/tipos-proyecto/actualizar")
public class TipoProyectoActualizarServlet extends BaseApiServlet {

    private final TipoProyectoApiClient client = new TipoProyectoApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long id = parsearId(req, "id");
            TipoProyectoDTO dto = new TipoProyectoDTO();
            dto.setNombre(req.getParameter("nombre"));
            dto.setMaxMiembros(Integer.valueOf(req.getParameter("maxMiembros")));
            dto.setTamanoMin(Integer.valueOf(req.getParameter("tamanoMin")));
            dto.setTamanoMax(Integer.valueOf(req.getParameter("tamanoMax")));

            if (dto.getTamanoMax() < dto.getTamanoMin()) {
                throw new IllegalArgumentException("El tamaño máximo debe ser mayor o igual al mínimo.");
            }
            
            client.actualizar(id, dto);
            resp.sendRedirect(req.getContextPath() + "/tipos-proyecto");
        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}
