package org.example.demo.servlet.admin;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validator;
import org.example.demo.dto.DepartmentDTO;
import org.example.demo.dto.SpecialtieDTO;
import org.example.demo.repository.DepartmentRepository;
import org.example.demo.repository.SpecialtieRepository;
import org.example.demo.service.DepartmentService;
import org.example.demo.service.SpecialtieService;
import org.example.demo.util.ValidatorUtil;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Set;

@WebServlet("/admin/specialties")
public class SpecialtieServlet extends HttpServlet {

    private SpecialtieService specialtieService;
    private  DepartmentService departmentService ;




    public void init() throws ServletException {
        SpecialtieRepository specialtieRepository = new SpecialtieRepository();
        DepartmentRepository departmentRepository = new DepartmentRepository();

        this.specialtieService = new SpecialtieService(specialtieRepository, departmentRepository);
        this.departmentService = new DepartmentService(departmentRepository);
        if (specialtieService == null) {
            System.out.println("specialtieService is NULL!");
        } else {
            System.out.println("specialtieService initialized OK");
        }

    }

    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<DepartmentDTO> departments = departmentService.findAllDepartment();
        List<SpecialtieDTO> specialties = specialtieService.getAllSpecialtie();

        req.setAttribute("specialties", specialties);
        req.setAttribute("departments", departments);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/admin/specialties.jsp");
        dispatcher.forward(req, resp);

    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          String action  = req.getParameter("action");
          if(action.equals("add")){
              addSpecialtie(req,resp);
          }else if(action.equals("update")){
              updateSpecialtie(req,resp);
          }else if(action.equals("delete")){
              deleteSpecialtie(req,resp);
          }
    }

    public void addSpecialtie(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
         String name=req.getParameter("name");
         String description=req.getParameter("description");
         String depaIdStr = req.getParameter("departmentId");
         Long depaId = Long.parseLong(depaIdStr);

        SpecialtieDTO specialtieDTO = new  SpecialtieDTO(name,description,depaId);

        Validator validator = ValidatorUtil.getValidator();
        Set<ConstraintViolation<SpecialtieDTO>>  violations =  validator.validate(specialtieDTO);
        if (!violations.isEmpty()) {
            req.setAttribute("oldName", name);
            req.setAttribute("oldDescription", description);
            req.setAttribute("errors", violations);

            doGet(req, resp);
            return;
        }
        try {
        specialtieService.saveSpecialtie(specialtieDTO);
        req.setAttribute("success", "specialty created successful");
        doGet(req, resp);
        }catch (Exception e){
            req.setAttribute("error", e.getMessage());
            doGet(req, resp);
        }

    }

    public void updateSpecialtie(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name=req.getParameter("name");
        String description=req.getParameter("description");
        String depaIdStr = req.getParameter("departmentId");
        Long depaId = Long.parseLong(depaIdStr);
        String idStr = req.getParameter("id");
        Long id = Long.parseLong(idStr);
        SpecialtieDTO specialtieDTO = new  SpecialtieDTO(name,description,depaId,id);

        Validator validator = ValidatorUtil.getValidator();
        Set<ConstraintViolation<SpecialtieDTO>>  violations =  validator.validate(specialtieDTO);
        if (!violations.isEmpty()) {
            req.setAttribute("oldName", name);
            req.setAttribute("oldDescription", description);
            req.setAttribute("errors", violations);

            doGet(req, resp);
            return;
        }
        try {
            specialtieService.updateSpecialtie(specialtieDTO);
            req.setAttribute("success", "specialty updated  successful");
            doGet(req, resp);
        }catch (Exception e){
            req.setAttribute("error", e.getMessage());
            doGet(req, resp);
        }
    }

    public void deleteSpecialtie(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        Long id = Long.parseLong(idStr);
        String name=req.getParameter("name");

        try {
            specialtieService.deleteSpecialtie(id);
            req.setAttribute("success","Spesialtie  deleted successfully!");
            doGet(req, resp);
        }catch (Exception e) {
            req.setAttribute("error", "Error deleting spesialtie: " + e.getMessage());
            doGet(req, resp);
        }

    }
}
