# IBM SkillsBuild Gamified Web App
### User Manual – Sprint 1 & Sprint 2

This guide explains how to run and use all features of our IBM SkillsBuild Gamified Web App.

---

# 1. Getting Started

## What You Need
- IntelliJ IDEA (recommended for compatibility with dependencies and user friendly UI)
- Java installed (project uses Java 21)
- A modern browser (Edge or Firefox recommended)
- Internet access (needed for GitHub login and IBM SkillsBuild course links)

---

## How to Set Up and Start the Application

1. **Clone the repository**
   ```bash
   git clone https://campus.cs.le.ac.uk/gitlab/co2303_2026/Group-05.git
   ```

2. **Open from the functional directory in IntelliJ and config file check**

   - In the IDE go to File → Open… and select the `Group-05/code` directory
   - This matters because the Gradle files (`build.gradle`, `gradlew`, `src/`) live inside the `code` directory
   - Opening `Group-05/` instead can cause Gradle and module detection issues on runtime
   - When IntelliJ displays "Load Gradle build scripts", press **Load**
   - Wait until the Gradle tool window shows tasks (bootRun, build, test)

3. **Configure your local database credentials**

   - Create a file at `src/main/resources/application-local.properties`
   - Add your local database credentials:
     ```
     spring.datasource.url=jdbc:mysql://localhost:3306/your_database_name
     spring.datasource.username=your_username
     spring.datasource.password=your_password
     ```
   - In IntelliJ, go to **Edit Configurations** → **Active profiles** and type `local`
   - This file is listed in `.gitignore` and will not be committed

4. **How to start the application**

   - In the project tree, go to `code/src/main/java/.../Group05Application.java`
   - Right-click `Group05Application` → **Run** (or use the green run icon at the top right)
   - Once started, open your browser and visit: `http://localhost:8080`

![Application running on localhost](Documentation/User%20Manual/Screenshots/Sprint%201/01-dashboard.png)

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

### How to Register

1. Open the application at `http://localhost:8080`
2. Click **Create an Account**
3. Enter your username and password following the rules above
4. Click **Register**

![Registration page](Documentation/User%20Manual/Screenshots/Sprint%201/02-registration-page.png)

![Registration validation error for weak password](Documentation/User%20Manual/Screenshots/Sprint%201/03-registration-validation.png)

---

## 2.2 Login with Username & Password

### How to Login

1. Navigate to the login page
2. Enter your username and password
3. Click **Sign in**

![Login page](Documentation/User%20Manual/Screenshots/Sprint%201/04-login-page.png)

### Result

- Correct credentials redirect you to the dashboard
- Incorrect credentials display an error message
- Session persists until logout or expiration

---

# 3. GitHub Login (OAuth2 Authentication)

To improve user experience, you may log in using GitHub instead of creating a separate password.

---

## 3.1 Login Using GitHub

### How It Works

1. On the login page, click **Continue with GitHub**
2. You will be redirected to GitHub
3. Authorise the application if prompted
4. After successful authentication, you are redirected back to the app

---

## 3.2 First-Time GitHub Login

If this is your first time logging in with GitHub:

- The system automatically creates a new user account
- No manual password setup is required
- Your account becomes linked to your GitHub identity

---

# 4. View Courses

After successfully logging in, you are redirected to the **Home Dashboard**.

This page contains:
- Your **Level**
- Your **Points**
- Your **Global Rank**
- Your **Streak**
- Your saved courses
- Routes to IBM SkillsBuild courses

![Home dashboard overview](Documentation/User%20Manual/Screenshots/Sprint%201/06-dashboard-overview.png)

---

## 4.1 Viewing All Courses

Scroll to the **Your Courses** or **All Courses** section on the dashboard.

Each course card displays:
- Course Title
- Category (AI, Cloud, Data Science, Security, etc.)
- Short description
- **Start Course** button
- **Mark Completed** button
- Star (⭐) button to save

![Course card example](Documentation/User%20Manual/Screenshots/Sprint%201/07-course-card.png)

---

## 4.2 Starting a Course

1. Click **Start Course →**
2. You will be redirected to the IBM SkillsBuild external course page

