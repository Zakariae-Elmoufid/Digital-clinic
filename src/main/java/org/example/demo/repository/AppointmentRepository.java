package org.example.demo.repository;

import jakarta.persistence.EntityManager;
import org.example.demo.entity.Appointment;
import org.example.demo.entity.Patient;
import org.example.demo.util.JPAsingleton;

import java.util.List;

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

    public List<Appointment> findByPatient(Patient patient) {
        EntityManager em = JPAsingleton.getEntityManager();
        try {
            return em.createQuery(
                            "SELECT a FROM Appointment a WHERE a.patient = :patient",
                            Appointment.class)
                    .setParameter("patient", patient)
                    .getResultList();
        } finally {
            em.close();
        }
    }

}
