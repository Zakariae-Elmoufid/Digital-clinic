package org.example.demo.service;

import org.example.demo.entity.Appointment;
import org.example.demo.repository.AppointmentInterface;

public class AppointmentService {

    private AppointmentInterface appointmentInterface;

    public AppointmentService(AppointmentInterface appointmentInterface) {
        this.appointmentInterface = appointmentInterface;
    }
}
