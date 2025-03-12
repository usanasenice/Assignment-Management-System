package com.app.submission.onlinesubmissionsystem_.dao;

import com.app.submission.onlinesubmissionsystem_.model.Assignment;
import com.app.submission.onlinesubmissionsystem_.model.ClassEntity;
import com.app.submission.onlinesubmissionsystem_.model.User;
import org.hibernate.Session;
import org.hibernate.Transaction;
import com.app.submission.onlinesubmissionsystem_.util.HibernateUtil;
import org.hibernate.query.Query;

import java.util.List;

public class AssignmentDAO {

    public void saveAssignment(Assignment assignment) {
        Transaction transaction = null;
        Session session = null;

        try {
            // Open a session
            session = HibernateUtil.getSessionFactory().openSession();
            System.out.println("Session opened");

            // Start a transaction
            transaction = session.beginTransaction();

            // Persist the assignment entity
            session.persist(assignment);
            System.out.println("Assignment persisted");

            // Commit the transaction
            transaction.commit();
            System.out.println("Transaction committed");

        } catch (Exception e) {
            // Handle exception and rollback transaction if needed
            if (transaction != null) {
                transaction.rollback();
                System.out.println("Transaction rolled back due to an error");
            }

            e.printStackTrace();  // Log the exception for debugging

        } finally {
            // Close the session
            if (session != null) {
                session.close();
                System.out.println("Session closed");
            }
        }
    }
    // Retrieve an assignment by ID
    public Assignment getAssignmentById(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Assignment.class, id);
        }
    }

    // Get all assignments created by a specific instructor
    public List<Assignment> getAssignmentsByInstructor(User instructor) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Assignment WHERE createdBy = :instructor", Assignment.class)
                    .setParameter("instructor", instructor)
                    .list();
        }
    }

    // Get all assignments available to students
    public List<Assignment> getAllAssignments() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Assignment", Assignment.class).list();
        }
    }

    // Update an existing assignment
    public void updateAssignment(Assignment assignment) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.merge(assignment);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }

    // Delete an assignment
    public void deleteAssignment(Assignment assignment) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.remove(assignment);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }

    public List<Assignment> getAssignmentsByClass(Long classId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Assignment> query = session.createQuery(
                    "SELECT a FROM Assignment a JOIN a.targetClasses c WHERE c.id = :classId",
                    Assignment.class
            );
            query.setParameter("classId", classId);
            return query.list();
        }
    }
}
