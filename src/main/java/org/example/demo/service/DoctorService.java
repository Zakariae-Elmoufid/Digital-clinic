package org.example.demo.service;

import jakarta.persistence.EntityManager;
import org.example.demo.dto.DoctorDTO;
import org.example.demo.entity.*;
import org.example.demo.enums.DayOfWeekEnum;
import org.example.demo.mapper.DoctorMapper;
import org.example.demo.repository.DoctorRepository;
import org.example.demo.repository.SpecialtieRepository;
import org.example.demo.util.JPAsingleton;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.SQLOutput;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class DoctorService {

    private SpecialtieRepository specialtieRepository;
    private DoctorRepository doctorRepository;

    public DoctorService( DoctorRepository doctorRepository) {
        this.doctorRepository = doctorRepository;
        this.specialtieRepository = specialtieRepository;
    }



    public void saveDoctor(DoctorDTO docDTO){
        Specialite  specialtie = specialtieRepository.findById(docDTO.getSepcialtieId());
        if (specialtie == null) {
            throw new RuntimeException("specialty not found");
        }
        String hashedPassword = BCrypt.hashpw(docDTO.getPassword(), BCrypt.gensalt());
        docDTO.setPassword(hashedPassword);
        Doctor doctor = DoctorMapper.ToEntity(docDTO,specialtie);
        System.out.println(doctor);

        doctorRepository.save(doctor);
    }
    public List<DoctorDTO> getAllDoctors(){
         List<DoctorDTO> doctors = doctorRepository.getAll();
        return doctors;
    }

    public void updateDoctor(DoctorDTO docDTO){
        Doctor doctor = doctorRepository.findById(docDTO.getId());
        Specialite specialite =  specialtieRepository.findById(docDTO.getSepcialtieId());
        doctor.getUser().setFullName(docDTO.getName());
        doctor.getUser().setEmail(docDTO.getEmail());
        doctor.getUser().setActive(docDTO.isActive());
        doctor.setSpecialite(specialite);
        doctor.setMatricule(docDTO.getMatriculate());

         doctorRepository.update(doctor);
    }

    public void deleteDoctor(long id){
        doctorRepository.delete(id);
    }

    public Doctor findDoctor(long id){
         Doctor doctor = doctorRepository.findDoctor(id);
         return doctor;
    }

    public List<LocalDate> generateAvailableDays(long doctorId) {
        Doctor doctor = doctorRepository.findDoctor(doctorId);

        List<Availability> availabilities = doctor.getAvailabilities();
        List<Appointment> appointments = doctor.getAppointments();

        List<LocalDate> availableDays = new ArrayList<>();
        LocalDate startDate = LocalDate.now();
        LocalDate endDate = startDate.plusDays(90);

        for (Availability a : availabilities) {
            if (!a.getAvailable()) continue;

            for (LocalDate date = startDate; !date.isAfter(endDate); date = date.plusDays(1)) {
                DayOfWeek dayEnum = DayOfWeek.valueOf(a.getDayOfWeek().name());

                // If this date matches the doctor's availability day
                if (date.getDayOfWeek().equals(dayEnum)) {
                    // Check if there is at least one 30min slot free that day
                    LocalTime start = a.getStartTime();
                    LocalTime end = a.getEndTime();
                    boolean hasFreeSlot = false;

                    for (LocalTime slotStart = start; slotStart.plusMinutes(30).isBefore(end); slotStart = slotStart.plusMinutes(35)) {
                        LocalTime finalSlotStart = slotStart;
                        LocalDate finalDate = date;
                        boolean isTaken = appointments.stream().anyMatch(appt ->
                                appt.getAppointmentDate().equals(finalDate)
                                        && appt.getStartTime().equals(finalSlotStart)
                        );

                        if (!isTaken) {
                            hasFreeSlot = true;
                            break;
                        }
                    }

                    if (hasFreeSlot && !availableDays.contains(date)) {
                        availableDays.add(date);
                    }
                }
            }
        }


        System.out.println("availableDays: " + availableDays.size());
        return availableDays;
    }

}
