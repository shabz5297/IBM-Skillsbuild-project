<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Friends</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css">
</head>
<body>

<div class="container">

    <a href="${pageContext.request.contextPath}/home" class="home-button">🏠 Home</a>

    <div class="card">
        <h2>Your Friends</h2>
        <p>View, add, or remove friends from your profile.</p>
    </div>

    <div class="card">
        <h3>Add a Friend</h3>
        <form action="${pageContext.request.contextPath}/profile/friends/add" method="post">
            <input type="text" name="username" placeholder="Enter username" required>
            <button type="submit" class="friends-btn">Add Friend</button>
        </form>
    </div>

    <div class="card">
        <h3>Friends List</h3>

        <c:if test="${empty friends}">
            <p>No friends added yet.</p>
        </c:if>

        <c:if test="${not empty friends}">
            <div class="friends-grid">
                <c:forEach var="friend" items="${friends}">
                    <div class="friend-card">
                        <div class="friend-infos">
                            <div class="friend-image">
                                <c:choose>
                                    <c:when test="${not empty friend.profilePicture}">
                                        <img src="${pageContext.request.contextPath}${friend.profilePicture}" alt="Profile Picture" class="friend-avatar-img"/>
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

                        <form action="${pageContext.request.contextPath}/profile/friends/remove" method="post" style="margin:0;">
                            <input type="hidden" name="username" value="${friend.username}">
                            <button type="submit" class="friend-request">Remove Friend</button>
                        </form>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </div>

    <div class="card">
        <a href="${pageContext.request.contextPath}/profile" class="friends-btn">Back to Profile</a>
    </div>

</div>

</body>
</html>