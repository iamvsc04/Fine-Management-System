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
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

/* Loading Screen Styles */
.loading-screen {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(-45deg, #6e48aa, #9d50bb, #6a82fb, #1e54e7);
  background-size: 400% 400%;
  animation: gradient 15s ease infinite;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  z-index: 9999;
  transition: opacity 0.8s ease-out, visibility 0.8s;
}

.loader {
  position: relative;
  width: 120px;
  height: 120px;
}

.loader-circle {
  position: absolute;
  width: 100%;
  height: 100%;
  border: 8px solid transparent;
  border-top-color: white;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

.loader-circle:nth-child(1) {
  animation-delay: 0s;
}

.loader-circle:nth-child(2) {
  width: 80%;
  height: 80%;
  top: 10%;
  left: 10%;
  border-top-color: rgba(255, 255, 255, 0.8);
  animation-delay: 0.2s;
}

.loader-circle:nth-child(3) {
  width: 60%;
  height: 60%;
  top: 20%;
  left: 20%;
  border-top-color: rgba(255, 255, 255, 0.6);
  animation-delay: 0.4s;
}

.loader-text {
  margin-top: 40px;
  color: white;
  font-size: 24px;
  font-weight: 600;
  letter-spacing: 2px;
  text-align: center;
  opacity: 0;
  animation: fadeIn 1s ease forwards 0.5s;
}

.loading-screen.hidden {
  opacity: 0;
  visibility: hidden;
}

@keyframes spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

@keyframes gradient {
  0% {
    background-position: 0% 50%;
  }
  50% {
    background-position: 100% 50%;
  }
  100% {
    background-position: 0% 50%;
  }
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}


body {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background: linear-gradient(-45deg, #6e48aa, #9d50bb, #6a82fb, #1e54e7);
  background-size: 400% 400%;
  animation: gradient 15s ease infinite;
  position: relative;
  overflow: hidden;
}

body::before {
  content: "";
  position: absolute;
  width: 150%;
  height: 150%;
  top: -25%;
  left: -25%;
  background: url("data:image/svg+xml,%3Csvg width='100' height='100' viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M11 18c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm48 25c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm-43-7c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm63 31c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM34 90c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm56-76c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM12 86c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm28-65c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm23-11c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-6 60c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm29 22c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zM32 63c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm57-13c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-9-21c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM60 91c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM35 41c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM12 60c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2z' fill='rgba(255,255,255,.1)' fill-rule='evenodd'/%3E%3C/svg%3E");
  z-index: 0;
  pointer-events: none;
  opacity: 0.3;
}

.login-container {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border-radius: 16px;
  box-shadow: 0 10px 25px rgba(0,0,0,0.1);
  width: 100%;
  max-width: 400px;
  padding: 35px;
  z-index: 1;
  animation: fadeIn 0.8s ease-out forwards, pulse 6s infinite ease-in-out;
  transform-origin: center center;
  transition: all 0.3s ease;
  opacity: 0;
}

.login-container.visible {
  opacity: 1;
}

.login-container:hover {
  transform: translateY(-5px) scale(1.01);
  box-shadow: 0 15px 30px rgba(0,0,0,0.15);
}

.login-header {
  text-align: center;
  margin-bottom: 30px;
  animation: fadeIn 0.8s ease-out 0.2s both;
}

.login-header h2 {
  color: #333;
  position: relative;
  display: inline-block;
  font-size: 28px;
  letter-spacing: 1px;
}

.login-header h2::after {
  content: "";
  position: absolute;
  width: 50%;
  height: 3px;
  background: linear-gradient(90deg, #6a82fb, #1e54e7);
  bottom: -10px;
  left: 25%;
  border-radius: 2px;
  transition: width 0.3s ease;
}

.login-header h2:hover::after {
  width: 100%;
  left: 0;
}

.login-options {
  display: flex;
  justify-content: center;
  margin-bottom: 25px;
  animation: fadeIn 0.8s ease-out 0.4s both;
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
  padding: 12px 25px;
  border: 2px solid #6a82fb;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
  font-weight: 600;
  color: #6a82fb;
  position: relative;
  overflow: hidden;
  z-index: 1;
}

.login-option label::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, #6a82fb, #1e54e7);
  transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
  z-index: -1;
}

.login-option label:hover {
  transform: translateY(-3px);
  box-shadow: 0 5px 15px rgba(106, 130, 251, 0.3);
}

.login-option input[type="radio"]:checked + label {
  color: white;
  border-color: #1e54e7;
  box-shadow: 0 5px 15px rgba(30, 84, 231, 0.4);
  transform: translateY(-3px);
}

.login-option input[type="radio"]:checked + label::before {
  left: 0;
}

.login-form {
  display: flex;
  flex-direction: column;
  animation: fadeIn 0.8s ease-out 0.6s both;
}

.login-form input[type="email"],
.login-form input[type="password"] {
  margin-bottom: 20px;
  padding: 15px;
  border: 2px solid #ddd;
  border-radius: 8px;
  transition: all 0.3s ease;
  font-size: 16px;
  background-color: rgba(255, 255, 255, 0.7);
}

.login-form input[type="email"]:focus,
.login-form input[type="password"]:focus {
  border-color: #6a82fb;
  box-shadow: 0 0 0 3px rgba(106, 130, 251, 0.2);
  outline: none;
  transform: translateY(-2px);
}

.login-form button {
  padding: 15px;
  background: linear-gradient(90deg, #6a82fb, #1e54e7);
  color: white;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
  font-size: 16px;
  font-weight: 600;
  letter-spacing: 1px;
  position: relative;
  overflow: hidden;
  z-index: 1;
}

.login-form button::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, #1e54e7, #6e48aa);
  transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
  z-index: -1;
}

.login-form button:hover {
  transform: translateY(-3px);
  box-shadow: 0 10px 20px rgba(30, 84, 231, 0.3);
}

.login-form button:hover::before {
  left: 0;
}

.login-form button:active {
  transform: translateY(1px);
  box-shadow: 0 5px 10px rgba(30, 84, 231, 0.2);
}

.error-message {
  color: #e53e3e;
  text-align: center;
  margin-bottom: 20px;
  font-size: 15px;
  padding: 10px;
  background-color: rgba(229, 62, 62, 0.1);
  border-radius: 8px;
  border-left: 3px solid #e53e3e;
  animation: fadeIn 0.5s ease-out;
}
</style>
</head>
<body>
<!-- Loading Screen -->
<div class="loading-screen" id="loadingScreen">
  <div class="loader">
    <div class="loader-circle"></div>
    <div class="loader-circle"></div>
    <div class="loader-circle"></div>
  </div>
  <div class="loader-text">
    <div>FINES MANAGEMENT SYSTEM</div>
    <div style="font-size: 14px; margin-top: 8px; font-weight: normal; opacity: 0.8;">Loading...</div>
  </div>
</div>

<div class="login-container" id="loginContainer">
  <div class="login-header">
    <h2>Welcome Back</h2>
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
    <input type="email" name="email" placeholder="Enter your email" required>
    <input type="password" name="password" placeholder="Enter your password" required>
    <button type="submit">Sign In</button>
  </form>
</div>

<script>
  // Show loading screen for 2.5 seconds before displaying the login form
  document.addEventListener('DOMContentLoaded', function() {
    const loadingScreen = document.getElementById('loadingScreen');
    const loginContainer = document.getElementById('loginContainer');
    
    // Hide loading screen and show login form after 2.5 seconds
    setTimeout(function() {
      loadingScreen.classList.add('hidden');
      loginContainer.classList.add('visible');
    }, 2500);
  });
</script>
</body>
</html>