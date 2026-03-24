<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Study – ${course.title}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/study.css"/>
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
            <a href="${pageContext.request.contextPath}/profile/${user.id}" class="profile-btn">👤 ${user.username}</a>
        </c:if>
        <form action="${pageContext.request.contextPath}/logout" method="post" style="display:inline">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button class="logout-btn" type="submit">Logout</button>
        </form>
    </div>
</nav>

<div class="page-wrapper">

    <!-- ══════════════════════ SIDEBAR ══════════════════════ -->
    <aside class="sidebar">
        <a href="${pageContext.request.contextPath}/home" class="nav-item">
            <span class="nav-icon">🏠</span> Home
        </a>
        <a href="${pageContext.request.contextPath}/browse" class="nav-item">
            <span class="nav-icon">🔍</span> Browse
        </a>
        <a href="${pageContext.request.contextPath}/goals" class="nav-item">
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
        <a href="${pageContext.request.contextPath}/profile/${user.id}" class="nav-item">
            <span class="nav-icon">👤</span> Profile
        </a>
    </aside>

    <!-- ══════════════════════ MAIN ══════════════════════════ -->
    <main class="main-content">

        <!-- Page hero -->
        <div class="study-hero">
            <div class="study-hero-text">
                <h1>📚 ${course.title}</h1>
                <p>Your personal notes &amp; flashcards for this course.</p>
            </div>
            <c:if test="${not empty flashcards}">
                <a href="${pageContext.request.contextPath}/study/${course.id}/review" class="study-mode-btn">
                    ▶ Study Mode
                </a>
            </c:if>
        </div>

        <!-- Flash messages -->
        <c:if test="${not empty noteSuccess}">
            <div class="flash-success">✅ ${noteSuccess}</div>
        </c:if>
        <c:if test="${not empty noteError}">
            <div class="flash-error">❌ ${noteError}</div>
        </c:if>
        <c:if test="${not empty flashcardSuccess}">
            <div class="flash-success">✅ ${flashcardSuccess}</div>
        </c:if>
        <c:if test="${not empty flashcardError}">
            <div class="flash-error">❌ ${flashcardError}</div>
        </c:if>

        <!-- ── Tab switcher ─────────────────────────────────── -->
        <div class="study-tabs">
            <button class="study-tab active" onclick="switchTab('notes', this)">
                📝 Notes <span class="study-count-pill">${notes.size()}</span>
            </button>
            <button class="study-tab" onclick="switchTab('flashcards', this)" id="flashcard-tab-btn">
                🃏 Flashcards <span class="study-count-pill">${flashcards.size()}</span>
            </button>
        </div>

        <!-- ════════════════════ NOTES PANEL ════════════════════ -->
        <div id="panel-notes" class="study-panel active">

            <!-- Create note -->
            <div class="study-create-card">
                <h2 class="study-create-title">➕ Add a Note</h2>
                <form action="${pageContext.request.contextPath}/study/${course.id}/notes/create" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="study-form-group">
                        <label for="note-title">Title</label>
                        <input type="text" id="note-title" name="title" class="study-input"
                               placeholder="e.g. Key concepts from Chapter 3" required maxlength="200"/>
                    </div>
                    <div class="study-form-group">
                        <label for="note-content">Content</label>
                        <textarea id="note-content" name="content" class="study-textarea"
                                  placeholder="Write your note here…" required maxlength="5000"></textarea>
                    </div>
                    <button type="submit" class="study-submit-btn">Save Note</button>
                </form>
            </div>

            <!-- Notes list -->
            <div class="study-section-heading">
                Your Notes <span class="study-count-pill">${notes.size()}</span>
            </div>

            <c:choose>
                <c:when test="${empty notes}">
                    <div class="study-empty">
                        <span class="study-empty-icon">📄</span>
                        No notes yet — add your first one above!
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="notes-grid">
                        <c:forEach var="note" items="${notes}">
                            <div class="note-card">
                                <!-- Display mode -->
                                <div class="note-display" id="note-display-${note.id}">
                                    <div class="note-card-header">
                                        <span class="note-title">${note.title}</span>
                                        <span class="note-time">${note.timeAgo}</span>
                                    </div>
                                    <p class="note-content" id="note-content-${note.id}">${note.content}</p>
                                    <button class="note-expand-btn"
                                            onclick="toggleExpand('note-content-${note.id}', this)">
                                        Show more
                                    </button>
                                    <div class="note-actions">
                                        <button class="btn-edit"
                                                onclick="openNoteEdit(${note.id})">✏️ Edit</button>
                                        <form action="${pageContext.request.contextPath}/study/${course.id}/notes/${note.id}/delete"
                                              method="post" style="flex:1">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                            <button type="submit" class="btn-delete"
                                                    onclick="return confirm('Delete this note?')">
                                                🗑 Delete
                                            </button>
                                        </form>
                                    </div>
                                </div>

                                <!-- Edit mode -->
                                <div class="edit-form" id="note-edit-${note.id}">
                                    <form action="${pageContext.request.contextPath}/study/${course.id}/notes/${note.id}/edit"
                                          method="post">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <div class="study-form-group">
                                            <label>Title</label>
                                            <input type="text" name="title" class="study-input"
                                                   value="${note.title}" required maxlength="200"/>
                                        </div>
                                        <div class="study-form-group">
                                            <label>Content</label>
                                            <textarea name="content" class="study-textarea"
                                                      required maxlength="5000">${note.content}</textarea>
                                        </div>
                                        <div class="edit-btn-row">
                                            <button type="button" class="edit-cancel-btn"
                                                    onclick="closeNoteEdit(${note.id})">Cancel</button>
                                            <button type="submit" class="study-submit-btn">Update</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- ════════════════════ FLASHCARDS PANEL ════════════════ -->
        <div id="panel-flashcards" class="study-panel" id="flashcards">

            <!-- Create flashcard -->
            <div class="study-create-card">
                <h2 class="study-create-title">➕ Add a Flashcard</h2>
                <form action="${pageContext.request.contextPath}/study/${course.id}/flashcards/create" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="study-form-row">
                        <div class="study-form-group">
                            <label for="fc-question">Question (Front)</label>
                            <textarea id="fc-question" name="question" class="study-textarea"
                                      placeholder="e.g. What is a primary key?" required maxlength="1000"
                                      style="min-height:70px"></textarea>
                        </div>
                        <div class="study-form-group">
                            <label for="fc-answer">Answer (Back)</label>
                            <textarea id="fc-answer" name="answer" class="study-textarea"
                                      placeholder="e.g. A unique identifier for each record in a table."
                                      required maxlength="2000" style="min-height:70px"></textarea>
                        </div>
                    </div>
                    <button type="submit" class="study-submit-btn">Save Flashcard</button>
                </form>
            </div>

            <!-- Flashcard list -->
            <div class="study-section-heading">
                Your Flashcards <span class="study-count-pill">${flashcards.size()}</span>
            </div>

            <c:choose>
                <c:when test="${empty flashcards}">
                    <div class="study-empty">
                        <span class="study-empty-icon">🃏</span>
                        No flashcards yet — create your first one above!
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="flashcard-grid">
                        <c:forEach var="fc" items="${flashcards}">
                            <div class="fc-card-item">
                                <!-- Flip card -->
                                <div class="fc-wrapper" id="fc-wrap-${fc.id}"
                                     onclick="flipCard('fc-wrap-${fc.id}')">
                                    <div class="fc-inner">
                                        <div class="fc-front">
                                            <span class="fc-label">Question</span>
                                            <span class="fc-text">${fc.question}</span>
                                            <span class="fc-flip-hint">tap to flip</span>
                                        </div>
                                        <div class="fc-back">
                                            <span class="fc-label">Answer</span>
                                            <span class="fc-text">${fc.answer}</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Actions -->
                                <div class="fc-actions">
                                    <button class="btn-edit"
                                            onclick="openFcEdit(${fc.id})">✏️ Edit</button>
                                    <form action="${pageContext.request.contextPath}/study/${course.id}/flashcards/${fc.id}/delete"
                                          method="post" style="flex:1">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <button type="submit" class="btn-delete"
                                                onclick="return confirm('Delete this flashcard?')">
                                            🗑 Delete
                                        </button>
                                    </form>
                                </div>

                                <!-- Edit form -->
                                <div class="edit-form" id="fc-edit-${fc.id}">
                                    <form action="${pageContext.request.contextPath}/study/${course.id}/flashcards/${fc.id}/edit"
                                          method="post">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <div class="study-form-group">
                                            <label>Question (Front)</label>
                                            <textarea name="question" class="study-textarea"
                                                      required maxlength="1000"
                                                      style="min-height:60px">${fc.question}</textarea>
                                        </div>
                                        <div class="study-form-group">
                                            <label>Answer (Back)</label>
                                            <textarea name="answer" class="study-textarea"
                                                      required maxlength="2000"
                                                      style="min-height:60px">${fc.answer}</textarea>
                                        </div>
                                        <div class="edit-btn-row">
                                            <button type="button" class="edit-cancel-btn"
                                                    onclick="closeFcEdit(${fc.id})">Cancel</button>
                                            <button type="submit" class="study-submit-btn">Update</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </main>
