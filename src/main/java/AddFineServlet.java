import java.io.IOException;

import java.sql.*;
import java.time.LocalDate;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AddFineServlet")
public class AddFineServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/fines_management";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Sai@1234";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null || 
            !session.getAttribute("role").equals("staff")) {
            response.sendRedirect("login.jsp");
            return;
        }
        String studentRollno = request.getParameter("student_rollno");
        int year = Integer.parseInt(request.getParameter("year"));
        String dept = request.getParameter("dept");
        double amount = Double.parseDouble(request.getParameter("amount"));
        String reason = request.getParameter("reason");
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String sql = "INSERT INTO fines (student_rollno, year, dept, amount, reason, fine_date, payment_status) " +
                         "VALUES (?, ?, ?, ?, ?, ?, FALSE)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, studentRollno);
            pstmt.setInt(2, year);
            pstmt.setString(3, dept);
            pstmt.setDouble(4, amount);
            pstmt.setString(5, reason);
            pstmt.setDate(6, Date.valueOf(LocalDate.now()));
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                session.setAttribute("successMessage", "Fine added successfully");
                response.sendRedirect("StaffDash.jsp");
            } else {
                request.setAttribute("errorMessage", "Failed to add fine");
                request.getRequestDispatcher("add_fine.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException e) {
            log("Database driver error", e);
            throw new ServletException("Database driver error", e);
        } catch (SQLException e) {
            log("Database error", e);
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("add_fine.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            log("Invalid number format", e);
            request.setAttribute("errorMessage", "Invalid number format");
            request.getRequestDispatcher("add_fine.jsp").forward(request, response);
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                log("Error closing database resources", e);
            }
        }
    }
}