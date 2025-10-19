package org.example.demo.service;

import org.example.demo.entity.*;
import org.example.demo.repository.AppointmentInterface;
import org.example.demo.repository.DoctorInterface;
import org.example.demo.repository.PatientInterface;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class AppointmentService {

    private AppointmentInterface appointmentInterface;
    private PatientInterface patientInterface;
    private DoctorInterface doctorInterface;

    public AppointmentService(AppointmentInterface appointmentInterface , PatientInterface patientInterface, DoctorInterface doctorInterface) {
        this.patientInterface = patientInterface;
        this.appointmentInterface = appointmentInterface;
        this.doctorInterface = doctorInterface;
    }

    public void makeAppointment(long doctorId, LocalDate date, long userId) {
        Patient patient = patientInterface.findPatientByUserId(userId);
        Doctor doctor = doctorInterface.findDoctor(doctorId);
        List<Availability> availabilities = doctor.getAvailabilities();
        List<Appointment> appointments = doctor.getAppointments();

        for (Availability availability : availabilities) {

            DayOfWeek dayEnum = DayOfWeek.valueOf(availability.getDayOfWeek().name());
            if (date.getDayOfWeek().equals(dayEnum) && availability.getAvailable()) {
                LocalTime slotStart = availability.getStartTime();
                LocalTime endTime = availability.getEndTime();

                while (slotStart.plusMinutes(30).isBefore(endTime) || slotStart.plusMinutes(30).equals(endTime)) {
                    LocalTime slotEnd = slotStart.plusMinutes(30);

                    // Vérifie si ce créneau est déjà pris
                    LocalTime finalSlotStart = slotStart;
                    boolean isTaken = appointments.stream().anyMatch(appt ->
                            appt.getAppointmentDate().equals(date) &&
                                    appt.getStartTime().equals(finalSlotStart)
                    );

                    if (!isTaken) {
                        // Crée le rendez-vous sur le premier créneau libre
                        Appointment appointment = new Appointment();
                        appointment.setDoctor(doctor);
                        appointment.setPatient(patient);
                        appointment.setAppointmentDate(date);
                        appointment.setStartTime(slotStart);
                        appointment.setEndTime(slotEnd);
                        appointmentInterface.save(appointment);

                        System.out.println("✅ Appointment created for " + date + " at " + slotStart);
                        return; // On arrête après avoir réservé le premier créneau disponible
                    }

                    // Passe au créneau suivant + 5 minutes de break
                    slotStart = slotStart.plusMinutes(35);
                }
            }
        }

        System.out.println("⚠️ No available slots on " + date);
    }
}
