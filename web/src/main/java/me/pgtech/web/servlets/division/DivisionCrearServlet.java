package me.pgtech.web.servlets.division;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import me.pgtech.web.client.DivisionApiClient;
import me.pgtech.web.dto.DivisionDetailDTO;
import me.pgtech.web.dto.PaisSummaryDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/divisiones/crear")
public class DivisionCrearServlet extends BaseApiServlet {

    private final DivisionApiClient client = new DivisionApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            DivisionDetailDTO dto = new DivisionDetailDTO();
            dto.setNombre(req.getParameter("nombre"));
            dto.setNam(req.getParameter("nam"));
            dto.setGna(req.getParameter("gna"));
            dto.setFna(req.getParameter("fna"));
            dto.setContexto(req.getParameter("contexto"));

            PaisSummaryDTO pais = new PaisSummaryDTO();
            pais.setId(Long.parseLong(req.getParameter("paisId")));
            dto.setPais(pais);
            client.crear(dto);
            //TODO: Redirigir mejor
            resp.sendRedirect(req.getContextPath() + "/divisiones");
        } catch (NumberFormatException e) {
            manejarError(req, resp, e, "País inválido");
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}
