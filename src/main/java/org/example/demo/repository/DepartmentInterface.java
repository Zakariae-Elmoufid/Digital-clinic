package org.example.demo.repository;

import org.example.demo.dto.DepartmentDTO;
import org.example.demo.entity.Department;

import java.util.List;

public interface DepartmentInterface {
   public void save(Department department);
   public void update(Department department);
   public void delete(Long id);
   public List<Department> findAll();
   public Department findById(Long id);
   public  void setActive(Long id,boolean isActive);
}