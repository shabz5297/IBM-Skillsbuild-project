<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Study Mode – ${course.title}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/study.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&family=DM+Sans:wght@400;500&display=swap" rel="stylesheet"/>
</head>
<body>

<!-- minimal topbar -->
<nav class="topbar">
    <a href="${pageContext.request.contextPath}/home" class="brand">
        <div class="brand-icon">🔥</div>
        IBM SkillsBuild
    </a>
    <div class="right">
        <button class="theme-toggle" onclick="toggleTheme()">🌙 Theme</button>
        <form action="${pageContext.request.contextPath}/logout" method="post" style="display:inline">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button class="logout-btn" type="submit">Logout</button>
        </form>
    </div>
</nav>

<c:choose>
    <c:when test="${empty flashcards}">
        <!-- No cards: redirect back -->
        <div class="review-page">
            <div class="review-header">
                <h2>No flashcards yet!</h2>
                <p>Create some flashcards first and then come back to study.</p>
            </div>
            <a href="${pageContext.request.contextPath}/study/${course.id}#flashcards"
               class="study-mode-btn">← Back to Study Hub</a>
        </div>
    </c:when>
    <c:otherwise>
        <div class="review-page">

            <a href="${pageContext.request.contextPath}/study/${course.id}#flashcards"
               class="review-back-link">← Back to ${course.title}</a>

            <div class="review-header">
                <h2>🃏 Study Mode</h2>
                <p>${course.title} &nbsp;·&nbsp; ${flashcards.size()} card<c:if test="${flashcards.size() != 1}">s</c:if></p>
            </div>

            <!-- Progress bar -->
            <div class="review-progress-bar">
                <div class="review-progress-fill" id="reviewProgress" style="width:0%"></div>
            </div>

            <!-- Flip card -->
            <div class="review-card-wrap" id="reviewCard" onclick="flipReview()">
                <div class="review-card-inner">
                    <div class="review-face front">
                        <span class="review-face-label">Question</span>
                        <span class="review-face-text" id="reviewQuestion"></span>
                        <span class="flip-hint">click to reveal answer</span>
                    </div>
                    <div class="review-face back">
                        <span class="review-face-label">Answer</span>
                        <span class="review-face-text" id="reviewAnswer"></span>
                    </div>
                </div>
            </div>

            <!-- Navigation controls -->
            <div class="review-controls">
                <button class="review-nav-btn" id="prevBtn" onclick="prevCard()" disabled>‹</button>
                <span class="review-counter" id="reviewCounter">1 / ${flashcards.size()}</span>
                <button class="review-nav-btn" id="nextBtn" onclick="nextCard()">›</button>
            </div>

            <!-- All-done message (hidden initially) -->
            <div id="reviewDone" style="display:none; text-align:center;">
                <p style="font-size:32px; margin-bottom:8px;">🎉</p>
                <p style="font-family:'Space Grotesk',sans-serif; font-size:18px; font-weight:700;
                          color:var(--text-primary); margin-bottom:4px;">You've reviewed all cards!</p>
                <p style="font-size:14px; color:var(--text-secondary); margin-bottom:20px;">
                    Great work. Keep it up!</p>
                <button class="study-mode-btn" onclick="restartReview()">↺ Restart</button>
            </div>

        </div>
    </c:otherwise>
</c:choose>

<!-- Flashcard data injected as JS array -->
<script>
    const cards = [
        <c:forEach var="fc" items="${flashcards}" varStatus="s">
        {
            question: `${fc.question.replace('`','\\`')}`,
            answer:   `${fc.answer.replace('`','\\`')}`
        }<c:if test="${!s.last}">,</c:if>
        </c:forEach>
    ];

    let current = 0;

    function render() {
        if (!cards.length) return;
        const card = cards[current];
        document.getElementById('reviewQuestion').textContent = card.question;
        document.getElementById('reviewAnswer').textContent   = card.answer;
        document.getElementById('reviewCounter').textContent  = (current + 1) + ' / ' + cards.length;
        document.getElementById('prevBtn').disabled = current === 0;
        document.getElementById('nextBtn').disabled = current === cards.length - 1;
        // reset flip
        document.getElementById('reviewCard').classList.remove('flipped');
        // progress
        const pct = ((current + 1) / cards.length * 100).toFixed(0);
        document.getElementById('reviewProgress').style.width = pct + '%';
    }

    function flipReview() {
        document.getElementById('reviewCard').classList.toggle('flipped');
    }

    function nextCard() {
        if (current < cards.length - 1) {
            current++;
            render();
        } else {
            // show done state
            document.getElementById('reviewCard').style.display = 'none';
            document.querySelector('.review-controls').style.display = 'none';
            document.getElementById('reviewDone').style.display = 'block';
            document.getElementById('reviewProgress').style.width = '100%';
        }
    }

    function prevCard() {
        if (current > 0) { current--; render(); }
    }

    function restartReview() {
        current = 0;
        document.getElementById('reviewCard').style.display = '';
        document.querySelector('.review-controls').style.display = '';
        document.getElementById('reviewDone').style.display = 'none';
        render();
    }

    /* keyboard navigation */
    document.addEventListener('keydown', e => {
        if (e.key === 'ArrowRight') nextCard();
        if (e.key === 'ArrowLeft')  prevCard();
        if (e.key === ' ' || e.key === 'Enter') {
            e.preventDefault();
            flipReview();
        }
    });

    /* theme */
    function toggleTheme() {
        document.body.classList.toggle('light-mode');
        const btn = document.querySelector('.theme-toggle');
        btn.textContent = document.body.classList.contains('light-mode') ? '🌙 Dark' : '☀️ Light';
        localStorage.setItem('theme', document.body.classList.contains('light-mode') ? 'light' : 'dark');
    }
    if (localStorage.getItem('theme') === 'light') {
        document.body.classList.add('light-mode');
        document.querySelector('.theme-toggle').textContent = '🌙 Dark';
    }

    render();
</script>

</body>
</html>
