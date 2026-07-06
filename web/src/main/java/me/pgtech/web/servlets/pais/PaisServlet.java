package me.pgtech.web.servlets.pais;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import me.pgtech.web.client.PaisApiClient;
import me.pgtech.web.dto.PaisDetailDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet({"/paises", "/paises/nuevo"})
public class PaisServlet extends BaseApiServlet {

    private final PaisApiClient client = new PaisApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String path = req.getServletPath();
        try {
            if (path.endsWith("/nuevo")) {
                req.getRequestDispatcher("/WEB-INF/vistas/pais-form.jsp").forward(req, resp);
                return;
            }

            String idParam = req.getParameter("id");
            if (idParam != null) {
                Long id = parsearId(req, "id");
                PaisDetailDTO pais = client.obtener(id);
                req.setAttribute("pais", pais);
                req.getRequestDispatcher("/WEB-INF/vistas/pais-form.jsp").forward(req, resp);
            } else {
                List<PaisDetailDTO> paises = client.listar();
                req.setAttribute("paises", paises);
                req.getRequestDispatcher("/WEB-INF/vistas/pais-lista.jsp").forward(req, resp);
            }
        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}