### Result
- The IBM SkillsBuild page opens in a new tab
- You can complete the course externally
- Progress is not automatic — you must manually confirm completion in the app

---

## 4.3 Marking a Course as Completed

After finishing a course:

1. Return to the dashboard
2. Click **Mark Completed** on the course card

![Marking a course as completed](Documentation/User%20Manual/Screenshots/Sprint%201/08-course-completion.png)

### Result
- The course is recorded as completed in the database
- Points are awarded
- Your level may increase if the threshold is reached
- The leaderboard updates automatically
- The same course cannot be marked completed multiple times

---

## 4.4 Saving Courses

1. Click the ⭐ icon on any course card
2. The course will appear in the **Your Courses** section at the top of the dashboard

---

# 5. Search & Filter Courses

## 5.1 Searching by Keyword

1. Navigate to the **Browse** page from the sidebar
2. Type a keyword into the search bar

## 5.2 Filtering by Category

1. Select a category from the filter options (AI, Cloud, Data Science, Security, etc.) and press **Search**
2. The course list updates to show only matching courses

![Search and filter on the browse page](Documentation/User%20Manual/Screenshots/Sprint%201/09-search-filter.png)

Both search and filter can be used at the same time across all available courses.

---

# 6. User Profile Management

Users can edit and personalise their profile information.

---

## 6.1 Accessing Your Profile

1. Click your **username button** in the top right corner
2. You will be redirected to the profile page

---

## 6.2 Editing Your Profile

On the profile page you can modify:

- Display Name
- Bio
- Email
- Profile Picture

### Steps

1. Click **Edit Profile**
2. Update the fields you wish to change
3. Upload a profile picture (optional)
4. Click **Save Changes**

![Profile page](Documentation/User%20Manual/Screenshots/Sprint%201/10-profile-page.png)

![Edit profile form](Documentation/User%20Manual/Screenshots/Sprint%201/11-edit-profile.png)

### Result
- Changes are saved to the backend
- A confirmation message is displayed
- Updated information persists after logout and login

---

# 7. Global Leaderboard

The leaderboard reflects your performance compared to all other students and updates automatically when course points change.

---

## 7.1 Viewing the Leaderboard

1. Click **Leaderboard** in the sidebar

