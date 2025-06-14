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

@WebServlet("/PayFineServlet")
public class PayFineServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
       
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("name") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int fineId = Integer.parseInt(request.getParameter("fine_id"));
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/fines_management", "root", "Sai@1234");
            ps = conn.prepareStatement("UPDATE fines SET payment_status = TRUE WHERE fine_id = ?");
            ps.setInt(1, fineId);
            int rowsUpdated = ps.executeUpdate();
            
            if (rowsUpdated > 0) {
                session.setAttribute("message", "Fine payment processed. Awaiting staff confirmation.");
            } else {
                session.setAttribute("error", "Failed to process fine payment.");
            }
            
            response.sendRedirect("StdDash.jsp");
            
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            session.setAttribute("error", "An error occurred while processing payment.");
            response.sendRedirect("StdDash.jsp");
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