import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ConfirmFineServlet")
public class ConfirmFineServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null || 
            !session.getAttribute("role").equals("staff")) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int fineId = Integer.parseInt(request.getParameter("fine_id"));
        String action = request.getParameter("action");
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/fines_management", "root", "Sai@1234");
            
            if ("confirm".equals(action)) {
                ps = conn.prepareStatement("UPDATE fines SET staff_confirmed = TRUE WHERE fine_id = ?");
                ps.setInt(1, fineId);
                int rowsUpdated = ps.executeUpdate();
                
                if (rowsUpdated > 0) {
                    session.setAttribute("message", "Fine confirmed successfully.");
                } else {
                    session.setAttribute("error", "Failed to confirm fine.");
                }
            } else if ("reject".equals(action)) {
                ps = conn.prepareStatement("UPDATE fines SET payment_status = FALSE, staff_confirmed = FALSE WHERE fine_id = ?");
                ps.setInt(1, fineId);
                int rowsUpdated = ps.executeUpdate();
                
                if (rowsUpdated > 0) {
                    session.setAttribute("message", "Fine payment rejected.");
                } else {
                    session.setAttribute("error", "Failed to reject fine payment.");
                }
            }
            
            response.sendRedirect("StaffDash.jsp");
            
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            session.setAttribute("error", "An error occurred while processing the fine.");
            response.sendRedirect("StaffDash.jsp");
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}