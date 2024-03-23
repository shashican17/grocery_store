
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.io.IOException" %>

<%
    // Get the user's username from the session

String url = "jdbc:mysql://localhost:3306/GroceryStore";
String user = "root";
String passwd = "-----------";
    String username = (String) session.getAttribute("username");
    session.setAttribute("username", username);
    

    // Get the product information from the request parameters
    String productID = request.getParameter("product_id");
    String quantity = request.getParameter("quantity");
    String price = request.getParameter("price");
    String insertQuery = "INSERT INTO Wishlist (username, product_id, quantity, price) VALUES (?, ?, ?, ?)" + "ON DUPLICATE KEY UPDATE quantity = quantity + VALUES(quantity)";
    PreparedStatement insertStatement = null;

    try {
    	Class.forName("com.mysql.cj.jdbc.Driver");
        java.sql.Connection connection = java.sql.DriverManager.getConnection(url, user, passwd);



        // Prepare and execute the SQL statement to insert into the Wishlist table
        insertStatement = connection.prepareStatement(insertQuery);
        insertStatement.setString(1, username);
        insertStatement.setInt(2, Integer.parseInt(productID));
        insertStatement.setInt(3, Integer.parseInt(quantity));
        insertStatement.setFloat(4, Float.parseFloat(price));

        int rowsAffected = insertStatement.executeUpdate();

        if (rowsAffected > 0) {
            response.sendRedirect("cart.jsp");
        } else {
            out.println("Failed to add the product to Wishlist.");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try {
            if (insertStatement != null) {
                insertStatement.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
