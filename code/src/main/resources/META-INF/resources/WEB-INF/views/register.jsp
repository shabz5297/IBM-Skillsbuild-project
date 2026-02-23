<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <title>Register | SkillsBuild</title>
</head>
<body class="auth-bg">

<div class="container auth-card">
    <h1>SkillsBuild</h1>
    <h2>Create your account</h2>

    <% if (request.getAttribute("error") != null) { %>
    <p class="alert error"><%= request.getAttribute("error") %></p>
    <% } %>


    <div class="game-preview">
        <div class="badges">
            <span class="badge">Build</span>
            <span class="badge locked">Your</span>
            <span class="badge locked">Skills</span>
        </div>
        <p class="small muted">Sign up to begin earning badges.</p>
    </div>

    <form action="${pageContext.request.contextPath}/register" method="post">
        <p>Username:</p>
        <input name="username" required>

        <p>Password:</p>
        <input type="password"
               name="password"
               required
               minlength="8"
               maxlength="72"
               pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,72}$"
               title="Password must be at least 8 characters and include: uppercase, lowercase, number, and symbol.">

        <p>Confirm Password:</p>
        <input type="password" name="confirmPassword" required>

        <button class="btn primary" type="submit">Register</button>
    </form>

    <p class="small muted">
        Already have an account?
        <a href="${pageContext.request.contextPath}/login">Back to login</a>
    </p>
</div>

</body>
</html>