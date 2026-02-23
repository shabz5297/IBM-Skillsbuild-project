<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <title>Register</title>
</head>
<body>

<div class="container">
    <h2>Register</h2>
    <% if (request.getAttribute("error") != null) { %>
    <p style="color:red;"><%= request.getAttribute("error") %></p>
    <% } %>

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

        <button type="submit">Register</button>
    </form>

    <p><a href="${pageContext.request.contextPath}/login">Back to login</a></p>
</div>

</body>
</html>