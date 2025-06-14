<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Fines Dashboard</title>
    <style>
        /* Base Styles */
        :root {
            --primary-color: #3a86ff;
            --secondary-color: #8338ec;
            --success-color: #38b000;
            --warning-color: #ffbe0b;
            --danger-color: #ff006e;
            --light-color: #f8f9fa;
            --dark-color: #212529;
            --gradient-bg: linear-gradient(135deg, #8338ec 0%, #3a86ff 100%);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            transition: all 0.3s ease;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
            background-image: 
                radial-gradient(circle at 10% 20%, rgba(216, 241, 230, 0.46) 0%, rgba(233, 226, 226, 0.28) 90.1%);
            color: var(--dark-color);
            line-height: 1.6;
        }
        
        /* Dashboard Container & Header */
        .dashboard-container {
            max-width: 1200px;
            margin: 40px auto;
            background-color: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            animation: fadeIn 0.8s ease-in-out;
            position: relative;
            overflow: hidden;
        }
        
        .dashboard-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 8px;
            background: var(--gradient-bg);
        }
        
        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 20px;
            margin-bottom: 30px;
            border-bottom: 1px solid #eaeaea;
            position: relative;
        }
        
        .dashboard-header h1 {
            font-size: 28px;
            color: var(--dark-color);
            font-weight: 600;
            position: relative;
            padding-left: 15px;
        }
        
        .dashboard-header h1::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            height: 70%;
            width: 5px;
            background: var(--gradient-bg);
            border-radius: 3px;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            font-weight: 500;
        }
        
        .user-info a {
            margin-left: 15px;
            color: var(--primary-color);
            text-decoration: none;
            padding: 6px 12px;
            border-radius: 4px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .user-info a:hover {
            background-color: var(--primary-color);
            color: white;
        }
        
        /* Section Styles */
        section {
            margin-bottom: 30px;
            opacity: 0;
            transform: translateY(20px);
            animation: fadeInUp 0.5s ease-out forwards;
        }
        
        section h2 {
            font-size: 22px;
            margin-bottom: 15px;
            color: var(--dark-color);
            display: flex;
            align-items: center;
        }
        
        section h2::before {
            content: '';
            display: inline-block;
            width: 10px;
            height: 10px;
            background-color: var(--primary-color);
            margin-right: 10px;
            border-radius: 50%;
        }
        
        /* Table Styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }
        
        th, td {
            padding: 15px;
            text-align: left;
        }
        
        th {
            background: var(--gradient-bg);
            color: white;
            font-weight: 500;
            letter-spacing: 0.5px;
        }
        
        tr {
            background-color: white;
            border-bottom: 1px solid #eee;
        }
        
        tr:hover {
            background-color: #f9f9f9;
            transform: scale(1.01);
        }
        
        tr:last-child {
            border-bottom: none;
        }
        
        /* Filter controls */
        .filter-controls {
            margin-bottom: 20px;
            display: flex;
            justify-content: flex-end;
        }
        
        .filter-select {
            padding: 8px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: white;
            color: var(--dark-color);
            font-family: inherit;
            cursor: pointer;
            outline: none;
            transition: all 0.3s;
        }
        
        .filter-select:hover {
            border-color: var(--primary-color);
        }
        
        /* Button Styles */
        .pay-button {
            background: var(--success-color);
            color: white;
            border: none;
            padding: 8px 16px;
            cursor: pointer;
            border-radius: 5px;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .pay-button:hover {
            background-color: #2d9900;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        
        .pay-button:active {
            transform: translateY(0);
        }
        
        .pay-button:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
            box-shadow: none;
        }
        
        /* Utility classes */
        .hidden {
            display: none;
        }
        
        .badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: bold;
            color: white;
        }
        
        .badge-pending {
            background-color: var(--warning-color);
        }
        
        .badge-paid {
            background-color: var(--success-color);
        }
        
        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        @keyframes fadeInUp {
            from { 
                opacity: 0;
                transform: translateY(20px);
            }
            to { 
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        /* No records message */
        .no-records {
            text-align: center;
            padding: 30px;
            color: #666;
            background-color: #f9f9f9;
            border-radius: 8px;
            font-style: italic;
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .dashboard-container {
                margin: 20px;
                padding: 20px;
            }
            
            .dashboard-header {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .user-info {
                margin-top: 10px;
            }
            
            th, td {
                padding: 10px;
            }
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
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/fines_management", "root", "Sai@1234");
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
            <div class="user-info">
                <span>Welcome, <%= rollno %></span>
                <a href="logout">Logout</a>
            </div>
        </div>
        
        <div class="filter-controls">
            <select id="fineTypeFilter" class="filter-select" onchange="filterFines()">
                <option value="all">All Fines</option>
                <option value="pending">Pending Fines</option>
                <option value="paid">Paid Fines</option>
            </select>
        </div>
        
        <section id="pendingFinesSection" style="animation-delay: 0.2s">
            <h2>Pending Fines</h2>
            <% if(!rsPending.isBeforeFirst()) { %>
                <div class="no-records">
                    <p>You have no pending fines. Keep it up!</p>
                </div>
            <% } else { %>
                <table>
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Reason</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% while(rsPending.next()) { %>
                            <tr>
                                <td><%= rsPending.getDate("fine_date") %></td>
                                <td><%= rsPending.getString("reason") %></td>
                                <td>₹<%= rsPending.getDouble("amount") %></td>
                                <td><span class="badge badge-pending">Pending</span></td>
                                <td>
                                    <form action="PayFineServlet" method="post">
                                        <input type="hidden" name="fine_id" value="<%= rsPending.getInt("fine_id") %>">
                                        <button type="submit" class="pay-button">Pay Now</button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </section>
        
        <section id="paidFinesSection" style="animation-delay: 0.4s">
            <h2>Paid Fines</h2>
            <% if(!rsPaid.isBeforeFirst()) { %>
                <div class="no-records">
                    <p>No payment history found.</p>
                </div>
            <% } else { %>
                <table>
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Reason</th>
                            <th>Amount</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% while(rsPaid.next()) { %>
                            <tr>
                                <td><%= rsPaid.getDate("fine_date") %></td>
                                <td><%= rsPaid.getString("reason") %></td>
                                <td>₹<%= rsPaid.getDouble("amount") %></td>
                                <td><span class="badge badge-paid">Paid</span></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </section>
    </div>
    
    <script>
        // Animation for section elements
        document.addEventListener('DOMContentLoaded', function() {
            const sections = document.querySelectorAll('section');
            sections.forEach(section => {
                setTimeout(() => {
                    section.style.opacity = '1';
                    section.style.transform = 'translateY(0)';
                }, 100);
            });
        });
        
        // Filter functionality
        function filterFines() {
            const filter = document.getElementById('fineTypeFilter').value;
            const pendingSection = document.getElementById('pendingFinesSection');
            const paidSection = document.getElementById('paidFinesSection');
            
            switch(filter) {
                case 'pending':
                    pendingSection.classList.remove('hidden');
                    pendingSection.style.animation = 'fadeInUp 0.5s ease-out forwards';
                    paidSection.classList.add('hidden');
                    break;
                case 'paid':
                    pendingSection.classList.add('hidden');
                    paidSection.classList.remove('hidden');
                    paidSection.style.animation = 'fadeInUp 0.5s ease-out forwards';
                    break;
                default:
                    pendingSection.classList.remove('hidden');
                    pendingSection.style.animation = 'fadeInUp 0.5s ease-out forwards';
                    paidSection.classList.remove('hidden');
                    paidSection.style.animation = 'fadeInUp 0.5s ease-out forwards';
                    paidSection.style.animationDelay = '0.2s';
            }
        }
        
        // Pulse animation for pay buttons
        const payButtons = document.querySelectorAll('.pay-button');
        payButtons.forEach(button => {
            button.addEventListener('mouseover', function() {
                this.style.animation = 'pulse 1s infinite';
            });
            
            button.addEventListener('mouseout', function() {
                this.style.animation = 'none';
            });
        });
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