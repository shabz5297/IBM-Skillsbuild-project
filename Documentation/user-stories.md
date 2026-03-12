# IBM SkillsBuild Gamified Web App - User Stories

---

## Sprint 1

---

### 1. Registration & Login
**User Story:**  
- As a Student, I want to register and log in to the web app so that my learning progress is saved and tied to my account.

**Acceptance Criteria:**  
- Users can register using a valid university email and password.  
- Users can log in with correct credentials.  
- Invalid credentials display an appropriate error message.  
- User session persists until logout or expiration.  

---

### 2. OAuth2 Social Login
**User Story:**  
- As a Student, I want to log in using an OAuth2 provider (GitHub) so that I can access the app quickly without creating a separate password.

**Acceptance Criteria:**  
- Users can initiate login via a supported OAuth2 provider.  
- The system successfully authenticates users through the provider. 
- A new account is created automatically if the user logs in via OAuth2 for the first time. 
- Existing users are linked to their OAuth2 identity when emails match.
- Users are logged into the app after successful OAuth2 authentication
- User session persists until logout or session expiration.

---

### 3. View Courses
**User Story:**  
- As a Student, I want to see a list or grid of available IBM SkillsBuild courses so that I can choose which course to start.

**Acceptance Criteria:**  
- Dashboard displays all available courses in a grid or list format.  
- Each course card shows the course title, category, and a short description (1–2 lines).  
- Clicking a course redirects the user to the IBM SkillsBuild course link.  
- Courses are dynamically loaded from the backend.  
- Courses that have been completed are visually marked (e.g., status label or icon).  

---

### 4. User Profile Management
**User Story:**  
- As a Student, I want to view and update my profile information so that my account details are accurate and personalized.

**Acceptance Criteria:**  
- Users can view their profile information (name, email, and preferences).  
- Users can update editable fields such as display name or preferences.  
- Changes are saved to the backend and persist after logout/login.  
- A confirmation message is displayed after successful updates.  

---

### 5. Search & Filter Courses
**User Story:**  
- As a Student, I want to search and filter IBM SkillsBuild courses by keywords and categories so that I can quickly find relevant courses.

**Acceptance Criteria:**  
- Users can type keywords into a search bar to filter courses by title.  
- Users can filter courses by category (e.g., AI, Cloud, Data Science).  
- Search results update dynamically as the user types or selects a filter.  
- The search and filter functionality works across all available courses.  

---

### 6. Secure Password Management
**User Story:**  
- As a Student, I want my password to be securely stored and managed so that my account is protected.

**Acceptance Criteria:**  
- Passwords must meet minimum security requirements (e.g., at least 8 characters, one number, one symbol).  
- Passwords are hashed before being stored in the backend.  
- Users can reset their password via a secure workflow.  
- The system does not store plain-text passwords.  

---

### 7. Record Course Completion 
**User Story:**  
- As a Student, I want the app to record when I complete an IBM SkillsBuild course so that my learning progress is tracked within the web app.

**Acceptance Criteria:**  
- Users can manually mark a course as “Completed” after returning from IBM SkillsBuild.  
- Completed courses are stored in the backend and linked to the user account.  
- Completed courses remain marked after logout and subsequent login.  
- The system prevents the same course from being marked completed multiple times.  
- Completion timestamps are recorded for each completed course.  

---

### 8. Leaderboard
**User Story:**  
- As a Student, I want to have a global leaderboard so that I can track my progress compared to other students and feel motivated to complete more courses.

**Acceptance Criteria:**  
- Leaderboard displays the top students globally based on points or level.  
- The logged-in user’s position is clearly highlighted.  
- Leaderboard updates automatically when a student completes a course or earns points.  
- Leaderboard shows student name, level, points, and earned badges. 

---

## Sprint 2

---

### 1. Levels
**User Story:**  
- As a Student, I want to have levels that indicate my progress so that I can feel a sense of accomplishment as I complete more courses.

**Acceptance Criteria:**  
- Users start at a “Beginner” level by default.  
- Experience points increase when courses are completed.  
- Level upgrades occur automatically when defined thresholds are reached.  
- The current level is visible on the dashboard, profile, and leaderboard.  

---

### 2. Streaks
**User Story:**  
- As a Student, I want to track my learning streak so that I am encouraged to return daily and maintain consistency.

