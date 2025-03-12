<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, com.app.submission.onlinesubmissionsystem_.model.Assignment, com.app.submission.onlinesubmissionsystem_.dao.AssignmentDAO, com.app.submission.onlinesubmissionsystem_.model.User" %>
<%@ page import="com.app.submission.onlinesubmissionsystem_.dao.UserDAO" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || user.getRole() != com.app.submission.onlinesubmissionsystem_.model.Role.INSTRUCTOR) {
        response.sendRedirect("login.jsp");
        return;
    }

    AssignmentDAO assignmentDAO = new AssignmentDAO();
    List<Assignment> assignments = assignmentDAO.getAssignmentsByInstructor(user);

    UserDAO userDAO = new UserDAO();
    long studentCount = userDAO.getStudentCount();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instructor Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f4f6f9;
            display: flex;
            height: 100vh;
            overflow: hidden;
        }
        .sidebar {
            width: 250px;
            background: #2d4059;
            color: white;
            padding: 20px;
            position: fixed;
            height: 100%;
        }
        .sidebar a {
            color: white;
            display: block;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            text-decoration: none;
        }
        .sidebar a:hover {
            background: #1a2a3a;
        }
        .content {
            margin-left: 270px;
            padding: 20px;
            flex-grow: 1;
            overflow-y: auto;
        }
        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .table th {
            background: #2d4059;
            color: white;
        }
    </style>
</head>
<body>

<div class="sidebar">
    <h3><i class="fas fa-user-tie"></i> Instructor Panel</h3>
    <a href="#"><i class="fas fa-home"></i> Dashboard</a>

    <a href="createAssignment.jsp"><i class="fas fa-plus"></i> Create Assignment</a>
    <a href="#"><i class="fas fa-home"></i> Manage Assignments</a>
    <a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>
<div class="content">

    <div class="dashboard-header">
        <h2>Instructor Dashboard</h2>
        <p>Welcome, <strong><%= user.getName() %></strong>!</p>
    </div>

    <div class="row">
        <div class="col-sm-6">
            <div class="card bg-light mb-3">
                <div class="card-header">Assignment</div>
                <div class="card-body">
                    <h5 class="card-title">Total students</h5>
                    <p class="card-text"><%= studentCount %></p>
                </div>
            </div>
        </div>
        <div class="col-sm-6">
            <div class="card bg-light mb-3">
                <div class="card-header">Assignment</div>
                <div class="card-body">
                    <h5 class="card-title">Total Assignments</h5>
                    <p class="card-text"><%= assignments.size() %></p>
                </div>
            </div>
        </div>
    </div>

    <div class="card p-4">
        <h4 class="mb-3">Your Assignments</h4>
        <table class="table">
            <thead>
            <tr>
                <th>Title</th>
                <th>Deadline</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for (Assignment assignment : assignments) { %>
            <tr>
                <td><%= assignment.getTitle() %></td>
                <td><%= assignment.getDeadline() %></td>
                <td>
                    <a href="viewSubmissions.jsp?assignmentId=<%= assignment.getId() %>" class="btn btn-secondary btn-sm">
                        View submissions
                    </a>
                    <a href="editAssignment.jsp?assignmentId=<%= assignment.getId() %>" class="btn btn-light btn-sm">
                        Edit
                    </a>
                    <a href="DeleteAssignmentServlet?assignmentId=<%= assignment.getId() %>" class="btn btn-outline-danger btn-sm" onclick="return confirm('Are you sure?')">
                        Delete
                    </a>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
