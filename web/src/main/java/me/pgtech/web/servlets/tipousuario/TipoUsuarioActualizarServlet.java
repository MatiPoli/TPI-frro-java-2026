package me.pgtech.web.servlets.tipousuario;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import me.pgtech.web.client.TipoUsuarioApiClient;
import me.pgtech.web.dto.TipoUsuarioDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/tipos-usuario/actualizar")
public class TipoUsuarioActualizarServlet extends BaseApiServlet {

    private final TipoUsuarioApiClient client = new TipoUsuarioApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long id = parsearId(req, "id");
            TipoUsuarioDTO dto = new TipoUsuarioDTO();
            dto.setNombre(req.getParameter("nombre"));
            dto.setDescripcion(req.getParameter("descripcion"));
            dto.setCantProyecSim(Integer.valueOf(req.getParameter("cantProyecSim")));

            client.actualizar(id, dto);
            resp.sendRedirect(req.getContextPath() + "/tipos-usuario");
        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }
}
