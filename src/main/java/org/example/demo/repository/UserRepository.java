package org.example.demo.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
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

   public Patient findUserByEmail(String email){
      EntityManager em  = JPAsingleton.getEntityManager();
      try{
         return em.createQuery( "SELECT p FROM Patient p " +
                         "JOIN p.user u " +
                         "WHERE u.email = :email", Patient.class)
                 .setParameter("email", email)
                 .getSingleResult();
      }catch(NoResultException e){
         return null;
      }

   }
}
