<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Products</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('indeximage.jpg'); /* Path to your background image */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            padding: 20px;
        }
        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: flex-start;
        }
        .product {
            width: 30%; /* Adjust as needed */
            margin-bottom: 20px;
            background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent background color */
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .product img {
            width: 100%;
            height: auto;
            margin-bottom: 10px;
        }
        .product p {
            margin: 0;
            font-size: 18px;
            line-height: 1.5;
        }
        .product form {
            text-align: center;
        }
        .cart-button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 10px;
        }
        .cart-button:hover {
            background-color: #45a049;
        }
        .proceed-button {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 20px;
            align-self: center; /* Center button horizontally */
        }
        .proceed-button:hover {
            background-color: #d32f2f;
        }
    </style>
</head>
<body>
<div class="container">
<%
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "Root123@");
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM products");
    while (rs.next()) {
%>
        <div class="product">
            <img src="<%= rs.getString("image_url") %>" alt="<%= rs.getString("name") %>">
            <p><%= rs.getString("name") %> - $<%= rs.getDouble("price") %></p>
            <form method="post" action="addtocart.jsp">
                <input type="hidden" name="product_id" value="<%= rs.getInt("id") %>">
                <input type="submit" class="cart-button" value="Add to Cart">
            </form>
            <div>
              <form action="cart.jsp">
                <input type="submit" value="view the cart"  placeholder="cart">
              </form>
            </div>
        </div>
<%
    }
    con.close();
%>

</body>
</html>


