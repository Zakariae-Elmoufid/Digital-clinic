package org.example.demo.servlet.patient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.demo.repository.AppointmentInterface;
import org.example.demo.repository.AppointmentRepository;
import org.example.demo.service.AppointmentService;

import java.io.IOException;
import java.time.LocalDate;


@WebServlet("/patient/appointments")
public class AppointmentServlet  extends HttpServlet {

    private AppointmentService appointmentService;

    public void init() {
        AppointmentRepository appointmentRepository = new AppointmentRepository();
        appointmentService = new AppointmentService(appointmentRepository);
    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        LocalDate localDate = LocalDate.parse(req.getParameter("date"));


        try{
            appointmentService.makeAppointment()
        }catch(Exception e){

        }
    }
}
