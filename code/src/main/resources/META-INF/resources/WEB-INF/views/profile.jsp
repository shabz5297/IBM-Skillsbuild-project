<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Profile</title>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&family=DM+Sans:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css">

</head>

<body>

<div class="container">

    <!-- Home Button -->
    <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 24px;">
        <a href="/home" class="home-button" style="margin-bottom: 0;">← Back to Dashboard</a>
        <button class="theme-toggle" id="themeToggle" onclick="toggleTheme()">☀️ Light</button>
    </div>

    <!-- Profile Card -->
    <div class="card">

        <!-- Success Message -->
        <c:if test="${param.updated == 'true'}">
            <div class="success-message"> ✅Profile updated successfully!</div>
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
                        <c:when test="${user.progress < 25}">🌱 Beginner</c:when>
                        <c:when test="${user.progress < 50}">🚀 Explorer</c:when>
                        <c:when test="${user.progress < 75}">🔥 Achiever</c:when>
                        <c:otherwise>🏆 Master</c:otherwise>
                    </c:choose>
                </div>

                <div class="bio">
                    ${user.bio != null ? user.bio : "No bio yet."}
                </div>

                <a href="/profile/${user.id}/edit" class="edit-btn">✏️Edit Profile</a>
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
                <h3>${user.points}</h3>
                <p>XP</p>
            </div>
            <div class="stat">
                <h3>${user.level}</h3>
                <p>Streak</p>
            </div>
        </div>

        <!-- Progress Bar -->
        <div class="progress-container">
            <div class="progress-label">
                <span>Progress to next level</span>
                <span>${user.progress}%</span>
            </div>
            <div class="progress-bar-bg">
                <div class="progress-bar-fill"
                     data-progress="${user.progress}"
                     style="width:0%;"></div>
            </div>
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
                <p class="no-badges" style="margin-top: 16px;">No badges earned yet. Complete courses to unlock achievements!</p>
            </c:if>
        </div>
    </div>

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
</script>
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