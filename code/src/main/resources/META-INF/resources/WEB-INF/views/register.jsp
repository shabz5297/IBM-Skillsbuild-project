<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <title>Register</title>
</head>
<body>

<div class="container">
    <h2>Register</h2>

    <form action="${pageContext.request.contextPath}/register" method="post">
        <p>Username:</p>
        <input name="username" required>

        <p>Password:</p>
        <input type="password" name="password" required>

        <button type="submit">Register</button>
    </form>

    <p><a href="${pageContext.request.contextPath}/login">Back to login</a></p>
</div>

</body>
</html>