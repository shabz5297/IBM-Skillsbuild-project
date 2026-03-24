<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Leaderboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/leaderboard.css">
</head>
<body>

<div class="topbar">
    <div class="left">
        <a href="${pageContext.request.contextPath}/home" class="brand">
            <div class="brand-icon">
                <img src="${pageContext.request.contextPath}/images/ibm-logo2.png" alt="IBM Logo"/>
            </div>
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
                <div>
                    <h2>${filterTitle}</h2>
                    <span class="leaderboard-subtitle">${filterSubtitle}</span>
                </div>
                <div class="leaderboard-filters">
                    <c:choose>
                        <c:when test="${currentFilter == 'friends'}">
                            <a href="${pageContext.request.contextPath}/leaderboard?filter=global" class="filter-btn">🌍 Global</a>
                            <button class="filter-btn active" disabled>👥 Friends</button>
                        </c:when>
                        <c:otherwise>
                            <button class="filter-btn active" disabled>🌍 Global</button>
                            <c:if test="${user != null}">
                                <a href="${pageContext.request.contextPath}/leaderboard?filter=friends" class="filter-btn">👥 Friends</a>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>
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
                        <tr class="${user != null and u.id == user.id ? 'highlight-row' : ''}">
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

                <c:choose>
                    <c:when test="${currentFilter == 'friends' and user != null and userRank != null and userRank > 10}">
                        <div class="leaderboard-footer">
                            You're ranked <strong>#${userRank}</strong> among your friends.
                        </div>
                    </c:when>
                    <c:when test="${currentFilter == 'global' and user != null and userRank != null and userRank > 10}">
                        <div class="leaderboard-footer">
                            You're currently <strong>#${userRank}</strong> globally. Keep completing courses to climb!
                        </div>
                    </c:when>
                    <c:when test="${currentFilter == 'friends' && empty leaderboardTop}">
                        <div class="leaderboard-footer">
                            No friends yet? <a href="${pageContext.request.contextPath}/friends">Add friends →</a> to see them here!
                        </div>
                    </c:when>
                </c:choose>
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

</body>
</html>