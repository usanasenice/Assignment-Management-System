<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.app.submission.onlinesubmissionsystem_.model.User" %>
<%@ page import="com.app.submission.onlinesubmissionsystem_.model.ClassEntity" %>
<%@ page import="com.app.submission.onlinesubmissionsystem_.dao.ClassDAO" %>
<%--<%@ page import="jakarta.servlet.jsp.PageContext" %>--%>
<%@ page import="java.util.List" %>
<%@ page import="com.app.submission.onlinesubmissionsystem_.model.Role" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || user.getRole() != Role.INSTRUCTOR) {
        response.sendRedirect("logout");
    } else {
        ClassDAO classDao = new ClassDAO();
        List<ClassEntity> classes = classDao.getAllClasses();
        if (classes == null) {
            classes = new ArrayList<>();
        }
        System.out.println("DEBUG: Number of classes: " + classes.size());
        request.setAttribute("classes", classes);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>:book: Create Assignment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #F8F9FA;
            color: rgba(0, 40, 73, 0.95);
        }
        .navbar {
            background: #1B3A57;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            padding: 0.8rem;
        }
        .navbar-brand {
            font-weight: bold;
        }
        .assignment-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 12px;
            width: 90%;
            max-width: 600px;
            box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.1);
            margin: 0 auto;
            animation: fadeIn 0.8s ease-in-out;
        }
        h2 {
            font-size: 24px;
            font-weight: 600;
            text-align: center;
            color: #34495E;
            margin-bottom: 1.5rem;
        }
        .form-control {
            background: rgba(255, 255, 255, 0.9);
            border: 1px solid #ddd;
            color: #333;
            padding: 12px;
            border-radius: 8px;
            transition: 0.3s;
        }
        .form-control:focus {
            border: 1px solid #34495E;
            box-shadow: 0px 0px 8px rgba(0, 119, 182, 0.5);
            outline: none;
        }
        .btn-glow {
            background: #34495E;
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 8px;
            transition: 0.3s;
            width: 100%;
        }
        .btn-glow:hover {
            background: #005F87;
            transform: scale(1.05);
            box-shadow: 0px 5px 15px rgba(0, 119, 182, 0.4);
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#"><i class="fas fa-user-tie"></i> Instructor Panel</a>
        <a href="logout" class="btn btn-danger"><i class="fas fa-sign-out-alt"></i> Log Out</a>
    </div>
</nav>
<div class="container">
    <div class="assignment-container">
        <h2>:Create Assignment</h2>
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger" role="alert">${param.error}</div>
        </c:if>
        <form action="createAssignment" method="post">
            <div class="mb-3">
                <label for="title" class="form-label">Title:</label>
                <input type="text" class="form-control" id="title" name="title" required>
            </div>
            <div class="mb-3">
                <label for="description" class="form-label">Description:</label>
                <textarea class="form-control" id="description" name="description" rows="4" required></textarea>
            </div>
            <div class="mb-3">
                <label for="deadline" class="form-label">Deadline:</label>
                <input type="datetime-local" class="form-control" id="deadline" name="deadline" required>
            </div>
            <div class="mb-3">
                <label for="classes" class="form-label">Assign to Classes:</label>
                <select class="form-control" id="classes" name="classIds" multiple required>
                    <c:forEach var="cls" items="${classes}">
                        <option value="${cls.id}">${cls.className}</option>
                    </c:forEach>
                </select>
                <small class="form-text text-muted">Hold Ctrl (Cmd on Mac) to select multiple classes.</small>
            </div>

            <button type="submit" class="btn-glow">Create Assignment</button>
        </form>
    </div>
</div>

<script>
    window.onload = function () {
        var now = new Date();
        var year = now.getFullYear();
        var month = String(now.getMonth() + 1).padStart(2, '0');
        var day = String(now.getDate()).padStart(2, '0');
        var hours = String(now.getHours()).padStart(2, '0');
        var minutes = String(now.getMinutes()).padStart(2, '0');
        var dateTime = year + '-' + month + '-' + day + 'T' + hours + ':' + minutes;
        document.getElementById("deadline").setAttribute("min", dateTime);
    }
</script>
</body>
</html>