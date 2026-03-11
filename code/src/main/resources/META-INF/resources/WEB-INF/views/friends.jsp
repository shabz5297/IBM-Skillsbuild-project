<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Friends</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/friends.css">
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
        <form action="${pageContext.request.contextPath}/logout" method="post">
            <button class="logout-btn">Logout</button>
        </form>
        <a href="${pageContext.request.contextPath}/profile" class="profile-btn">Profile ⚙</a>
    </div>
</div>

<div class="page-wrapper">

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <a href="${pageContext.request.contextPath}/home" class="nav-item">
            <span class="nav-icon">⊞</span> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/home#your-courses" class="nav-item">
            <span class="nav-icon">📖</span> My Courses
        </a>
        <a href="${pageContext.request.contextPath}/home#leaderboard" class="nav-item">
            <span class="nav-icon">🏆</span> Leaderboard
        </a>
        <a href="${pageContext.request.contextPath}/home#all-courses" class="nav-item">
            <span class="nav-icon">🔍</span> Browse
        </a>
        <a href="${pageContext.request.contextPath}/friends" class="nav-item active">
            <span class="nav-icon">👥</span> Friends
        </a>
    </aside>

    <!-- MAIN CONTENT -->
    <main class="main-content">

        <div class="dashboard-header">
            <h1>Your Friends</h1>
            <p class="dashboard-subtitle">View, add, and remove friends from your profile.</p>
        </div>

        <!-- ADD FRIEND -->
        <div class="course-section">
            <div class="section-header">
                <h2>Add a Friend</h2>
            </div>

            <form action="${pageContext.request.contextPath}/friends/add" method="post" class="filter-bar">
                <input type="text" name="username" placeholder="Enter username" required>
                <button type="submit">Add Friend</button>
            </form>
        </div>

        <!-- FRIENDS LIST -->
        <div class="course-section">
            <div class="section-header">
                <h2>Friends List</h2>
            </div>

            <c:if test="${empty friends}">
                <p class="muted">No friends added yet.</p>
            </c:if>

            <c:if test="${not empty friends}">
                <div class="friends-grid">
                    <c:forEach var="friend" items="${friends}">
                        <div class="friend-card">
                            <div class="friend-infos">
                                <div class="friend-image">
                                    <c:choose>
                                        <c:when test="${not empty friend.profilePicture}">
                                            <img
                                                    src="${pageContext.request.contextPath}${friend.profilePicture}"
                                                    alt="Profile Picture"
                                                    class="friend-avatar-img"
                                            />
                                        </c:when>
                                        <c:otherwise>
                                            <span class="friend-avatar-letter">
                                                    ${friend.username.substring(0,1).toUpperCase()}
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="friend-info">
                                    <div>
                                        <p class="friend-name">
                                            <c:choose>
                                                <c:when test="${not empty friend.displayName}">
                                                    ${friend.displayName}
                                                </c:when>
                                                <c:otherwise>
                                                    ${friend.username}
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                        <p class="friend-function">@${friend.username}</p>
                                    </div>

                                    <div class="friend-stats">
                                        <p class="friend-flex">
                                            Level
                                            <span class="friend-stat-value">${friend.level}</span>
                                        </p>
                                        <p class="friend-flex">
                                            Points
                                            <span class="friend-stat-value">${friend.points}</span>
                                        </p>
                                        <p class="friend-flex">
                                            Progress
                                            <span class="friend-stat-value">${friend.progress}%</span>
                                        </p>
                                    </div>
                                </div>
                            </div>

                            <form action="${pageContext.request.contextPath}/friends/remove" method="post" style="margin:0;">
                                <input type="hidden" name="username" value="${friend.username}">
                                <button type="submit" class="friend-request">Remove Friend</button>
                            </form>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>


    </main>
</div>

</body>
</html>