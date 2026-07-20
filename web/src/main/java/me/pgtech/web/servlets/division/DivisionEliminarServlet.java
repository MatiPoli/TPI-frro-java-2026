package me.pgtech.web.servlets.division;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import me.pgtech.web.client.DivisionApiClient;
import me.pgtech.web.dto.DivisionDetailDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/divisiones/eliminar")
public class DivisionEliminarServlet extends BaseApiServlet {

    private final DivisionApiClient client = new DivisionApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            Long id = parsearId(req, "id");
            DivisionDetailDTO division = client.obtener(id);
            client.eliminar(id);
            resp.sendRedirect(req.getContextPath() + "/paises/divisiones?paisId=" + division.getPais().getId());
        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }
}
