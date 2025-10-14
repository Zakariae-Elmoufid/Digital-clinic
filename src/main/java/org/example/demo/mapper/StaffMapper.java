package org.example.demo.mapper;

import org.eclipse.tags.shaded.org.apache.regexp.RE;
import org.example.demo.dto.StaffDTO;
import org.example.demo.entity.Staff;
import org.example.demo.entity.User;
import org.example.demo.enums.RoleEnum;

import java.util.ArrayList;
import java.util.List;

public class StaffMapper {
    public static User  toEntity(StaffDTO staffDTO){
        User user = new User();
        user.setId(staffDTO.getId());
        user.setFullName(staffDTO.getName());
        user.setEmail(staffDTO.getEmail());
        user.setActive(staffDTO.isActive());
        user.setRole(RoleEnum.STAFF);
        return  user;
    }

    public static User toNewEntity(StaffDTO dto) {
        User user = new User();
        user.setFullName(dto.getName());
        user.setEmail(dto.getEmail());
        user.setPassword(dto.getPassword());
        user.setRole(RoleEnum.STAFF);
        return user;
    }


    public static StaffDTO toDTO(User user){
      return  new StaffDTO(user.getId(), user.getFullName(),user.getEmail(),user.getActive(),user.getCreatedAt());
    }

    public static List<StaffDTO> toListDTO(List<User> staffs){
        List<StaffDTO> list =  new ArrayList<StaffDTO>();
        for(User staff : staffs){
            list.add(toDTO(staff));
        }
        return list;
    }

}
