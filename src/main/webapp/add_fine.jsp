<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Fine</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .form-container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input, 
        .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .submit-btn {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <%
        String role = (String) session.getAttribute("role");
        if (role == null || !role.equals("staff")) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>
    <div class="form-container">
        <h2>Add New Fine</h2>
        <form action="AddFineServlet" method="post">
            <div class="form-group">
                <label for="student_rollno">Student Roll Number</label>
                <input type="text" id="student_rollno" name="student_rollno" required>
            </div>
            
            <div class="form-group">
			    <label for="year">Year</label>
			    <select id="year" name="year" required>
			        <option value="1">1st Year</option>
			        <option value="2">2nd Year</option>
			        <option value="3">3rd Year</option>
			        <option value="4">4th Year</option>
			    </select>
			</div>
            <div class="form-group">
                <label for="dept">Department</label>
                <select id="dept" name="dept" required>
                    <option value="AIML">AIML</option>
                    <option value="CIVIL">CIVIL</option>
                    <option value="CSE">CSE</option>
                    <option value="DS">DS</option>
                    <option value="ECE">ECE</option>
                    <option value="EEE">EEE</option>
                    <option value="MECHANICAL">MECHANICAL</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="amount">Fine Amount (₹)</label>
                <input type="number" id="amount" name="amount" min="0" step="0.01" required>
            </div>
            
            <div class="form-group">
                <label for="reason">Reason for Fine</label>
                <input type="text" id="reason" name="reason" required>
            </div>
            
            <button type="submit" class="submit-btn">Add Fine</button>
        </form>
    </div>
</body>
</html>