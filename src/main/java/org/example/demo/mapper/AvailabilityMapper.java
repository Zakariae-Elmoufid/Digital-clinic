package org.example.demo.mapper;

import org.example.demo.dto.AvailabilityDTO;
import org.example.demo.entity.Availability;
import org.example.demo.entity.Doctor;

import java.util.ArrayList;
import java.util.List;

public class AvailabilityMapper {

    public static Availability toNewEntity(AvailabilityDTO dto, Doctor doctor){
        Availability  availability  = new Availability();
        availability.setId(dto.getId());
        availability.setSlotDuration(dto.getSlotDuration());
        availability.setDayOfWeek(dto.getDayOfWeek());
        availability.setStartTime(dto.getStartTime());
        availability.setEndTime(dto.getEndTime());
        availability.setStartDate(dto.getStartDate());
        availability.setEndDate(dto.getEndDate());
        availability.setDoctor(doctor);
        return availability;
    }

    public static AvailabilityDTO toDTO(Availability availability){
        return  new AvailabilityDTO(availability.getId(),availability.getDayOfWeek(),availability.getStartTime(),availability.getEndTime(),availability.getStartDate(),availability.getEndDate(),availability.getSlotDuration() ,availability.getAvailable());
    }

    public static List<AvailabilityDTO> toDTOList(List<Availability> availabilities){
        List<AvailabilityDTO> availabilityDTOS = new ArrayList<>();
        for(Availability availability : availabilities){
            availabilityDTOS.add(toDTO(availability));
        }
        return availabilityDTOS;
    }
}
