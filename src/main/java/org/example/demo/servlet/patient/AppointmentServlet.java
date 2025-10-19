package org.example.demo.servlet.patient;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.demo.dto.LoginDTO;
import org.example.demo.entity.Doctor;
import org.example.demo.repository.*;
import org.example.demo.service.AppointmentService;
import org.example.demo.service.DoctorService;

import java.io.IOException;
import java.time.LocalDate;


@WebServlet("/patient/appointments")
public class AppointmentServlet  extends HttpServlet {

    private AppointmentService appointmentService;

    public void init() {
        AppointmentRepository appointmentRepository = new AppointmentRepository();
        appointmentService = new AppointmentService(appointmentRepository,new PatientRepository(),new DoctorRepository());

    }



    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("doctorId"));
        LocalDate dateAppointment = LocalDate.parse(req.getParameter("date"));




        try{
            HttpSession session = req.getSession(false);
            LoginDTO user = (session != null) ? (LoginDTO)  session.getAttribute("user") : null;
            Long userId = user.getId();
            appointmentService.makeAppointment(id,dateAppointment,userId);
            req.setAttribute("success","appointment  taking successfully!");
            resp.sendRedirect(req.getContextPath() + "/patient/doctor/"+id);
        }catch(Exception e) {
            req.setAttribute("error", "Error taking appointment: " + e.getMessage());
            RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/patient/doctor.jsp");
        }
    }
}
