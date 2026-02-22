<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>
<h1>Available Courses</h1>

<div>
    <c:forEach var="course" items="${courses}">
        <div class="course-card">
            <h3>${course.title}</h3>
            <p><b>Category:</b> ${course.category}</p>
            <p>${course.description}</p>
            <a href="${course.link}" target="_blank">Start Course</a>
        </div>
    </c:forEach>
</div>
