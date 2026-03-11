<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Edit Profile</title>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&family=DM+Sans:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/editprofile.css">
</head>

<body>

<div style="max-width: 600px; margin: 0 auto; display: flex; align-items: center; gap: 12px; margin-bottom: 24px;">
    <a href="/home" class="home-button" style="margin-bottom: 0;">← Back to Dashboard</a>
    <button class="theme-toggle" id="themeToggle" onclick="toggleTheme()">☀️ Light</button>
</div>

<div class="profile-card">

    <div class="profile-header">
        <h2>Level Up Your Profile ✨</h2>
    </div>

    <form action="/profile/${user.id}/edit" method="post" enctype="multipart/form-data">

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

        <div class="avatar-preview-wrapper">
            <img id="imagePreview"
                 src="${user.profilePicture}"
                 alt="Profile preview"/>
        </div>

        <button type="submit" class="save-button">Save Changes</button>

    </form>

    <a href="/profile/${user.id}" class="back-link">← Back to Profile</a>

</div>
<script>
    function toggleTheme() {
        const isLight = document.body.classList.toggle('light-mode');
        document.getElementById('themeToggle').textContent = isLight ? '🌙 Dark' : '☀️ Light';
        localStorage.setItem('theme', isLight ? 'light' : 'dark');
    }

    if (localStorage.getItem('theme') === 'light') {
        document.body.classList.add('light-mode');
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('themeToggle').textContent = '🌙 Dark';
        });
    }
</script>
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