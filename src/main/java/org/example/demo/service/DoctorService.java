package org.example.demo.service;

import org.example.demo.dto.DoctorDTO;
import org.example.demo.dto.SpecialtieDTO;
import org.example.demo.entity.Doctor;
import org.example.demo.entity.Specialite;
import org.example.demo.mapper.DoctorMapper;
import org.example.demo.mapper.SpecialtieMapper;
import org.example.demo.repository.DoctorRepository;
import org.example.demo.repository.SpecialtieRepository;
import org.mindrot.jbcrypt.BCrypt;

import java.util.List;

public class DoctorService {

    private SpecialtieRepository specialtieRepository;
    private DoctorRepository doctorRepository;

    public DoctorService( DoctorRepository doctorRepository, SpecialtieRepository specialtieRepository) {
        this.doctorRepository = doctorRepository;
        this.specialtieRepository = specialtieRepository;
    }



    public void saveDoctor(DoctorDTO docDTO){
        Specialite  specialtie = specialtieRepository.findById(docDTO.getSepcialtieId());
        if (specialtie == null) {
            throw new RuntimeException("specialty not found");
        }
        String hashedPassword = BCrypt.hashpw(docDTO.getPassword(), BCrypt.gensalt());
        docDTO.setPassword(hashedPassword);
        Doctor doctor = DoctorMapper.ToEntity(docDTO,specialtie);
        System.out.println(doctor);

        doctorRepository.save(doctor);
    }
    public List<DoctorDTO> getAllDoctors(){
         List<DoctorDTO> doctors = doctorRepository.getAll();
        return doctors;
    }

    public void updateDoctor(DoctorDTO docDTO){
        Doctor doctor = doctorRepository.findById(docDTO.getId());
        Specialite specialite =  specialtieRepository.findById(docDTO.getSepcialtieId());
        doctor.getUser().setFullName(docDTO.getName());
        doctor.getUser().setEmail(docDTO.getEmail());
        doctor.getUser().setActive(docDTO.isActive());
        doctor.setSpecialite(specialite);
        doctor.setMatricule(docDTO.getMatriculate());

         doctorRepository.update(doctor);
    }

    public void deleteDoctor(long id){
        doctorRepository.delete(id);
    }
}
