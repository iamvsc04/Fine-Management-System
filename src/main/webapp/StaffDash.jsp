<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Staff Dashboard - Fines Management</title>
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
            padding-bottom: 20px;
        }
        .fine-filter {
            margin-bottom: 20px;
        }
        .fine-filter select {
        	margin-top:20px;
        	padding: 8px;
            width: 200px;
        }
        .fine-sections {
            margin-top: 20px;
        }
        .fine-section {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .add-fine-btn {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            font-size: 30px;
            cursor: pointer;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            display: flex;
            justify-content: center;
            align-items: center;
            text-decoration: none;
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
        .action-btn {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 3px;
            margin-right: 5px;
        }
        .reject-btn {
            background-color: #f44336;
        }
    </style>
</head>
<body>
    <%
        String role = (String) session.getAttribute("role");
        String email = (String) session.getAttribute("email");
        String name = (String) session.getAttribute("name");
        if (role == null || !role.equals("staff")) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        Connection conn = null;
        PreparedStatement psNotPaid = null;
        PreparedStatement psPendingConfirmation = null;
        PreparedStatement psPaid = null;
        ResultSet rsNotPaid = null;
        ResultSet rsPendingConfirmation = null;
        ResultSet rsPaid = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/fines_management", "root", "IamVsc@1234");
            psNotPaid = conn.prepareStatement("SELECT * FROM fines WHERE payment_status = FALSE AND staff_confirmed = FALSE ORDER BY fine_date DESC");
            rsNotPaid = psNotPaid.executeQuery();
            psPendingConfirmation = conn.prepareStatement("SELECT * FROM fines WHERE payment_status = TRUE AND staff_confirmed = FALSE ORDER BY fine_date DESC");
            rsPendingConfirmation = psPendingConfirmation.executeQuery();
            psPaid = conn.prepareStatement("SELECT * FROM fines WHERE staff_confirmed = TRUE ORDER BY fine_date DESC");
            rsPaid = psPaid.executeQuery();
    %>
    <div class="dashboard-container">
        <div class="dashboard-header">
            <h1>Fines Management Dashboard</h1>
            <p>Welcome, <%= name %> | <a href="logout">Logout</a></p>
        </div>
        
        <div class="fine-filter">
            <select id="fineTypeFilter" onchange="filterFines()">
                <option value="not-paid">Not Paid Fines</option>
                <option value="pending-confirmation">Pending Confirmation</option>
                <option value="paid">Paid Fines</option>
            </select>
        </div>
        
        <div class="fine-sections">
            <div id="notPaidFinesSection" class="fine-section">
                <h2>Not Paid Fines</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Roll No</th>
                            <th>Dept</th>
                            <th>Amount</th>
                            <th>Reason</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% while(rsNotPaid.next()) { %>
                            <tr>
                                <td><%= rsNotPaid.getString("student_rollno") %></td>
                                <td><%= rsNotPaid.getString("dept") %></td>
                                <td>₹<%= rsNotPaid.getDouble("amount") %></td>
                                <td><%= rsNotPaid.getString("reason") %></td>
                                <td><%= rsNotPaid.getDate("fine_date") %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            
            <div id="pendingConfirmationSection" class="fine-section hidden">
                <h2>Pending Payment Confirmation</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Roll No</th>
                            <th>Dept</th>
                            <th>Amount</th>
                            <th>Reason</th>
                            <th>Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% while(rsPendingConfirmation.next()) { %>
                            <tr>
                                <td><%= rsPendingConfirmation.getString("student_rollno") %></td>
                                <td><%= rsPendingConfirmation.getString("dept") %></td>
                                <td>₹<%= rsPendingConfirmation.getDouble("amount") %></td>
                                <td><%= rsPendingConfirmation.getString("reason") %></td>
                                <td><%= rsPendingConfirmation.getDate("fine_date") %></td>
                                <td>
                                    <form action="ConfirmFineServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="fine_id" value="<%= rsPendingConfirmation.getInt("fine_id") %>">
                                        <input type="hidden" name="action" value="confirm">
                                        <button type="submit" class="action-btn">Confirm</button>
                                    </form>
                                    <form action="ConfirmFineServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="fine_id" value="<%= rsPendingConfirmation.getInt("fine_id") %>">
                                        <input type="hidden" name="action" value="reject">
                                        <button type="submit" class="action-btn reject-btn">Reject</button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            
            <div id="paidFinesSection" class="fine-section hidden">
                <h2>Paid Fines</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Roll No</th>
                            <th>Dept</th>
                            <th>Amount</th>
                            <th>Reason</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% while(rsPaid.next()) { %>
                            <tr>
                                <td><%= rsPaid.getString("student_rollno") %></td>
                                <td><%= rsPaid.getString("dept") %></td>
                                <td>₹<%= rsPaid.getDouble("amount") %></td>
                                <td><%= rsPaid.getString("reason") %></td>
                                <td><%= rsPaid.getDate("fine_date") %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
        
        <a href="add_fine.jsp" class="add-fine-btn">+</a>
    </div>
    
    <script>
        function filterFines() {
            const filter = document.getElementById('fineTypeFilter').value;
            const notPaidSection = document.getElementById('notPaidFinesSection');
            const pendingConfirmationSection = document.getElementById('pendingConfirmationSection');
            const paidSection = document.getElementById('paidFinesSection');
            notPaidSection.classList.add('hidden');
            pendingConfirmationSection.classList.add('hidden');
            paidSection.classList.add('hidden');
            switch(filter) {
                case 'not-paid':
                    notPaidSection.classList.remove('hidden');
                    break;
                case 'pending-confirmation':
                    pendingConfirmationSection.classList.remove('hidden');
                    break;
                case 'paid':
                    paidSection.classList.remove('hidden');
                    break;
            }
        }
    </script>
    <%
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(rsNotPaid != null) rsNotPaid.close();
                if(rsPendingConfirmation != null) rsPendingConfirmation.close();
                if(rsPaid != null) rsPaid.close();
                if(psNotPaid != null) psNotPaid.close();
                if(psPendingConfirmation != null) psPendingConfirmation.close();
                if(psPaid != null) psPaid.close();
                if(conn != null) conn.close();
            } catch(SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>