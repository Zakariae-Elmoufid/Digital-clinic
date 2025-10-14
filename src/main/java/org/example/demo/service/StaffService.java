package org.example.demo.service;

import org.example.demo.dto.StaffDTO;
import org.example.demo.entity.Specialite;
import org.example.demo.entity.Staff;
import org.example.demo.entity.User;
import org.example.demo.mapper.SpecialtieMapper;
import org.example.demo.mapper.StaffMapper;
import org.example.demo.repository.StaffInterface;
import org.example.demo.util.PasswordUtils;
import org.mindrot.jbcrypt.BCrypt;

import java.util.ArrayList;
import java.util.List;

public class StaffService {

    private StaffInterface staffRepo;

    public StaffService(StaffInterface staffRepo) {
        this.staffRepo = staffRepo;
    }

    public void saveStaff(StaffDTO staffDTO){
        String hashedPassword = BCrypt.hashpw(staffDTO.getPassword(), BCrypt.gensalt());
        staffDTO.setPassword(hashedPassword);
        User user = StaffMapper.toNewEntity(staffDTO);
        staffRepo.save(user);
    }

    public List<StaffDTO> findAllStaff(){
        List<User> staffs = staffRepo.findAll();
        List<StaffDTO> list = StaffMapper.toListDTO(staffs);
        return list;
    }

    public void updateStaff(StaffDTO staffDTO){
        User user = StaffMapper.toEntity(staffDTO);
        User existing = staffRepo.findById(user.getId());
        existing.setFullName(user.getFullName());
        existing.setEmail(user.getEmail());
        existing.setActive(user.getActive());
        staffRepo.update(existing);
    }

    public void deleteStaff(Long id){
         staffRepo.delete(id);
    }





}
