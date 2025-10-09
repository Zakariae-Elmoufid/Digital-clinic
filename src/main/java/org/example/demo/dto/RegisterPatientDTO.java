package org.example.demo.dto;

import org.example.demo.enums.BloodTypeEnum;
import org.example.demo.enums.GenderEnum;

import java.time.LocalDate;

public class RegisterPatientDTO {
    private String fullName;
    private String email;
    private String password;
    private GenderEnum gender;
    private LocalDate birthDate;
    private String phone;
    private String cin;
    private String insuranceNumber ;
    private BloodTypeEnum bloodType;

    public RegisterPatientDTO(String email, String password, String fullName,  GenderEnum gender, LocalDate birthDate, String phone, String cin, String insuranceNumber, BloodTypeEnum bloodType) {
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.gender = gender;
        this.birthDate = birthDate;
        this.phone = phone;
        this.cin = cin;
        this.insuranceNumber = insuranceNumber;
        this.bloodType = bloodType;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
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



    public GenderEnum getGender() {
        return gender;
    }

    public void setGender(GenderEnum gender) {
        this.gender = gender;
    }

    public LocalDate getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(LocalDate birthDate) {
        this.birthDate = birthDate;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCin() {
        return cin;
    }

    public void setCin(String cin) {
        this.cin = cin;
    }

    public String getInsuranceNumber() {
        return insuranceNumber;
    }

    public void setInsuranceNumber(String insuranceNumber) {
        this.insuranceNumber = insuranceNumber;
    }

    public BloodTypeEnum getBloodType() {
        return bloodType;
    }

    public void setBloodType(BloodTypeEnum bloodType) {
        this.bloodType = bloodType;
    }
}
