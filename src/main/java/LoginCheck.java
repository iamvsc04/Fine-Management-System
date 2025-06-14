import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginCheck")
public class LoginCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String url="jdbc:mysql://localhost:3306/fines_management";
	String user="root";
	String Password="Sai@1234";

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email=request.getParameter("email");
		String pass=request.getParameter("password");
		String role=request.getParameter("userRole");
		response.setContentType("text/html");
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			System.out.println(e);
		}
		try {
			Connection conn=DriverManager.getConnection(url,user,Password);
			PreparedStatement stmt = conn.prepareStatement("SELECT * FROM " + role + " WHERE email = ? AND pass = ?");
			stmt.setString(1, email);
			stmt.setString(2, pass);
			ResultSet rs=stmt.executeQuery();
			if (rs.next()) {
				String name=rs.getString(1);
				HttpSession session = request.getSession();
				session.setAttribute("email", email);
				session.setAttribute("role", role);
				session.setAttribute("name",name);
				if ("student".equals(role)) {
                    response.sendRedirect("StdDash.jsp");
                } else{
                    response.sendRedirect("StaffDash.jsp");
                }
            } else {
                request.setAttribute("errorMessage", "Email/Password does not match. Please try again!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                dispatcher.forward(request, response);
            }
		} catch (SQLException e) {
			System.out.println(e);
		}
		
	}

}
