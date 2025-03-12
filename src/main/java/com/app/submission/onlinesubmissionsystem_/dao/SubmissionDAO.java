package com.app.submission.onlinesubmissionsystem_.dao;

import com.app.submission.onlinesubmissionsystem_.model.Submission;
import com.app.submission.onlinesubmissionsystem_.util.HibernateUtil;
import com.mysql.cj.jdbc.ConnectionImpl;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

public class SubmissionDAO {

    public boolean saveSubmission(Submission submission) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.persist(submission);
            transaction.commit();
            return true;
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return false;
        }
    }

    public List<Submission> getSubmissionsByAssignment(Long assignmentId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Submission WHERE assignment.id = :assignmentId", Submission.class)
                    .setParameter("assignmentId", assignmentId)
                    .list();
        }
    }

    public Submission getSubmissionByStudentAndAssignment(Long studentId, Long assignmentId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Submission WHERE student.id = :studentId AND assignment.id = :assignmentId", Submission.class)
                    .setParameter("studentId", studentId)
                    .setParameter("assignmentId", assignmentId)
                    .uniqueResult();
        }
    }

    public Submission getSubmissionById(Long submissionId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Submission.class, submissionId);
        }
    }
    public void deleteSubmission(Long submissionId) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Submission submission = session.get(Submission.class, submissionId);
            if (submission != null) {
                session.remove(submission);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }

}
