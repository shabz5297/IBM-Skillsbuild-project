<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <title>Login</title>
</head>
<body>

<div class="container">
    <h2>Login</h2>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <p>Username:</p>
        <input name="username" required>

        <p>Password:</p>
        <input type="password" name="password" required>

        <button type="submit">Login</button>
    </form>

    <hr />

    <a class="oauth-btn" href="${pageContext.request.contextPath}/oauth2/authorization/github">
        Login with GitHub
    </a>
    <p><a href="${pageContext.request.contextPath}/register">Register</a></p>
</div>

</body>
</html>