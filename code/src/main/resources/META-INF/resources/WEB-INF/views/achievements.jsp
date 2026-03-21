<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Friends</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/achievements.css">
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
        <button class="theme-toggle" id="themeToggle" onclick="toggleTheme()">☀️ Light</button>
        <form action="${pageContext.request.contextPath}/logout" method="post">
            <button class="logout-btn">Logout</button>
        </form>
        <a href="${pageContext.request.contextPath}/profile" class="profile-btn">Profile ⚙</a>
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

                    <!-- Beginner Badge -->
                    <div class="badge-card ${user.progress < 25 ? 'locked' : ''}"
                         data-lock-text="Unlock at 25%">
                        🌱 Beginner
                        <c:if test="${user.progress < 25}">
                            <span class="lock">🔒</span>
                        </c:if>
                    </div>

                    <!-- Explorer Badge -->
                    <div class="badge-card ${user.progress < 50 ? 'locked' : ''}"
                         data-lock-text="Unlock at 50%">
                        🚀 Explorer
                        <c:if test="${user.progress < 50}">
                            <span class="lock">🔒</span>
                        </c:if>
                    </div>

                    <!-- Achiever Badge -->
                    <div class="badge-card ${user.progress < 75 ? 'locked' : ''}"
                         data-lock-text="Unlock at 75%">
                        🔥 Achiever
                        <c:if test="${user.progress < 75}">
                            <span class="lock">🔒</span>
                        </c:if>
                    </div>

                    <!-- Master Badge -->
                    <div class="badge-card ${user.progress < 100 ? 'locked' : ''}"
                         data-lock-text="Unlock at 100%">
                        🏆 Master
                        <c:if test="${user.progress < 100}">
                            <span class="lock">🔒</span>
                        </c:if>
                    </div>

                </div>

                <c:if test="${empty user.badges}">
                    <p class="no-badges" style="margin-top: 16px;">No badges earned yet. Complete courses to unlock achievements!</p>
                </c:if>
            </div>
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

</body>
</html>