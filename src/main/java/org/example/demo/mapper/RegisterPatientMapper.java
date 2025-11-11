package org.example.demo.mapper;

import org.example.demo.dto.RegisterPatientDTO;
import org.example.demo.entity.Patient;
import org.example.demo.entity.User;
import org.example.demo.enums.RoleEnum;


public class RegisterPatientMapper {

    public static Patient toEntity(RegisterPatientDTO dto) {
        Patient patient = new Patient();
        User user = new User();
        user.setFullName(dto.getFullName());
        user.setEmail(dto.getEmail());
        user.setPassword(dto.getPassword());
        user.setRole(RoleEnum.PATIENT);
        patient.setCin(dto.getCin());
        patient.setGender(dto.getGender());
        patient.setBloodType(dto.getBloodType());
        patient.setInsuranceNumber(dto.getInsuranceNumber());
        patient.setDateOfBirth(dto.getBirthDate());
        patient.setUser(user);
        return patient;
    }
}