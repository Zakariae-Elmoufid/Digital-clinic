package org.example.demo.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Table;
import jakarta.persistence.TypedQuery;
import jakarta.transaction.Transaction;
import org.example.demo.entity.Staff;
import org.example.demo.entity.User;
import org.example.demo.enums.RoleEnum;
import org.example.demo.util.JPAsingleton;

import java.util.List;

public class StaffRepository implements  StaffInterface{

    public void  save(User user){
        EntityManager em = JPAsingleton.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try{
            em.getTransaction().begin();
            em.persist(user);
            tx.commit();
        }catch(Exception e){
            tx.rollback();
        }finally{
            em.close();
        }
    }

    public List<User> findAll(){
        EntityManager em = JPAsingleton.getEntityManager();
        try{
            TypedQuery<User> query = em.createQuery(
                    "SELECT u FROM User u WHERE u.role = :role", User.class);
            query.setParameter("role", RoleEnum.STAFF);
            return query.getResultList();
        } finally{
            em.close();        }
    }

    public User findById(long id){
        EntityManager em = JPAsingleton.getEntityManager();
        try{
          return   em.find(User.class, id);
        } finally{
            em.close();
        }
    }


    public void update(User user){
        EntityManager em = JPAsingleton.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(user);
            tx.commit();
        }catch(Exception e) {
            if (tx.isActive()) tx.rollback();
        }finally{
            em.close();
        }
    }

    public void delete(Long id){
        EntityManager em = JPAsingleton.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            User user = em.find(User.class, id);
            em.remove(user);
            tx.commit();
        }catch(Exception e) {
            if (tx.isActive()) tx.rollback();
        }finally{
            em.close();
        }
    }
}
