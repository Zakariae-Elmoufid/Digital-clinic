package org.example.demo.servlet.admin;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validator;
import org.example.demo.dto.DoctorDTO;
import org.example.demo.dto.SpecialtieDTO;
import org.example.demo.entity.Doctor;
import org.example.demo.repository.DoctorRepository;
import org.example.demo.repository.SpecialtieRepository;
import org.example.demo.service.DoctorService;
import org.example.demo.service.SpecialtieService;
import org.example.demo.util.ValidatorUtil;

import java.io.IOException;
import java.util.List;
import java.util.Set;

@WebServlet("/admin/doctors")
public class DoctorServlet extends HttpServlet {

    private SpecialtieService specialtieService;
    private DoctorService doctorService;

    public void init() throws ServletException {
        DoctorRepository  doctorRepository = new DoctorRepository();
        SpecialtieRepository specialtieRepository = new SpecialtieRepository();

        this.doctorService = new DoctorService(doctorRepository,specialtieRepository );
        this.specialtieService = new SpecialtieService(specialtieRepository);
    }

    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<SpecialtieDTO> specialties = specialtieService.getAllSpecialtie();
        List<DoctorDTO> doctors = doctorService.getAllDoctors();


        req.setAttribute("specialties", specialties);
        req.setAttribute("doctors", doctors);

        RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/admin/doctors.jsp");
        rd.forward(req, resp);
    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if(action.equals("add")){
            addDoctor(req,resp);
        }else if (action.equals("update")){
            updateDoctor(req,resp);
        }else if(action.equals("delete")){
            deleteDoctor(req,resp);
        }
    }

    public void addDoctor(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String specialtieIdStr = req.getParameter("specialtyId");
        Long specialtieId = Long.valueOf(specialtieIdStr);
        String matriculate =  req.getParameter("matricule");

        DoctorDTO doctorDTO = new DoctorDTO(name,email,password,specialtieId,matriculate);
        Validator validator = ValidatorUtil.getValidator();
        Set<ConstraintViolation<DoctorDTO>> violations =  validator.validate(doctorDTO);

        if (!violations.isEmpty()) {
            req.setAttribute("oldName", name);
            req.setAttribute("oldEmail", email);
            req.setAttribute("oldPassword", password);
            req.setAttribute("oldMatriculate", matriculate);
            req.setAttribute("errors", violations);
            doGet(req, resp);
            return;
        }

        try{
            doctorService.saveDoctor(doctorDTO);
            req.setAttribute("success", "Doctor has been saved successfully");
            doGet(req, resp);
        }catch (Exception e){
            e.printStackTrace();
            doGet(req, resp);
        }
    }

    public void updateDoctor(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String matriculate = req.getParameter("matriculate");
        boolean active = req.getParameter("active") != null;
        Long specialtieId = Long.parseLong(req.getParameter("specialtyId"));



        DoctorDTO doctorDTO = new DoctorDTO(id,name,email,specialtieId,matriculate,active);
        Validator validator = ValidatorUtil.getValidator();
        Set<ConstraintViolation<DoctorDTO>> violations =  validator.validate(doctorDTO);

        if (!violations.isEmpty()) {
            req.setAttribute("oldName", name);
            req.setAttribute("oldEmail", email);
            req.setAttribute("oldMatriculate", matriculate);
            req.setAttribute("errors", violations);
            doGet(req, resp);
            return;
        }
        try{
            doctorService.updateDoctor(doctorDTO);
            req.setAttribute("success", "Doctor has been update successfully");
            doGet(req, resp);
        }catch (Exception e){
            e.printStackTrace();
            doGet(req, resp);
        }

    }

    public void  deleteDoctor(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        Long id = Long.parseLong(idStr);
        try {
            doctorService.deleteDoctor(id);
            req.setAttribute("success","doctor  deleted successfully!");
            doGet(req, resp);
        }catch (Exception e) {
            req.setAttribute("error", "Error deleting doctor: " + e.getMessage());
            doGet(req, resp);
        }
    }



}
