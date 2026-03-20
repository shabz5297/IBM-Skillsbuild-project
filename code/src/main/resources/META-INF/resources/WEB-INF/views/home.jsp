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

<!-- FLASH MESSAGES -->
<c:if test="${param.reviewSuccess == 'true'}">
    <div class="flash-success">✅ Review submitted successfully.</div>
</c:if>
<c:if test="${param.reviewError == 'true'}">
    <div class="flash-error">❌ Could not submit review.</div>
</c:if>

<div class="page-wrapper">

    <aside class="sidebar">
        <a href="#dashboard" class="nav-item active">
            <span class="nav-icon">🏠</span> Home
        </a>
        <a href="#your-courses" class="nav-item">
            <span class="nav-icon">📖</span> My Courses
        </a>
        <a href="/browse" class="nav-item">
            <span class="nav-icon">🔍</span> Browse
        </a>
        <a href="/leaderboard" class="nav-item">
            <span class="nav-icon">🏆</span> Leaderboard
        </a>
        <a href="${pageContext.request.contextPath}/friends" class="nav-item">
            <span class="nav-icon">👥</span> Friends
        </a>
        <a href="${pageContext.request.contextPath}/achievements" class="nav-item">
            <span class="nav-icon">🎖️</span> Achievements
        </a>
    </aside>

    <main class="main-content" id="dashboard">

        <div class="dashboard-header">
            <h1>
                Welcome back<c:if test="${user != null}">, ${user.username}</c:if> 👋
            </h1>
            <p class="dashboard-subtitle">Keep your streak alive — keep learning!</p>

            <c:if test="${user != null}">
                <div class="quick-stats">
                    <div class="stat-card cyan">
                        <div class="stat-header">
                            <span class="stat-icon cyan">⚡</span>
                            <span class="stat-label">Total Points</span>
                        </div>
                        <div class="stat-value">${user.points}</div>
                    </div>
                    <div class="stat-card green">
                        <div class="stat-header">
                            <span class="stat-icon green">🚀</span>
                            <span class="stat-label">Level</span>
                        </div>
                        <div class="stat-value">${user.level}</div>
                        <div class="stat-sub">Keep completing courses to level up</div>
                    </div>
                    <div class="stat-card orange">
                        <div class="stat-header">
                            <span class="stat-icon orange">🔥</span>
                            <span class="stat-label">Streak</span>
                        </div>
                        <div class="stat-value">1</div>
                        <div class="stat-sub">Keep your streak alive!</div>
                    </div>
                    <div class="stat-card blue">
                        <div class="stat-header">
                            <span class="stat-icon blue">🎯</span>
                            <span class="stat-label">Your Rank</span>
                        </div>
                        <div class="stat-value">
                            <c:choose>
                                <c:when test="${userRank != null}">#${userRank}</c:when>
                                <c:otherwise>—</c:otherwise>
                            </c:choose>
                        </div>
                        <c:if test="${userRank != null}">
                            <div class="stat-sub">Global leaderboard</div>
                        </c:if>
                    </div>
                </div>
            </c:if>
        </div>

        <!-- YOUR COURSES SECTION -->
        <div class="course-section" id="your-courses">
            <div class="section-header">
                <h2>Your Courses</h2>
            </div>

            <div class="course-grid">
                <c:forEach var="course" items="${savedCourses}">
                    <div class="course-card saved">
                        <h3>${course.title}</h3>
                        <p class="category">${course.category}</p>
                        <p>${course.description}</p>

                        <div class="course-actions">
                            <a class="start-btn" href="${course.link}" target="_blank">Start Course →</a>

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
                                    <form action="${pageContext.request.contextPath}/completeCourse" method="post" class="complete-form">
                                        <input type="hidden" name="courseId" value="${course.id}" />
                                        <button type="submit" class="complete-btn">Mark Completed</button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="review-section">
                            <h4>Average Rating</h4>
                            <p class="review-stars">
                                <c:choose>
                                    <c:when test="${averageRatings[course.id] >= 4.5}">★★★★★</c:when>
                                    <c:when test="${averageRatings[course.id] >= 3.5}">★★★★☆</c:when>
                                    <c:when test="${averageRatings[course.id] >= 2.5}">★★★☆☆</c:when>
                                    <c:when test="${averageRatings[course.id] >= 1.5}">★★☆☆☆</c:when>
                                    <c:when test="${averageRatings[course.id] >= 0.5}">★☆☆☆☆</c:when>
                                    <c:otherwise>☆☆☆☆☆</c:otherwise>
                                </c:choose>
                            </p>
                            <p>${averageRatings[course.id]}</p>

                            <h4>Reviews</h4>
                            <c:choose>
                                <c:when test="${empty reviewsByCourseId[course.id]}">
                                    <p>No reviews yet.</p>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="review" items="${reviewsByCourseId[course.id]}">
                                        <div class="review-box">
                                            <p class="review-stars">
                                                <c:choose>
                                                    <c:when test="${review.rating == 1}">★☆☆☆☆</c:when>
                                                    <c:when test="${review.rating == 2}">★★☆☆☆</c:when>
                                                    <c:when test="${review.rating == 3}">★★★☆☆</c:when>
                                                    <c:when test="${review.rating == 4}">★★★★☆</c:when>
                                                    <c:when test="${review.rating == 5}">★★★★★</c:when>
                                                    <c:otherwise>☆☆☆☆☆</c:otherwise>
                                                </c:choose>
                                            </p>
                                            <p><strong>Comment:</strong> ${review.comment}</p>
                                            <p><small>${review.timeAgo}</small></p>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>

                            <c:if test="${reviewableCourseIds.contains(course.id)}">
                                <h4>Leave a Review</h4>
                                <form action="${pageContext.request.contextPath}/addReview" method="post">
                                    <input type="hidden" name="courseId" value="${course.id}" />
                                    <label>Rating:</label>
                                    <div class="star-rating" data-course-id="${course.id}">
                                        <span class="star" data-value="1">☆</span>
                                        <span class="star" data-value="2">☆</span>
                                        <span class="star" data-value="3">☆</span>
                                        <span class="star" data-value="4">☆</span>
                                        <span class="star" data-value="5">☆</span>
                                        <input type="hidden" name="rating" id="rating-${course.id}" required>
                                    </div>
                                    <label for="comment-saved-${course.id}">Comment:</label>
                                    <textarea name="comment" id="comment-saved-${course.id}" rows="4" required></textarea>
                                    <button type="submit">Submit Review</button>
                                </form>
                            </c:if>

                            <c:if test="${completedCourseIds.contains(course.id) and reviewedCourseIds.contains(course.id)}">
                                <p>You have already reviewed this course.</p>
                            </c:if>
                            <c:if test="${not completedCourseIds.contains(course.id)}">
                                <p>Complete this course to leave a review.</p>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty savedCourses}">
                    <p style="color: var(--text-muted); font-size: 14px;">No courses saved yet. Click the ☆ button on any course below to add it here!</p>
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

    document.addEventListener("DOMContentLoaded", function () {
        document.querySelectorAll(".star-rating").forEach(function (ratingBox) {
            const stars = ratingBox.querySelectorAll(".star");
            const courseId = ratingBox.getAttribute("data-course-id");
            const hiddenInput = document.getElementById("rating-" + courseId);

            function paintStars(selectedValue) {
                stars.forEach(function (star) {
                    const starValue = parseInt(star.getAttribute("data-value"));
                    star.textContent = starValue <= selectedValue ? "★" : "☆";
                    star.style.color = starValue <= selectedValue ? "#eab308" : "";
                });
            }

            stars.forEach(function (star) {
                star.addEventListener("mouseover", function () {
                    paintStars(parseInt(star.getAttribute("data-value")));
                });
                star.addEventListener("click", function () {
                    const val = parseInt(star.getAttribute("data-value"));
                    hiddenInput.value = val;
                    ratingBox.setAttribute("data-selected", val);
                    paintStars(val);
                });
            });

            ratingBox.addEventListener("mouseleave", function () {
                paintStars(parseInt(ratingBox.getAttribute("data-selected")) || 0);
            });
        });

        document.querySelectorAll('.nav-item').forEach(function(link) {
            link.addEventListener('click', function(e) {
                const href = this.getAttribute('href');
                if (href && href.startsWith('#')) {
                    e.preventDefault();
                    document.querySelectorAll('.nav-item').forEach(n => n.classList.remove('active'));
                    this.classList.add('active');
                    const target = document.querySelector(href);
                    if (target) target.scrollIntoView({ behavior: 'smooth' });
                }
            });
        });
    });
</script>

</body>
</html>