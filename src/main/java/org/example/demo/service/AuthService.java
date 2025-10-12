package org.example.demo.service;

import org.example.demo.dto.LoginDTO;
import org.example.demo.dto.RegisterPatientDTO;
import org.example.demo.entity.Patient;
import org.example.demo.entity.User;
import org.example.demo.mapper.LoginMapper;
import org.example.demo.mapper.RegisterPatientMapper;
import org.example.demo.repository.UserRepository;
import org.example.demo.util.Validator;
import org.mindrot.jbcrypt.BCrypt;

import java.io.PrintWriter;
import java.nio.file.Files;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import static org.example.demo.mapper.LoginMapper.toDTO;
import static org.example.demo.util.PasswordUtils.checkPassword;

public class AuthService {

    private UserRepository userRepository = new UserRepository();

    public  Map<String, String>  registerPatient(RegisterPatientDTO dto){

        Validator validator = new Validator();

        validator.required("name", dto.getFullName(), "Name is required");
        validator.email("email", dto.getEmail(), "Email is invalid");
        validator.minLength("password", dto.getPassword(), 6, "Password must be at least 6 characters");
        validator.regex("cin", dto.getCin(), "^[A-Z]{1,2}\\d{4,6}$", "CIN format is invalid");
        validator.minLength("phone",dto.getPhone(),10,"Phone number is invalid");
        validator.required("gender",  dto.getGender().name(), "Gender is invalid");
        validator.required("insuranceNumber", dto.getInsuranceNumber(), "Insurance number is invalid");
        validator.required("dateOfBirth", String.valueOf(dto.getBirthDate()), "Date of birth is invalid");
        validator.required("blood", dto.getBloodType().name(), "Blood is invalid");


        if (validator.hasErrors()) {
           return validator.getErrors();
        }

        String hashedPassword = BCrypt.hashpw(dto.getPassword(), BCrypt.gensalt());
        dto.setPassword(hashedPassword);
        Patient newPatient = RegisterPatientMapper.toEntity(dto);
        userRepository.save(newPatient);
        return validator.getErrors();
    }

    public LoginDTO  login(LoginDTO dto , Map<String, String> errors){

        Validator validator = new Validator();
        validator.email("email",dto.getEmail(), "Email is invalid");
        validator.minLength("password", dto.getPassword(), 6, "Password must be at least 6 characters");

        if (validator.hasErrors()) {
            errors.putAll(validator.getErrors());
           return null;
        }


        User newuser = LoginMapper.toEntity(dto);
        User user = userRepository.findUserByEmail(newuser.getEmail());
        if (user == null) {
            errors.put("email", "No account found with this email");
            return null;
        }
        boolean passwordMatch = checkPassword(dto.getPassword(), user.getPassword());
        if (!passwordMatch) {
            errors.put("password", "Incorrect password");
            return null;
        }

        return LoginMapper.toDTO(user);
    }
}
