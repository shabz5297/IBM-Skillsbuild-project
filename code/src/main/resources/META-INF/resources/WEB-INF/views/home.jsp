<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <title>Home</title>
</head>
<body>

<div class="container">

    <h2>Welcome to the Home Page</h2>

    <p class="subtitle">You are logged in</p>

    <form action="${pageContext.request.contextPath}/logout" method="post">
        <button type="submit" class="logout-btn">Logout</button>
    </form>

</div>

</body>
</html>
