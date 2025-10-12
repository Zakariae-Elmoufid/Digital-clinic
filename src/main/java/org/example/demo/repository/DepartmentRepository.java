package org.example.demo.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import org.example.demo.entity.Department;
import org.example.demo.util.JPAsingleton;

import java.util.List;

public class DepartmentRepository implements DepartmentInterface {

    public void save(Department department) {
        EntityManager em = JPAsingleton.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(department);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
        } finally {
            em.close();
        }
    }

    public Department findById(Long id) {
        EntityManager em = JPAsingleton.getEntityManager();
        try {
            return em.find(Department.class, id);
        } finally {
            em.close();
        }
    }

    public List<Department> findAll() {
        EntityManager em = JPAsingleton.getEntityManager();
        try {
            TypedQuery<Department> query = em.createNamedQuery("Department.findAll", Department.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void update(Department department) {
        EntityManager em = JPAsingleton.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(department);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = JPAsingleton.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            Department department = em.find(Department.class, id);
            if (department != null) {
                em.remove(department);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public  void setActive(Long id,boolean isActive){
        EntityManager em = JPAsingleton.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Department department = em.find(Department.class, id);
            if (department != null) {
                department.setActive(isActive);
            }
            tx.commit();
        }catch (Exception e){
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        }finally {
            em.close();
        }
    }
}
