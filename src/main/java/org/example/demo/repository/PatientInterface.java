package org.example.demo.repository;

import org.example.demo.entity.Patient;

public interface PatientInterface {
    public Patient findPatientByUserId(long id);
}
