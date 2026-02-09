<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html><head><title>Login</title></head><body>
<h2>Login</h2>
<form action="${pageContext.request.contextPath}/login" method="post">
    <p>Username: <input name="username" required></p>
    <p>Password: <input type="password" name="password" required></p>
    <button type="submit">Login</button>
</form>
<p><a href="${pageContext.request.contextPath}/register">Register</a></p>
</body></html>