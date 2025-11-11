package org.example.demo.mapper;

import org.example.demo.dto.LoginDTO;
import org.example.demo.entity.Patient;
import org.example.demo.entity.User;

import java.net.SocketOption;

public class LoginMapper {

    public static User toEntity(LoginDTO dto) {
        User user = new User();
        user.setEmail(dto.getEmail());
        user.setPassword(dto.getPassword());
        return user;
    }

    public static LoginDTO toDTO(User user) {
        return new LoginDTO(user.getId(), user.getEmail(), user.getFullName(),user.getRole());
    }



}
