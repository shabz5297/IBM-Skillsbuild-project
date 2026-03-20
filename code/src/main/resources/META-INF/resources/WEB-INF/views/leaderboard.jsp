<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Friends</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/leaderboard.css">
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
            <span class="nav-icon">⊞</span> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/home#your-courses" class="nav-item">
            <span class="nav-icon">📖</span> My Courses
        </a>
        <a href="${pageContext.request.contextPath}/home#all-courses" class="nav-item">
            <span class="nav-icon">🔍</span> Browse
        </a>
        <a href="${pageContext.request.contextPath}/leaderboard" class="nav-item active">
            <span class="nav-icon">🏆</span> Leaderboard
        </a>
        <a href="${pageContext.request.contextPath}/friends" class="nav-item">
            <span class="nav-icon">👥</span> Friends
        </a>
        <a href="${pageContext.request.contextPath}/achievements" class="nav-item">
            <span class="nav-icon">🎖️</span> Achievements
        </a>
    </aside>

    <main class="main-content">
        <div class="course-section" id="leaderboard">
            <div class="section-header">
                <h2>Global Leaderboard</h2>
                <span class="leaderboard-subtitle">Top students by points</span>
            </div>

            <div class="leaderboard-card">
                <table class="leaderboard-table">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Student</th>
                        <th>Level</th>
                        <th>Points</th>
                        <th>Badges</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="u" items="${leaderboardTop}" varStatus="status">
                        <tr class="${user != null && u.id == user.id ? 'highlight-row' : ''}">
                            <td class="rank-cell">#${status.index + 1}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${u.displayName != null && u.displayName ne ''}">
                                        ${u.displayName}
                                        <span class="muted">(@${u.username})</span>
                                    </c:when>
                                    <c:otherwise>${u.username}</c:otherwise>
                                </c:choose>
                            </td>
                            <td>${u.level}</td>
                            <td>${u.points}</td>
                            <td>
                                <c:set var="badgeCount" value="${u.badges != null ? u.badges.size() : 0}" />
                                <c:choose>
                                    <c:when test="${badgeCount == 0}">
                                        <span class="muted">None</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge-list">
                                            <c:forEach var="b" items="${u.badges}" varStatus="bStatus">
                                                <c:if test="${bStatus.index < 3}">
                                                    <span class="badge-pill">${b.name}</span>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${badgeCount > 3}">
                                                <span class="muted">+${badgeCount - 3}</span>
                                            </c:if>
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <c:if test="${user != null && userRank != null && userRank > 10}">
                    <div class="leaderboard-footer">
                        You're currently <strong>#${userRank}</strong>. Keep completing courses to climb!
                    </div>
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

</body>
</html>