<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.*" %>

<html>
<head>
    <title>Checkout</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 0;
            margin: 0;
            overflow: hidden;
            background-image: url('indeximage.jpg'); /* Path to your background image */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            position: relative;
        }
        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent black overlay */
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            color: #fff;
            text-align: center;
            z-index: 1; /* Ensure overlay is on top of background */
        }
        .total-container {
            background-color: rgba(0, 0, 0, 0.7); /* Semi-transparent black background */
            padding: 20px;
            border-radius: 10px;
        }
        .total {
            font-size: 24px;
            margin-bottom: 20px;
        }
        .checkout-button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .checkout-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="overlay">
<%
    List<Integer> cart = (List<Integer>) session.getAttribute("cart");
    if (cart == null || cart.size() == 0) {
        out.println("<p>Your cart is empty</p>");
    } else {
        double total = 0;
        Class.forName("com.mysql.cj.jdbc.Driver");  // Ensure the JDBC driver is loaded
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "Root123@");
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            for (Integer productId : cart) {
                ps = con.prepareStatement("SELECT price FROM products WHERE id = ?");
                ps.setInt(1, productId);
                rs = ps.executeQuery();
                while (rs.next()) {
                    total += rs.getDouble("price");
                }
            }
            out.println("<div class='total-container'><div class='total'>Total: $" + total + "</div>");
            out.println("<form action='checkout.jsp'>");
            out.println("<input type='submit' class='checkout-button' value='Proceed to Pay'>");
            out.println("</form></div>");
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                out.println("<p>Error closing resources: " + e.getMessage() + "</p>");
            }
        }
    }
%>
</div>
</body>
</html>
