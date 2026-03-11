<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Friends</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/friends.css">
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

    <main class="main-content">

        <div class="dashboard-header">
            <h1>Your Friends</h1>
            <p class="dashboard-subtitle">Send requests, accept requests, and manage your friends.</p>
        </div>

        <c:if test="${not empty error}">
            <div class="flash-error">${error}</div>
        </c:if>

        <!-- SEND REQUEST -->
        <div class="course-section">
            <div class="section-header">
                <h2>Send a Friend Request</h2>
            </div>

            <form action="${pageContext.request.contextPath}/friends/request" method="post" class="filter-bar">
                <input type="text" name="username" placeholder="Enter username" required>
                <button type="submit">Send Request</button>
            </form>
        </div>

        <!-- PENDING REQUESTS -->
        <div class="course-section">
            <div class="section-header">
                <h2>Pending Requests</h2>
            </div>

            <c:if test="${empty pendingRequests}">
                <p class="muted">No pending requests.</p>
            </c:if>

            <c:if test="${not empty pendingRequests}">
                <div class="friends-grid">
                    <c:forEach var="request" items="${pendingRequests}">
                        <div class="friend-card">
                            <div class="friend-infos">
                                <div class="friend-image">
                                    <c:choose>
                                        <c:when test="${not empty request.sender.profilePicture}">
                                            <img
                                                    src="${pageContext.request.contextPath}${request.sender.profilePicture}"
                                                    alt="Profile Picture"
                                                    class="friend-avatar-img"
                                            />
                                        </c:when>
                                        <c:otherwise>
                                            <span class="friend-avatar-letter">
                                                    ${request.sender.username.substring(0,1).toUpperCase()}
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="friend-info">
                                    <div>
                                        <p class="friend-name">
                                            <c:choose>
                                                <c:when test="${not empty request.sender.displayName}">
                                                    ${request.sender.displayName}
                                                </c:when>
                                                <c:otherwise>
                                                    ${request.sender.username}
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                        <p class="friend-function">@${request.sender.username}</p>
                                    </div>

                                    <div class="friend-stats">
                                        <p class="friend-flex">
                                            Level
                                            <span class="friend-stat-value">${request.sender.level}</span>
                                        </p>
                                        <p class="friend-flex">
                                            Points
                                            <span class="friend-stat-value">${request.sender.points}</span>
                                        </p>
                                        <p class="friend-flex">
                                            Progress
                                            <span class="friend-stat-value">${request.sender.progress}%</span>
                                        </p>
                                    </div>
                                </div>
                            </div>

                            <div class="friend-action-row">
                                <form action="${pageContext.request.contextPath}/friends/accept" method="post" style="margin:0;">
                                    <input type="hidden" name="requestId" value="${request.id}">
                                    <button type="submit" class="friend-accept">Accept</button>
                                </form>

                                <form action="${pageContext.request.contextPath}/friends/decline" method="post" style="margin:0;">
                                    <input type="hidden" name="requestId" value="${request.id}">
                                    <button type="submit" class="friend-decline">Decline</button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
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