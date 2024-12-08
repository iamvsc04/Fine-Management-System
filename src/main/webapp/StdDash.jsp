<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Fines Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .dashboard-container {
            max-width: 1200px;
            margin: 20px auto;
            background-color: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #333;
            padding-bottom: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .hidden {
            display: none;
        }
        .pay-button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 3px;
        }
        .pay-button:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
    <%
        String email = (String) session.getAttribute("email");
        String rollno = (String) session.getAttribute("name");
        if (email==null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        Connection conn = null;
        PreparedStatement psPending = null;
        PreparedStatement psPaid = null;
        ResultSet rsPending = null;
        ResultSet rsPaid = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/fines_management", "root", "IamVsc@1234");
            psPending = conn.prepareStatement("SELECT * FROM fines WHERE student_rollno = ? AND payment_status = FALSE AND staff_confirmed = FALSE ORDER BY fine_date DESC");
            psPending.setString(1, rollno);
            rsPending = psPending.executeQuery();
            psPaid = conn.prepareStatement("SELECT * FROM fines WHERE student_rollno = ? AND (payment_status = TRUE OR staff_confirmed = TRUE) ORDER BY fine_date DESC");
            psPaid.setString(1, rollno);
            rsPaid = psPaid.executeQuery();
    %>
    
    <div class="dashboard-container">
        <div class="dashboard-header">
            <h1>Student Fines Dashboard</h1>
            <p>Welcome, <%= rollno %> | <a href="logout">Logout</a></p>
        </div>
	       <h2>Pending Fines</h2>
	       <table>
	           <thead>
	               <tr>
	                   <th>Date</th>
	                   <th>Amount</th>
	                   <th>Reason</th>
	                   <th>Pay</th>
	               </tr>
	           </thead>
	           <tbody>
	               <% while(rsPending.next()) { %>
	                   <tr>
	                       <td><%= rsPending.getDate("fine_date") %></td>
	                       <td><%= rsPending.getString("reason") %></td>
	                       <td>₹<%= rsPending.getDouble("amount") %></td>
	                       <td>
	                           <form action="PayFineServlet" method="post">
	                               <input type="hidden" name="fine_id" value="<%= rsPending.getInt("fine_id") %>">
	                               <button type="submit" class="pay-button">Pay Fine</button>
	                           </form>
	                       </td>
	                   </tr>
	               <% } %>
	           </tbody>
	       </table>
           
    </div>
    
    <script>
        function filterFines() {
            const filter = document.getElementById('fineTypeFilter').value;
            const pendingSection = document.getElementById('pendingFinesSection');
            const paidSection = document.getElementById('paidFinesSection');
            
            switch(filter) {
                case 'pending':
                    pendingSection.classList.remove('hidden');
                    paidSection.classList.add('hidden');
                    break;
                case 'paid':
                    pendingSection.classList.add('hidden');
                    paidSection.classList.remove('hidden');
                    break;
                default:
                    pendingSection.classList.remove('hidden');
                    paidSection.classList.remove('hidden');
            }
        }
    </script>
    
    <%
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(rsPending != null) rsPending.close();
                if(rsPaid != null) rsPaid.close();
                if(psPending != null) psPending.close();
                if(psPaid != null) psPaid.close();
                if(conn != null) conn.close();
            } catch(SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>