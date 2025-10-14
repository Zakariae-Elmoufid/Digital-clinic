package org.example.demo.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import jakarta.persistence.Table;
import org.example.demo.entity.Department;
import org.example.demo.entity.Specialite;
import org.example.demo.util.JPAsingleton;

import java.util.List;

public class SpecialtieRepository  implements SpecialtieInterface {

  public void save(Specialite spe) {
      EntityManager em = JPAsingleton.getEntityManager();
          EntityTransaction tx = em.getTransaction();
      try {
          tx.begin();
          em.persist(spe);
          tx.commit();
      } catch (Exception e) {
          if (tx.isActive()) tx.rollback();
          e.printStackTrace();
      } finally {
          em.close();
      }
  }

  public Specialite findById(long id) {
         EntityManager em = JPAsingleton.getEntityManager();
         try {
             return em.find(Specialite.class, id);
         }finally {
             em.close();
         }

  }
  public void update(Specialite spe) {
      EntityManager em = JPAsingleton.getEntityManager();
      EntityTransaction tx = em.getTransaction();
      try {
          tx.begin();
          em.merge(spe);
          tx.commit();
      }catch (Exception e) {
          if (tx.isActive()) tx.rollback();
      }finally {
          em.close();
      }
  }
  public List<Specialite> findAll() {
      EntityManager em = JPAsingleton.getEntityManager();
      try {
          return em.createQuery("SELECT s FROM Specialite s", Specialite.class).getResultList();
      } finally {
          em.close();
      }
  }

  public void delete(Long id) {
      EntityManager em = JPAsingleton.getEntityManager();
      EntityTransaction tx = em.getTransaction();
      try {
          tx.begin();
          Specialite specialite = em.find(Specialite.class, id);
          if (specialite != null) {
          em.remove(specialite);
          }
          tx.commit();
      }catch (Exception e) {
          if (tx.isActive()) tx.rollback();
      }finally {
          em.close();
      }
  }
}
