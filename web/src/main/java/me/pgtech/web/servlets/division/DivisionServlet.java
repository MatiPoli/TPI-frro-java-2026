package me.pgtech.web.servlets.division;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import me.pgtech.web.client.DivisionApiClient;
import me.pgtech.web.client.PaisApiClient;
import me.pgtech.web.dto.DivisionDetailDTO;
import me.pgtech.web.servlets.BaseApiServlet;

@WebServlet({"/divisiones", "/divisiones/nuevo"})
public class DivisionServlet extends BaseApiServlet {

    private final DivisionApiClient client = new DivisionApiClient();
    private final PaisApiClient paisClient = new PaisApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String path = req.getServletPath();

        try {
            if (path.endsWith("/nuevo")) {
                req.setAttribute("paises", paisClient.listar());
                req.getRequestDispatcher("/WEB-INF/vistas/division-form.jsp").forward(req, resp);
                return;
            }

            String idParam = req.getParameter("id");
            if (idParam != null) {
                Long id = parsearId(req, "id");
                DivisionDetailDTO division = client.obtener(id);
                req.setAttribute("division", division);
                req.setAttribute("paises", paisClient.listar());
                req.getRequestDispatcher("/WEB-INF/vistas/division-form.jsp").forward(req, resp);
                return;
            }
            
            throw new IllegalArgumentException("Parámetro 'id' es requerido para ver o editar una división.");

        } catch (IllegalArgumentException e) {
            manejarError(req, resp, e, "Datos inválidos: " + e.getMessage());
        } catch (IOException e) {
            manejarErrorApi(req, resp, e);
        }
    }

}