</div><!-- /.page-wrapper -->

<!-- ══════════════════════════ SCRIPTS ═══════════════════════════ -->
<script>
    /* ── Theme toggle (matches home.css logic) ── */
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

    /* ── Tab switcher ── */
    function switchTab(tab, btn) {
        document.querySelectorAll('.study-panel').forEach(p => p.classList.remove('active'));
        document.querySelectorAll('.study-tab').forEach(b => b.classList.remove('active'));
        document.getElementById('panel-' + tab).classList.add('active');
        btn.classList.add('active');
    }

    /* Auto-open flashcards tab if URL has #flashcards */
    window.addEventListener('DOMContentLoaded', () => {
        if (window.location.hash === '#flashcards') {
            switchTab('flashcards', document.getElementById('flashcard-tab-btn'));
        }
    });

    /* ── Flip card ── */
    function flipCard(id) {
        document.getElementById(id).classList.toggle('flipped');
    }

    /* ── Expand/collapse note content ── */
    function toggleExpand(id, btn) {
        const el = document.getElementById(id);
        el.classList.toggle('expanded');
        btn.textContent = el.classList.contains('expanded') ? 'Show less' : 'Show more';
    }

    /* ── Note edit toggle ── */
    function openNoteEdit(id) {
        document.getElementById('note-display-' + id).style.display = 'none';
        document.getElementById('note-edit-' + id).classList.add('open');
    }
    function closeNoteEdit(id) {
        document.getElementById('note-edit-' + id).classList.remove('open');
        document.getElementById('note-display-' + id).style.display = '';
    }

    /* ── Flashcard edit toggle ── */
    function openFcEdit(id) {
        document.getElementById('fc-edit-' + id).classList.add('open');
    }
    function closeFcEdit(id) {
        document.getElementById('fc-edit-' + id).classList.remove('open');
    }
</script>

</body>
</html>
