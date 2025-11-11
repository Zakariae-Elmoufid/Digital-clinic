package org.example.demo.dto;

import org.example.demo.enums.RoleEnum;

public class LoginDTO {

    private long id;
    private String email;
    private String fullName;
    private RoleEnum role;

    private String password;


    public LoginDTO(String email,String password){
        this.password = password;
        this.email = email;
    }

    public LoginDTO(Long  id ,String email, String fullName ,  RoleEnum role){
        this.id = id;
        this.email = email;
        this.fullName = fullName;
        this.role = role;
    }


    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public RoleEnum getRole() {
        return role;
    }

    public void setRole(RoleEnum role) {
        this.role = role;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
