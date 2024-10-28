<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Food Menu</title>
    <link rel="stylesheet" type="text/css" href="css/foodmenu.css"> <!-- Link to your CSS file -->
</head>
<body>
<h2>Food Menu</h2>

<table>
    <tr>
        <th>Item ID</th>
        <th>Item Name</th>
        <th>Description</th>
        <th>Price</th>
        <th>Available Quantity</th>
        <th>Action</th>
    </tr>

    <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            // Load the database driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Connect to the database
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "thani@6304");
            stmt = conn.createStatement();
            // Query to fetch food menu
            String sql = "SELECT * FROM foodMenu";
            rs = stmt.executeQuery(sql);

            // Iterate through the result set and display the menu
            while (rs.next()) {
                int itemId = rs.getInt("itemid");
                String itemName = rs.getString("itemname");
                String description = rs.getString("description");
                double price = rs.getDouble("price");
                int availableQuantity = rs.getInt("quantity");
    %>
                <tr>
                    <td><%= itemId %></td>
                    <td><%= itemName %></td>
                    <td><%= description %></td>
                    <td><%= price %></td>
                    <td><%= availableQuantity %></td>
                    <td>
                        <form action="order.jsp" method="post">
                            <input type="hidden" name="itemid" value="<%= itemId %>">
                            <input type="hidden" name="price" value="<%= price %>">
                            Quantity: <input type="number" name="quantity" min="1" max="<%= availableQuantity %>" value="1">
                            <input type="submit" value="Order">
                        </form>
                    </td>
                </tr>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<tr><td colspan='6'>Error retrieving menu: " + e.getMessage() + "</td></tr>");
        } finally {
            // Close resources
            if (rs != null) try { rs.close(); } catch (SQLException e) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
            if (conn != null) try { conn.close(); } catch (SQLException e) {}
        }
    %>
</table>

</body>
</html>