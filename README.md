# File Management System

## Table of Contents
1. [Description](#description)
2. [Features](#features)
3. [Technologies Used](#technologies-used)
4. [Installation](#installation)
5. [Usage](#usage)
6. [License](#license)

---

## Description
The **File Management System** is a web-based platform designed for managing and monitoring fines for students in an educational institution. It includes two user roles:
- **Admin:** Responsible for managing fines, verifying payments, and filtering records.
- **Student:** Able to view pending fines and make payments.

This project ensures a seamless process for both students and administrators to track, pay, and manage fines efficiently.

---

## Features

### Admin Side
- **Login Page:** Secure login to access the admin panel.  
  ![Login Page](Fine-Management-System/Images/login-page.png)

- **Manage Fines:** Add new fines for students.  
![Add new Fines Staff Dash](https://github.com/user-attachments/assets/0513c4df-ac0d-4c17-b2de-329380d0989a)
- **Verify Payments:** Approve or reject fines marked as paid.  
  ![Pending Confirmation Staff Dash](Images/Pending-Confirmation-Staff-Dash.png)

- **View Tables:**
  - Students who have not paid fines.  
    ![Not Paid Fines Staff Dash](Images/Not-Paid-Fines-Staff-Dash.png)
  - Students whose fines are fully paid.  
    ![Paid Fines Staff Dash](Images/Paid-Fines-Staff-Dash.png)

- **Filter Options:** Filter fines based on:
  - Year
  - Department

### Student Side
- **Login Page:** Secure login to access the student panel.  
  (Same as Admin Login Page)

- **View Fines:** Students can see fines associated with their roll numbers.  
  ![Student Dashboard](Images/Student-Dashboard.png)

- **Make Payments:** Interface for students to pay fines online.

---

## Technologies Used
- **Frontend:** HTML, CSS, JavaScript
- **Backend:** Java, JSP, Servlets
- **Database:** MySQL
- **Server:** Apache Tomcat

---

## Installation

### Prerequisites
- Java JDK 8 or higher
- Apache Tomcat (version 10.1 recommended)
- MySQL Database
- Eclipse IDE (optional)

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/file-management-system.git
   cd file-management-system
