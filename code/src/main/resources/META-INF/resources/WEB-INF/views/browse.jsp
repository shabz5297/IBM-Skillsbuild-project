<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Browse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
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

<main class="page-wrapper">

    <aside class="sidebar">
        <a href="${pageContext.request.contextPath}/home" class="nav-item">
            <span class="nav-icon">🏠</span> Home
        </a>
        <a href="${pageContext.request.contextPath}/home#your-courses" class="nav-item">
            <span class="nav-icon">📖</span> My Courses
        </a>
        <a href="${pageContext.request.contextPath}/browse" class="nav-item active">
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
        <a href="${pageContext.request.contextPath}/achievements" class="nav-item">
            <span class="nav-icon">🎖️</span> Achievements
        </a>
    </aside>

    <main class="main-content">
        <div class="course-section" id="all-courses">
            <div class="section-header">
                <h2>All Courses</h2>
                <form action="${pageContext.request.contextPath}/browse" method="get" class="filter-bar">
                    <input type="text" name="query" placeholder="Search..." value="${param.query}" />
                    <select name="category">
                        <option value="">All</option>
                        <option value="AI" ${param.category == 'AI' ? 'selected' : ''}>AI</option>
                        <option value="Cloud" ${param.category == 'Cloud' ? 'selected' : ''}>Cloud</option>
                        <option value="Data Science" ${param.category == 'Data Science' ? 'selected' : ''}>Data Science</option>
                        <option value="Security" ${param.category == 'Security' ? 'selected' : ''}>Security</option>
                        <option value="Development" ${param.category == 'Development' ? 'selected' : ''}>Development</option>
                        <option value="Business" ${param.category == 'Business' ? 'selected' : ''}>Business</option>
                        <option value="Emerging Tech" ${param.category == 'Emerging Tech' ? 'selected' : ''}>Emerging Tech</option>
                    </select>
                    <button type="submit">Search</button>
                </form>
            </div>

            <c:if test="${empty courses}">
                <p style="color: var(--text-muted); font-size: 14px;">No courses found. Try a different search or clear filters.</p>
            </c:if>

            <div class="course-grid">
                <c:forEach var="course" items="${courses}">
                    <div class="course-card">
                        <h3>${course.title}</h3>
                        <p class="category">${course.category}</p>
                        <p>${course.description}</p>

                        <div class="course-actions">
                            <a class="start-btn" href="${course.link}" target="_blank">Start Course →</a>

                            <c:set var="isSaved" value="${savedCourseIds.contains(course.id)}" />
                            <form action="${pageContext.request.contextPath}/${isSaved ? 'removeCourse' : 'saveCourse'}" method="post" class="save-form">
                                <input type="hidden" name="courseId" value="${course.id}" />
                                <button type="submit" class="save-btn" title="${isSaved ? 'Remove course' : 'Save course'}">
                                    <c:choose>
                                        <c:when test="${isSaved}">⭐</c:when>
                                        <c:otherwise>☆</c:otherwise>
                                    </c:choose>
                                </button>
                            </form>

                            <c:set var="isCompleted" value="${completedCourseIds.contains(course.id)}" />
                            <c:choose>
                                <c:when test="${isCompleted}">
                                        <span class="completed-badge">
                                            Completed ✅
                                            <c:if test="${completionTimestamps[course.id] != null}">
                                                <small>(${completionTimestamps[course.id]})</small>
                                            </c:if>
                                        </span>
                                </c:when>
                                <c:otherwise>
                                    <form action="${pageContext.request.contextPath}/completeCourse" method="post" class="complete-form">
                                        <input type="hidden" name="courseId" value="${course.id}" />
                                        <button type="submit" class="complete-btn">Mark Completed</button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </main>
</main>

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