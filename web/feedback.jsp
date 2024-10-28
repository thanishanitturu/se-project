<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Feedback</title>
    <link rel="stylesheet" type="text/css" href="css/style.css"> <!-- Optional: Link to your CSS file -->
</head>
<body>
    <h1>Customer Feedback Form</h1>

    <%
        // Retrieve the customerId from the session
        HttpSession userSession = request.getSession(); // Renamed variable to avoid conflict
        Integer customerId = (Integer) userSession.getAttribute("customerId");

        // Check if customerId is available in the session
        if (customerId == null) {
            out.println("<h2>You must be logged in to submit feedback.</h2>");
            out.println("<a href='login.jsp'>Login</a>");
            return; // Stop further processing
        }
    %>

    <form action="submitFeedback" method="post">
        <input type="hidden" id="custId" name="custId" value="<%= customerId %>"> <!-- Hidden field for customerId -->

        <label for="feedbackText">Feedback:</label><br>
        <textarea id="feedbackText" name="feedbackText" rows="4" required></textarea><br><br>

        <label for="rating">Rating (1-5):</label>
        <input type="number" id="rating" name="rating" min="1" max="5" required><br><br>

        <input type="submit" value="Submit Feedback">
    </form>

    <br>
    <a href="logged.jsp">Return to Dashboard</a> <!-- Link back to the logged in page -->
</body>
</html>