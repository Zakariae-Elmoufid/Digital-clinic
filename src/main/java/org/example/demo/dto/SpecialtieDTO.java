package org.example.demo.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import org.example.demo.entity.Department;

public class SpecialtieDTO {

    private Long id;
    @NotNull(message = "the name of specialtie is required")
    @Size(min = 4, max = 20 , message = "the name must be between 4 and 20 char ")
    private String name;
    private String description;
    @NotNull(message = "Department is required")
    private Long depaId;
    private String departmentName;
    private Boolean active;


    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public Long getDepaId() {
        return depaId;
    }
    public void setDepaId(Long depaId) {
        this.depaId = depaId;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public SpecialtieDTO(String name, String description , Long depaId) {
        this.name = name;
        this.description = description;
        this.depaId = depaId;
    }
    public SpecialtieDTO(String name, String description , Long depaId ,Long id) {
        this.name = name;
        this.description = description;
        this.depaId = depaId;
        this.id = id;
    }
    public SpecialtieDTO(Long id, String name, String description, boolean active,String department,long depaId) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.active = active;
        this.departmentName = department;
        this.depaId=depaId;
    }
}
