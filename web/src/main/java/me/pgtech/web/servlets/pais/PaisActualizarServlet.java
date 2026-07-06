package me.pgtech.web.servlets.pais;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import me.pgtech.web.client.PaisApiClient;
import me.pgtech.web.dto.PaisDetailDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/paises/actualizar")
public class PaisActualizarServlet extends BaseApiServlet {

    private final PaisApiClient client = new PaisApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long id = parsearId(req, "id");
            PaisDetailDTO dto = new PaisDetailDTO();
            dto.setNombre(req.getParameter("nombre"));
            dto.setNombrePublico(req.getParameter("nombrePublico"));
            dto.setDsIdGuild(Long.parseLong(req.getParameter("dsIdGuild")));
            dto.setDsIdGlobalChat(Long.parseLong(req.getParameter("dsIdGlobalChat")));
            dto.setDsIdCountryChat(Long.parseLong(req.getParameter("dsIdCountryChat")));
            dto.setDsIdLog(Long.parseLong(req.getParameter("dsIdLog")));
            dto.setDsIdRequest(Long.parseLong(req.getParameter("dsIdRequest")));
            dto.setWebId(req.getParameter("webId"));
            dto.setWebToken(req.getParameter("webToken"));

            client.actualizar(id, dto);
            resp.sendRedirect(req.getContextPath() + "/paises");
        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}
