<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fines Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .login-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 400px;
            padding: 30px;
        }
        .login-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .login-header h2 {
            color: #333;
        }
        .login-options {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }
        .login-option {
            margin: 0 10px;
            position: relative;
        }
        .login-option input[type="radio"] {
            display: none;
        }
        .login-option label {
            display: block;
            padding: 10px 20px;
            border: 2px solid #667eea;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .login-option input[type="radio"]:checked + label {
            background-color: #667eea;
            color: white;
        }
        .login-form {
            display: flex;
            flex-direction: column;
        }
        .login-form input[type="email"], 
        .login-form input[type="password"] {
            margin-bottom: 15px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .login-form button {
            padding: 10px;
            background-color: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .login-form button:hover {
            background-color: #5a67d8;
        }
        .error-message {
            color: red;
            text-align: center;
            margin-bottom: 15px;
            font-size:14px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h2>Login</h2>
        </div>
        <% 
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
        %>
            <div class="error-message">
                <%= errorMessage %>
            </div>
        <% } %>
        
        <form class="login-form" action="LoginCheck" method="post">
            <div class="login-options">
                <div class="login-option">
                    <input type="radio" id="student" name="userRole" value="student" checked>
                    <label for="student">Student</label>
                </div>
                <div class="login-option">
                    <input type="radio" id="staff" name="userRole" value="staff">
                    <label for="staff">Staff</label>
                </div>
            </div>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
    </div>
</body>
</html>