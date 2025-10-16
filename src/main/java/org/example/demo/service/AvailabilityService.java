package org.example.demo.service;

import org.example.demo.dto.AvailabilityDTO;
import org.example.demo.entity.Availability;
import org.example.demo.entity.Doctor;
import org.example.demo.entity.User;
import org.example.demo.mapper.AvailabilityMapper;
import org.example.demo.repository.AvailabilityInterface;
import org.example.demo.repository.DoctorRepository;
import org.example.demo.repository.UserRepository;

import java.util.ArrayList;
import java.util.List;

public class AvailabilityService {

    private AvailabilityInterface availabilityInterface ;
    private DoctorRepository doctorRepository;

    public AvailabilityService(AvailabilityInterface availabilityInterface,DoctorRepository doctorRepository) {
        this.availabilityInterface = availabilityInterface;
        this.doctorRepository = doctorRepository;
    }

   public void addAvailability(AvailabilityDTO availabilityDTO){
        Doctor doctor = doctorRepository.findByUserId(availabilityDTO.getUserId());

       if (doctor == null) {
           throw new RuntimeException("Doctor not found for id: " + availabilityDTO.getUserId());
       }
       Availability availability = AvailabilityMapper.toNewEntity(availabilityDTO, doctor);

       availabilityInterface.save(availability);
   }

   public List<AvailabilityDTO> getAllAvailabilityByDoctor(long userId){
       Doctor doctor = doctorRepository.findByUserId(userId);
       List<Availability> availabilities = availabilityInterface.findAllByDoctor(doctor.getId());
       List<AvailabilityDTO> availabilityDTOS  = AvailabilityMapper.toDTOList(availabilities);
       return   availabilityDTOS;
   }

}
