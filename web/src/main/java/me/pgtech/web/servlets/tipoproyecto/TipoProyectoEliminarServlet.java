package me.pgtech.web.servlets.tipoproyecto;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import me.pgtech.web.client.TipoProyectoApiClient;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/tipos-proyecto/eliminar")
public class TipoProyectoEliminarServlet extends BaseApiServlet {

    private final TipoProyectoApiClient client = new TipoProyectoApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long id = parsearId(req, "id");
            client.eliminar(id);
            resp.sendRedirect(req.getContextPath() + "/tipos-proyecto");
        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}
