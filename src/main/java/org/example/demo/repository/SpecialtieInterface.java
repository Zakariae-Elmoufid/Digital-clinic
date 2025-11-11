package org.example.demo.repository;

import org.example.demo.entity.Specialite;

import javax.swing.plaf.SpinnerUI;
import java.util.List;

public interface SpecialtieInterface {
    public void save(Specialite spe);
    public List<Specialite> findAll();
}
