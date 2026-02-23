<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>User Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: darkseagreen;
            margin: 0;
            padding: 0;
        }

        .profile-container {
            max-width:  800px;
            margin: 60px auto;
            background: white;
            border-radius:  12px;
            padding:  30px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
        }

        .profile-header {
            text-align: center;
            margin-bottom: 30px;
        }


        .profile-header h2 {
            margin: 0;
            font-size: 28px;
        }

        .profile-section {
            margin-bottom: 25px;
        }

        .profile-section h3 {
            margin-bottom: 8px;
            color: #555;
        }

        .badge {
            display:  inline-block;
            background: darkkhaki;
            color: aliceblue;
            padding: 6px 12px;
            margin: 5px 5px 0 0;
            border-radius: 20px;
            font-size: 14px;
        }

        .edit-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 18px;
            background: #2196F3;
            color: white;
            border-radius: 6px;
            text-decoration: none;
            transition: 0.2s;
        }

        .edit-btn:hover {
            background: #1976D2;
        }



    </style>
</head>
<body>
<div class="profile-container">

    <div class="profile-header">
        <h2>${user.displayName != null ? user.displayName : user.username}</h2>
        <p>@${user.username}</p>
    </div>

    <div class="profile-section">
        <h3>Bio</h3>
        <p>${user.bio != null ? user.bio : "No bio yet."}</p>
    </div>

    <div class="profile-section">
        <h3>Badges</h3>
        <c:forEach var="badge" items="${user.badges}">
            <span class="badge">${badge.name}</span>
        </c:forEach>
    </div>

    <a href="/profile/${user.id}/edit" class="edit-btn">Edit Profile</a>

</div>
</body>
</html>