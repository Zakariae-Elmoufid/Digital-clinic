package org.example.demo.repository;

import org.example.demo.entity.Appointment;
import org.example.demo.entity.Patient;

import java.util.List;

public interface AppointmentInterface {
    public void save(Appointment appointment);
    public List<Appointment> findByPatient(Patient patient);
}
