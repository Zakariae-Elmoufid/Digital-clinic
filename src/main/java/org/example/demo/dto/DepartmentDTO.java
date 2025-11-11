package org.example.demo.dto;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.time.LocalDateTime;

public class DepartmentDTO {


  private  long id;
  @NotNull(message = "the name of department is required")
  @Size(min = 4, max = 20 , message = "the name must be between 4 and 20 char ")
  private String name;
  private String description;
  private LocalDateTime createdAt;
  private boolean isActive;

  public DepartmentDTO(long id , String name, String description, boolean isActive, LocalDateTime createdAt) {
      this.id = id;
      this.name = name;
      this.description = description;
      this.isActive = isActive;
      this.createdAt = createdAt;
  }

    public boolean isActive() {
        return isActive;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public DepartmentDTO(String name, String description) {
        this.name = name;
        this.description = description;
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
}
