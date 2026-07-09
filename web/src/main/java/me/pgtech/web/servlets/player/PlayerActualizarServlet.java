package me.pgtech.web.servlets.player;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.UUID;

import me.pgtech.web.client.PlayerApiClient;
import me.pgtech.web.dto.PaisSummaryDTO;
import me.pgtech.web.dto.PlayerDetailDTO;
import me.pgtech.web.dto.RangoUsuarioDTO;
import me.pgtech.web.dto.TipoUsuarioDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/players/actualizar")
public class PlayerActualizarServlet extends BaseApiServlet {

    private final PlayerApiClient client = new PlayerApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            UUID id = UUID.fromString(req.getParameter("id"));

            PlayerDetailDTO dto = new PlayerDetailDTO();
            dto.setNombre(req.getParameter("nombre"));
            dto.setNombrePublico(req.getParameter("nombrePublico"));

            String dsId = req.getParameter("dsIdUsuario");
            if (dsId != null && !dsId.isBlank()) {
                dto.setDsIdUsuario(Long.valueOf(dsId));
            } else {
                dto.setDsIdUsuario(null);
            }

            RangoUsuarioDTO rango = new RangoUsuarioDTO();
            rango.setId(Long.valueOf(req.getParameter("rangoUsuarioId")));
            dto.setRangoUsuario(rango);

            TipoUsuarioDTO tipo = new TipoUsuarioDTO();
            tipo.setId(Long.valueOf(req.getParameter("tipoUsuarioId")));
            dto.setTipoUsuario(tipo);

            String paisId = req.getParameter("paisId");
            if (paisId != null && !paisId.isBlank()) {
                PaisSummaryDTO pais = new PaisSummaryDTO();
                pais.setId(Long.valueOf(paisId));
                dto.setPaisPrefix(pais);
            }

            client.actualizar(id, dto);
            resp.sendRedirect(req.getContextPath() + "/players?id=" + id);

        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}
