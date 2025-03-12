<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Assignments</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1>Your Assignments</h1>

    <!-- Add Button for New Assignment -->
    <a href="createAssignment.jsp" class="btn btn-primary mb-3">+ Create New Assignment</a>

    <!-- Display Assignments in a Table -->
    <table class="table table-striped">
        <thead>
        <tr>
            <th>#</th>
            <th>Title</th>
            <th>Description</th>
            <th>Due Date</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <!-- Dynamically Render Assignment Rows -->
        <c:forEach var="assignment" items="${assignments}">
            <tr>
                <td>${assignment.id}</td>
                <td>${assignment.title}</td>
                <td>${assignment.description}</td>
                <td>${assignment.dueDate}</td>
                <td>
                    <a href="viewAssignment?id=${assignment.id}" class="btn btn-info btn-sm">View</a>
                    <a href="editAssignment?id=${assignment.id}" class="btn btn-warning btn-sm">Edit</a>
                    <a href="deleteAssignment?id=${assignment.id}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this assignment?')">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</div>
</body>
</html>
