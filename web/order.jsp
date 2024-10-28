<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<h2>Order Confirmation</h2>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Load the database driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        // Connect to the database
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "thani@6304");

        // Retrieve customerId from session (using implicit session object)
        Integer custId = (Integer) session.getAttribute("customerId");

        // Check if customerId is null
        if (custId == null) {
            out.println("<p>Error: Customer ID is not available. Please log in again.</p>");
            return; // Exit if customer ID is not found
        }

        // Get the parameters from the request
        String itemId = request.getParameter("itemid");
        String price = request.getParameter("price");
        String quantity = request.getParameter("quantity");
        String orderDate = new java.util.Date().toString(); // Current date as a string
        String orderStatus = "Pending"; // Default order status

        // Insert the order into the foodorder table
        String sql = "INSERT INTO foodorder (customerid, itemid, price, quantity, orderdate, orderstatus) VALUES (?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, custId); // Use the retrieved customer ID
        pstmt.setString(2, itemId);
        pstmt.setDouble(3, Double.parseDouble(price)); // Convert price to double
        pstmt.setInt(4, Integer.parseInt(quantity)); // Convert quantity to int
        pstmt.setString(5, orderDate);
        pstmt.setString(6, orderStatus);

        int rowsAffected = pstmt.executeUpdate();
        
        if (rowsAffected > 0) {
%>
            <p>Your order has been placed successfully!</p>
            <p>Item ID: <%= itemId %></p>
            <p>Price: <%= price %></p>
            <p>Quantity: <%= quantity %></p>
            <p>Order Date: <%= orderDate %></p>
            <p>Order Status: <%= orderStatus %></p>
<%
        } else {
%>
            <p>There was an error placing your order. Please try again.</p>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close resources
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>

<a href="foodmenu.jsp">Return to Food Menu</a>

</body>
</html>