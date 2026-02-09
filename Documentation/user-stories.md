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
- Each course card shows the course title, category and a short description (1-2 lines).
- Clicking a course redirects the user to the IBM SkillsBuild course link.  
- Courses are dynamically loaded from the backend or a simulated API.  

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
- The search/filter function works on all courses in the dashboard.  

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

## Sprint 2

### 1. Leaderboard
**User Story:**  
- As a Student, I want to have a global leaderboard so that I can track my progress compared to other students and feel motivated to complete more courses.

**Acceptance Criteria:**  
- Leaderboard displays the top students globally by points or level.  
- Logged-in user’s row is highlighted.  
- Leaderboard updates automatically when a student completes a course or earns points.  
- Leaderboard shows student name, level, points, and badges earned.  

---

### 2. Levels
**User Story:**  
- As a Student, I want to have levels that indicate my progress so that I can feel a sense of accomplishment as I complete more courses.

**Acceptance Criteria:**  
- Users start at a “Beginner” level.  
- XP or progress points increase as courses are completed.  
- Level-up occurs automatically when XP thresholds are reached.  
- Current level is visible on the dashboard, profile, and leaderboard.  

---

### 3. Streaks
**User Story:**  
- As a Student, I want to track my learning streak so that I am encouraged to return daily and maintain consistency.

**Acceptance Criteria:**  
- System tracks consecutive days of course activity.  
- Streak is displayed on the dashboard/profile with an icon.  
- Missing a day resets the streak.  
- Streak milestones can trigger notifications or badges.  

---

### 4. Badges
**User Story:**  
- As a Student, I want to earn badges for completing courses or reaching milestones so that I feel rewarded and motivated to continue learning.

**Acceptance Criteria:**  
- Badges are awarded for completing courses, reaching new levels, or maintaining streaks.  
- Badges are displayed on the dashboard and profile.  
- Users can see badge descriptions when hovering over or clicking the badge.  
- Badge data is stored in the backend and persists across sessions.  

---
