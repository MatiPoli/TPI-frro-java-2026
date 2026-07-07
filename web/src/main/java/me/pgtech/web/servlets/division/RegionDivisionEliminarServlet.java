package me.pgtech.web.servlets.division;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import me.pgtech.web.client.DivisionApiClient;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/divisiones/regiones/eliminar")
public class RegionDivisionEliminarServlet extends BaseApiServlet {

    private final DivisionApiClient client = new DivisionApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long divisionId = parsearId(req, "divisionId");
            Long regionId = parsearId(req, "regionId");
            client.eliminar(divisionId, regionId);
            resp.sendRedirect(req.getContextPath() + "/divisiones/regiones?divisionId=" + divisionId);
        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }
    
}
