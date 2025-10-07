package org.example.demo.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAsingleton {
    private static final EntityManagerFactory emf;

    static {
        emf = Persistence.createEntityManagerFactory("demoPU");
    }

    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public static void close() {
        emf.close();
    }
}
