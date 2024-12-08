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
- **Manage Fines:** Add new fines for students.
- **Verify Payments:** Approve or reject fines marked as paid.
- **View Tables:**
  - Students who have not paid fines.
  - Students who paid fines and are awaiting confirmation.
  - Students whose fines are fully paid.
- **Filter Options:** Filter fines based on:
  - Year
  - Department

### Student Side
- **Login Page:** Secure login to access the student panel.
- **View Fines:** Students can see fines associated with their roll numbers.
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
