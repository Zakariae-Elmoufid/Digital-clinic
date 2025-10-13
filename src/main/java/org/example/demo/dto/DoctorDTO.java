package org.example.demo.dto;

import jakarta.validation.constraints.*;
import org.example.demo.enums.RoleEnum;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class DoctorDTO {
    private Long id;
    @NotNull(message = "the fullName  of doctor is required")
    private String name;
    @NotBlank(message = "L'adresse e-mail est obligatoire")
    @Email(message = "L'adresse e-mail doit être valide")
    private String email;
    @Size(min = 6 , message = "password must be 6 char min")
    private String password;
    private Long sepcialtieId;
    private String specialite;
    private  String department;
    private boolean active;
    private String  createdAt;


    private RoleEnum role;

    @Pattern(regexp = "DOC[0-9]{4}", message = "the matricule must follow this form DOC1234")
    private String matriculate;

    public DoctorDTO(String name, String email, String password, Long sepcialtieId, String matriculate) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.sepcialtieId = sepcialtieId;
        this.matriculate = matriculate;
    }

    public DoctorDTO(Long id, String name, String email,  Long sepcialtieId, String matriculate , boolean active) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.sepcialtieId = sepcialtieId;
        this.matriculate = matriculate;
        this.active = active;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public DoctorDTO(Long id, String email, String name, RoleEnum role, String matriculate , String specialite , String department , boolean active, String createdAt ,long sepcialtieId) {
        this.id = id;
        this.email = email;
        this.name = name;
        this.role = role;
        this.matriculate = matriculate;
        this.specialite = specialite;
        this.department = department;
        this.active = active;
        this.createdAt = createdAt;
        this.sepcialtieId = sepcialtieId;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public RoleEnum getRole() {
        return role;
    }

    public void setRole(RoleEnum role) {
        this.role = role;
    }

    public String getSpecialite() {
        return specialite;
    }

    public void setSpecialite(String specialite) {
        this.specialite = specialite;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Long getSepcialtieId() {
        return sepcialtieId;
    }

    public void setSepcialtieId(Long sepcialtieId) {
        this.sepcialtieId = sepcialtieId;
    }

    public String getMatriculate() {
        return matriculate;
    }

    public void setMatriculate(String matriculate) {
        this.matriculate = matriculate;
    }

    @Override
    public String toString() {
        return "DoctorDTO{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", sepcialtieId=" + sepcialtieId +
                ", specialite='" + specialite + '\'' +
                ", role=" + role +
                ", matriculate='" + matriculate + '\'' +
                '}';
    }
}
