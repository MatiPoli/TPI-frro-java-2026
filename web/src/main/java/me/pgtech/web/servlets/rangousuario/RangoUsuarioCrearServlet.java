package me.pgtech.web.servlets.rangousuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import me.pgtech.web.client.RangoUsuarioApiClient;
import me.pgtech.web.dto.RangoUsuarioDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet("/rangos-usuario/crear")
public class RangoUsuarioCrearServlet extends BaseApiServlet {

    private final RangoUsuarioApiClient client = new RangoUsuarioApiClient();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            RangoUsuarioDTO dto = new RangoUsuarioDTO();
            dto.setNombre(req.getParameter("nombre"));

            client.crear(dto);
            resp.sendRedirect(req.getContextPath() + "/rango-usuario");
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }
}