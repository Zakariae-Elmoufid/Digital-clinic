package org.example.demo.repository;

import jakarta.persistence.EntityManager;
import org.example.demo.entity.Patient;
import org.example.demo.util.JPAsingleton;

public class PatientRepository implements PatientInterface {

    public Patient  findPatientByUserId(long id) {
        EntityManager em = JPAsingleton.getEntityManager();
        try{
            return em.createQuery("select  p from  Patient p where p.user.id = :id",Patient.class)
                    .setParameter("id",id).getSingleResult();
        }finally {
            em.close();
        }
    }
}
