<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, com.app.submission.onlinesubmissionsystem_.model.Assignment, com.app.submission.onlinesubmissionsystem_.model.Submission, com.app.submission.onlinesubmissionsystem_.dao.AssignmentDAO, com.app.submission.onlinesubmissionsystem_.dao.SubmissionDAO, com.app.submission.onlinesubmissionsystem_.model.User" %>
<%@ page import="com.app.submission.onlinesubmissionsystem_.model.ClassEntity" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || user.getRole() != com.app.submission.onlinesubmissionsystem_.model.Role.STUDENT) {
        response.sendRedirect("logout");
        return;
    }

    // Get the student's enrolled class
    ClassEntity enrolledClass = user.getEnrolledClass();
    String className = (enrolledClass != null) ? enrolledClass.getClassName() : "No Class Enrolled";

    AssignmentDAO assignmentDAO = new AssignmentDAO();
    SubmissionDAO submissionDAO = new SubmissionDAO();
    List<Assignment> assignments = (enrolledClass != null) ? assignmentDAO.getAssignmentsByClass(enrolledClass.getId()) : new java.util.ArrayList<>();

    // Debug: Log the number of assignments fetched
    System.out.println("DEBUG: Student " + user.getName() + " enrolled in " + className + ", fetched " + assignments.size() + " assignments.");
    for (Assignment assignment : assignments) {
        System.out.println("DEBUG: Assignment: " + assignment.getTitle()  );
    }

    String successMessage = request.getParameter("success");
    String errorMessage = request.getParameter("error");
    String message = request.getParameter("message");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>🚀 Student Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #F8F9FA;
            color: #2C3E50;
        }
        .navbar {
            background: #1B3A57;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            padding: 0.8rem;
        }
        .navbar-brand {
            font-weight: bold;
        }
        .card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-top: 20px;
        }
        .table th {
            background: #1B3A57;
            color: white;
            font-weight: 600;
            padding: 12px;
        }
        .table td {
            background: #F8F9FA;
            padding: 12px;
            border: none;
        }
        .btn-primary {
            background: #1B3A57;
            border-radius: 6px;
        }
        .btn-primary:hover {
            background: #154263;
        }
        .btn-danger {
            background: #C0392B;
            border-radius: 6px;
        }
        .btn-danger:hover {
            background: #A93226;
        }
        footer {
            background: none; /* Removes the background color */
            color: #4A6572; /* A soft dark grey-blue */
            padding: 10px 0; /* Keeps minimal padding */
            font-size: 0.85em; /* Slightly smaller text */
            text-align: center; /* Centers the text */
            width: 100%; /* Ensures it spans the bottom but doesn't look like a box */
            box-shadow: none; /* Removes any shadows */
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="#">Student Dashboard</a>
        <a href="logout" class="btn btn-danger">Log Out</a>
    </div>
</nav>

<div class="container">
    <div class="card">
        <h2 class="text-center">Student Dashboard</h2>
        <p class="text-center">Welcome, <strong><%= user.getName() %>!</strong></p>

        <% if (successMessage != null && successMessage.equals("true")) { %>
        <div class="alert alert-success">
            <strong>Success!</strong> <%= message %>
        </div>
        <% } %>

        <% if (errorMessage != null && errorMessage.equals("true")) { %>
        <div class="alert alert-danger">
            <strong>Error!</strong> <%= message %>
        </div>
        <% } %>

        <h4 class="text-center text-secondary">
            Available Assignments for <%= className %>
            <%if (enrolledClass == null) {%>
            <small class="text-muted">(Enroll in a class to see assignment)</small>
            <%}%>
        </h4>

        <table class="table mt-4">
            <thead>
            <tr>
                <th>Title</th>
                <th>Deadline</th>
                <th>Submission</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <% for (Assignment assignment : assignments) {
                Submission submission = submissionDAO.getSubmissionByStudentAndAssignment(user.getId(), assignment.getId());
            %>
            <tr>
                <td><%= assignment.getTitle() %></td>
                <td><%= assignment.getDeadline() %></td>
                <td>
                    <% if (submission != null) { %>
                    Submitted (<a href="<%= submission.getFilePath() %>" target="_blank">View</a>)
                    <% } else { %>
                    Not yet
                    <% } %>
                </td>
                <td>
                    <% if (submission == null) { %>
                    <form action="UploadSubmissionServlet" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="assignmentId" value="<%= assignment.getId() %>">
                        <input type="file" name="file" required>
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </form>
                    <% } else { %>
                    <button class="btn btn-secondary" disabled>Already Submitted</button>
                    <% } %>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="footer.jsp" />

</body>
</html>
