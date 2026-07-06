package me.pgtech.web.servlets.tipoproyecto;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import me.pgtech.web.client.TipoProyectoApiClient;
import me.pgtech.web.dto.TipoProyectoDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet({"/tipos-proyecto", "/tipos-proyecto/nuevo"})
public class TipoProyectoServlet extends BaseApiServlet {

    private final TipoProyectoApiClient client = new TipoProyectoApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String path = req.getServletPath();
        try {
            if (path.endsWith("/nuevo")) {
                req.getRequestDispatcher("/WEB-INF/vistas/tipo-proyecto-form.jsp").forward(req, resp);
                return;
            }

            String idParam = req.getParameter("id");
            if (idParam != null) {
                Long id = parsearId(req, "id");
                TipoProyectoDTO tipoProyecto = client.obtener(id);
                req.setAttribute("tipoProyecto", tipoProyecto);
                req.getRequestDispatcher("/WEB-INF/vistas/tipo-proyecto-form.jsp").forward(req, resp);
            } else {
                List<TipoProyectoDTO> tiposProyecto = client.listar();
                req.setAttribute("tiposProyecto", tiposProyecto);
                req.getRequestDispatcher("/WEB-INF/vistas/tipo-proyecto-lista.jsp").forward(req, resp);
            }
        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}
