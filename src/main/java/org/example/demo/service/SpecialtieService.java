package org.example.demo.service;

import org.example.demo.dto.SpecialtieDTO;
import org.example.demo.entity.Department;
import org.example.demo.entity.Specialite;
import org.example.demo.mapper.DepartmentMapper;
import org.example.demo.mapper.SpecialtieMapper;
import org.example.demo.repository.DepartmentRepository;
import org.example.demo.repository.SpecialtieRepository;

import java.util.ArrayList;
import java.util.List;

public class SpecialtieService {
    private final   SpecialtieRepository specialtieRepository;
    private  DepartmentRepository departmentRepository;

    public SpecialtieService (SpecialtieRepository specialtieRepository , DepartmentRepository departmentRepository) {
        this.specialtieRepository = specialtieRepository;
        this.departmentRepository =  departmentRepository;
    }

    public SpecialtieService (SpecialtieRepository specialtieRepository) {
        this.specialtieRepository = specialtieRepository;
    }

    public void  saveSpecialtie(SpecialtieDTO dto){
        Department department = departmentRepository.findById(dto.getDepaId());
        if (department == null) {
            throw new RuntimeException("Department not found");
        }
       Specialite specialite = SpecialtieMapper.toEntity(dto, department);
       specialtieRepository.save(specialite);
    }

    public List<SpecialtieDTO> getAllSpecialtie(){
          List<Specialite> specialites  = specialtieRepository.findAll();
        return SpecialtieMapper.toDTOList(specialites);
    }

    public void updateSpecialtie(SpecialtieDTO dto){
        Department department = departmentRepository.findById(dto.getDepaId());
        if (department == null) {
            throw new RuntimeException("Department not found");
        }
        Specialite specialite = SpecialtieMapper.toEntity(dto, department);
        Specialite existing = specialtieRepository.findById(specialite.getId());
        if (existing != null) {
            existing.setName(dto.getName());
            existing.setDescription(dto.getDescription());
            existing.setDepartment(department);
            specialtieRepository.update(existing);
        }
    }

   public void deleteSpecialtie(Long id){
        specialtieRepository.delete(id);
   }


}
