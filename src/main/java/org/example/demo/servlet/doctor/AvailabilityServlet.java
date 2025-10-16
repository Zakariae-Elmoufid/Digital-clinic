package org.example.demo.servlet.doctor;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validator;
import org.example.demo.dto.AvailabilityDTO;
import org.example.demo.dto.LoginDTO;
import org.example.demo.dto.StaffDTO;
import org.example.demo.entity.Availability;
import org.example.demo.enums.DayOfWeekEnum;
import org.example.demo.repository.AvailabilityRepository;
import org.example.demo.repository.DoctorRepository;
import org.example.demo.repository.UserRepository;
import org.example.demo.service.AvailabilityService;
import org.example.demo.service.DoctorService;
import org.example.demo.util.ValidatorUtil;

import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Set;

@WebServlet("/doctor/availability")
public class AvailabilityServlet  extends HttpServlet {

    private AvailabilityService availabilityService;
    public void init() throws ServletException {
        AvailabilityRepository availabilityRepository = new AvailabilityRepository();
        DoctorRepository doctorRepository = new DoctorRepository();
        availabilityService = new AvailabilityService(availabilityRepository,doctorRepository);
    }


    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        LoginDTO user = (session != null) ? (LoginDTO)  session.getAttribute("user") : null;
        System.out.println("Doctor ID in session: " + user.getId());

        List<AvailabilityDTO> availabilities = availabilityService.getAllAvailabilityByDoctor(user.getId());
        System.out.println("✅ Found " + availabilities.size() + " availabilities:");
        for (AvailabilityDTO availabilityDTO : availabilities) {
            System.out.println("🕒 " + availabilityDTO);
        }
        request.setAttribute("availabilities", availabilities);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/views/doctor/availability.jsp");
        requestDispatcher.forward(request,response);
    }



    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            String action = request.getParameter("action");
            if(action.equals("add")){
                addAvailability(request,response);
            }
    }

    public void addAvailability(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String slotParam = request.getParameter("slot-duration");
        int slotDuration = (slotParam != null && !slotParam.isEmpty())
                ? Integer.parseInt(slotParam)
                : 30;
        DayOfWeekEnum dayOfWeek = DayOfWeekEnum.valueOf(request.getParameter("day-of-week"));
        LocalTime startTime = LocalTime.parse(request.getParameter("start-time"));
        LocalTime endTime = LocalTime.parse(request.getParameter("end-time"));
        LocalDate startDate = LocalDate.parse(request.getParameter("start-date") );
        String endDateParam = request.getParameter("end-date");
        LocalDate endDate = (endDateParam != null && !endDateParam.isEmpty())
                ? LocalDate.parse(endDateParam)
                : null;


        HttpSession session = request.getSession(false);
        LoginDTO user = (session != null) ? (LoginDTO)  session.getAttribute("user") : null;


        long userId = user.getId();


        AvailabilityDTO availabilityDTO = new AvailabilityDTO(slotDuration, dayOfWeek, startTime, endTime,startDate,endDate, userId);

        Validator validator = ValidatorUtil.getValidator();
        Set<ConstraintViolation<AvailabilityDTO>> violations =  validator.validate(availabilityDTO);

        if(!violations.isEmpty()){
            request.setAttribute("oldDayOfWeek", dayOfWeek);
            request.setAttribute("oldStartTime", startTime);
            request.setAttribute("oldEndTime", endTime);
            request.setAttribute("oldSlotDuration", slotDuration);
            request.setAttribute("errors", violations);
            doGet(request, response);
            return;
        }

        try {
            availabilityService.addAvailability(availabilityDTO);
            request.setAttribute("success","availability added successful" );
            doGet(request, response);
        }catch (Exception e){
            request.setAttribute("error",e.getMessage() );
        }


    }
}
