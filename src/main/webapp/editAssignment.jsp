<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.app.submission.onlinesubmissionsystem_.model.Assignment, com.app.submission.onlinesubmissionsystem_.dao.AssignmentDAO, com.app.submission.onlinesubmissionsystem_.model.User" %>
<%
  User user = (User) session.getAttribute("user");
  if (user == null || user.getRole() != com.app.submission.onlinesubmissionsystem_.model.Role.INSTRUCTOR) {
    response.sendRedirect("login.jsp");
    return;
  }

  int assignmentId = Integer.parseInt(request.getParameter("assignmentId"));
  AssignmentDAO assignmentDAO = new AssignmentDAO();
  Assignment assignment = assignmentDAO.getAssignmentById((long) assignmentId);

  if (assignment == null) {
    response.sendRedirect("instructorDashboard.jsp");
    return;
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>✏️ Edit Assignment</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background: #F5F5F5; /* Light grey background */
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .card {
      background: white;
      border-radius: 12px;
      padding: 35px;
      width: 420px;
      box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1); /* Light shadow */
      text-align: center;
      color: #333; /* Dark text for readability */
    }
    .card h2 {
      font-weight: bold;
      text-transform: uppercase;
      color: #1B3A57; /* Blue color */
    }
    .form-group {
      position: relative;
      margin-bottom: 20px;
    }
    .form-control {
      border-radius: 8px;
      padding: 12px;
      font-size: 16px;
      width: 100%;
      background: #F1F1F1; /* Light grey background */
      border: 1px solid #ccc; /* Light border */
      color: #333;
      padding-left: 40px;
    }
    .form-control:focus {
      outline: none;
      border: 2px solid #1B3A57; /* Blue border on focus */
      background: #fff; /* White background on focus */
    }
    .form-group i {
      position: absolute;
      left: 15px;
      top: 50%;
      transform: translateY(-50%);
      color: #999; /* Light grey icon color */
      font-size: 16px;
    }
    .btn-primary {
      background: #1B3A57; /* Blue background */
      border: none;
      padding: 12px;
      font-size: 16px;
      font-weight: bold;
      border-radius: 8px;
      width: 100%;
      transition: 0.3s;
      color: white;
    }
    .btn-primary:hover {
      background: #003B8F; /* Darker blue on hover */
      transform: scale(1.05);
    }
    .form-footer {
      margin-top: 15px;
      text-align: center;
    }
    a {
      color: #004AAD; /* Blue color */
      text-decoration: none;
    }
    a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

<div class="card">
    <h2>Edit Assignment</h2>
    <form action="UpdateAssignmentServlet" method="post">
      <%--@declare id="title"--%><%--@declare id="description"--%><%--@declare id="deadline"--%><input type="hidden" name="assignmentId" value="<%= assignment.getId() %>">

      <label for="title">Title</label>
      <input type="text" class="form-control" name="title" value="<%= assignment.getTitle() %>" required>

      <label for="description">Description</label>
      <textarea class="form-control" name="description" rows="4" required><%= assignment.getDescription() %></textarea>

      <label for="deadline">Deadline</label>
      <input type="datetime-local" class="form-control" name="deadline" value="<%= assignment.getDeadline().toString().replace("T", " ") %>" required>

      <button type="submit" class="btn-primary pt-10">Update Assignment</button>
      <a href="instructorDashboard.jsp" class="btn-outline-danger">Cancel</a>
    </form>
</div>

</body>
</html>
