<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Profile</title>

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f7f9fc;
        }

        .container {
            max-width: 900px;
            margin: 50px auto;
            padding: 20px;
        }

        .home-button {
            display: inline-block;
            margin-bottom: 20px;
            background: lightgreen;
            color: white;
            padding: 10px 16px;
            border-radius: 12px;
            text-decoration: none;
            font-weight: bold;
            transition: 0.2s;
        }

        .home-button:hover {
            background: darkgreen;
        }

        .card {
            background: white;
            border-radius: 16px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.05);
        }

        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 20px;
            animation: fadeIn 0.6s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .profile-header {
            display: flex;
            align-items: center;
            gap: 25px;
        }

        .avatar {
            width: 100px;
            height: 100px;
            background-color: #58cc02;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            color: white;
            font-weight: bold;
            overflow: hidden;
        }

        .avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .username {
            font-size: 28px;
            margin: 0;
        }

        .handle {
            color: #888;
        }

        .bio {
            margin-top: 15px;
            font-size: 16px;
            color: #444;
        }

        .edit-btn {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 20px;
            background: #58cc02;
            color: white;
            border-radius: 8px;
            text-decoration: none;
            transition: 0.2s;
        }

        .edit-btn:hover {
            background: #46a302;
        }

        .stats {
            display: flex;
            justify-content: space-between;
            text-align: center;
        }

        .stat h3 {
            margin: 0;
            color: #58cc02;
        }

        .progress-container {
            margin-top: 20px;
        }

        .progress-bar-bg {
            background: #e0e0e0;
            height: 12px;
            border-radius: 10px;
        }

        .progress-bar-fill {
            height: 12px;
            background: #58cc02;
            border-radius: 10px;
            transition: width 0.6s ease;
        }

        .progress-text {
            margin-top: 5px;
            color: #666;
            font-size: 14px;
        }

        .badges-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }

        .badge-card {
            background: #ffffff;
            border-radius: 20px;
            padding: 15px 20px;
            font-weight: 600;
            color: #2e7d32;
            border: 2px solid #e8f5e9;
            transition: 0.2s ease;
        }

        .badge-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 15px rgba(0,0,0,0.1);
        }

        .level-title {
            margin-top: 8px;
            font-weight: bold;
            color: #ff9800;
            font-size: 14px;
        }

        .badge-card.locked {
            filter: grayscale(100%);
            opacity: 0.5;
            border: 2px dashed #ddd;
            position: relative;
            transition: all 0.3s ease;
        }

        .badge-card.locked:hover {
            opacity: 0.7;
            filter: grayscale(80%);
            cursor: not-allowed;
        }

        .badge-card.locked::after {
            content: attr(data-lock-text);
            position: absolute;
            bottom: -30px;
            left: 50%;
            transform: translateX(-50%);
            background: #333;
            color: white;
            font-size: 12px;
            padding: 5px 10px;
            border-radius: 8px;
            white-space: nowrap;
            opacity: 0;
            pointer-events: none;
            transition: 0.2s ease;
        }

        .badge-card.locked:hover::after {
            opacity: 1;
        }

        .badge-card:not(.locked) {
            animation: unlockPop 0.4s ease;
        }

        @keyframes unlockPop {
            from { transform: scale(0.95); }
            to { transform: scale(1); }
        }

    </style>
</head>

<body>

<div class="container">

    <!-- Home Button -->
    <a href="/home" class="home-button">🏠 Home</a>

    <!-- Profile Card -->
    <div class="card">

        <!-- Success Message -->
        <c:if test="${param.updated == 'true'}">
            <div class="success-message">
                Profile updated successfully 🎉
            </div>
        </c:if>

        <div class="profile-header">

            <div class="avatar">
                <c:choose>
                    <c:when test="${not empty user.profilePicture}">
                        <img src="${user.profilePicture}" alt="Profile Picture"/>
                    </c:when>
                    <c:otherwise>
                        ${user.username.substring(0,1).toUpperCase()}
                    </c:otherwise>
                </c:choose>
            </div>

            <div>
                <h2 class="username">
                    ${user.displayName != null ? user.displayName : user.username}
                </h2>
                <div class="handle">@${user.username}</div>

                <div class="level-title">
                    <c:choose>
                        <c:when test="${user.progress < 25}">
                            🌱 Beginner
                        </c:when>
                        <c:when test="${user.progress < 50}">
                            🚀 Explorer
                        </c:when>
                        <c:when test="${user.progress < 75}">
                            🔥 Achiever
                        </c:when>
                        <c:otherwise>
                            🏆 Master
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="bio">
                    ${user.bio != null ? user.bio : "No bio yet."}
                </div>

                <a href="/profile/${user.id}/edit" class="edit-btn">
                    Edit Profile
                </a>
            </div>

        </div>
    </div>

    <!-- Stats Card -->
    <div class="card">
        <div class="stats">
            <div class="stat">
                <h3>${user.badges.size()}</h3>
                <p>Badges</p>
            </div>
            <div class="stat">
                <h3>0</h3>
                <p>XP</p>
            </div>
            <div class="stat">
                <h3>0</h3>
                <p>Streak</p>
            </div>
        </div>

        <!-- Progress Bar -->
        <div class="progress-container">
            <div class="progress-bar-bg">
                <div class="progress-bar-fill"
                     data-progress="${user.progress}"
                     style="width:0%;"></div>
            </div>
            <p class="progress-text">
                ${user.progress}% to next level
            </p>
        </div>
    </div>

    <!-- Badges Section -->
    <div class="card">
        <h3>Achievements</h3>

        <div class="badges-grid">

            <!-- Beginner Badge -->
            <div class="badge-card ${user.progress < 25 ? 'locked' : ''}"
                 data-lock-text="Unlock at 25%">
                🌱 Beginner
                <c:if test="${user.progress < 25}">
                    <span class="lock">🔒</span>
                </c:if>
            </div>

            <!-- Explorer Badge -->
            <div class="badge-card ${user.progress < 50 ? 'locked' : ''}"
                 data-lock-text="Unlock at 50%">
                🚀 Explorer
                <c:if test="${user.progress < 50}">
                    <span class="lock">🔒</span>
                </c:if>
            </div>

            <!-- Achiever Badge -->
            <div class="badge-card ${user.progress < 75 ? 'locked' : ''}"
                 data-lock-text="Unlock at 75%">
                🔥 Achiever
                <c:if test="${user.progress < 75}">
                    <span class="lock">🔒</span>
                </c:if>
            </div>

            <!-- Master Badge -->
            <div class="badge-card ${user.progress < 100 ? 'locked' : ''}"
                 data-lock-text="Unlock at 100%">
                🏆 Master
                <c:if test="${user.progress < 100}">
                    <span class="lock">🔒</span>
                </c:if>
            </div>

        </div>

            <c:if test="${empty user.badges}">
                <p>No badges earned yet.</p>
            </c:if>
        </div>
    </div>

</div>
<script>
    setTimeout(function() {
        const msg = document.querySelector(".success-message");
        if (msg) {
            msg.style.transition = "opacity 0.5s ease";
            msg.style.opacity = "0";
            setTimeout(() => msg.remove(), 500);
        }
    }, 5000);
    window.addEventListener("DOMContentLoaded", function() {
        const progressBar = document.querySelector(".progress-bar-fill");
        if(progressBar) {
            const target = progressBar.getAttribute("data-progress");
            setTimeout(() => {
                progressBar.style.width = target + "%";
            }, 300);
        }
    });
</script>
</body>
</html>