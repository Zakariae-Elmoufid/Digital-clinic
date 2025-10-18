package org.example.demo.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import org.example.demo.dto.DoctorDTO;
import org.example.demo.entity.Appointment;
import org.example.demo.entity.Availability;
import org.example.demo.entity.AvailabilitySlot;
import org.example.demo.entity.Doctor;
import org.example.demo.mapper.DoctorMapper;
import org.example.demo.util.JPAsingleton;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Queue;

public class DoctorRepository implements DoctorInterface {
    public void  save(Doctor doctor) {
        EntityManager em = JPAsingleton.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try{
            tx.begin();
            em.persist(doctor);
            tx.commit();
        }catch(Exception e){
            if(tx.isActive())tx.rollback();
            e.printStackTrace();
        }finally{
            em.close();
        }
    }

    public List<DoctorDTO> getAll() {
        EntityManager em = JPAsingleton.getEntityManager();
        try{
            Query query = em.createQuery("""
            SELECT d 
            FROM Doctor d
            JOIN FETCH d.specialite s
            JOIN FETCH s.department dept
        """, Doctor.class);


            List<Doctor> doctors = query.getResultList();
            return DoctorMapper.toDTOList(doctors);

        }finally{
            em.close();
        }

    }

    public Doctor findById(long id){
         EntityManager em = JPAsingleton.getEntityManager();
         try{
          return    em.find(Doctor.class, id);
         }finally{
             em.close();
         }
    }

    public void update(Doctor doctor) {
        EntityManager em = JPAsingleton.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try{
            tx.begin();
            em.merge(doctor);
            tx.commit();
        }catch(Exception e){
            if(tx.isActive())tx.rollback();
        }finally{
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = JPAsingleton.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try{
            tx.begin();
            Doctor doctor =  em.find(Doctor.class, id);
            em.remove(doctor);
            tx.commit();
        }catch(Exception e){
            if(tx.isActive())tx.rollback();
        }finally{
            em.close();
        }
    }

    public Doctor findByUserId(long userId) {
        EntityManager em = JPAsingleton.getEntityManager();
        try{
            return em.createQuery(
                            "SELECT d FROM Doctor d WHERE d.user.id = :userId",
                            Doctor.class
                    )
                    .setParameter("userId", userId)
                    .getSingleResult();
        }finally {
            em.close();
        }
    }

    public Doctor findDoctor(long doctorId) {
        EntityManager em = JPAsingleton.getEntityManager();
        try {
            Doctor doctor = em.find(Doctor.class, doctorId);
            doctor.getAvailabilities().size();
            doctor.getAppointments().size();
            return doctor;
        } finally {
            em.close();
        }
    }




}
