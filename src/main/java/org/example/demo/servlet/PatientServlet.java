package org.example.demo.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.Map;

import org.example.demo.dto.RegisterPatientDTO;
import org.example.demo.enums.BloodTypeEnum;
import org.example.demo.enums.GenderEnum;
import org.example.demo.service.AuthService;
import org.example.demo.util.Validator;


@WebServlet("/patient")
public class PatientServlet extends HttpServlet {

    private AuthService authService = new AuthService();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/patient/register.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("register".equals(action)) {
            register(req, resp);
        } else if ("login".equals(action)) {
            login(req, resp);
        }
    }
    private void register(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException{

        String name = req.getParameter("fullName");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");
        String gender = req.getParameter("gender");
        String cin = req.getParameter("cin");
        String insuranceNumber =  req.getParameter("insuranceNumber");
        String dateOfBirth = req.getParameter("dob");
        String blood =  req.getParameter("blood");


        RegisterPatientDTO registerPatientDTO = new RegisterPatientDTO(email,password,name, GenderEnum.valueOf(gender), LocalDate.parse(dateOfBirth) ,phone,cin,insuranceNumber, BloodTypeEnum.valueOf(blood));
        Map<String, String> errors = authService.registerPatient(registerPatientDTO);

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/WEB-INF/views/patient/register.jsp").forward(req, resp);
        } else {
            req.setAttribute("success", "Registration successful!");
            req.getRequestDispatcher("/WEB-INF/views/patient/register.jsp").forward(req, resp);
            //resp.sendRedirect("login.jsp");
        }


    }

    private void login(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {}
}
