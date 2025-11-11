package org.example.demo.repository;

import org.example.demo.entity.Doctor;

import java.io.Serializable;

public interface DoctorInterface {
    public void save(Doctor doctor);

    public Doctor findDoctor(long doctorId);
}
