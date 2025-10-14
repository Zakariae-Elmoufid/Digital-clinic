package org.example.demo.service;

import org.example.demo.dto.DepartmentDTO;
import org.example.demo.entity.Department;
import org.example.demo.mapper.DepartmentMapper;
import org.example.demo.repository.DepartmentRepository;

import java.util.ArrayList;
import java.util.List;

public class DepartmentService {
    private final DepartmentRepository departmentRepository ;

    public DepartmentService(DepartmentRepository departmentRepository) {
        this.departmentRepository = departmentRepository;
    }

    public void createDepartment(DepartmentDTO departmentDTO) {
        Department department = DepartmentMapper.toEntity(departmentDTO);
        departmentRepository.save(department);
    }

    public DepartmentDTO getDepartment(Long id) {
        Department department = departmentRepository.findById(id);
        return DepartmentMapper.toDTO(department);
    }

    public List<DepartmentDTO> findAllDepartment() {
         List<Department> departments = departmentRepository.findAll();
        return DepartmentMapper.toDTOList(departments);
    }

    public void updateDepartment(DepartmentDTO departmentDTO) {
        Department department = DepartmentMapper.toEntity(departmentDTO);
        departmentRepository.update(department);

    }

    public void deleteDepartment(Long id) {
        departmentRepository.delete(id);
    }

    public void activeDepartment(Long id,boolean isActive){
        departmentRepository.setActive(id,isActive);
    }
}
