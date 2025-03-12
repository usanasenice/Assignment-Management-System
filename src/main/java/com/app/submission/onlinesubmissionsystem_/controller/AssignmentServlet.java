package com.app.submission.onlinesubmissionsystem_.controller;

import com.app.submission.onlinesubmissionsystem_.dao.AssignmentDAO;
import com.app.submission.onlinesubmissionsystem_.dao.ClassDAO;
import com.app.submission.onlinesubmissionsystem_.model.Assignment;
import com.app.submission.onlinesubmissionsystem_.model.ClassEntity;
import com.app.submission.onlinesubmissionsystem_.model.Role;
import com.app.submission.onlinesubmissionsystem_.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@WebServlet("/createAssignment")
public class AssignmentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Check if the user is an instructor
        if (user == null || user.getRole() != Role.INSTRUCTOR) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve form parameters
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String deadlineStr = request.getParameter("deadline");
        String[] classIdParams = request.getParameterValues("classIds");

        // Validate that at least one class is selected
        if (classIdParams == null || classIdParams.length == 0) {
            response.sendRedirect("createAssignment.jsp?error=NoClassesSelected");
            return;
        }

        try {
            // Parse the deadline using LocalDateTime
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            LocalDateTime parsedDeadline = LocalDateTime.parse(deadlineStr, formatter);

            ClassDAO classDAO = new ClassDAO();
            List<ClassEntity> targetClasses = new ArrayList<>();

            // Process each class ID
            for (String classIdStr : classIdParams) {
                Long classId = Long.parseLong(classIdStr);
                ClassEntity cls = classDAO.getClassById(classId);
                if (cls == null) {
                    response.sendRedirect("createAssignment.jsp?error=InvalidClass");
                    return;
                }
                targetClasses.add(cls);
            }

            // Create and populate the Assignment object
            Assignment assignment = new Assignment();
            assignment.setTitle(title);
            assignment.setDescription(description);
            assignment.setDeadline(parsedDeadline); // Use LocalDateTime directly
            assignment.setInstructor(user);
            assignment.setCreatedBy(user);
            assignment.setTargetClasses(targetClasses); // Set multiple classes

            // Save the assignment
            AssignmentDAO assignmentDAO = new AssignmentDAO();
            assignmentDAO.saveAssignment(assignment);

            response.sendRedirect("instructorDashboard.jsp?success=AssignmentCreated");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("createAssignment.jsp?error=GeneralError");
        }
    }
}