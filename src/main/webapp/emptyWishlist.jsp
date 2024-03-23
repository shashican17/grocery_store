<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
// Get the username and totalCartValue from the session
String username = (String) session.getAttribute("username");

String url = "jdbc:mysql://localhost:3306/GroceryStore";
String user = "root";
String passwd = "-----------";

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection connection = DriverManager.getConnection(url, user, passwd);

    // Clear the user's wishlist
    String clearWishlistSql = "DELETE FROM Wishlist WHERE username = ?";
    PreparedStatement clearWishlistStatement = connection.prepareStatement(clearWishlistSql);
    clearWishlistStatement.setString(1, username);
    clearWishlistStatement.executeUpdate();

    // Redirect back to the wishlist page or any other page as needed
    response.sendRedirect("cart.jsp");
    
    clearWishlistStatement.close();
    connection.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>
