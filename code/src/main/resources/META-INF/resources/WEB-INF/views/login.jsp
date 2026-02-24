<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Login | SkillsBuild</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="auth-bg">

<div class="auth-card">
    <h1>SkillsBuild</h1>
    <p class="muted">Sign in to track courses, badges, and your progress.</p>

    <%
        if (request.getParameter("error") != null) {
    %>
    <p class="alert error">Invalid username or password.</p>
    <%
        }
        if (request.getParameter("logout") != null) {
    %>
    <p class="alert success">Logged out successfully.</p>
    <%
        }
    %>

    <a class="btn oauth" href="${pageContext.request.contextPath}/oauth2/authorization/github">
        Continue with GitHub
    </a>

    <div class="divider">or</div>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <label>Username</label>
        <input name="username" required>

        <label>Password</label>
        <input type="password" name="password" required>

        <button class="btn primary" type="submit">Sign in</button>
    </form>

    <p class="small muted">
        New here? <a href="${pageContext.request.contextPath}/register">Create an account</a>
    </p>
</div>

</body>
</html>