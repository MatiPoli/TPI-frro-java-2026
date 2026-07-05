package me.pgtech.web.servlets.tipousuario;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import me.pgtech.web.client.TipoUsuarioApiClient;
import me.pgtech.web.dto.TipoUsuarioDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/tipos-usuario/crear")
public class TipoUsuarioCrearServlet extends BaseApiServlet {

    private final TipoUsuarioApiClient client = new TipoUsuarioApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            TipoUsuarioDTO dto = new TipoUsuarioDTO();
            dto.setNombre(req.getParameter("nombre"));
            dto.setDescripcion(req.getParameter("descripcion"));
            dto.setCantProyecSim(Integer.valueOf(req.getParameter("cantProyecSim")));
            client.crear(dto);
            resp.sendRedirect(req.getContextPath() + "/tipos-usuario");
        } catch (NumberFormatException e) {
            manejarError(req, resp, e, "El máximo de proyectos debe ser un número válido");
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}
