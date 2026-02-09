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

### 2. View Courses
**User Story:**  
- As a Student, I want to see a list or grid of available IBM SkillsBuild courses so that I can choose which course to start.

**Acceptance Criteria:**  
- Dashboard displays all available courses in a grid or list format.  
- Each course card shows the course title, category, and a short description (1–2 lines).  
- Clicking a course redirects the user to the IBM SkillsBuild course link.  
- Courses are dynamically loaded from the backend.  
- Courses that have been completed are visually marked (e.g., status label or icon).  

---

### 3. User Profile Management
**User Story:**  
- As a Student, I want to view and update my profile information so that my account details are accurate and personalized.

**Acceptance Criteria:**  
- Users can view their profile information (name, email, and preferences).  
- Users can update editable fields such as display name or preferences.  
- Changes are saved to the backend and persist after logout/login.  
- A confirmation message is displayed after successful updates.  

---

### 4. Search & Filter Courses
**User Story:**  
- As a Student, I want to search and filter IBM SkillsBuild courses by keywords and categories so that I can quickly find relevant courses.

**Acceptance Criteria:**  
- Users can type keywords into a search bar to filter courses by title.  
- Users can filter courses by category (e.g., AI, Cloud, Data Science).  
- Search results update dynamically as the user types or selects a filter.  
- The search and filter functionality works across all available courses.  

---

### 5. Secure Password Management
**User Story:**  
- As a Student, I want my password to be securely stored and managed so that my account is protected.

**Acceptance Criteria:**  
- Passwords must meet minimum security requirements (e.g., at least 8 characters, one number, one symbol).  
- Passwords are hashed before being stored in the backend.  
- Users can reset their password via a secure workflow.  
- The system does not store plain-text passwords.  

---

### 6. Record Course Completion 
**User Story:**  
- As a Student, I want the app to record when I complete an IBM SkillsBuild course so that my learning progress is tracked within the web app.

**Acceptance Criteria:**  
- Users can manually mark a course as “Completed” after returning from IBM SkillsBuild.  
- Completed courses are stored in the backend and linked to the user account.  
- Completed courses remain marked after logout and subsequent login.  
- The system prevents the same course from being marked completed multiple times.  
- Completion timestamps are recorded for each completed course.  

---

## Sprint 2

---

### 1. Leaderboard
**User Story:**  
- As a Student, I want to have a global leaderboard so that I can track my progress compared to other students and feel motivated to complete more courses.

**Acceptance Criteria:**  
- Leaderboard displays the top students globally based on points or level.  
- The logged-in user’s position is clearly highlighted.  
- Leaderboard updates automatically when a student completes a course or earns points.  
- Leaderboard shows student name, level, points, and earned badges.  

---

### 2. Levels
**User Story:**  
- As a Student, I want to have levels that indicate my progress so that I can feel a sense of accomplishment as I complete more courses.

**Acceptance Criteria:**  
- Users start at a “Beginner” level by default.  
- Experience points increase when courses are completed.  
- Level upgrades occur automatically when defined thresholds are reached.  
- The current level is visible on the dashboard, profile, and leaderboard.  

---

### 3. Streaks
**User Story:**  
- As a Student, I want to track my learning streak so that I am encouraged to return daily and maintain consistency.

**Acceptance Criteria:**  
- The system tracks consecutive days of learning activity.  
- The current streak is displayed on the dashboard or profile.  
- Missing a day resets the streak count.  
- Streak milestones can trigger visual indicators or rewards.  

---

### 4. Badges
**User Story:**  
- As a Student, I want to earn badges for completing courses or reaching milestones so that I feel rewarded and motivated to continue learning.

**Acceptance Criteria:**  
- Badges are awarded for course completion, level progression, or streak milestones.  
- Earned badges are displayed on the user profile and dashboard.  
- Users can view badge descriptions via hover or click interaction.  
- Badge data is stored in the backend and persists across sessions.  

