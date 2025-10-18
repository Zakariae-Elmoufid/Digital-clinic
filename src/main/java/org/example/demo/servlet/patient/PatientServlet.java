package org.example.demo.servlet.patient;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.demo.dto.DoctorDTO;
import org.example.demo.dto.SpecialtieDTO;
import org.example.demo.repository.DepartmentRepository;
import org.example.demo.repository.DoctorRepository;
import org.example.demo.repository.SpecialtieRepository;
import org.example.demo.service.DoctorService;
import org.example.demo.service.SpecialtieService;

import java.io.IOException;
import java.util.List;

@WebServlet("/patient")
public class PatientServlet  extends HttpServlet {
    private  SpecialtieService specialtieService ;
    private DoctorService doctorService ;
    @Override
    public void init() throws ServletException {
        specialtieService = new SpecialtieService(new SpecialtieRepository(), new DepartmentRepository());
        doctorService = new DoctorService(new DoctorRepository());
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<SpecialtieDTO>  specialties = specialtieService.getAllSpecialtie();
        List<DoctorDTO>  doctors = doctorService.getAllDoctors();
        for(DoctorDTO doctor : doctors){
            System.out.println(doctor);
            System.out.println("-----------------");
        }
        request.setAttribute("doctors",doctors);
        request.setAttribute("specialties", specialties);


        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/patient/index.jsp");
        rd.forward(request,response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action =  request.getParameter("action");

    }


//    private void SearchDoctor(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//             String doctorName = request.getParameter("doctorName");
//             String specialtyName = request.getParameter("specialtyName");
//
//             try{
//                 List<DoctorDTO>  doctors = doctorService.searchDoctor(doctorName,specialtyName);
//
//                for(DoctorDTO doctor: doctors){
//                    System.out.println(doctors);
//                    System.out.println("---------------");
//                }
//                request.setAttribute("doctors",doctors);
//
//                 doGet(request,response);
//             }catch (Exception e){
//                 request.setAttribute("error", "Error searching doctor: " + e.getMessage());
//                 doGet(request,response);
//             }
//    }
}
