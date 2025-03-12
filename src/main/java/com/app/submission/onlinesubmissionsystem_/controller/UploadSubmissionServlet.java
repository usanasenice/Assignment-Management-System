package com.app.submission.onlinesubmissionsystem_.controller;

import com.app.submission.onlinesubmissionsystem_.dao.AssignmentDAO;
import com.app.submission.onlinesubmissionsystem_.dao.SubmissionDAO;
import com.app.submission.onlinesubmissionsystem_.model.Assignment;
import com.app.submission.onlinesubmissionsystem_.model.Role;
import com.app.submission.onlinesubmissionsystem_.model.Submission;
import com.app.submission.onlinesubmissionsystem_.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;

/**
 * Servlet that handles student assignment submissions.
 * It verifies the user, processes file uploads, and saves the submission record to the database.
 */
@WebServlet("/UploadSubmissionServlet")
@MultipartConfig
public class UploadSubmissionServlet extends HttpServlet {

    /**
     * Handles the HTTP POST request to upload an assignment submission.
     *
     * @param request  the HttpServletRequest object containing client request parameters
     * @param response the HttpServletResponse object to send response data to the client
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the current student from session
        User user = (User) request.getSession().getAttribute("user");

        if (user == null || user.getRole() != Role.STUDENT) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get the assignment ID and file from the request
        String assignmentId = request.getParameter("assignmentId");
        Part filePart = request.getPart("file");  // The file being uploaded

        if (filePart == null || assignmentId == null || assignmentId.isEmpty()) {
            response.sendRedirect("studentDashboard.jsp?error=true&message=Missing file or assignment ID");
            return;
        }

        // Process file
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String filePath = "uploads/" + fileName;  // Save the file in the 'uploads' directory

        // Save file to server
        String uploadDir = getServletContext().getRealPath("/uploads");
        File uploadDirectory = new File(uploadDir);
        if (!uploadDirectory.exists()) {
            uploadDirectory.mkdir();
        }

        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, Paths.get(uploadDir + "/" + fileName), StandardCopyOption.REPLACE_EXISTING);
        }

        // Save submission record in the database
        AssignmentDAO assignmentDAO = new AssignmentDAO();
        SubmissionDAO submissionDAO = new SubmissionDAO();
        Assignment assignment = assignmentDAO.getAssignmentById(Long.parseLong(assignmentId));

        if (assignment == null) {
            response.sendRedirect("studentDashboard.jsp?error=true&message=Assignment not found");
            return;
        }

        // Create a new submission object and populate it
        Submission submission = new Submission();
        submission.setAssignment(assignment);
        submission.setStudent(user);
        submission.setFilePath(filePath);
        submission.setSubmittedAt(LocalDateTime.now());

        // Save to the database
        boolean success = submissionDAO.saveSubmission(submission);

        if (success) {
            // If submission is successfully saved in the DB, send a success message
            response.sendRedirect("studentDashboard.jsp?success=true&message=Submission successful");
        } else {
            // If something went wrong while saving, send an error message
            response.sendRedirect("studentDashboard.jsp?error=true&message=Failed to submit the assignment");
        }
    }
}
