package me.pgtech.web.servlets.rangousuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import me.pgtech.web.client.RangoUsuarioApiClient;
import me.pgtech.web.dto.RangoUsuarioDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/rangos-usuario/actualizar")
public class RangoUsuarioActualizarServlet extends BaseApiServlet {

    private final RangoUsuarioApiClient client = new RangoUsuarioApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long id = parsearId(req, "id");
            RangoUsuarioDTO dto = new RangoUsuarioDTO();
            dto.setNombre(req.getParameter("nombre"));

            client.actualizar(id, dto);
            resp.sendRedirect(req.getContextPath() + "/rangos-usuario");
        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }
}
