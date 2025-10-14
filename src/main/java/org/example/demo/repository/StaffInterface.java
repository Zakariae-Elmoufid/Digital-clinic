package org.example.demo.repository;

import org.example.demo.dto.StaffDTO;
import org.example.demo.entity.User;

import java.util.List;

public interface StaffInterface {
    public void save(User user);
    public List<User> findAll();
    public User findById(long id);
    public void update(User user);
    public void delete(Long id);
}
