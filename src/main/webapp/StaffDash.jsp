<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Staff Dashboard - Fines Management</title>
    <style>
        /* Global Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            transition: all 0.3s ease;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            background-attachment: fixed;
            min-height: 100vh;
            padding: 20px;
        }
        
        /* Dashboard Container */
        .dashboard-container {
            max-width: 1200px;
            margin: 20px auto;
            background: rgba(255, 255, 255, 0.9);
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transform: translateY(0);
            opacity: 1;
            animation: fadeIn 0.8s ease-in-out;
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
        
        /* Dashboard Header */
        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid transparent;
            padding-bottom: 20px;
            margin-bottom: 30px;
            position: relative;
            background: linear-gradient(to right, #1a2a6c, #b21f1f, #fdbb2d);
            background-clip: text;
            -webkit-background-clip: text;
            color: transparent;
        }
        
        .dashboard-header::after {
            content: '';
            position: absolute;
            width: 100%;
            height: 3px;
            bottom: 0;
            left: 0;
            background: linear-gradient(to right, #1a2a6c, #b21f1f, #fdbb2d);
            border-radius: 3px;
        }
        
        .dashboard-header p {
            color: #333;
            font-weight: 500;
        }
        
        .dashboard-header a {
            color: #1a2a6c;
            text-decoration: none;
            font-weight: bold;
            position: relative;
        }
        
        .dashboard-header a::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: -2px;
            left: 0;
            background-color: #1a2a6c;
            transition: width 0.3s ease;
        }
        
        .dashboard-header a:hover::after {
            width: 100%;
        }
        
        /* Fine Filter */
        .fine-filter {
            margin-bottom: 30px;
            display: flex;
            justify-content: center;
        }
        
        .fine-filter select {
            margin-top: 0;
            padding: 12px 15px;
            width: 250px;
            border: none;
            border-radius: 50px;
            background-color: #f0f2f5;
            font-size: 16px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            cursor: pointer;
            transition: all 0.3s ease;
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%23333' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 15px center;
            background-size: 15px;
        }
        
        .fine-filter select:focus {
            outline: none;
            box-shadow: 0 0 0 3px rgba(26, 42, 108, 0.2);
        }
        
        .fine-filter select:hover {
            background-color: #e9ecef;
            transform: translateY(-2px);
        }
        
        /* Fine Sections */
        .fine-sections {
            margin-top: 20px;
        }
        
        .fine-section {
            background-color: #fff;
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            transform: scale(1);
            opacity: 1;
        }
        
        .fine-section:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        
        .fine-section h2 {
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f2f5;
            color: #1a2a6c;
            position: relative;
        }
        
        .fine-section h2::after {
            content: '';
            position: absolute;
            width: 60px;
            height: 3px;
            bottom: -2px;
            left: 0;
            background: linear-gradient(to right, #1a2a6c, #b21f1f);
            border-radius: 3px;
            transition: width 0.3s ease;
        }
        
        .fine-section:hover h2::after {
            width: 120px;
        }
        
        /* Table Styles */
        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
        }
        
        th, td {
            padding: 15px;
            text-align: left;
            border: none;
        }
        
        th {
            background-color: #1a2a6c;
            color: white;
            font-weight: 500;
            text-transform: uppercase;
            font-size: 14px;
            letter-spacing: 0.5px;
        }
        
        tr {
            background-color: #fff;
            transition: all 0.3s ease;
        }
        
        tr:nth-child(even) {
            background-color: #f8f9fa;
        }
        
        tr:hover {
            background-color: #f0f2f5;
            transform: scale(1.01);
        }
        
        /* Amount formatting */
        td:nth-child(3) {
            font-weight: bold;
            color: #b21f1f;
        }
        
        /* Action Buttons */
        .action-btn {
            background: linear-gradient(to right, #1a2a6c, #2a4dad);
            color: white;
            border: none;
            padding: 8px 15px;
            cursor: pointer;
            border-radius: 50px;
            margin-right: 8px;
            font-weight: 500;
            box-shadow: 0 4px 6px rgba(26, 42, 108, 0.2);
            transition: all 0.3s ease;
        }
        
        .action-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 10px rgba(26, 42, 108, 0.3);
        }
        
        .reject-btn {
            background: linear-gradient(to right, #b21f1f, #e94057);
            box-shadow: 0 4px 6px rgba(178, 31, 31, 0.2);
        }
        
        .reject-btn:hover {
            box-shadow: 0 6px 10px rgba(178, 31, 31, 0.3);
        }
        
        /* Add Fine Button */
        .add-fine-btn {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background: linear-gradient(to right, #1a2a6c, #4CAF50);
            color: white;
            border: none;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            font-size: 30px;
            cursor: pointer;
            box-shadow: 0 5px 15px rgba(26, 42, 108, 0.3);
            display: flex;
            justify-content: center;
            align-items: center;
            text-decoration: none;
            transition: all 0.3s ease;
            z-index: 1000;
        }
        
        .add-fine-btn:hover {
            transform: rotate(90deg) scale(1.1);
            box-shadow: 0 8px 25px rgba(26, 42, 108, 0.4);
        }
        
        .add-fine-btn::before {
            content: '';
            position: absolute;
            width: 100%;
            height: 100%;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            opacity: 0;
            transform: scale(0.8);
            transition: all 0.3s ease;
        }
        
        .add-fine-btn:hover::before {
            opacity: 1;
            transform: scale(1.5);
        }
        
        /* Hidden Class with Animation */
        .hidden {
            display: none;
            opacity: 0;
            transform: translateY(20px);
            transition: opacity 0.5s ease, transform 0.5s ease;
        }
        
        /* Empty Table Message */
        .empty-table-message {
            text-align: center;
            padding: 30px;
            color: #888;
            font-style: italic;
        }
        
        /* Loading Animation */
        @keyframes pulse {
            0% { opacity: 0.6; }
            50% { opacity: 1; }
            100% { opacity: 0.6; }
        }
        
        .loading {
            animation: pulse 1.5s infinite;
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
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/fines_management", "root", "Sai@1234");
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
                        <% 
                        boolean hasNotPaidFines = false;
                        while(rsNotPaid.next()) { 
                            hasNotPaidFines = true;
                        %>
                            <tr>
                                <td><%= rsNotPaid.getString("student_rollno") %></td>
                                <td><%= rsNotPaid.getString("dept") %></td>
                                <td>₹<%= rsNotPaid.getDouble("amount") %></td>
                                <td><%= rsNotPaid.getString("reason") %></td>
                                <td><%= rsNotPaid.getDate("fine_date") %></td>
                            </tr>
                        <% } 
                        if (!hasNotPaidFines) { %>
                            <tr>
                                <td colspan="5" class="empty-table-message">No unpaid fines found</td>
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
                        <% 
                        boolean hasPendingFines = false;
                        while(rsPendingConfirmation.next()) { 
                            hasPendingFines = true;
                        %>
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
                        <% } 
                        if (!hasPendingFines) { %>
                            <tr>
                                <td colspan="6" class="empty-table-message">No pending confirmations</td>
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
                        <% 
                        boolean hasPaidFines = false;
                        while(rsPaid.next()) { 
                            hasPaidFines = true;
                        %>
                            <tr>
                                <td><%= rsPaid.getString("student_rollno") %></td>
                                <td><%= rsPaid.getString("dept") %></td>
                                <td>₹<%= rsPaid.getDouble("amount") %></td>
                                <td><%= rsPaid.getString("reason") %></td>
                                <td><%= rsPaid.getDate("fine_date") %></td>
                            </tr>
                        <% } 
                        if (!hasPaidFines) { %>
                            <tr>
                                <td colspan="5" class="empty-table-message">No paid fines found</td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
        
        <a href="add_fine.jsp" class="add-fine-btn">+</a>
    </div>
    
    <script>
        // Add loading animation on page load
        document.addEventListener('DOMContentLoaded', function() {
            document.body.classList.add('loaded');
        });
        
        function filterFines() {
            const filter = document.getElementById('fineTypeFilter').value;
            const notPaidSection = document.getElementById('notPaidFinesSection');
            const pendingConfirmationSection = document.getElementById('pendingConfirmationSection');
            const paidSection = document.getElementById('paidFinesSection');
            
            // First add the hidden class to all sections
            notPaidSection.classList.add('hidden');
            pendingConfirmationSection.classList.add('hidden');
            paidSection.classList.add('hidden');
            
            // After a short delay, show the selected section with animation
            setTimeout(() => {
                switch(filter) {
                    case 'not-paid':
                        notPaidSection.style.display = 'block';
                        setTimeout(() => {
                            notPaidSection.classList.remove('hidden');
                            pendingConfirmationSection.classList.add('hidden');
                            paidSection.classList.add('hidden');
                            notPaidSection.style.opacity = '1';
                            notPaidSection.style.transform = 'translateY(0)';
                        }, 50);
                        break;
                    case 'pending-confirmation':
                        pendingConfirmationSection.style.display = 'block';
                        setTimeout(() => {
                            pendingConfirmationSection.classList.remove('hidden');
                            notPaidSection.classList.add('hidden');
                            paidSection.classList.add('hidden');
                            pendingConfirmationSection.style.opacity = '1';
                            pendingConfirmationSection.style.transform = 'translateY(0)';
                        }, 50);
                        break;
                    case 'paid':
                        paidSection.style.display = 'block';
                        setTimeout(() => {
                            paidSection.classList.remove('hidden');
                            notPaidSection.classList.add('hidden');
                            pendingConfirmationSection.classList.add('hidden');
                            paidSection.style.opacity = '1';
                            paidSection.style.transform = 'translateY(0)';
                        }, 50);
                        break;
                }
            }, 300);
        }
        
        // Add animation to rows when they appear
        function animateRows() {
            const rows = document.querySelectorAll('tbody tr');
            rows.forEach((row, index) => {
                row.style.opacity = '0';
                row.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    row.style.opacity = '1';
                    row.style.transform = 'translateY(0)';
                }, 100 + (index * 50));
            });
        }
        
        // Call animation function after filtering or on page load
        document.addEventListener('DOMContentLoaded', function() {
            animateRows();
            
            // Add ripple effect to buttons
            const buttons = document.querySelectorAll('.action-btn');
            buttons.forEach(button => {
                button.addEventListener('click', function(e) {
                    const x = e.clientX - e.target.getBoundingClientRect().left;
                    const y = e.clientY - e.target.getBoundingClientRect().top;
                    
                    const ripple = document.createElement('span');
                    ripple.style.position = 'absolute';
                    ripple.style.width = '1px';
                    ripple.style.height = '1px';
                    ripple.style.borderRadius = '50%';
                    ripple.style.backgroundColor = 'rgba(255, 255, 255, 0.7)';
                    ripple.style.transform = 'scale(0)';
                    ripple.style.left = x + 'px';
                    ripple.style.top = y + 'px';
                    ripple.style.animation = 'ripple 0.6s linear';
                    
                    button.appendChild(ripple);
                    
                    setTimeout(() => {
                        ripple.remove();
                    }, 600);
                });
            });
        });
        
        // Reinitialize animation when changing tabs
        document.getElementById('fineTypeFilter').addEventListener('change', function() {
            setTimeout(animateRows, 400);
        });
        
        // Add keyframe animation for ripple effect
        const style = document.createElement('style');
        style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(30);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);
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