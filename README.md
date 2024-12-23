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
![Staff login page](https://github.com/user-attachments/assets/320d8818-5914-432c-9b91-b388054a5d48)
- **Manage Fines:** Add new fines for students.  
![Add new Fines Staff Dash](https://github.com/user-attachments/assets/0513c4df-ac0d-4c17-b2de-329380d0989a)
- **Verify Payments:** Approve or reject fines marked as paid.  
  ![Pending Confirmation Staff Dash](https://github.com/user-attachments/assets/03a2fba4-08c2-4cf7-b015-9fca1a947319)

- **View Tables:**
  - Students who have not paid fines.  
    ![Not Paid Fines Staff Dash](https://github.com/user-attachments/assets/0d587154-2c34-4610-9a62-81a9348e3610)
  - Students whose fines are fully paid.  
    ![Paid Fines Staff Dash](https://github.com/user-attachments/assets/8cdf761e-befb-4a4a-b761-73335cceb1e0)

- **Filter Options:** Filter fines based on:
  - Year
  - Department

### Student Side
- **Login Page:** Secure login to access the student panel.  
    ![login page](https://github.com/user-attachments/assets/1f915d0f-154b-40ff-8126-d8ca2a574d5b)

- **View Fines:** Students can see fines associated with their roll numbers.  
![Student Dashboard](https://github.com/user-attachments/assets/a10a4a3b-8b78-430d-9d9e-3f56e0a11c79)


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
