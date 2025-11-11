package org.example.demo.servlet.auth;



import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.demo.dto.LoginDTO;
import org.example.demo.entity.User;

import java.io.IOException;

@WebFilter(urlPatterns = {"/admin/*", "/doctor/*" ,"/patient/*"})
public class AuthFilter  implements Filter {


    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        String path = request.getRequestURI();

        HttpSession session = request.getSession(false);
        LoginDTO authUser = (session != null) ? (LoginDTO)  session.getAttribute("user") : null;
        boolean isLoggedIn = (authUser != null);
        boolean isLoginPage = path.endsWith("login.jsp") || path.endsWith("login");
        boolean isPublicResource = path.contains("css") || path.contains("js");

        if (isLoggedIn || isLoginPage || isPublicResource) {
            chain.doFilter(req, resp);
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }



}
