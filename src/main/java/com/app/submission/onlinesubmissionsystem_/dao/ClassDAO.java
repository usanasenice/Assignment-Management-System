package com.app.submission.onlinesubmissionsystem_.dao;

import com.app.submission.onlinesubmissionsystem_.model.ClassEntity;
import com.app.submission.onlinesubmissionsystem_.model.User;
import com.app.submission.onlinesubmissionsystem_.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

public class ClassDAO {
    public ClassEntity getClassById(long id){
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(ClassEntity.class, id);
        }
    }

    public void saveClass(ClassEntity classEntity) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(classEntity);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }

    public List<ClassEntity> getAllClasses() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<ClassEntity> query = session.createQuery("FROM ClassEntity", ClassEntity.class);
            List<ClassEntity> result = query.list();
            System.out.println("Total classes: " + result.size());
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public List<ClassEntity> getClassesByInstructor(User instructor) {
        return new ArrayList<>(instructor.getClasses());
    }

}
