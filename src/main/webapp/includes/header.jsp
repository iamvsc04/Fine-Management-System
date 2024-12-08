<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= request.getAttribute("pageTitle") != null ? request.getAttribute("pageTitle") : "Fines Management System" %></title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Arial', sans-serif;
            line-height: 1.6;
            background-color: #f4f4f4;
            color: #333;
        }
        
        /* Navigation Styles */
        .navbar {
            background-color: #2c3e50;
            color: white;
            padding: 1rem 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .navbar-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 15px;
        }
        .navbar-logo {
            font-size: 1.5rem;
            font-weight: bold;
            color: white;
            text-decoration: none;
        }
        .navbar-menu {
            display: flex;
            list-style: none;
        }
        .navbar-menu li {
            margin-left: 20px;
        }
        .navbar-menu a {
            color: white;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .navbar-menu a:hover {
            color: #3498db;
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .navbar-container {
                flex-direction: column;
                text-align: center;
            }
            .navbar-menu {
                margin-top: 15px;
                flex-direction: column;
            }
            .navbar-menu li {
                margin: 10px 0;
            }
        }
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 15px;
            background-color: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <%
        String role = (String) session.getAttribute("role");
        String name = (String) session.getAttribute("name");
    %>
    
    <nav class="navbar">
        <div class="navbar-container">
            <a href="#" class="navbar-logo">Fines Management</a>
            <ul class="navbar-menu">
                <% if (role == null) { %>
                    <li><a href="login.jsp">Login</a></li>
                <% } else if ("student".equals(role)) { %>
                    <li><a href="StdDash.jsp">Dashboard</a></li>
                    <li><a href="logout">Logout (<%= name %>)</a></li>
                <% } else if ("staff".equals(role)) { %>
                    <li><a href="StaffDash.jsp">Dashboard</a></li>
                    <li><a href="add_fine.jsp">Add Fine</a></li>
                    <li><a href="logout">Logout (<%= name %>)</a></li>
                <% } %>
            </ul>
        </div>
    </nav>
    <div class="container">
        <% 
        String successMessage = (String) session.getAttribute("message");
        String errorMessage = (String) session.getAttribute("error");
        
        if (successMessage != null) { %>
            <div class="alert alert-success"><%= successMessage %></div>
            <% session.removeAttribute("message"); 
        } %>
        
        <% if (errorMessage != null) { %>
            <div class="alert alert-error"><%= errorMessage %></div>
            <% session.removeAttribute("error"); 
        } %>