package org.example.demo.repository;

import org.example.demo.dto.AvailabilityDTO;
import org.example.demo.entity.Availability;
import org.example.demo.entity.Doctor;

import java.util.List;

public interface AvailabilityInterface {
    public void save(Availability availability  );
    public List<Availability> findAllByDoctor(long id);
    public Availability findById(long id);
    public void update(Availability availability);
    public void delete(long id);

}
