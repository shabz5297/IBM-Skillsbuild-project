<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Edit Your Profile</title>

    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }

        .profile-card {
            max-width: 600px;
            margin: 60px auto;
            background: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
        }

        .profile-header {
            text-align: center;
            margin-bottom: 25px;
        }

        .profile-header h2 {
            margin: 0;
            font-size: 24px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        .form-input {
            width: 100%;
            padding: 12px;
            border-radius: 12px;
            border: 2px solid #e0e0e0;
            margin-bottom: 18px;
            font-size: 14px;
            transition: 0.2s ease;
        }

        .form-input:focus {
            border-color: #58cc02;
            outline: none;
        }

        .save-button {
            width: 100%;
            background: #58cc02;
            border: none;
            padding: 12px;
            border-radius: 12px;
            color: white;
            font-weight: bold;
            font-size: 14px;
            cursor: pointer;
            transition: 0.2s ease;
        }

        .save-button:hover {
            background: #46a302;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #666;
            text-decoration: none;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .home-button {
            display: inline-block;
            margin-top: 15px;
            background: lightgreen;
            color: white;
            padding: 10px 16px;
            border-radius: 12px;
            text-decoration: none;
            font-weight: bold;
            transition: 0.2s;
        }

        .home-button:hover {
            background: darkgreen;
        }

    </style>
</head>

<body>
<a href="/home" class="home-button">🏠 Home</a>
<div class="profile-card">

    <div class="profile-header">
        <h2>Level Up Your Profile ✨</h2>
    </div>

    <form action="/profile/${user.id}/edit"
          method="post"
          enctype="multipart/form-data">

        <label>Display Name</label>
        <input type="text" name="displayName"
               value="${user.displayName}"
               class="form-input"/>

        <label>Bio</label>
        <textarea name="bio"
                  class="form-input">${user.bio}</textarea>

        <label>Email</label>
        <input type="text" name="email"
               value="${user.email}"
               class="form-input"/>

        <label>Profile Picture</label>
        <input type="file"
               name="profileImage"
               accept="image/*"
               class="form-input"
               id="imageInput"/>

        <div style="text-align: center; margin-bottom:20px;">

        <img id="imagePreview"
             src="${user.profilePicture}"
             style="width:120px;
                    height:120px;
                    border-radius:50%;
                    margin-top: 10px;
                    object-fit: cover;
                    border: 3px solid #e0e0e0;" />
        </div>


        <button type="submit" class="save-button">
            Save Changes
        </button>

    </form>

    <a href="/profile/${user.id}" class="back-link">
        ← Back to Profile
    </a>

</div>
<script>
    const imageInput = document.getElementById("imageInput");
    const imagePreview = document.getElementById("imagePreview");

    imageInput.addEventListener("change", function(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                imagePreview.src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });
</script>
</body>
</html>