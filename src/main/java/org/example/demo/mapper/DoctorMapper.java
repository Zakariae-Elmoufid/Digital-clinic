package org.example.demo.mapper;

import org.example.demo.dto.DoctorDTO;
import org.example.demo.entity.Doctor;
import org.example.demo.entity.Specialite;
import org.example.demo.entity.User;
import org.example.demo.enums.RoleEnum;

public class DoctorMapper {
    public static Doctor ToEntity(DoctorDTO  doctorDTO, Specialite specialite){
        User user = new User();
        Doctor doctor = new Doctor();
        user.setFullName(doctorDTO.getName());
        user.setEmail(doctorDTO.getEmail());
        user.setPassword(doctorDTO.getPassword());
        user.setRole(RoleEnum.DOCTOR);
        doctor.setMatricule(doctorDTO.getMatriculate());
        doctor.setSpecialite(specialite);
        doctor.setUser(user);
        return doctor;
    }
}
