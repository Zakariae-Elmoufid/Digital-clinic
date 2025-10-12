package org.example.demo.mapper;

import org.example.demo.dto.DepartmentDTO;
import org.example.demo.entity.Department;

import java.util.ArrayList;
import java.util.List;

public class DepartmentMapper {
    public static Department toEntity(DepartmentDTO departmentDTO) {
        Department department = new Department();
        department.setName(departmentDTO.getName());
        department.setDescription(departmentDTO.getDescription());
        return department;
    }

    public static DepartmentDTO toDTO(Department dept) {
        return new DepartmentDTO(dept.getId(),  dept.getName(), dept.getDescription() , dept.getActive(),dept.getCreatedAt());
    }

    public static  List<DepartmentDTO> toDTOList(List<Department> departments){
        List<DepartmentDTO> departmentDTOs = new ArrayList<>();
        for(Department department : departments){
            departmentDTOs.add(DepartmentMapper.toDTO(department));
        }
        return departmentDTOs;
    }
}
