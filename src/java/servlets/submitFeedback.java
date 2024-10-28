package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SubmitFeedback", urlPatterns = {"/submitFeedback"})
public class submitFeedback extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                // Load the JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish the connection
                try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "thani@6304")) {
                    // Get parameters from the request
                    int custId = Integer.parseInt(request.getParameter("custId"));
                    String feedbackText = request.getParameter("feedbackText");
                    int rating = Integer.parseInt(request.getParameter("rating"));
                    java.sql.Date givenDate = new java.sql.Date(System.currentTimeMillis());

                    // Check if the customer ID exists in the customer table
                    try (PreparedStatement ps = con.prepareStatement("SELECT * FROM customer WHERE custId = ?")) {
                        ps.setInt(1, custId);
                        try (ResultSet rs = ps.executeQuery()) {
                            if (!rs.next()) {
                                out.println("<h2>Invalid Customer ID. Please provide a valid ID.</h2>");
                                return;
                            }
                        }
                    }

                    // Prepare and execute the SQL statement to insert feedback
                    try (PreparedStatement insertPs = con.prepareStatement("INSERT INTO feedback (custId, givenDate, feedbackText, rating) VALUES (?, ?, ?, ?)")) {
                        insertPs.setInt(1, custId);
                        insertPs.setDate(2, givenDate);
                        insertPs.setString(3, feedbackText);
                        insertPs.setInt(4, rating);
                        int rowsAffected = insertPs.executeUpdate();

                        // Check if the feedback was successfully inserted
                        if (rowsAffected > 0) {
                            out.println("<h2>Thank you for your feedback!</h2>");
                        } else {
                            out.println("<h2>Feedback submission failed. Please try again.</h2>");
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<font color=red size=18>Database error: " + e.getMessage() + "</font>");
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    out.println("<font color=red size=18>Invalid input. Please ensure all fields are filled correctly.</font>");
                }
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                out.println("<font color=red size=18>Database Driver not found.</font>");
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
        return "Feedback Submission Servlet";
    }
}