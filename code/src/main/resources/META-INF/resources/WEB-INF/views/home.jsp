<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>

<body>

<!-- TOPBAR -->
<div class="topbar">
    <div class="left">
        <form action="${pageContext.request.contextPath}/logout" method="post">
            <button class="logout-btn">Logout</button>
        </form>
    </div>
    <div class="right">
        <a href="${pageContext.request.contextPath}/profile" class="profile-btn">Profile ⚙</a>
    </div>
</div>

<!-- DASHBOARD HEADER -->
<div class="dashboard-header">
    <h1>
        Welcome back
        <c:if test="${user != null}">
            , ${user.username}
        </c:if>
        👋
    </h1>
    // leaderboard labels
    <c:if test="${user != null}">
        <div class="quick-stats">
            <div class="stat-card">
                <div class="stat-label">Level</div>
                <div class="stat-value">${user.level}</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Points</div>
                <div class="stat-value">${user.points}</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Your Rank</div>
                <div class="stat-value">
                    <c:choose>
                        <c:when test="${userRank != null}">#${userRank}</c:when>
                        <c:otherwise>—</c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </c:if>
</div>

<!-- YOUR COURSES SECTION -->
<div class="course-section">
    <!-- Global leaderboard section-->
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
                            <c:otherwise>
                                ${u.username}
                            </c:otherwise>
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
                You’re currently <strong>#${userRank}</strong>. Keep completing courses to climb!
            </div>
        </c:if>
    </div>
</div>

    <h2>Your Courses</h2>
    <div class="course-grid">
        <c:forEach var="course" items="${savedCourses}">
            <div class="course-card saved">
                <h3>${course.title}</h3>
                <p class="category">${course.category}</p>
                <p>${course.description}</p>
                <div class="course-actions">
                    <a class="start-btn" href="${course.link}" target="_blank">Start Course →</a>
                    <!-- REMOVE BUTTON -->
                    <form action="${pageContext.request.contextPath}/removeCourse" method="post">
                        <input type="hidden" name="courseId" value="${course.id}" />
                        <button type="submit" class="trash-btn">🗑</button>
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
                            <form action="${pageContext.request.contextPath}/completeCourse"
                                  method="post"
                                  class="complete-form">
                                <input type="hidden" name="courseId" value="${course.id}" />
                                <button type="submit" class="complete-btn">
                                    Mark Completed
                                </button>
                            </form>
                        </c:otherwise>
                    </c:choose>

                </div>
            </div>
        </c:forEach>

        <c:if test="${empty savedCourses}">
            <p>No courses saved yet. Click the ⭐ button on any course below to add it here!</p>
        </c:if>
    </div>
</div>

<!-- ALL COURSES SECTION -->
<div class="course-section">

    <div class="section-header">
        <h2>All Courses</h2>

        <form action="${pageContext.request.contextPath}/home" method="get" class="filter-bar">
            <input type="text" name="query" placeholder="Search..." value="${param.query}" />

            <select name="category">
                <option value="">All</option>
                <option value="AI" ${param.category == 'AI' ? 'selected' : ''}>AI</option>
                <option value="Cloud" ${param.category == 'Cloud' ? 'selected' : ''}>Cloud</option>
                <option value="Data Science" ${param.category == 'Data Science' ? 'selected' : ''}>Data Science</option>
                <option value="Security" ${param.category == 'Security' ? 'selected' : ''}>Security</option>
            </select>

            <button type="submit">Search</button>
        </form>
    </div>

    <c:if test="${empty courses}">
        <p>No courses found. Try a different search or clear filters.</p>
    </c:if>

    <div class="course-grid">
        <c:forEach var="course" items="${courses}">
            <div class="course-card">
                <h3>${course.title}</h3>
                <p class="category">${course.category}</p>
                <p>${course.description}</p>

                <div class="course-actions">
                    <a class="start-btn" href="${course.link}" target="_blank">Start Course →</a>

                    <!-- Save/Unsave (STAR) -->
                    <c:set var="isSaved" value="${savedCourseIds.contains(course.id)}" />
                    <form action="${pageContext.request.contextPath}/${isSaved ? 'removeCourse' : 'saveCourse'}"
                          method="post"
                          class="save-form">
                        <input type="hidden" name="courseId" value="${course.id}" />
                        <button type="submit" class="save-btn" title="${isSaved ? 'Remove course' : 'Save course'}">
                            <c:choose>
                                <c:when test="${isSaved}">⭐</c:when>
                                <c:otherwise>☆</c:otherwise>
                            </c:choose>
                        </button>
                    </form>

                    <!-- Completed / Mark Completed -->
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
                            <form action="${pageContext.request.contextPath}/completeCourse"
                                  method="post"
                                  class="complete-form">
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


</div>



</body>
</html>