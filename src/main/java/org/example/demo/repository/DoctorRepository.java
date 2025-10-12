package org.example.demo.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import org.example.demo.entity.Doctor;
import org.example.demo.util.JPAsingleton;

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
}
