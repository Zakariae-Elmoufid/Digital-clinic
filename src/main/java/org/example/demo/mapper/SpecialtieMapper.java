package org.example.demo.mapper;

import org.example.demo.dto.SpecialtieDTO;
import org.example.demo.entity.Department;
import org.example.demo.entity.Specialite;

import java.util.ArrayList;
import java.util.List;

public class SpecialtieMapper {
    public static Specialite toEntity(SpecialtieDTO dto , Department department ){
        Specialite specialite = new Specialite();
        specialite.setId(dto.getId());
        specialite.setName(dto.getName());
        specialite.setDescription(dto.getDescription());
        specialite.setDepartment(department);
        return specialite;
    }

    public static SpecialtieDTO toDTO(Specialite specialite){
      return   new SpecialtieDTO(specialite.getId(), specialite.getName(), specialite.getDescription(),specialite.getActive(), specialite.getDepartment().getName(), specialite.getDepartment().getId());
    }

    public static List<SpecialtieDTO> toDTOList(List<Specialite> specialties){
        List<SpecialtieDTO> list = new ArrayList<>();
        for(Specialite specialite : specialties){
            list.add(toDTO(specialite));
        }
        return list;
    }
}
