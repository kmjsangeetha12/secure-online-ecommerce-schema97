<%@ page import="java.sql.*,java.util.*"%>
<%
    int productId = Integer.parseInt(request.getParameter("product_id"));
    ArrayList<Integer> cart = (ArrayList<Integer>) session.getAttribute("cart");
    if (cart == null) {
        cart = new ArrayList<Integer>();
    }
    cart.add(productId);
    session.setAttribute("cart", cart);
    response.sendRedirect("products.jsp");
%>
