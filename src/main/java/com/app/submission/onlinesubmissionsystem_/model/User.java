package com.app.submission.onlinesubmissionsystem_.model;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    @Column(name = "email")
    private String email;

    private String password;

    @Enumerated(EnumType.STRING)
    private Role role; // STUDENT or INSTRUCTOR

    // Many students enrolled in one class
    @ManyToOne
    @JoinColumn(name = "enrolled_class_id")
    private ClassEntity enrolledClass;

    // Many-to-many relationship with classes for instructors
    @ManyToMany(mappedBy = "instructors")
    private List<ClassEntity> classes = new ArrayList<>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public ClassEntity getEnrolledClass() {
        return enrolledClass;
    }

    public void setEnrolledClass(ClassEntity enrolledClass) {
        this.enrolledClass = enrolledClass;
    }

    public List<ClassEntity> getClasses() {
        return classes;
    }

    public void setClasses(List<ClassEntity> classes) {
        this.classes = classes;
    }
}