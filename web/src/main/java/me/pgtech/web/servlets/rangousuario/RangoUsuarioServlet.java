package me.pgtech.web.servlets.rangousuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import me.pgtech.web.client.RangoUsuarioApiClient;
import me.pgtech.web.dto.RangoUsuarioDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet({"/rangos-usuario", "/rangos-usuario/nuevo"})
public class RangoUsuarioServlet extends BaseApiServlet {

    private final RangoUsuarioApiClient client = new RangoUsuarioApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String path = req.getServletPath();
        try {
            if (path.endsWith("/nuevo")) {
                req.getRequestDispatcher("/WEB-INF/vistas/rango-usuario-form.jsp").forward(req, resp);
                return;
            }

            String idParam = req.getParameter("id");
            if (idParam != null) {
                Long id = parsearId(req, "id");
                RangoUsuarioDTO rango = client.obtener(id);
                req.setAttribute("rango", rango);
                req.getRequestDispatcher("/WEB-INF/vistas/rango-usuario-form.jsp").forward(req, resp);
            } else {
                List<RangoUsuarioDTO> rangos = client.listar();
                req.setAttribute("rangos", rangos);
                req.getRequestDispatcher("/WEB-INF/vistas/rango-usuario-lista.jsp").forward(req, resp);
            }
        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }
}
