package me.pgtech.web.servlets.pais;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import me.pgtech.web.client.PaisApiClient;
import me.pgtech.web.dto.RegionPaisDetailDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/paises/regiones/añadir")
public class RegionPaisAñadirServlet extends BaseApiServlet {

    private final PaisApiClient client = new PaisApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            RegionPaisDetailDTO dto = new RegionPaisDetailDTO();
            Long paisId = parsearId(req, "paisId");
            dto.setNombre(req.getParameter("nombre"));
            dto.setPolygon(req.getParameter("polygon"));

            client.añadir(paisId, dto);
            resp.sendRedirect(req.getContextPath() + "/paises/regiones?paisId=" + paisId);
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}
