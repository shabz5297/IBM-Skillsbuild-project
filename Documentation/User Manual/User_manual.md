# IBM SkillsBuild Gamified Web App  
### User Manual – Sprint 1

This guide explains how to run and use the core features of our IBM SkillsBuild Gamified Web App.
---

# Getting Started

## What You Need
- IntelliJ IDEA (recommended for compabtibility with dependencies and user friendly UI)
- Java installed (project uses Java 21)
- A modern browser (edge or Firefox reccommended)
- Internet access (needed for GitHub login and IBM SkillsBuild course links)

---

## How to Set up and start Application

1. **Clone the repository**
   ```bash
   git clone https://campus.cs.le.ac.uk/gitlab/co2303_2026/Group-05.git



2. **Open from the functional directory in IntelliJ and config file check**

- In IDE go to File -> Open… and press on the Group-05/code directory
- This matters because the Gradle files (build.gradle, gradlew, src/) live inside the code directory.
- Opening Group-05/ instead can cause Gradle and module detection issues on runtime. When IntelliJ displays “Load Gradle build scripts”, press Load.
- Wait until the Gradle tool window shows tasks (bootRun, build, test).

3. **How to start the application**

In the project tree, go to:
- code/src/main/java/.../Group05Application.java
- Right-click Group05Application → Run (or use the green run icon at the top-right).
- Once it starts, you can open your browser and visit: http://localhost:8080
- This section explains how to use the **Registration, Login, and Authentication** features of the application.

---

# 2. Registration & Login

The system allows users to authenticate in two ways:

- **Traditional Username + Password**
- **GitHub OAuth Login (recommended for convenience)**

User sessions remain active until logout or session expiration.

---

## 2.1 Register a New Account (Username + Password)

### Registration Requirements

When creating an account, users must follow these rules:

**Username Rules**
- Must be between **3–10 characters**
- Letters and numbers only
- No spaces or special characters

**Password Rules**
- Minimum **8 characters**
- Must include at least:
  - One number
  - One symbol
- Weak passwords are rejected with an error message

---

### How to Register

1. Open the application at:
2. Click **Create an Account**
3. Enter:
- Username(must be 3-10 characters and only contain numbers and letters)
- Password (Must be at least 8 characters and include uppercase, lowercase and symbols)
4. **Submit**

---

## 2.2 Login with Username & Password

### How to Login

1. Navigate to the login page
2. Enter your username and password
3. Click **Login**

---

###  Result

- Correct credentials redirect you to the dashboard
- Incorrect credentials display an error message
- Session persists until logout or expiration

---

## 3. GitHub Login (OAuth2 Authentication)

To improve user experience and reduce time, you may log in using GitHub instead of creating a separate password.

---

## 3.1 Login Using GitHub

### How It Works

1. On the login page, click **Login with GitHub**
2. You will be redirected to GitHub
3. Authorize the application if prompted
4. After successful authentication, you are redirected back to the app

---

---

## 3.2 First-Time GitHub Login

If this is your first time logging in with GitHub:

- The system automatically creates a new user account
- No manual password setup is required
Your account becomes linked to your GitHub identity.


# 4. View Courses

After successfully logging in, you are redirected to the **Home Dashboard**.

This page contains:
- Your **Level**
- Your **Points**
- Your **Global Rank**
- Your saved courses
- routes to IBM SkillsBuild courses

---

## 4.1 Viewing All Courses

Scroll to the **All Courses** section on the dashboard.

Each course card displays:
- Course Title  
- Category (AI, Cloud, Data Science, Security, etc.)  
- Short description  
- “Start Course” button  
- “Mark Completed” button  
- Star (⭐) button to save  



## 4.2 Starting a Course

1. Click **Start Course →**
2. You will be redirected to the IBM SkillsBuild external course page.

### Result
- The IBM SkillsBuild page opens.
- You can complete the course externally.
- Progress is not automatic, you must manually confirm completion in the app.

---

## 4.3 Marking a Course as Completed

After finishing a course:

1. Return to the dashboard.
2. Click **Mark Completed** on the course card.

###  Result
- The course is recorded as completed in the database.
- Points are awarded.
- Your Level may increase.
- Leaderboard updates automatically.
- The same course cannot be marked completed multiple times.

---

## 4.4 Saving Courses

1. Click the ⭐ icon on any course.
2. The course will appear in the **Your Courses** section above.



# 5. User Profile Management

Users can edit and personalise their profile information.

---

## 5.1 Accessing Profile

1. Click **Profile** (top-right corner).
2. You will be redirected to the profile page.

---

## 5.2 Editing Your Profile

On the **Edit Profile** page you can modify:

- Display Name  
- Bio  
- Email  
- Profile Picture  

### Steps

1. Update the fields you wish to change.
2. Upload a profile picture (optional).
3. Click **Save Changes**.


# 6. Global Leaderboard

The leaderboard reflects your performance compared to other students.
It updates automatically when course points change.

---

## 6.1 Viewing the Leaderboard

1. Scroll to the **Global Leaderboard** section on the Home page.

Displayed columns include:
- Rank (#)
- Student Name
- Level
- Points
- Badges

---

## 6.2 Rank Calculation

Leaderboard ranking is determined by:
- Total course points earned
- Level progression based on accumulated points

When you:
- Complete a course  
- Earn points  

Your:
- Level increases (if threshold reached)
- Global rank updates automatically

Your own row is visually highlighted so you can easily identify your position.

---

## 6.3 Level & Points System

- Completing courses awards points.
- Points contribute to your level progression.
- Higher levels increase leaderboard competitiveness.
- Rank updates dynamically based on total points across all users.

---


# TROUBLESHOOTING RUNTIME

## 1. Port 8080 Already in Use

If you see:

“Port 8080 was already in use”

You can:
- Stop the process using port 8080  
OR  
- Change the port inside:



## Common Problems

1. **Port 8080 already in use**

If you see: “Port 8080 was already in use”. Stop the other process using 8080, or change:
server.port=8081 in your application-local.properties file.

2. **Database connection issue or entities not loading into DBs**

- Ensure MariaDB or MYSQL is running.
- Ensure your application-local.properties has the correct DB_USER, DB_PASS and DB_URL
- Ensure your local credentials are not committed to git, the path should be in .git ignore as: 
               src/main/resources/application-local.properties

Restart the application after fixing configuration.

---

This covers thesse elements of Sprint 1:

- Registration & Login
- GitHub OAuth2
- Course dashboard
- Profile Editing
- Course Completion Tracking
- Global Leaderboard