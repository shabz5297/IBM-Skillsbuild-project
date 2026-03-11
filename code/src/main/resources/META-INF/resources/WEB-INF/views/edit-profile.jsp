<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Edit Your Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/editprofile.css">

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