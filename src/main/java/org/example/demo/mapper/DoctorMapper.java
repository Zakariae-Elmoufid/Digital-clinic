package org.example.demo.mapper;

import org.example.demo.dto.DoctorDTO;
import org.example.demo.entity.Doctor;
import org.example.demo.entity.Specialite;
import org.example.demo.entity.User;
import org.example.demo.enums.RoleEnum;

import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

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

    public static DoctorDTO ToDTO(Doctor doctor){
        return  new DoctorDTO(doctor.getId(),doctor.getUser().getEmail(),doctor.getUser().getFullName(),doctor.getUser().getRole(),
                doctor.getMatricule(),doctor.getSpecialite().getName(), doctor.getSpecialite().getDepartment().getName(),doctor.getUser().getActive(),doctor.getUser().getCreatedAt().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")),doctor.getSpecialite().getId());
    }

    public static List<DoctorDTO> toDTOList(List<Doctor> doctors){
        List<DoctorDTO> dtos = new ArrayList<>();
        for(Doctor doctor : doctors){
            dtos.add(DoctorMapper.ToDTO(doctor));
        }
        return dtos;
    }
}
