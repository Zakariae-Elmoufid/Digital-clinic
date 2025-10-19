package org.example.demo.repository;

import jakarta.persistence.EntityManager;
import org.example.demo.entity.Appointment;
import org.example.demo.util.JPAsingleton;

public class AppointmentRepository implements  AppointmentInterface{

    @Override
    public void save(Appointment appointment) {
        EntityManager em = JPAsingleton.getEntityManager();
        em.getTransaction().begin();
        try {
            em.persist(appointment);
            em.getTransaction().commit();
        }catch(Exception e){
            em.getTransaction().rollback();
            e.printStackTrace();
        }finally {
            em.close();
        }
    }
}
