package me.pgtech.web.servlets.session.filters;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter({"/admin", "/admin/*", "/tipos-usuario/*", "/rangos/*", "/tipos-proyecto/*", "/paises/*", "/divisiones/*"})
public class AdminAccessFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("player") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String rango = (String) session.getAttribute("rango");
        if (!"Admin".equals(rango)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "No tenés permisos para acceder a esta sección");
            return;
        }

        chain.doFilter(req, res);
    }
}