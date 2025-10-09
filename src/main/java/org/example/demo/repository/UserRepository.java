package org.example.demo.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import org.example.demo.entity.Patient;
import org.example.demo.entity.User;
import org.example.demo.util.JPAsingleton;

public class UserRepository implements UserInterface {

   public Patient save(Patient patient){
      EntityManager em  = JPAsingleton.getEntityManager();
      EntityTransaction tx = em.getTransaction();
      try{
         tx.begin();
         em.persist(patient);
         tx.commit();
         return patient;
      }catch (Exception e) {
         if (tx.isActive()) tx.rollback();
         throw e;
      } finally {
         em.close();
      }
   }
}
