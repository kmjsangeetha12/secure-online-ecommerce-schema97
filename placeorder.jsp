<%@ page import="java.sql.*,java.util.*"%>

<%
    ArrayList<Integer> cart = (ArrayList<Integer>) session.getAttribute("cart");
    if (cart != null && !cart.isEmpty()) {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "Root123@");
        con.setAutoCommit(false);
        try {
            // Insert into orders table
            PreparedStatement ps = con.prepareStatement("INSERT INTO orders(username, total) VALUES (?, ?)", Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, (String) session.getAttribute("username"));
            double total = 0;
            for (Integer productId : cart) {
                PreparedStatement priceStmt = con.prepareStatement("SELECT price FROM products WHERE id = ?");
                priceStmt.setInt(1, productId);
                ResultSet rs = priceStmt.executeQuery();
                if (rs.next()) {
                    total += rs.getDouble("price");
                }
            }
            ps.setDouble(2, total);
            ps.executeUpdate();

            // Get generated order ID
            ResultSet generatedKeys = ps.getGeneratedKeys();
            if (generatedKeys.next()) {
                int orderId = generatedKeys.getInt(1);
                // Insert into order_items table
                for (Integer productId : cart) {
                    ps = con.prepareStatement("INSERT INTO order_items(order_id, product_id, quantity) VALUES (?, ?, ?)");
                    ps.setInt(1, orderId);
                    ps.setInt(2, productId);
                    ps.setInt(3, 1);
                    ps.executeUpdate();
                }
            }
            con.commit();
            session.removeAttribute("cart");  // Clear the cart after placing order
            out.println("<p>Order successfully placed.</p>");
        } catch (Exception e) {
            con.rollback();
            out.println("<p>Error placing order.</p>");
        } finally {
            con.close();
        }
    } else {
        out.println("<p>Your cart is empty.</p>");
    }
%>
