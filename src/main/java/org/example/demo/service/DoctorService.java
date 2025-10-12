package org.example.demo.service;

import org.example.demo.dto.DoctorDTO;
import org.example.demo.dto.SpecialtieDTO;
import org.example.demo.entity.Doctor;
import org.example.demo.entity.Specialite;
import org.example.demo.mapper.DoctorMapper;
import org.example.demo.mapper.SpecialtieMapper;
import org.example.demo.repository.DoctorRepository;
import org.example.demo.repository.SpecialtieRepository;

import java.util.List;

public class DoctorService {

    private SpecialtieRepository specialtieRepository;
    private DoctorRepository doctorRepository;

    public DoctorService( DoctorRepository doctorRepository, SpecialtieRepository specialtieRepository) {
        this.doctorRepository = doctorRepository;
        this.specialtieRepository = specialtieRepository;
    }

    public List<SpecialtieDTO> getAllSpecialtie(){
        List<Specialite> specialites  = specialtieRepository.findAll();
        return SpecialtieMapper.toDTOList(specialites);
    }

    public void saveDoctor(DoctorDTO docDTO){
        Specialite  specialtie = specialtieRepository.findById(docDTO.getSepcialtieId());
        if (specialtie == null) {
            throw new RuntimeException("specialty not found");
        }
        Doctor doctor = DoctorMapper.ToEntity(docDTO,specialtie);
        System.out.println(doctor);

        doctorRepository.save(doctor);

    }
}
