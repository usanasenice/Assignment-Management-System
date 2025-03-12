<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'en'}" />
<fmt:setBundle basename="messages" />

<%@ page import="com.app.submission.onlinesubmissionsystem_.dao.SubmissionDAO,
                 com.app.submission.onlinesubmissionsystem_.dao.AssignmentDAO,
                 com.app.submission.onlinesubmissionsystem_.model.Submission,
                 com.app.submission.onlinesubmissionsystem_.model.Assignment,
                 java.util.List,
                 com.app.submission.onlinesubmissionsystem_.model.User" %>

<%
    // Authenticate user (only instructors can review assignments)
    User user = (User) session.getAttribute("user");
    if (user == null || user.getRole() != com.app.submission.onlinesubmissionsystem_.model.Role.INSTRUCTOR) {
        response.sendRedirect("login.jsp");
        return;
    }

    String assignmentId = request.getParameter("assignmentId");
    if (assignmentId == null || assignmentId.isEmpty()) {
        request.setAttribute("errorMessage", "Error: Missing assignment ID.");
        request.getRequestDispatcher("errorPage.jsp").forward(request, response);
        return;
    }

    AssignmentDAO assignmentDAO = new AssignmentDAO();
    SubmissionDAO submissionDAO = new SubmissionDAO();
    Assignment assignment = assignmentDAO.getAssignmentById(Long.parseLong(assignmentId));
    List<Submission> submissions = submissionDAO.getSubmissionsByAssignment(Long.parseLong(assignmentId));
%>

<!DOCTYPE html>
<html lang="${sessionScope.lang != null ? sessionScope.lang : 'en'}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key="assignment.review.title" /></title>
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
        <a class="navbar-brand" href="#">Instructor Panel</a>
        <a href="logout" class="btn btn-danger">Log Out</a>
    </div>
</nav>

<div class="container">
    <div class="card">
        <h2 class="text-center"><fmt:message key="assignment.review.header" /></h2>
        <h4 class="text-center text-secondary">
            <fmt:message key="assignment.review.assignmentHeader">
                <fmt:param value="<%= assignment.getTitle() %>" />
            </fmt:message>
        </h4>

        <!-- 📑 Submissions Table -->
        <div class="mt-4">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th><fmt:message key="assignment.table.studentName" /></th>
                    <th><fmt:message key="assignment.table.submittedAt" /></th>
                    <th><fmt:message key="assignment.table.status" /></th>
                    <th><fmt:message key="assignment.table.action" /></th>
                </tr>
                </thead>
                <tbody>
                <% for (Submission submission : submissions) { %>
                <tr>
                    <td><strong><i class="fas fa-user"></i> <%= submission.getStudent().getName() %></strong></td>
                    <td><i class="fas fa-clock"></i> <%= submission.getSubmittedAt()
                            .format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy HH:mm")) %></td>
                    <td>
                        <% if (submission.getSubmittedAt().isBefore(assignment.getDeadline())) { %>
                        <span class="status-on-time"><i class="fas fa-check-circle"></i> <fmt:message key="assignment.status.onTime" /></span>
                        <% } else { %>
                        <span class="status-late"><i class="fas fa-exclamation-triangle"></i> <fmt:message key="assignment.status.late" /></span>
                        <% } %>
                    </td>
                    <td>
                        <a href="<%= submission.getFilePath() %>" download class="btn btn-info btn-sm">
                            <i class="fas fa-download"></i> <fmt:message key="assignment.download" />
                        </a>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <!-- 🔙 Back Button -->
        <div class="text-center mt-4">
            <a href="instructorDashboard.jsp" class="custom-btn">
                <i class="fas fa-arrow-left"></i> <fmt:message key="assignment.back" />
            </a>
        </div>
    </div>
</div>
</body>
</html>
