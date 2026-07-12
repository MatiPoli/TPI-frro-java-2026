package me.pgtech.web.servlets.division;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import me.pgtech.web.client.DivisionApiClient;
import me.pgtech.web.dto.RegionDivisionDetailDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/divisiones/regiones/añadir")
public class RegionDivisionAñadirServlet extends BaseApiServlet {

    private final DivisionApiClient client = new DivisionApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            RegionDivisionDetailDTO dto = new RegionDivisionDetailDTO();
            Long divisionId = parsearId(req, "divisionId");
            dto.setNombre(req.getParameter("nombre"));
            dto.setPolygon(req.getParameter("polygon"));
            System.out.println("POLYGON RECIBIDO: " + dto.getPolygon());
            client.añadir(divisionId, dto);
            resp.sendRedirect(req.getContextPath() + "/divisiones/regiones?divisionId=" + divisionId);
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }
    
}