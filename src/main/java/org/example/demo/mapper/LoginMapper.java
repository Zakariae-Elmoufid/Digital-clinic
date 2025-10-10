package org.example.demo.mapper;

import org.example.demo.dto.LoginDTO;
import org.example.demo.entity.Patient;
import org.example.demo.entity.User;

public class LoginMapper {

    public static Patient toEntity(LoginDTO dto) {
        User user = new User();
        Patient patient = new Patient();
        user.setEmail(dto.getEmail());
        user.setPassword(dto.getPassword());
        patient.setUser(user);
        return patient;
    }


}