Displayed columns include:
- Rank (#)
- Student Name
- Level
- Points
- Badges

![Global leaderboard](Documentation/User%20Manual/Screenshots/Sprint%201/12-leaderboard.png)

---

## 7.2 Rank Calculation

Leaderboard ranking is determined by total course points earned. When you complete a course and earn points, your level increases if the threshold is reached and your global rank updates automatically. Your own row is visually highlighted so you can easily identify your position.

---

## 7.3 Friends Leaderboard Filter

The leaderboard can also be filtered to show only you and your accepted friends.

1. Click the **Friends** toggle button at the top of the leaderboard page
2. The view switches to show only you and your friends ranked by points
3. Click **Global** to return to the full rankings

![Friends leaderboard filter](Documentation/User%20Manual/Screenshots/Sprint%202/08-friends-leaderboard.png)

Your row remains highlighted in both views.

---

# 8. Levels & Points System

## 8.1 How Levels Work

- Every student starts at **Level 0**
- Completing courses awards **points**
- Every **30 points** earned equals one level up
- Levels upgrade automatically when the threshold is reached

## 8.2 Progress Bar

The progress bar on your profile shows how far through your current level you are, displayed as a percentage toward the next level threshold.

![Level progress bar on the profile](Documentation/User%20Manual/Screenshots/Sprint%202/04-levels-profile.png)

## 8.3 Where Your Level is Displayed

Your current level is visible on:
- The home dashboard stats bar
- The leaderboard

---

# 9. Streaks

## 9.1 How Streaks Work

- The system tracks consecutive days of learning activity
- Each day you complete a course, your streak increases by one
- Missing a day resets your streak to zero
- Streak milestones can trigger visual indicators and rewards

## 9.2 Viewing Your Streak

Your current streak count is displayed on the home dashboard stats bar and on your profile page.

![Streak counter on the dashboard](Documentation/User%20Manual/Screenshots/Sprint%202/05-streak-counter.png)

---

# 10. Badges & Achievements

## 10.1 How Badges Work

Badges are awarded automatically when you reach specific milestones:

| Badge | How to Earn |
|---|---|
| 🎉 First Login | Log in to the app for the first time |
| 🌱 Beginner | Complete your first course |
| 🚀 Explorer | Complete three courses |
| 🤝 Socializer | Send or receive a friend request |
| 🏆 Monthly Goal Achiever | Complete a Monthly Goal |
| 🏆 Weekly Goal Achiever | Complete a Weekly Goal |
| 🏆 Daily Goal Achiever | Complete a Daily Goal |

## 10.2 Viewing Your Badges

1. Click **Achievements** in the sidebar
2. Earned badges are displayed in full colour
3. Locked badges are greyed out with a lock icon
4. Hover over any badge to see the unlock requirement

![Achievements page showing earned and locked badges](Documentation/User%20Manual/Screenshots/Sprint%202/06-badges-achievements.png)

Earned badges are also displayed on your profile page and on the leaderboard.

---

# 11. Side Navigation Menu

The sidebar is permanently visible across all dashboard pages and provides quick access to every section of the platform.

## 11.1 Navigation Links

| Link | Destination |
|---|---|
| 🏠 Home | Main dashboard |
| 📖 My Courses | Your saved courses |
| 🔍 Browse | Browse and search all courses |
| 🎯 Goals | Set and track course completion goals |
| 🏆 Leaderboard | Global and friends leaderboard |
| 👥 Friends | Friend requests and friends list |
| 🏅 Achievements | Badges and achievements |

![Persistent sidebar navigation](Documentation/User%20Manual/Screenshots/Sprint%202/01-sidebar-navigation.png)

The active page is highlighted in the menu so you always know where you are. The sidebar extends the full height of the page even on long scrollable pages.

---

# 12. Theme Toggle

## 12.1 Switching Between Light and Dark Mode

1. Click the **Light / Dark** toggle button in the top right of any dashboard page
2. The theme switches instantly across the entire interface

![Dark mode dashboard](Documentation/User%20Manual/Screenshots/Sprint%202/02-dark-mode.png)

![Light mode dashboard](Documentation/User%20Manual/Screenshots/Sprint%202/03-light-mode.png)

## 12.2 Theme Persistence

The selected theme is remembered across all pages and persists after a page refresh. All text, buttons, cards, and navigation remain fully readable in both themes.

---

# 13. Course Reviews

## 13.1 Leaving a Review

Reviews can only be submitted after you have marked a course as completed.

1. Navigate to the course you have completed
2. Scroll to the **Reviews** section
3. Select a star rating (1–5 stars)
4. Write a comment in the text field
5. Click **Submit Review**

![Course review submission form](Documentation/User%20Manual/Screenshots/Sprint%202/11-course-review.png)

### Result
- Your review is saved and displayed immediately for all users
- The course's average rating updates automatically
- You can only submit one review per course

## 13.2 Viewing Reviews

Each review displays:
- Star rating
- Written comment
- Timestamp of submission

---

# 14. Course Completion Goals

## 14.1 Creating a Goal

1. Click **Goals** in the sidebar
2. Click **Create Goal**
3. Enter the number of courses you want to complete
4. Select a time period (daily, weekly, or monthly)
5. Click **Save**

![Goal creation form](Documentation/User%20Manual/Screenshots/Sprint%202/09-goals-page.png)

## 14.2 Tracking Goal Progress

- Active goals are displayed on the dashboard and the goals page
- Progress updates automatically as you complete courses — no manual update needed
- A visual progress bar shows how close you are to your target

## 14.3 Completing a Goal

When you reach your target within the time period:
- A notification appears on the dashboard confirming the goal was completed
- You receive rewards — points, badges and level progression

![Completed goal with reward notification](Documentation/User%20Manual/Screenshots/Sprint%202/10-goal-completed.png)

## 14.4 Expired Goals

If the time period expires before you reach the target, the goal is automatically marked as **Incomplete**.

---

# 15. Adding Friends

## 15.1 Searching for a User

1. Click **Friends** in the sidebar
2. Type a username into the search bar
3. Click **Send Request** next to the user you want to add

![Friends page with search bar](Documentation/User%20Manual/Screenshots/Sprint%202/07-friends-page.png)

## 15.2 Accepting or Declining a Friend Request

1. Go to the **Friends** page
2. Pending requests appear in the **Incoming Requests** section
3. Click **Accept** or **Decline**

## 15.3 Friends List

Accepted friends appear in your friends list with their points and progress displayed. You can remove a friend at any time.

## 15.4 Friends Leaderboard

Once you have accepted friends, you can view a friends-only leaderboard from the Leaderboard page. See **Section 7.3** for details.

---

# 16. Flashcards & Notes

## 16.1 Accessing Study Mode

1. Click **My Courses** in the sidebar
2. Click the **Study** button on any course card
3. You will be taken to the study interface for that course

## 16.2 Creating Notes

1. In the study interface, go to the **Notes** tab
2. Enter a title and write your note content
3. Click **Save Note**

![Note creation interface](Documentation/User%20Manual/Screenshots/Sprint%202/13-notes.png)

Notes are linked to the specific course and saved to your account. You can view, edit, and delete notes at any time.

## 16.3 Creating Flashcards

1. Go to the **Flashcards** tab in the study interface
2. Enter a question (front of card) and an answer (back of card)
3. Click **Save Flashcard**

![Flashcard creation interface](Documentation/User%20Manual/Screenshots/Sprint%202/12-flashcards.png)

## 16.4 Study Mode

1. Click **Study Mode** to begin reviewing your flashcards
2. Each card shows the question — click or press the card to flip it and reveal the answer
3. Work through all cards at your own pace

![Flashcard study mode with card flip](Documentation/User%20Manual/Screenshots/Sprint%202/14-study-mode.png)

All flashcards and notes persist after logout and login.

---

# 17. Troubleshooting

## 17.1 Port 8080 Already in Use

If you see: `Port 8080 was already in use`

You can either stop the other process using port 8080, or change the port by adding this to your `application-local.properties` file:

```
server.port=8081
```

Then visit `http://localhost:8081` instead.

---

## 17.2 Database Connection Issues

- Ensure MySQL or MariaDB is running on your machine
- Ensure your `application-local.properties` has the correct `spring.datasource.url`, `spring.datasource.username`, and `spring.datasource.password`
- Ensure your local credentials file is not committed to Git — the path `src/main/resources/application-local.properties` should be listed in `.gitignore`

Restart the application after fixing any configuration issues.

---

## 17.3 Foreign Key Constraint Errors After Pulling from Main

If you see errors such as `Cannot add or update a child row: a foreign key constraint fails` after pulling the latest version from main, this is caused by a database schema mismatch.

Please follow the full step-by-step SQL fix documented in:

```
Documentation/DATABASE_MIGRATION_GUIDE.md
```

This guide covers all affected tables and provides the exact SQL commands needed to resolve the issue.

---

## 17.4 Profile Button Not Showing / Page Logs You Out

If you are logged in via GitHub OAuth2 and a page logs you out unexpectedly or shows an error, this is likely a known issue that has been resolved in the latest version of main. Ensure you have pulled the latest changes and run the database migration guide if needed.

---

# Feature Summary

| Feature | Sprint |
|---|---|
| Registration & Login | Sprint 1 |
| GitHub OAuth2 Login | Sprint 1 |
| Course Dashboard | Sprint 1 |
| Search & Filter Courses | Sprint 1 |
| User Profile Management | Sprint 1 |
| Course Completion Tracking | Sprint 1 |
| Global Leaderboard | Sprint 1 |
| Levels & Points System | Sprint 2 |
| Streak Tracking | Sprint 2 |
| Badges & Achievements | Sprint 2 |
| Persistent Side Navigation | Sprint 2 |
| Theme Toggle (Light/Dark) | Sprint 2 |
| Course Reviews | Sprint 2 |
| Course Completion Goals | Sprint 2 |
| Adding Friends | Sprint 2 |
| Friends Leaderboard Filter | Sprint 2 |
| Flashcards & Notes | Sprint 2 |