# Database Migration Guide
## Changes Made & How to Fix Common Errors After Pulling from Main

This guide documents all the changes made to the project and the SQL fixes required to resolve database schema mismatches that occur after pulling the latest version from main.

---

## Summary of Code Changes

### Sprint 1 Fixes
- **Sidebar** — The sidebar is now persistent and extends to the bottom of the page regardless of content length. The main content area is independently scrollable.
- **Profile Button** — The profile button now displays the logged-in user's username instead of 'Profile' and is consistent across all pages.

### Sprint 2 Features & Fixes
- **Friends Leaderboard Filter** — Added a toggle on the leaderboard page to switch between a global leaderboard and a friends-only leaderboard. The friends leaderboard shows the logged-in user and their accepted friends ranked by points.
- **Current User Highlighting** — The logged-in user's row is highlighted in a different colour on both the global and friends leaderboards.
- **Dark Mode Toggle** — The dark mode toggle is now consistent across all study pages.
- **Friends Page Profile Button** — Fixed the profile button not rendering on the friends page due to a missing model attribute.

---

## Database Fixes Required After Pulling from Main

After pulling from main, you may encounter a series of foreign key constraint errors. This is because the `User` entity table was renamed from `user` to `users`, but the existing database schema still has foreign keys referencing the old `user` table name.

Follow the steps below in order to fix all affected tables.

---

### Step 1 — Fix the user_badges Table

The `user_badges` join table may have a column name mismatch. Drop and let Hibernate recreate it:

```sql
DROP TABLE IF EXISTS user_badges;
```

After running this, restart your application and Hibernate will recreate the table automatically with the correct structure.

---

### Step 2 — Fix Foreign Keys Referencing the Old 'user' Table

Multiple tables have foreign key constraints pointing to the old `user` table instead of `users`. Before running the fix, delete any orphaned data that would prevent the constraints from being added.

#### 2a. Delete Orphaned Data

```sql
DELETE FROM course_completions 
WHERE user_id NOT IN (SELECT id FROM users);

DELETE FROM user_courses 
WHERE user_id NOT IN (SELECT id FROM users);

DELETE FROM friend_request 
WHERE sender_id NOT IN (SELECT id FROM users);

DELETE FROM friend_request 
WHERE receiver_id NOT IN (SELECT id FROM users);

DELETE FROM user_friends 
WHERE user_id NOT IN (SELECT id FROM users);

DELETE FROM user_friends 
WHERE friend_id NOT IN (SELECT id FROM users);
```

#### 2b. Fix course_completions Table

```sql
ALTER TABLE course_completions 
DROP FOREIGN KEY FKp6d76qrqxuppnarmayqrm9my2;

ALTER TABLE course_completions 
ADD CONSTRAINT fk_course_completions_user_id 
FOREIGN KEY (user_id) REFERENCES users(id);
```

#### 2c. Fix user_courses Table

```sql
ALTER TABLE user_courses 
DROP FOREIGN KEY FK4leaja1jtelxjs2iqqk4yuxna;

ALTER TABLE user_courses 
ADD CONSTRAINT fk_user_courses_user_id 
FOREIGN KEY (user_id) REFERENCES users(id);
```

#### 2d. Fix goals Table

```sql
ALTER TABLE goals 
DROP FOREIGN KEY FK93vx2ptki2jloeq8nkqxp0mpp;

ALTER TABLE goals 
ADD CONSTRAINT fk_goals_user_id 
FOREIGN KEY (user_id) REFERENCES users(id);
```

#### 2e. Fix reviews Table

```sql
ALTER TABLE reviews 
DROP FOREIGN KEY FKsdlcf7wf8l1k0m00gik0m6b1m;

ALTER TABLE reviews 
ADD CONSTRAINT fk_reviews_user_id 
FOREIGN KEY (user_id) REFERENCES users(id);
```

#### 2f. Fix friend_request Table

```sql
ALTER TABLE friend_request 
DROP FOREIGN KEY FK9rnftqmm2lmkhv4xrq8b9lp4f;

ALTER TABLE friend_request 
DROP FOREIGN KEY FKpu7xdjn95orp6rucjsxps7gkg;

ALTER TABLE friend_request 
ADD CONSTRAINT fk_friend_request_sender_id 
FOREIGN KEY (sender_id) REFERENCES users(id);

ALTER TABLE friend_request 
ADD CONSTRAINT fk_friend_request_receiver_id 
FOREIGN KEY (receiver_id) REFERENCES users(id);
```

#### 2g. Fix user_friends Table

```sql
ALTER TABLE user_friends 
DROP FOREIGN KEY FK9i7cldnk7cx2g47qex8ovm2ah;

ALTER TABLE user_friends 
DROP FOREIGN KEY FKm24u3115vx7bnje3b09oyflkd;

ALTER TABLE user_friends 
ADD CONSTRAINT fk_user_friends_user_id 
FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE user_friends 
ADD CONSTRAINT fk_user_friends_friend_id 
FOREIGN KEY (friend_id) REFERENCES users(id);
```

---

### Step 3 — Restart the Application

After running all the SQL commands above, restart your Spring Boot application. All foreign key constraints should now correctly reference the `users` table and the application should run without database errors.

---

## How to Run the SQL Commands

1. Open IntelliJ and go to the **Database** panel on the right side
2. Right click your database → **New → Query Console**
3. Make sure your schema (`group_05`) is selected in the schema dropdown at the top of the console
4. Paste and run the SQL commands above
5. Restart the Spring Boot application using the stop and play buttons in the top toolbar

---

## Notes

- These SQL fixes only need to be run once per local database instance
- If you get a `Can't DROP` error on any of the foreign key names, it means that constraint was already dropped in a previous attempt — skip that line and continue with the rest
- If you get a `Cannot add or update a child row` error when adding a new constraint, re-run the orphaned data deletion queries in Step 2a before retrying