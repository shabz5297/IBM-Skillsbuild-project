<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <title>Register | SkillsBuild</title>
</head>
<body class="auth-bg">

<div class="auth-card">
    <h1>SkillsBuild</h1>
    <h2>Build Your Skills</h2>
    <p class="muted">Sign up to begin earning badges.</p>

    <% if (request.getAttribute("error") != null) { %>
    <p class="alert error"><%= request.getAttribute("error") %></p>
    <% } %>

    <form action="${pageContext.request.contextPath}/register" method="post">
        <label>Username:</label>
        <input name="username" required>

        <label>Password:</label>
        <input type="password"
               name="password"
               required
               minlength="8"
               maxlength="72"
               pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,72}$"
               title="Password must be at least 8 characters and include: uppercase, lowercase, number, and symbol.">

        <label>Confirm Password:</label>
        <input type="password" name="confirmPassword" required>

        <button class="btn primary" type="submit">Register</button>
    </form>

    <p class="small muted">Already have an account?</p>
        <a href="${pageContext.request.contextPath}/login">Back to login</a>

</div>

</body>
</html>