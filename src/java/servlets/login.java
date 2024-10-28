package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException; // Import SQLException
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "login", urlPatterns = {"/login"})
public class login extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the connection
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "thani@6304");

            // Get parameters from the request
            String n = request.getParameter("txtName");
            String p = request.getParameter("txtPwd");

            // Prepare and execute the SQL statement
            ps = con.prepareStatement("SELECT custId FROM customer WHERE name=? AND password=?");
            ps.setString(1, n);
            ps.setString(2, p);
            rs = ps.executeQuery();

            // Check if the user exists
            if (rs.next()) {
                // Store custId in the session
                int customerId = rs.getInt("custId"); // Use custId instead of customerId
                HttpSession session = request.getSession();
                session.setAttribute("customerId", customerId);

                // Redirect to the logged page
                response.sendRedirect("logged.jsp");
            } else {
                out.println("<font color=red size=18>Login Failed!!<br>");
                out.println("<a href=login.jsp>Try Again</a>");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            out.println("<font color=red size=18>Database Driver not found.</font>");
        } catch (SQLException e) { // Catch SQLException
            e.printStackTrace();
            out.println("<font color=red size=18>Database error: " + e.getMessage() + "</font>");
        } finally {
            // Close resources in reverse order of creation
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Login servlet for user authentication.";
    }
}