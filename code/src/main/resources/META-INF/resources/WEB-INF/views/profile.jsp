<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Profile</title>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&family=DM+Sans:wght@400;500&display=swap" rel="stylesheet">

    <style>
        :root {
            --bg-primary: #0e1117;
            --bg-secondary: #161b22;
            --bg-card: #1c2333;
            --border: #2a3245;
            --text-primary: #e6edf3;
            --text-secondary: #8b949e;
            --text-muted: #6e7681;
            --accent-cyan: #22d3ee;
            --accent-green: #22c55e;
            --accent-orange: #f97316;
            --accent-yellow: #eab308;
            --accent-blue: #4a6cf7;
        }

        body.light-mode {
            --bg-primary: #f5f7fb;
            --bg-secondary: #ffffff;
            --bg-card: #ffffff;
            --border: #e2e8f0;
            --text-primary: #1a202c;
            --text-secondary: #4a5568;
            --text-muted: #9ca3af;
        }

        .theme-toggle {
            background: transparent;
            border: 1px solid var(--border);
            color: var(--text-secondary);
            padding: 8px 14px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 13px;
            font-family: 'DM Sans', sans-serif;
            transition: all 0.2s;
        }
        .theme-toggle:hover {
            background: var(--bg-card);
            color: var(--text-primary);
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'DM Sans', sans-serif;
            background-color: var(--bg-primary);
            color: var(--text-primary);
            min-height: 100vh;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .home-button {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 24px;
            background: var(--bg-card);
            color: var(--text-secondary);
            padding: 9px 16px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            border: 1px solid var(--border);
            transition: all 0.2s;
        }

        .home-button:hover {
            color: var(--text-primary);
            border-color: var(--accent-cyan);
            background: var(--bg-secondary);
        }

        .card {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 28px;
            margin-bottom: 20px;
        }

        .success-message {
            background: #22c55e15;
            color: var(--accent-green);
            border: 1px solid #22c55e33;
            padding: 12px 16px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-size: 14px;
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
            width: 90px;
            height: 90px;
            background: linear-gradient(135deg, var(--accent-cyan), #0891b2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 36px;
            color: #0e1117;
            font-weight: 700;
            overflow: hidden;
            flex-shrink: 0;
            font-family: 'Space Grotesk', sans-serif;
        }

        .avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .username {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 26px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 4px;
        }

        .handle {
            color: var(--text-muted);
            font-size: 14px;
            margin-bottom: 8px;
        }

        .level-title {
            display: inline-block;
            margin-bottom: 10px;
            font-weight: 600;
            font-size: 13px;
            color: var(--accent-orange);
            background: #f9731615;
            border: 1px solid #f9731633;
            padding: 3px 10px;
            border-radius: 999px;
        }

        .bio {
            font-size: 14px;
            color: var(--text-secondary);
            margin-bottom: 14px;
            line-height: 1.6;
        }

        .edit-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 18px;
            background: var(--accent-blue);
            color: white;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: background 0.2s;
        }

        .edit-btn:hover {
            background: #3a5ce0;
        }

        .stats {
            display: flex;
            justify-content: space-around;
            text-align: center;
            margin-bottom: 24px;
        }

        .stat h3 {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 28px;
            font-weight: 700;
            color: var(--accent-cyan);
            margin-bottom: 4px;
        }

        .stat p {
            font-size: 13px;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .progress-container {
            margin-top: 4px;
        }

        .progress-label {
            display: flex;
            justify-content: space-between;
            font-size: 13px;
            color: var(--text-muted);
            margin-bottom: 8px;
        }

        .progress-bar-bg {
            background: #ffffff10;
            height: 10px;
            border-radius: 10px;
            overflow: hidden;
        }

        .progress-bar-fill {
            height: 10px;
            background: linear-gradient(90deg, var(--accent-cyan), #0891b2);
            border-radius: 10px;
            transition: width 0.8s ease;
        }

        .progress-text {
            margin-top: 8px;
            color: var(--text-muted);
            font-size: 13px;
        }

        .card h3 {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 16px;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 18px;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .badges-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
        }

        .badge-card {
            background: var(--bg-secondary);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 14px 20px;
            font-weight: 600;
            font-size: 14px;
            color: var(--text-primary);
            transition: all 0.2s ease;
            position: relative;
        }

        .badge-card:not(.locked):hover {
            transform: translateY(-3px);
            border-color: var(--accent-cyan);
            box-shadow: 0 0 16px #22d3ee18;
        }

        .badge-card.locked {
            filter: grayscale(100%);
            opacity: 0.35;
            border: 1px dashed var(--border);
        }

        .badge-card.locked:hover {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .badge-card.locked::after {
            content: attr(data-lock-text);
            position: absolute;
            bottom: -34px;
            left: 50%;
            transform: translateX(-50%);
            background: #1c2333;
            border: 1px solid var(--border);
            color: var(--text-secondary);
            font-size: 12px;
            padding: 5px 10px;
            border-radius: 8px;
            white-space: nowrap;
            opacity: 0;
            pointer-events: none;
            transition: 0.2s ease;
            z-index: 10;
        }

        .badge-card.locked:hover::after {
            opacity: 1;
        }

        .no-badges {
            color: var(--text-muted);
            font-size: 14px;
        }
    </style>
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