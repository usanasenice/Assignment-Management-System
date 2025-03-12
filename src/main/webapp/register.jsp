<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="${sessionScope.lang != null ? sessionScope.lang : 'en'}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key="register.header" /></title>
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

<!-- Set locale and resource bundle -->
<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'en'}" />
<fmt:setBundle basename="messages" />

<div class="card">
    <!-- You can optionally add language switcher links at the top -->
    <div class="mb-3">
        <a href="?lang=en" class="${sessionScope.lang == 'en' ? 'active' : ''}">English</a> |
        <a href="?lang=fr" class="${sessionScope.lang == 'fr' ? 'active' : ''}">Français</a>
    </div>

    <h2><fmt:message key="register.header" /></h2>

    <form action="RegisterServlet" method="post">
        <div class="form-group">
            <i class="fas fa-user"></i>
            <input type="text" class="form-control" name="name" required placeholder="<fmt:message key='register.fullName' />">
        </div>
        <div class="form-group">
            <i class="fas fa-envelope"></i>
            <input type="email" class="form-control" name="email" required placeholder="<fmt:message key='register.email' />">
        </div>
        <div class="form-group">
            <i class="fas fa-lock"></i>
            <input type="password" class="form-control" name="password" required placeholder="<fmt:message key='register.password' />">
        </div>
        <div class="form-group">
            <i class="fas fa-user-tag"></i>
            <select class="form-control" name="role" required>
                <option value="" disabled selected><fmt:message key="register.selectRole" /></option>
                <option value="STUDENT"><fmt:message key="register.role.student" /></option>
                <option value="INSTRUCTOR"><fmt:message key="register.role.instructor" /></option>
            </select>
        </div>
        <div class="form-group" id="classGroup">
            <i class="fas fa-users-class"></i>
            <select name="classId" class="form-control" id="classSelect">
                <option value="" disabled selected>Select Class</option>
                <option value="1">Year 2A</option>
                <option value="2">Year 2B</option>
                <option value="3">Year 2C</option>
                <option value="4">Year 2D</option>
            </select>
        </div>

        <button type="submit" class="btn-primary"><fmt:message key="register.signUp" /></button>
    </form>

    <div class="form-footer">
        <p>
            <fmt:message key="register.existingAccount" /> <a href="login.jsp"><fmt:message key="login.signIn" /></a>
        </p>
    </div>
</div>

</body>
</html>
