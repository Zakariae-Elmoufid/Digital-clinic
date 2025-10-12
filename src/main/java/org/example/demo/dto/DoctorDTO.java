package org.example.demo.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

public class DoctorDTO {
    private String name;
    @NotBlank(message = "L'adresse e-mail est obligatoire")
    @Email(message = "L'adresse e-mail doit être valide")
    private String email;
    private String password;
    private Long sepcialtieId;

    @Pattern(regexp = "DOC[0-9]{4}", message = "the matricule must follow this form DOC1234")
    private String matriculate;

    public DoctorDTO(String name, String email, String password, Long sepcialtieId, String matriculate) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.sepcialtieId = sepcialtieId;
        this.matriculate = matriculate;
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
}
