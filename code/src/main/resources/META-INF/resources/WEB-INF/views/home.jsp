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
</div>

<!-- YOUR COURSES SECTION -->
<div class="course-section">
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

    <!-- Header row (title + search on same line) -->
    <div class="section-header">
        <h2>All Courses</h2>

        <form action="${pageContext.request.contextPath}/home"
              method="get"
              class="filter-bar">

            <input type="text"
                   name="query"
                   placeholder="Search..."
                   value="${param.query}" />

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

    <div class="course-grid">
        <div class="course-grid">
            <c:if test="${empty courses}">
                <p>No courses found. Try a different search or clear filters.</p>
            </c:if>

            <c:forEach var="course" items="${courses}">
                <div class="course-card">
                    <h3>${course.title}</h3>
                    <p class="category">${course.category}</p>
                    <p>${course.description}</p>
                    <div class="course-actions">
                        <a class="start-btn" href="${course.link}" target="_blank">Start Course →</a>

                        <!-- Save button (star) -->
                        <c:set var="isSaved" value="${savedCourseIds.contains(course.id)}" />

                        <form action="${pageContext.request.contextPath}/${isSaved ? 'removeCourse' : 'saveCourse'}"
                              method="post"
                              class="save-form">

                            <input type="hidden" name="courseId" value="${course.id}">

                            <button class="save-btn" title="${isSaved ? 'Remove course' : 'Save course'}">
                                <c:choose>
                                    <c:when test="${isSaved}">
                                        ★
                                    </c:when>
                                    <c:otherwise>
                                        ☆
                                    </c:otherwise>
                                </c:choose>
                            </button>

                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

</div>



</body>
</html>