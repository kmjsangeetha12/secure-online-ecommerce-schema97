<%@ page import="java.sql.*, java.io.*" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('indeximage.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
        .container {
            max-width: 500px;
            margin: 0 auto;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }
        h1 {
            text-align: center;
        }
        form {
            margin-top: 20px;
        }
        label {
            display: block;
            margin-bottom: 10px;
        }
        input, select {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }
        button {
            width: 100%;
            padding: 10px;
            border: none;
            background-color: #f44336;
            color: white;
            cursor: pointer;
        }
        button:hover {
            background-color: #d32f2f;
        }
    </style>
</head>
<body>
    <%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("Username");
        String address = request.getParameter("Address");
        String phoneNumber = request.getParameter("PhoneNumber");
        String bankName = request.getParameter("BankName");
        String cardNumber = request.getParameter("CardNumber");
        String expiryDate = request.getParameter("ExpiryDate");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/checkoutdb", "root", "Root123@");

            String sql = "INSERT INTO pay (Username, Address, PhoneNumber, BankName, CardNumber, ExpiryDate) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, address);
            pstmt.setString(3, phoneNumber);
            pstmt.setString(4, bankName);
            pstmt.setString(5, cardNumber);
            pstmt.setString(6, expiryDate);
            pstmt.executeUpdate();
            pstmt.close();
            conn.close();

            response.sendRedirect("success.html");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("success.html");
        }
    }
    %>
    <div class="container">
        <h1>Checkout Form</h1>
        <form action="checkout.jsp" method="post">
            <label for="Username">Username:</label>
            <input type="text" id="Username" name="Username" required><br>

            <label for="Address">Address:</label>
            <input type="text" id="Address" name="Address" required><br>

            <label for="PhoneNumber">Phone Number:</label>
            <input type="text" id="PhoneNumber" name="PhoneNumber" required><br>

            <label for="BankName">Bank Name:</label>
            <input type="text" id="BankName" name="BankName"><br>

            <label for="CardNumber">Card Number:</label>
            <input type="text" id="CardNumber" name="CardNumber"><br>

            <label for="ExpiryDate">Expiry Date:</label>
            <input type="date" id="ExpiryDate" name="ExpiryDate"><br>

            <button type="submit">Proceed to Pay</button>
        </form>
    </div>
</body>
</html>
