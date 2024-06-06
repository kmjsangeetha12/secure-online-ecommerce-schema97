<%@ page language="java" import="java.sql.*" %>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('indeximage.jpg'); /* Path to your background image */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            color: #fff; /* Text color for contrast */
        }
        .container {
            width: 400px;
            margin: 100px auto;
            padding: 20px;
            background-color: rgba(0, 0, 0, 0.7); /* Semi-transparent background color */
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .welcome {
            font-size: 24px;
            margin-bottom: 20px;
        }
        input[type="text"], input[type="password"], input[type="submit"] {
            width: 80%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #ccc;
            background-color: rgba(255, 255, 255, 0.7); /* Semi-transparent background color */
        }
        input[type="submit"] {
            background-color: #4CAF50;
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
        <div class="welcome">Welcome to our E-Commerce Website</div>
        <form id="loginForm" method="post" action="login.jsp">
            <input type="text" name="username" placeholder="Username" required><br>
            <input type="password" name="password" placeholder="Password" required><br>
            <input type="submit" value="Login">
        </form>
        <form method="get" action="register.jsp">
           
            <input type="submit" value="register" />
            </form>
    </div>

    <%
        String error = request.getParameter("error");
        if (error != null) {
            out.println("<p style='color:red'>" + error + "</p>");
        }

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            boolean isAuthenticated = false;

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root","Root123@");
                pstmt = conn.prepareStatement("SELECT * FROM users WHERE username=? AND password=?");
                pstmt.setString(1, username);
                pstmt.setString(2, password);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    isAuthenticated = true;
                    session.setAttribute("username", username);
                    response.sendRedirect("products.jsp");
                } else {
                    response.sendRedirect("login.jsp?error=Invalid username or password");
                }
            } catch (Exception e) {
                out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    out.println("<p style='color:red'>Error closing resources: " + e.getMessage() + "</p>");
                }
            }
        }
    %>
</body>
</html>


