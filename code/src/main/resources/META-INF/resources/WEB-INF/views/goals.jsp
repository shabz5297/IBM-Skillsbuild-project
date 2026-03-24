<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Goals</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/goals.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&family=DM+Sans:wght@400;500&display=swap" rel="stylesheet"/>
</head>
<body>

<!-- ═══════════════════════════ TOP BAR ═══════════════════════════ -->
<nav class="topbar">
    <a href="${pageContext.request.contextPath}/home" class="brand">
        <div class="brand-icon">🔥</div>
        IBM SkillsBuild
    </a>
    <div class="right">
        <button class="theme-toggle" onclick="toggleTheme()">☀️ Light</button>
        <c:if test="${user != null}">
            <a href="/profile/${user.id}" class="profile-btn">👤 ${user.username}</a>
        </c:if>
        <form action="/logout" method="post" style="display:inline">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button class="logout-btn" type="submit">Logout</button>
        </form>
    </div>
</nav>

<div class="page-wrapper">

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <a href="${pageContext.request.contextPath}/home" class="nav-item">
            <span class="nav-icon">🏠</span> Home
        </a>
        <a href="${pageContext.request.contextPath}/home#your-courses" class="nav-item">
            <span class="nav-icon">📖</span> My Courses
        </a>
        <a href="${pageContext.request.contextPath}/browse" class="nav-item">
            <span class="nav-icon">🔍</span> Browse
        </a>
        <a href="${pageContext.request.contextPath}/goals" class="nav-item active">
            <span class="nav-icon">🎯</span> Goals
        </a>
        <a href="${pageContext.request.contextPath}/leaderboard" class="nav-item">
            <span class="nav-icon">🏆</span> Leaderboard
        </a>
        <a href="${pageContext.request.contextPath}/friends" class="nav-item">
            <span class="nav-icon">👥</span> Friends
        </a>
        <a href="${pageContext.request.contextPath}/achievements" class="nav-item">
            <span class="nav-icon">🎖️</span> Achievements
        </a>
    </aside>

    <!--  MAIN  -->
    <main class="main-content">

        <!-- Page header -->
        <div class="dashboard-header">
            <h1>🎯 My Goals</h1>
            <p class="dashboard-subtitle">Set targets, track progress, earn rewards.</p>
        </div>

        <!-- Flash messages -->
        <c:if test="${not empty success}">
            <div class="flash-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="flash-error">${error}</div>
        </c:if>

        <!-- ── Create Goal Card ─────────────────────────────────── -->
        <div class="goal-create-card">
            <h2 class="goal-create-title">➕ Create a New Goal</h2>
            <form action="/goals/create" method="post" class="goal-form">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <div class="goal-form-row">
                    <div class="goal-form-group">
                        <label for="targetCount">Courses to complete</label>
                        <input  type="number" id="targetCount" name="targetCount"
                                min="1" max="20" value="1" required class="goal-input"/>
                    </div>

                    <div class="goal-form-group">
                        <label for="periodDays">Time period</label>
                        <select id="periodDays" name="periodDays" class="goal-input">
                            <option value="1">1 day (Daily)</option>
                            <option value="7" selected>7 days (Weekly)</option>
                            <option value="30">30 days (Monthly)</option>
                        </select>
                    </div>

                    <div class="goal-form-group goal-reward-preview">
                        <label>Reward preview</label>
                        <span id="rewardPreview" class="reward-badge">🏆 ~30 pts + Badge</span>
                    </div>

                    <div class="goal-form-group" style="align-self:flex-end">
                        <button type="submit" class="goal-submit-btn">Set Goal 🚀</button>
                    </div>
                </div>
                <p class="goal-hint">You can have up to 3 active goals at once. Max 3 active at a time.</p>
            </form>
        </div>

        <!-- Active Goals  -->
        <div class="course-section" style="margin-top:32px">
            <div class="section-header">
                <h2>🔥 Active Goals <span class="goal-count-pill">${activeGoals.size()}/3</span></h2>
            </div>

            <c:choose>
                <c:when test="${empty activeGoals}">
                    <div class="goal-empty">
                        <span class="goal-empty-icon">🎯</span>
                        <p>No active goals yet. Create one above to get started!</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="goal-grid">
                        <c:forEach var="goal" items="${activeGoals}">
                            <c:set var="progress" value="${progressMap[goal.id]}"/>
                            <c:set var="percent"  value="${percentMap[goal.id]}"/>
                            <div class="goal-card active-goal">

                                <!-- Header row -->
                                <div class="goal-card-header">
                                    <span class="goal-period-badge">${goal.periodLabel}</span>
                                    <span class="goal-reward-label">🏆 +${goal.pointsReward} pts</span>
                                </div>

                                <!-- Title -->
                                <div class="goal-title">
                                    Complete <strong>${goal.targetCount}</strong> course<c:if test="${goal.targetCount > 1}">s</c:if>
                                </div>

                                <!-- Progress bar -->
                                <div class="goal-progress-wrap">
                                    <div class="goal-progress-bar">
                                        <div class="goal-progress-fill"
                                             style="width: ${percent}%"
                                             data-percent="${percent}">
                                        </div>
                                    </div>
                                    <div class="goal-progress-label">
                                        <span>${progress} / ${goal.targetCount} completed</span>
                                        <span>${percent}%</span>
                                    </div>
                                </div>

                                <!-- Deadline -->
                                <div class="goal-deadline">
                                    ⏰ Deadline: ${goal.deadlineFormatted}
                                </div>

                                <!-- Delete form -->
                                <form action="/goals/delete" method="post" style="margin-top:12px">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <input type="hidden" name="goalId" value="${goal.id}"/>
                                    <button type="submit" class="goal-delete-btn"
                                            onclick="return confirm('Abandon this goal?')">
                                        🗑 Abandon
                                    </button>
                                </form>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- ── Goal History ─────────────────────────────────────── -->
        <div class="course-section" style="margin-top:32px">
            <h2>📜 Goal History</h2>

            <c:set var="hasHistory" value="false"/>
            <c:forEach var="goal" items="${allGoals}">
                <c:if test="${goal.status != 'ACTIVE'}">
                    <c:set var="hasHistory" value="true"/>
                </c:if>
            </c:forEach>

            <c:choose>
                <c:when test="${hasHistory == 'false'}">
                    <div class="goal-empty">
                        <p>No completed or expired goals yet.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="goal-history-list">
                        <c:forEach var="goal" items="${allGoals}">
                            <c:if test="${goal.status != 'ACTIVE'}">
                                <div class="goal-history-row ${goal.status == 'COMPLETED' ? 'history-completed' : 'history-expired'}">
                                    <span class="history-status-icon">
                                        <c:choose>
                                            <c:when test="${goal.status == 'COMPLETED'}">✅</c:when>
                                            <c:otherwise>❌</c:otherwise>
                                        </c:choose>
                                    </span>
                                    <span class="history-desc">
                                        ${goal.periodLabel}: ${goal.targetCount} course<c:if test="${goal.targetCount > 1}">s</c:if>
                                    </span>
                                    <span class="history-reward">
                                        <c:if test="${goal.status == 'COMPLETED'}">+${goal.pointsReward} pts 🏆</c:if>
                                        <c:if test="${goal.status == 'EXPIRED'}">Not completed</c:if>
                                    </span>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </main>
