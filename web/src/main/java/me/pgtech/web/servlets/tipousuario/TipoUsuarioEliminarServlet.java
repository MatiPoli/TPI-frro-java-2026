package me.pgtech.web.servlets.tipousuario;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import me.pgtech.web.client.TipoUsuarioApiClient;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/tipos-usuario/eliminar")
public class TipoUsuarioEliminarServlet extends BaseApiServlet {

    private final TipoUsuarioApiClient client = new TipoUsuarioApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long id = parsearId(req, "id");
            client.eliminar(id);
            resp.sendRedirect(req.getContextPath() + "/tipos-usuario");
        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }
}
