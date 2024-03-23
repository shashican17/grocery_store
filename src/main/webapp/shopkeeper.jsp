<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Listing</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        
        th {
            background-color: #f2f2f2;
        }
        
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        
        .product-table {
            max-width: 800px;
            margin: 0 auto;
        }
        td {
            font-size: 16px;
        }
    </style>
</head>
<body>
	  
		<%@include file="headers.jsp"%>
	<div style="margin-top: 100px;">
	<% String username = (String) session.getAttribute("username");
	session.setAttribute("username", username);%>
	 <h1>Hello, Shopkeeper <%= username%></h1>
	 </div> 
    <div class="product-table">
        <h1>Product Listing</h1>
        <table>
            <tr>
            	<th>Product Id</th>
                <th>Product Name</th>
                <th>Category</th>
                <th>Price</th>
                <th>Unit</th>
                <th>Available Quantity</th>
                <th>Description</th>
            </tr>
            
            <%
                String url = "jdbc:mysql://localhost:3306/GroceryStore";
                String user = "root";
                String passwd = "-----------";
                String shopkeeperUsername = (String) session.getAttribute("username");

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection(url, user, passwd);

                    // Query the database to get the list of products for the current shopkeeper
                    String selectProductsSql = "SELECT * FROM products WHERE shopkeeper_username = ?";
                    PreparedStatement selectProductsStatement = connection.prepareStatement(selectProductsSql);
                    selectProductsStatement.setString(1, shopkeeperUsername);
                    ResultSet productResultSet = selectProductsStatement.executeQuery();

                    while (productResultSet.next()) {
                        String productName = productResultSet.getString("name");
                        String category = productResultSet.getString("category");
                        float price = productResultSet.getFloat("price");
                        String unit = productResultSet.getString("unit");
                        int availableQty = productResultSet.getInt("availableQty");
                        String description = productResultSet.getString("description");
            %>
            <tr>
            	<td><%= productResultSet.getInt(1) %>
                <td><%= productName %></td>
                <td><%= category %></td>
                <td><%= price %></td>
                <td><%= unit %></td>
                <td><%= availableQty %></td>
                <td><%= description %></td>
            </tr>
            <%
                    }
                    productResultSet.close();
                    selectProductsStatement.close();
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </table>
        
        
    </div>
    <%@ include file="footer.jsp" %>
</body>
</html>
