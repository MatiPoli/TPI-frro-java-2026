package me.pgtech.web.servlets.pais;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import me.pgtech.web.client.PaisApiClient;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/paises/eliminar")
public class PaisEliminarServlet extends BaseApiServlet {

    private final PaisApiClient client = new PaisApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long id = parsearId(req, "id");
            client.eliminar(id);
            resp.sendRedirect(req.getContextPath() + "/paises");
        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }
    
}
