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
                <c:set var="hasBeginner" value="false"/>
                <c:set var="hasExplorer" value="false"/>
                <c:set var="hasSocializer" value="false"/>
                <c:set var="hasFirstLogin" value="false"/>

                <c:forEach var="badge" items="${user.badges}">
                    <c:if test="${badge.name == 'Beginner'}">
                        <c:set var="hasBeginner" value="true"/>
                    </c:if>
                    <c:if test="${badge.name == 'Explorer'}">
                        <c:set var="hasExplorer" value="true"/>
                    </c:if>
                    <c:if test="${badge.name == 'Socializer'}">
                        <c:set var="hasSocializer" value="true"/>
                    </c:if>
                    <c:if test="${badge.name == 'First Login'}">
                        <c:set var="hasFirstLogin" value="true"/>
                    </c:if>
                </c:forEach>

                <div class="badges-grid">
                    <!-- First Login Badge -->
                    <div class="badge-card ${!hasFirstLogin ? 'locked' : 'earned'}"
                         data-lock-text="Unlocks after first login">
                        🎉 First Login
                        <c:if test="${!hasFirstLogin}">
                            <span class="lock">🔒</span>
                        </c:if>
                    </div>

                    <!-- Beginner Badge -->
                    <div class="badge-card ${!hasBeginner ? 'locked' : 'earned'}"
                         data-lock-text="Unlocks after 1 completed course">
                        🌱 Beginner
                        <c:if test="${!hasBeginner}">
                            <span class="lock">🔒</span>
                        </c:if>
                    </div>

                    <!-- Explorer Badge -->
                    <div class="badge-card ${!hasExplorer ? 'locked' : 'earned'}"
                         data-lock-text="Unlocks after 3 completed courses">
                        🚀 Explorer
                        <c:if test="${!hasExplorer}">
                            <span class="lock">🔒</span>
                        </c:if>
                    </div>

                    <!-- Socializer Badge -->
                    <div class="badge-card ${!hasSocializer ? 'locked' : 'earned'}"
                         data-lock-text="Unlock after a sent/received friend request">
                        🤝 Socializer
                        <c:if test="${!hasSocializer}">
                            <span class="lock">🔒</span>
                        </c:if>
                    </div>
                </div>
            </div>


    </main>
</div>

<script>
    /* ── Theme toggle (matches home.css logic) ── */
    function toggleTheme() {
        document.body.classList.toggle('light-mode');
        const btn = document.querySelector('.theme-toggle');
        btn.textContent = document.body.classList.contains('light-mode') ? '🌙 Dark' : '☀️ Light';
        localStorage.setItem('theme', document.body.classList.contains('light-mode') ? 'light' : 'dark');
    }
    if (localStorage.getItem('theme') === 'light') {
        document.body.classList.add('light-mode');
        document.querySelector('.theme-toggle').textContent = '🌙 Dark';
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