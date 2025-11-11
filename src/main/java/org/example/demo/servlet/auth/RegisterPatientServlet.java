package org.example.demo.servlet.auth;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Map;

import org.example.demo.dto.RegisterPatientDTO;
import org.example.demo.enums.BloodTypeEnum;
import org.example.demo.enums.GenderEnum;
import org.example.demo.service.AuthService;


@WebServlet("/register")
public class RegisterPatientServlet extends HttpServlet {

    private AuthService authService = new AuthService();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String name = req.getParameter("fullName");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");
        String gender = req.getParameter("gender");
        String cin = req.getParameter("cin");
        String insuranceNumber = req.getParameter("insuranceNumber");
        String dateOfBirth = req.getParameter("dob");
        String blood = req.getParameter("blood");


        RegisterPatientDTO registerPatientDTO = new RegisterPatientDTO(email, password, name, GenderEnum.valueOf(gender), LocalDate.parse(dateOfBirth), phone, cin, insuranceNumber, BloodTypeEnum.valueOf(blood));
        Map<String, String> errors = authService.registerPatient(registerPatientDTO);

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
        }
    }


}
