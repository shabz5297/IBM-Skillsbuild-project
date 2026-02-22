<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Edit your Profile</title>
    <style>
        body{
            font-family: Arial, Helvetica, sans-serif;
            background-color: darkseagreen;
        }

        form {
            width: 400px;
            margin: 50px auto;
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        input, textarea{
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom:  15px;
        }

        button:hover {
            background: aliceblue;
        }
    </style>
</head>
<body>
<h2>Edit Profile</h2>
<form action="/profile/${user.id}/edit" method="post">
    <label>Username:</label>
    <input type="text" name="displayName" value="${user.displayName}"/>
    <br><br>

    <label>Bio:</label>
    <textarea name="bio">${user.bio}</textarea>
    <br><br>

    <label>Email:</label>
    <input type="text" name="email" value="${user.email}"/>
    <br><br>

    <button type="submit">Save Changes</button>
</form>
</body>
</html>