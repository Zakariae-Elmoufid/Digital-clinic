package org.example.demo.servlet.patient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.demo.dto.DoctorDTO;
import org.example.demo.entity.Appointment;
import org.example.demo.entity.Availability;
import org.example.demo.entity.AvailabilitySlot;
import org.example.demo.entity.Doctor;
import org.example.demo.repository.DoctorRepository;
import org.example.demo.service.DoctorService;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;


@WebServlet("/patient/doctor/*")
public class DoctorServlet  extends HttpServlet {

    private DoctorService doctorService;

    @Override
    public void init() throws ServletException {
        DoctorRepository doctorRepository = new DoctorRepository();
        this.doctorService = new DoctorService(doctorRepository);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo(); // ex: "/5"
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Doctor ID is missing");
            return;
        }

        try{
            Long doctorId = Long.parseLong(pathInfo.substring(1));

            Doctor doctor = doctorService.findDoctor(doctorId);
            if (doctor == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Doctor not found");
                return;
            }

            request.setAttribute("doctor", doctor);
            List<LocalDate> availableDays = doctorService.generateAvailableDays(doctorId);
            request.setAttribute("availableDays", availableDays);



           

            request.getRequestDispatcher("/WEB-INF/views/patient/doctor.jsp").forward(request, response);
        }catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid doctor ID");
        }
    }
}
