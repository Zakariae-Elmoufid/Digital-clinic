package org.example.demo.servlet.auth;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.demo.dto.LoginDTO;
import org.example.demo.service.AuthService;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;


@WebServlet("/login")
public class LoginServlet  extends HttpServlet {
    private AuthService authService = new AuthService();

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp");
        dispatcher.forward(request, response);
    }

    public void  doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        LoginDTO loginDTO = new LoginDTO(email, password);
        Map<String, String> errors = new HashMap<>();
        LoginDTO user = authService.login(loginDTO , errors );
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        session.setAttribute("role", user.getRole().name());

        String role =  (String) session.getAttribute("role");

        switch (role) {
            case "ADMIN":
                response.sendRedirect(request.getContextPath() + "/WEB-INF/views/admin/dashboard");
                break;
            case "DOCTOR":
                response.sendRedirect(request.getContextPath() + "/WEB-INF/views/doctor/dashboard");
                break;
            case "PATIENT":
                response.sendRedirect(request.getContextPath() + "/WEB-INF/views/patient/dashboard");
                break;
            case "STAFF":
                response.sendRedirect(request.getContextPath() + "/WEB-INF/views/staff/dashboard");
            default:
                response.sendRedirect(request.getContextPath() + "WEB-INF/views");
        }










    }
}
