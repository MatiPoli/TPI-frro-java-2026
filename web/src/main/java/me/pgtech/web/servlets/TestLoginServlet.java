package me.pgtech.web.servlets;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.UUID;

import me.pgtech.web.dto.PaisSummaryDTO;
import me.pgtech.web.dto.PlayerDetailDTO;
import me.pgtech.web.dto.RangoUsuarioDTO;

@WebServlet("/test-login")
public class TestLoginServlet extends HttpServlet {

    // UUIDs fijos de prueba - reemplazar por Players reales de tu DB si querés datos consistentes
    public static final UUID UUID_ADMIN = UUID.fromString("559693e8-7f35-45ee-8a47-a9fca9ab22d4");
    public static final UUID UUID_REVIEWER = UUID.fromString("559693e8-7f35-45ee-8a47-a9fca9ab22d4");
    public static final UUID UUID_LIDER = UUID.fromString("559693e8-7f35-45ee-8a47-a9fca9ab22d4");
    public static final UUID UUID_MIEMBRO = UUID.fromString("559693e8-7f35-45ee-8a47-a9fca9ab22d4");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String rol = req.getParameter("rol");
        if (rol == null) rol = "admin";

        PlayerDetailDTO player = new PlayerDetailDTO();
        RangoUsuarioDTO rango = new RangoUsuarioDTO();
        PaisSummaryDTO pais = new PaisSummaryDTO();
        pais.setId(1L);
        pais.setNombre("Argentina");

        switch (rol) {
            case "reviewer" -> {
                player.setId(UUID_REVIEWER);
                player.setNombrePublico("ReviewerPrueba");
                rango.setNombre("Reviewer");
            }
            case "lider" -> {
                player.setId(UUID_LIDER);
                player.setNombrePublico("LiderPrueba");
                rango.setNombre("Usuario");
            }
            case "miembro" -> {
                player.setId(UUID_MIEMBRO);
                player.setNombrePublico("MiembroPrueba");
                rango.setNombre("Usuario");
            }
            default -> {
                player.setId(UUID_ADMIN);
                player.setNombrePublico("AdminPrueba");
                rango.setNombre("Admin");
            }
        }

        player.setRangoUsuario(rango);
        player.setPaisPrefix(pais);

        HttpSession session = req.getSession();
        session.setAttribute("player", player);
        session.setAttribute("rango", rango.getNombre());
        //session.setAttribute("paisReviewerId", pais.getId());

        resp.sendRedirect(req.getContextPath() + "/");
    }
    
}