**Acceptance Criteria:**  
- The system tracks consecutive days of learning activity.  
- The current streak is displayed on the dashboard or profile.  
- Missing a day resets the streak count.  
- Streak milestones can trigger visual indicators or rewards.  

---

### 3. Badges
**User Story:**  
- As a Student, I want to earn badges for completing courses or reaching milestones so that I feel rewarded and motivated to continue learning.

**Acceptance Criteria:**  
- Badges are awarded for course completion, level progression, or streak milestones.  
- Earned badges are displayed on the user profile and dashboard.  
- Users can view badge descriptions via hover or click interaction.  

---

### 4. Side Menu Navigation
**User Story:**
- As a student, I want a persistent side navigation menu on the dashboard so that I can efficiently access the Courses, Leaderboard, Achievements, and Reviews sections of the platform.

**Acceptance Criteria:**
- The dashboard displays a persistent side navigation menu.
- The menu contains links to Courses, Leaderboard, Achievements, and Reviews.
- Selecting a menu item loads the corresponding page.
- The active page is clearly indicated in the menu.
- The menu is displayed consistently on all dashboard-related pages.
- The menu includes IBM SkillsBuild branding and logo.
- The menu layout remains usable across different screen sizes.

### 5. Theme Toggle

**User Story:**
- As a student, I want to toggle between light mode and dark mode on the dashboard so that I can personalise the interface for comfort and accessibility.

**Acceptance Criteria:**
- A theme toggle control is available on the dashboard.
- Users can switch between light and dark themes.
- The selected theme is applied to all dashboard-related pages.
- The chosen theme persists during navigation and page refresh.
- All text, buttons, cards, and navigation components remain readable in both themes.
- The interface clearly indicates the currently selected theme.

### 6. Course Review Feature

**User Story:**
- As a student, I want to leave a comment and a rating on a course after I have completed it so that I can suggest improvements or encourage others to complete the course.

**Acceptance Criteria:**
- A review section is available for each course.
- Students can submit a rating using a star rating system.
- Students can write a text comment alongside the rating.
- Reviews can only be submitted after the student has marked the course as completed.
- A student can only submit one review per course.
- Submitted reviews are displayed for all users to see.
- The course displays an average rating based on submitted reviews.
- Reviews display the rating, comment, and timestamp of when the review was submitted.

---

### 7. Course Completion Goals

**User Story:**
- As a student, I want to set goals for course completion (such as completing one course within a day, or three courses across a week) with rewards for achieving them so that I can increase my productivity and complete more courses.

**Acceptance Criteria:**
- Students can create a goal specifying the number of courses to complete within a defined time period.
- The dashboard displays the student’s active goals.
- The system tracks course completions toward the goal automatically.
- Progress towards each goal is visually displayed on the dashboard.
- When a goal is achieved, the student receives a reward such as points, badges, or level progression.
- The dashboard displays a notification when a goal has been completed.
- Expired goals are marked as incomplete if the target is not achieved within the time period.

---

### 8. Adding Friends 

**User Story:**
- As a student, I want to add friends so that our accounts can be linked and overall course progress can be compared.

**Acceptance Criteria:**
- Students can search for other users by username.
- Students can send and receive friend requests.
- Users can accept or decline friend requests.
- Accepted friends appear in the student’s friends list.
- A friends leaderboard displays the progress, points, or completed courses of connected friends.
- The leaderboard ranks friends based on their points or completed courses.
- The friends leaderboard is accessible from the dashboard navigation menu.

---

### 9. Flashcards and Notes for Courses 

**User Story:**
- As a Student, I want to create personal notes and flashcards for the courses I am studying so that I can review important concepts and reinforce my learning.

**Acceptance Criteria:**
- Students can create notes linked to a specific course.
- Students can create flashcards with a front (question) and back (answer).
- Flashcards and notes are saved to the student’s account and linked to the selected course.
- Students can view, edit, and delete their notes or flashcards.
- Flashcards can be reviewed in a study mode where the student can flip the card to reveal the answer.
- Notes and flashcards persist after logout and login.
- The dashboard or course page displays a section where users can access their notes and flashcards.




- Badge data is stored in the backend and persists across sessions.  

