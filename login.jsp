<%@ page import="java.sql.*, java.io.*" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>E-Commerce Website</title>
    <style>
        body {
            background-image: url('background_image.jpg'); /* Path to your background image */
            background-size: cover;
            font-family: Arial, sans-serif;
        }
        .container {
            width: 400px;
            margin: 100px auto;
            padding: 20px;
            background-color: rgba(0, 0, 255, 0.5); /* Blue background color with transparency */
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            text-align: center;
        }
        input[type="text"], input[type="password"], input[type="submit"] {
            width: 80%;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        input[type="submit"] {
            background-color: #4CAF50; /* Green submit button */
            color: white;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Welcome to our E-Commerce Website</h2>
        <form action="login.jsp" method="post">
            <label for="username">Username:</label><br>
            <input type="text" id="username" name="username" required><br>
            <label for="password">Password:</label><br>
            <input type="password" id="password" name="password" required><br>
            <input type="submit" value="Login">
        </form>
    </div>
</body>
</html>

<%
if ("POST".equalsIgnoreCase(request.getMethod())) {
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "Root123@");

        String sql = "INSERT INTO user (Username, password) VALUES (?, ?)";

        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, password);

        pstmt.executeUpdate();
        conn.close();

        response.sendRedirect("products.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("products.jsp");
    }
}
%>