</div>

<script>
    // ── Theme toggle ──────────────────────────────────────────────
    function toggleTheme() {
        document.body.classList.toggle('light-mode');
        localStorage.setItem('theme', document.body.classList.contains('light-mode') ? 'light' : 'dark');
    }
    if (localStorage.getItem('theme') === 'light') document.body.classList.add('light-mode');

    // ── Animate progress bars on load ─────────────────────────────
    document.addEventListener('DOMContentLoaded', () => {
        document.querySelectorAll('.goal-progress-fill').forEach(bar => {
            const target = bar.dataset.percent;
            bar.style.width = '0%';
            setTimeout(() => { bar.style.width = target + '%'; }, 200);
        });
    });

    // ── Reward preview calculator ─────────────────────────────────
    function updateRewardPreview() {
        const count  = parseInt(document.getElementById('targetCount').value) || 1;
        const period = parseInt(document.getElementById('periodDays').value);
        let base = count * 15;
        if (period === 7)  base += 25;
        if (period === 30) base += 60;
        document.getElementById('rewardPreview').textContent = '🏆 ~' + base + ' pts + Badge';
    }

    document.getElementById('targetCount').addEventListener('input', updateRewardPreview);
    document.getElementById('periodDays').addEventListener('change', updateRewardPreview);
    updateRewardPreview();
</script>
</body>
</html>
