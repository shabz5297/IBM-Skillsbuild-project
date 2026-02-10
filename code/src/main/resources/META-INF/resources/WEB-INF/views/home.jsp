<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html><head><title>Home</title></head><body>
<h2>HomePage</h2>
<p>logged in.</p>
<form action="${pageContext.request.contextPath}/logout" method="post">
    <button type="submit">Logout</button>
</form>
</body></html>