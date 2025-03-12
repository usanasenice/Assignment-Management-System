package com.app.submission.onlinesubmissionsystem_.util;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {
    private static final SessionFactory sessionFactory;

    static {
        try {
            Configuration config = new Configuration().configure("hibernate.cfg.xml");
            System.out.println("Configuring Hibernate with entities...");
            sessionFactory = config.buildSessionFactory();
            System.out.println("SessionFactory built successfully.");
        } catch (Exception e) {
            System.err.println("Failed to initialize SessionFactory: " + e.getMessage());
            e.printStackTrace();
            throw new ExceptionInInitializerError("Hibernate initialization failed: " + e.getMessage());
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public static void shutdown() {
        if (sessionFactory != null) {
            sessionFactory.close();
        }
    }
}