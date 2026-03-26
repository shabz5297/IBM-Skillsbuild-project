# Definiton of Done (DoD)

## Core Definition

A user story is considered done when all the following criteria are met

1. **Functionality Tested**
- All features must be tested manually and/or with tests

2. **Complete Code**
- Code must be complete and the frontend and backend must work together as intended

3. **Documentation Updated**
- Whilst working on a user story, you must consistently update the documentation directory to keep everything up to date

4. **No Bugs**
- All identified bugs must be fixed or logged in GitLab issues

5. **Approved Merges**
- Merges must be done via GitLab Merge request and reviewed and up to date

6. **Meets Criteria**
- Must meet all the mandatory acceptance criteria of the user story

### DoD-A: Frontend User Stories

A frontend user story is also considered complete when:
- The UI is implemented using HTML, CSS, and Javascript and user interactions behave as expected with no console errors

### DoD-B: Backend User Stories

A backend user story is also considered complete when:
- Functionality is implemented using Java and Spring Boot and input validation and error handling are implemented

### DoD-C: Database User Stories

A database user story is also considered complete when:
-Required tables are created/updated in the relational database and data can be stored and retrieved via the backend API

### DoD-D: Security User Stories

A security-related user story is also considered complete when:
-Sensitive data is not stored or transmitted in plain text and authentication/authorisation mechanisms are enforced where necessary.

## User Story to Definition of Done Mapping

### Sprint 1

| User Story ID | User Story                   | DoD Category |
|---------------|------------------------------|--------------|
| US-S1-01      | Registration & Login         | DoD-B        |
| US-S1-02      | OAuth2 Social Login          | DoD-D        |
| US-S1-03      | View Courses                 | DoD-A        |
| US-S1-04      | User Profile Management      | DoD-C        |
| US-S1-05      | Search & Filter Courses      | DoD-A        |
| US-S1-06      | Secure Password Management   | DoD-D        |
| US-S1-07      | Record Course Completion     | DoD-C        |
| US-S1-08      | Leaderboard                  | DoD-B        |

### Sprint 2

| User Story ID | User Story                   | DoD Category |
|---------------|------------------------------|--------------|
| US-S2-01      | Levels                       | DoD-B        |
| US-S2-02      | Streaks                      | DoD-B        |
| US-S2-03      | Badges                       | DoD-B        |
| US-S2-04      | Side Menu Navigation         | DoD-A        |
| US-S2-05      | Theme Toggle                 | DoD-A        |
| US-S2-06      | Course Review Feature        | DoD-C        |
| US-S2-07      | Course Completion Goals      | DoD-B        |
| US-S2-08      | Adding Friends               | DoD-C        |
| US-S2-09      | Flashcards and Notes         | DoD-C        |
| US-S2-10      | Friends Leaderboard          | DoD-B        |
