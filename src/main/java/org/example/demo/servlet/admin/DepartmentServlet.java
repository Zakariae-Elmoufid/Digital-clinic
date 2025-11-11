package org.example.demo.servlet.admin;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Validator;
import org.example.demo.dto.DepartmentDTO;
import org.example.demo.entity.Department;
import org.example.demo.repository.DepartmentRepository;
import org.example.demo.service.DepartmentService;
import org.example.demo.util.ValidatorUtil;
import jakarta.validation.ConstraintViolation;

import java.io.PrintWriter;
import java.util.List;
import java.util.Set;
import java.io.IOException;


@WebServlet("/admin/departments")
public class DepartmentServlet extends  HttpServlet {


    private  DepartmentService departmentService;



    public  void init() throws ServletException {
         DepartmentRepository departmentRepository = new DepartmentRepository();
         this.departmentService =   new DepartmentService(departmentRepository);
     }

     public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         List<DepartmentDTO> departments = departmentService.findAllDepartment();

         request.setAttribute("departments", departments);
         RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/admin/department.jsp");
         dispatcher.forward(request, response);

     }

    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if(action.equals("add")){
             addDepartment(req, resp);
        }else if(action.equals("update")){
            updateDepartment(req, resp);
        }else if(action.equals("delete")){
            deleteDepartment(req,resp);
        }else if(action.equals("toggleActive")){
            activateDepartment(req,resp);
        }
    }

    private  void addDepartment(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
           String name = req.getParameter("name");
           String description = req.getParameter("description");

           DepartmentDTO departmentDTO = new DepartmentDTO(name,description);

            Validator validator = ValidatorUtil.getValidator();
            Set<ConstraintViolation<DepartmentDTO>> violations = validator.validate(departmentDTO);
        if (!violations.isEmpty()) {
            req.setAttribute("oldName", name);
            req.setAttribute("oldDescription", description);
            req.setAttribute("errors", violations);

            doGet(req, resp);
            return;
        }
        try {
            departmentService.createDepartment(departmentDTO);
            req.setAttribute("success", "Department created successfully!");
            doGet(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Error creating department: " + e.getMessage());
            doGet(req, resp);
        }
    }

    private void updateDepartment(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        DepartmentDTO departmentDTO = new DepartmentDTO(name,description);

        Validator validator = ValidatorUtil.getValidator();
        Set<ConstraintViolation<DepartmentDTO>> violations = validator.validate(departmentDTO);
        if (!violations.isEmpty()) {
            req.setAttribute("oldName", name);
            req.setAttribute("oldDescription", description);
            req.setAttribute("errors", violations);
            doGet(req, resp);
            return;
        }

        try{
            departmentService.updateDepartment(departmentDTO);
            req.setAttribute("success", "Department updated successfully!");
            doGet(req, resp);

        }catch (Exception e){
            req.setAttribute("oldName", name);
            req.setAttribute("oldDescription", description);
            req.setAttribute("error", "Error creating department: " + e.getMessage());
            doGet(req, resp);

        }

    }

    private void deleteDepartment(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        String idStr = req.getParameter("id");
        Long id = Long.parseLong(idStr);

        try{
            departmentService.deleteDepartment(id);
            req.setAttribute("success","Department  deleted successfully!");
            doGet(req, resp);
        }catch (Exception e) {
            req.setAttribute("error", "Error creating department: " + e.getMessage());
            doGet(req, resp);
        }
    }

    private void activateDepartment(HttpServletRequest req,HttpServletResponse resp) throws ServletException , IOException {
        String idStr = req.getParameter("id");
        Long id = Long.parseLong(idStr);
        String isActiveStr = req.getParameter("isActive");
        Boolean isActive = Boolean.parseBoolean(isActiveStr);

        try{
            departmentService.activeDepartment(id,isActive);
            req.setAttribute("success","Department activated or closed successfully!");
            doGet(req, resp);
        }catch (Exception e){
            req.setAttribute("error","Error activing department: " + e.getMessage());
        }

    }

}
