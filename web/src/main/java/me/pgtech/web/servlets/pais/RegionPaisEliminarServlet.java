package me.pgtech.web.servlets.pais;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import me.pgtech.web.client.PaisApiClient;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/paises/regiones/eliminar")
public class RegionPaisEliminarServlet extends BaseApiServlet {

    private final PaisApiClient client = new PaisApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long paisId = parsearId(req, "paisId");
            Long regionId = parsearId(req, "regionId");
            client.eliminar(paisId, regionId);
            resp.sendRedirect(req.getContextPath() + "/paises/regiones?paisId=" + paisId);
        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}
