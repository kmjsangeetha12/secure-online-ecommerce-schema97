<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*" %>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Establish connection to the database
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database_name", "username", "password");

        // Insert user details into 'users' table
        String insertUserQuery = "INSERT INTO users (username, address, phone) VALUES (?, ?, ?)";
        pstmt = conn.prepareStatement(insertUserQuery, Statement.RETURN_GENERATED_KEYS);
        pstmt.setString(1, request.getParameter("username"));
        pstmt.setString(2, request.getParameter("address"));
        pstmt.setString(3, request.getParameter("phone"));
        pstmt.executeUpdate();

        // Retrieve the auto-generated user ID
        ResultSet rs = pstmt.getGeneratedKeys();
        int userId = 0;
        if (rs.next()) {
            userId = rs.getInt(1);
        }

        // Insert payment details into 'payments' table
        String insertPaymentQuery = "INSERT INTO payments (user_id, payment_method, bank_name, card_number, , expiry_date) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(insertPaymentQuery);
        pstmt.setInt(1, userId);
        pstmt.setString(2, request.getParameter("payment_method"));
        pstmt.setString(3, request.getParameter("bank_name"));
        pstmt.setString(4, request.getParameter("card_number"));
     
        pstmt.setString(6, request.getParameter("expiry_date"));
        pstmt.executeUpdate();

        // Close resources
        pstmt.close();
        conn.close();

        out.println("<h2>Payment Processed Successfully!</h2>");
    } catch (Exception e) {
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
    } finally {
        // Close resources in the finally block
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("<h2>Error closing resources: " + e.getMessage() + "</h2>");
        }
    }
%>
