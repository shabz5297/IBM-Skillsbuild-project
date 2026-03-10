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
    <!-- leaderboard labels -->
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

<!--review form label-->
<c:if test="${param.reviewSuccess == 'true'}">
    <p style="color: green; text-align: center;">Review submitted successfully.</p>
</c:if>

<c:if test="${param.reviewError == 'true'}">
    <p style="color: red; text-align: center;">Could not submit review.</p>
</c:if>

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

                <!-- review section -->
                <div class="review-section">
                    <h4>Average Rating</h4>
                    <p>${averageRatings[course.id]}</p>

                    <h4>Reviews</h4>
                    <c:choose>
                        <c:when test="${empty reviewsByCourseId[course.id]}">
                            <p>No reviews yet.</p>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="review" items="${reviewsByCourseId[course.id]}">
                                <div class="review-box">
                                    <p><strong>Rating:</strong> ${review.rating}/5</p>
                                    <p><strong>Comment:</strong> ${review.comment}</p>
                                    <p><small>${review.createdAt}</small></p>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

                    <c:if test="${reviewableCourseIds.contains(course.id)}">
                        <h4>Leave a Review</h4>
                        <form action="${pageContext.request.contextPath}/addReview" method="post">
                            <input type="hidden" name="courseId" value="${course.id}" />

                            <label for="rating-saved-${course.id}">Rating:</label>
                            <select name="rating" id="rating-saved-${course.id}" required>
                                <option value="">Select rating</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                            </select>

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