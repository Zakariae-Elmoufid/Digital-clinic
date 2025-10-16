package org.example.demo.repository;

import jakarta.ejb.TransactionManagement;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.transaction.TransactionManager;
import org.eclipse.tags.shaded.org.apache.xalan.xsltc.util.IntegerArray;
import org.example.demo.dto.AvailabilityDTO;
import org.example.demo.entity.Availability;
import org.example.demo.entity.Doctor;
import org.example.demo.mapper.AvailabilityMapper;
import org.example.demo.util.JPAsingleton;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class AvailabilityRepository implements AvailabilityInterface {

    public void save(Availability availability ) {
        EntityManager em = JPAsingleton.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();

            em.merge(availability);

            tx.commit();
        } catch(Exception e){
            if(tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }

    }

    public List<Availability> findAllByDoctor(long doctorId){
        EntityManager em = JPAsingleton.getEntityManager();
        try{
            return em.createNativeQuery(
                    "SELECT * FROM availabilities " +
                            "WHERE start_date <= CURRENT_DATE " +
                            "AND (end_date IS NULL OR end_date >= CURRENT_DATE) " +
                            "AND doctor_id = :doctorId " +
                            "ORDER BY CASE day_of_week " +
                            "WHEN 'MONDAY' THEN 1 " +
                            "WHEN 'TUESDAY' THEN 2 " +
                            "WHEN 'WEDNESDAY' THEN 3 " +
                            "WHEN 'THURSDAY' THEN 4 " +
                            "WHEN 'FRIDAY' THEN 5 " +
                            "WHEN 'SATURDAY' THEN 6 " +
                            "WHEN 'SUNDAY' THEN 7 END",
                    Availability.class)
                    .setParameter("doctorId", doctorId)
                    .getResultList();
        }catch(Exception e){
            e.printStackTrace();
            return Collections.emptyList();
        }finally{
            em.close();
        }
    }
}
