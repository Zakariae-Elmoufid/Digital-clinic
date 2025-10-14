package org.example.demo.servlet.admin;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validator;
import org.example.demo.dto.SpecialtieDTO;
import org.example.demo.dto.StaffDTO;
import org.example.demo.entity.Staff;
import org.example.demo.repository.StaffInterface;
import org.example.demo.repository.StaffRepository;
import org.example.demo.service.StaffService;
import org.example.demo.util.ValidatorUtil;

import java.io.IOException;
import java.util.List;
import java.util.Set;


@WebServlet("/admin/staffs")
public class StaffServlate extends HttpServlet {

    private StaffService staffService;

    public void init() throws ServletException {
        StaffInterface staffRepo = new StaffRepository();
        staffService = new StaffService(staffRepo);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<StaffDTO> staffs = staffService.findAllStaff();
        request.setAttribute("staffs", staffs);

        RequestDispatcher  requestDispatcher =  request.getRequestDispatcher("/WEB-INF/views/admin/staff.jsp");
        requestDispatcher.forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
          String action = request.getParameter("action");

          if(action.equals("add")){
              addStaff(request,response);
          }else if(action.equals("update")){
              updateStaff(request,response);
          }else if(action.equals("delete")){
              deleteStaff(request,response);
          }
    }

    private void addStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        StaffDTO staff = new StaffDTO(name, email, password);
        Validator validator = ValidatorUtil.getValidator();
        Set<ConstraintViolation<StaffDTO>> violations =  validator.validate(staff);

        if (!violations.isEmpty()) {
            request.setAttribute("oldName", name);
            request.setAttribute("oldEmail", email);
            request.setAttribute("oldPassword", password);
            request.setAttribute("errors", violations);
            doGet(request, response);
            return;
        }

        try {
            staffService.saveStaff(staff);
            doGet(request, response);
        }catch (Exception e){
            request.setAttribute("error", e.getMessage());
            doGet(request, response);
        }
    }

    private void updateStaff(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        boolean active = Boolean.parseBoolean(req.getParameter("active"));
        Long id = Long.valueOf(req.getParameter("id"));

         StaffDTO staffDTO = new StaffDTO(id,name,email,active);
        System.out.println("i'm here 1");
        Validator validator = ValidatorUtil.getValidator();
        Set<ConstraintViolation<StaffDTO>> violations =  validator.validate(staffDTO);

        if (!violations.isEmpty()) {
            req.setAttribute("oldName", name);
            req.setAttribute("oldEmail", email);
            req.setAttribute("errors", violations);
            doGet(req, resp);
            return;
        }

        try{
            staffService.updateStaff(staffDTO);
            req.setAttribute("success","Staff Updated successfully!");
            doGet(req, resp);
        }catch (Exception e){
            req.setAttribute("error", e.getMessage());
            doGet(req, resp);
        }
    }

    private void deleteStaff(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            Long id = Long.valueOf(req.getParameter("id"));

        try {
            staffService.deleteStaff(id);
            req.setAttribute("success","Staff  deleted successfully!");
            doGet(req, resp);
        }catch (Exception e) {
            req.setAttribute("error", "Error deleting Staff: " + e.getMessage());
            doGet(req, resp);
        }

    }
}
