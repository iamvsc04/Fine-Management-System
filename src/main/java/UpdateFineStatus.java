import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UpdateFineStatus")
public class UpdateFineStatus extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/fines_management";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "IamVsc@1234";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null || 
            !session.getAttribute("role").equals("staff")) {
            response.sendRedirect("login.jsp");
            return;
        }
        int fineId = Integer.parseInt(request.getParameter("fine_id"));

        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String sql = "UPDATE fines SET payment_status = TRUE WHERE fine_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, fineId);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                session.setAttribute("successMessage", "Fine status updated successfully");
                response.sendRedirect("StaffDash.jsp");
            } else {
                session.setAttribute("errorMessage", "Fine not found or no changes made");
                response.sendRedirect("StaffDash.jsp");
            }
        } catch (ClassNotFoundException e) {
            log("Database driver error", e);
            throw new ServletException("Database driver error", e);
        } catch (SQLException e) {
            log("Database error", e);
            session.setAttribute("errorMessage", "Database error: " + e.getMessage());
            response.sendRedirect("staffDash.jsp");
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