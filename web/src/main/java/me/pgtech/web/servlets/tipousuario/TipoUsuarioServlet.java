package me.pgtech.web.servlets.tipousuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import me.pgtech.web.client.TipoUsuarioApiClient;
import me.pgtech.web.dto.TipoUsuarioDTO;
import me.pgtech.web.servlets.BaseApiServlet;

import java.io.IOException;
import java.util.List;


@WebServlet({"/tipos-usuario", "/tipos-usuario/nuevo"})
public class TipoUsuarioServlet extends BaseApiServlet {

    private final TipoUsuarioApiClient client = new TipoUsuarioApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String path = req.getServletPath();
        try {
            if (path.endsWith("/nuevo")) {
                req.getRequestDispatcher("/WEB-INF/vistas/tipo-usuario-form.jsp").forward(req, resp);
                return;
            }

            String idParam = req.getParameter("id");
            if (idParam != null) {

                Long id = parsearId(req, "id");
                TipoUsuarioDTO tipo = client.obtener(id);
                req.setAttribute("tipo", tipo);
                req.getRequestDispatcher("/WEB-INF/vistas/tipo-usuario-form.jsp").forward(req, resp);
            } else {
                // Listado
                List<TipoUsuarioDTO> tipos = client.listar();
                req.setAttribute("tipos", tipos);
                req.getRequestDispatcher("/WEB-INF/vistas/tipo-usuario-lista.jsp").forward(req, resp);
            }
        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }
}
