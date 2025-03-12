<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="${sessionScope.lang != null ? sessionScope.lang : 'en'}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key="portal.title" /></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #1A2330;
            color: #FFFFFF;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .navbar {
            background: transparent;
            padding: 1rem;
            position: absolute;
            width: 100%;
            z-index: 1000;
        }
        .navbar-brand {
            color: #FFFFFF;
            font-weight: 700;
            font-size: 24px;
            transition: color 0.3s;
        }
        .navbar-brand:hover {
            color: #87CEEB;
        }
        .hero {
            background: #1A2330;
            color: #FFFFFF;
            text-align: left;
            padding: 100px 20px 150px;
            position: relative;
            overflow: hidden;
            min-height: 100vh;
        }
        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"%3E%3Cpath fill="%232C3E50" fill-opacity="0.5" d="M0,64L48,80C96,96,192,128,288,128C384,128,480,96,576,85.3C672,75,768,85,864,96C960,107,1056,117,1152,122.7C1248,128,1344,128,1392,128L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"%3E%3C/path%3E%3C/svg%3E');
            background-size: cover;
            opacity: 0.3;
            z-index: 0;
        }
        .hero-content {
            position: relative;
            z-index: 1;
        }
        .hero h1 {
            font-size: 58px;
            font-weight: 600;
            line-height: 1.2;
            margin-bottom: 20px;
            color: #FFFFFF;
            animation: fadeInUp 1.5s ease-out, float 3s ease-in-out infinite;
        }
        .highlight-text {
            font-size: 52px;
            font-weight: 700;
            -webkit-text-stroke: 2px #FFFFFF;
            color: transparent;
            letter-spacing: 2px;
            line-height: 1;
            display: inline-block;

        }
        .highlight-text::after {
            content: '.';
            font-size: 72px;
            color: #FFFFFF;

            margin-left: 5px;
        }
        .hero p {
            font-size: 18px;
            margin-bottom: 30px;
            color: #D3D3D3;
            animation: fadeInUp 2s ease-out;
        }
        .btn-custom {
            background-color: white;
            color: #1A2330;
            border: 2px solid #FFFFFF;
            border-radius: 25px;
            padding: 10px 25px;
            font-size: 16px;
            font-weight: 600;
            transition: 0.3s;
            text-decoration: none;
            display: inline-block;
            margin-right: 20px;
            animation: fadeInUp 2.5s ease-out;
        }
        .btn-custom:hover {
            background: transparent;
            color: #FFFFFF;
            transform: scale(1.05);
        }
        .btn-video {
            background: transparent;
            color: #FFFFFF;
            border: none;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            transition: 0.3s;
            animation: fadeInUp 2.5s ease-out;
        }
        .btn-video:hover {
            color: #87CEEB;
        }
        .btn-video i {
            margin-right: 8px;
            font-size: 20px;
        }
        .language-switcher {
            position: absolute;
            top: 20px;
            right: 20px;
            z-index: 1000;
        }
        .language-switcher a {
            color: #FFFFFF;
            margin-left: 10px;
            text-decoration: none;
        }
        .language-switcher a.active {
            font-weight: bold;
            color: #87CEEB;
        }
        .features {
            padding: 50px 20px;
            text-align: center;
            background: #2C3E50;
        }
        .feature-item {
            background: #34495E;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin: 20px 0;
            transition: transform 0.3s;
            color: #FFFFFF;
        }
        .feature-item:hover {
            transform: translateY(-5px);
        }
        footer {
            color: #4A6572;
            padding: 10px 0;
            font-size: 0.85em;
            text-align: center;
            width: 100%;
            background: #1A2330;
            margin-top: auto;
        }
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        @keyframes float {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-10px);
            }
        }
        @keyframes glow {
            0% {
                text-shadow: 0 0 5px #FFFFFF, 0 0 10px #FFFFFF, 0 0 20px #87CEEB;
            }
            100% {
                text-shadow: 0 0 10px #FFFFFF, 0 0 20px #87CEEB, 0 0 40px #87CEEB;
            }
        }
    </style>
</head>
<body>

<!-- Set locale and resource bundle -->
<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'en'}" />
<fmt:setBundle basename="messages" />

<nav class="navbar navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="#">Submit0.</a>
    </div>
    <div class="language-switcher">
        <a href="?lang=en" class="btn btn-link ${sessionScope.lang == 'en' ? 'active' : ''}">English</a> |
        <a href="?lang=fr" class="btn btn-link ${sessionScope.lang == 'fr' ? 'active' : ''}">Français</a>
    </div>
</nav>
<section class="hero">
    <div class="container">
        <div class="hero-content">
            <h1>Most Popular<br>Way to Submit<br><span class="highlight-text">Assignments</span></h1>
            <p><fmt:message key="portal.description" /></p>
            <div class="button-group">
                <a href="register.jsp" class="btn btn-custom"><fmt:message key="portal.register" /></a>
                <a href="#" class="btn btn-video"><i class="bi bi-play-circle"></i> Play Video</a>
            </div>
        </div>
    </div>
</section>
<section class="features">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <div class="feature-item">
                    <i class="fas fa-cloud-upload-alt fa-3x text-primary"></i>
                    <fmt:message key="portal.feature1" />
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-item">
                    <i class="fas fa-bell fa-3x text-warning"></i>
                    <fmt:message key="portal.feature2" />
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-item">
                    <i class="fas fa-user-lock fa-3x text-success"></i>
                    <fmt:message key="portal.feature2" />
                </div>
            </div>
        </div>
    </div>
</section>
<footer>
    <jsp:include page="footer.jsp" />
</footer>
</body>
</html>