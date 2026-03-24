<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Achievements</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/achievements.css">
    <meta charset="UTF-8">
</head>
<body>

<div class="topbar">
    <div class="left">
        <a href="${pageContext.request.contextPath}/home" class="brand">
            <div class="brand-icon">🔥</div>
            IBM SkillsBuild
        </a>
    </div>

    <div class="right">
        <button class="theme-toggle" onclick="toggleTheme()">☀️ Light</button>
        <c:if test="${user != null}">
            <a href="/profile/${user.id}" class="profile-btn">👤 ${user.username}</a>
        </c:if>
        <form action="${pageContext.request.contextPath}/logout" method="post">
            <button class="logout-btn">Logout</button>
        </form>
    </div>
</div>

<div class="page-wrapper">

    <aside class="sidebar">
        <a href="${pageContext.request.contextPath}/home" class="nav-item">
            <span class="nav-icon">🏠</span> Home
        </a>
        <a href="${pageContext.request.contextPath}/home#your-courses" class="nav-item">
            <span class="nav-icon">📖</span> My Courses
        </a>
        <a href="${pageContext.request.contextPath}/browse" class="nav-item">
            <span class="nav-icon">🔍</span> Browse
        </a>
        <a href="${pageContext.request.contextPath}/goals" class="nav-item">
            <span class="nav-icon">🎯</span> Goals
        </a>
        <a href="${pageContext.request.contextPath}/leaderboard" class="nav-item">
            <span class="nav-icon">🏆</span> Leaderboard
        </a>
        <a href="${pageContext.request.contextPath}/friends" class="nav-item">
            <span class="nav-icon">👥</span> Friends
        </a>
        <a href="${pageContext.request.contextPath}/achievements" class="nav-item active">
            <span class="nav-icon">🎖️</span> Achievements
        </a>
    </aside>

    <main class="main-content">
        <div class="course-section" id="leaderboard">
            <div class="section-header">
                <h2>Achievements</h2>
                <span class="leaderboard-subtitle">Badges earned by you</span>
            </div>

            <!-- Badges Section -->
            <div class="card">
                <h3>Achievements</h3>
                <div class="badges-grid">
                    <c:forEach var="badge" items="${user.badges}">
                        <div class="badge-card unlocked">

                            <c:choose>
                                <c:when test="${badge.name == 'First Login'}">🎉</c:when>
                                <c:when test="${badge.name == 'Beginner'}">🌱</c:when>
                                <c:when test="${badge.name == 'Explorer'}">🚀</c:when>
                                <c:when test="${badge.name == 'Socializer'}">🤝</c:when>
                            </c:choose>

                                ${badge.name}
                        </div>
                    </c:forEach>
                </div>
                <c:if test="${empty user.badges}">
                    <p class="no-badges">No badges earned yet.</p>
                </c:if>
            </div>

        </div>
    </main>
</div>

<script>
    function toggleTheme() {
        const isLight = document.body.classList.toggle('light-mode');
        document.getElementById('themeToggle').textContent = isLight ? '🌙 Dark' : '☀️ Light';
        localStorage.setItem('theme', isLight ? 'light' : 'dark');
    }

    if (localStorage.getItem('theme') === 'light') {
        document.body.classList.add('light-mode');
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('themeToggle').textContent = '🌙 Dark';
        });
    }
</script>
<c:if test="${badgeCelebration != null}">
    <div class="badge-popup">
        🎉 New Badge: ${badgeCelebration}!
    </div>
    <script>
        alert("🎉 You unlocked: ${badgeCelebration}!")
    </script>
</c:if>
</body>
</html>