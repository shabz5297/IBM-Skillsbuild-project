## 1. Overview

The system implements a client-server architecure and allows frontend, backend and data storage to operate independently with their own clear responsibilities. Our aooplication will not modify IBM SkillsBuild directly - it links to SkillsBuild resources and simulates a student's progress through a course in our system.

## 2. High-Level Architecture

The system consists of three main components that communicate using RESTful APIs over HTTP:

* Frontend (Presentation Layer - HTML, CSS, Javascript)
* Backend (Application and Logic Layer - Java/ Sprint Boot API)
* Database (Persistent Data Storage - MySQL)

## 3. Frontend

The frontend is a web-user interface that allows students to interact with our system. It will send HTTP requests to the backend to retrieve and update data, and render a response. Communication over HTTPS protects data in its transferral.

**Responsibilities**

*User authentication (login feature)

*Displaying courses

*Displaying the user stories we have listed

*Providing links to IBM SkillsBuild

## 4. Backend 

The backend is implemented using Java and Spring Boot using the IDE IntelliJ, following the MVC pattern.

**Responsibilities**

*Managing logic for gamification features

*Validating requests

*Error handling

*User authentication and authorisation

## 5. Database 

The database stores persistent data needed by the application, ensuring data integrity and structured data storage. The MySQL database is never accessed directly by the frontend, to reduce exposure of sensitive data.

**Responsibilities**

*User accounts and login details

*User story data that needs to be stored

## 6. Security-Focussed 

* May implement OAuth2 login to limit the amount of sensitive information handled by the system to improve privacy and security.
