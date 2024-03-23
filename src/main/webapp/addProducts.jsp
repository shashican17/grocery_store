<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Products</title>
    <%@include file="headers.jsp"%>
       <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 500px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0px 0px 10px 0px #000;
        }
        label {
            display: block;
            margin-top: 10px;
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        button[type="submit"] {
            display: block;
            width: 100%;
            background-color: #007BFF;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        button[type="submit"]:hover {
            background-color: #0056b3;
        }
        .product-list {
            margin-top: 20px;
        }
        .product {
            border: 1px solid #ccc;
            margin-top: 10px;
            padding: 10px;
            border-radius: 3px;
        }
    </style>
</head>
<body>
	 
    <div style="margin-top: 100px;">
        <h1>Add Products</h1>
        <form method="post" action="addProducts.jsp">
            <label for="name">Product Name:</label>
            <input type="text" id="name" name="name" required><br>

            <label for="category">Category:</label>
            <input type="text" id="category" name="category" required><br>

            <label for="price">Price:</label>
            <input type="text" id="price" name="price" required><br>

            <label for="unit">Unit:</label>
            <input type="text" id="unit" name="unit" required><br>

            <label for="availableQty">Available Quantity:</label>
            <input type="text" id="availableQty" name="availableQty" required><br>

            <label for="description">Description:</label>
            <input type="text" id="description" name="description" required><br>

            <!-- You can use session to get the shopkeeper username -->
            <%
                String shopkeeperUsername = (String) session.getAttribute("username");
            %>
            <input type="hidden" name="shopkeeperUsername" value="<%= shopkeeperUsername %>">

            <button type="submit">Add Product</button>
        </form>
    </div>

    <%
        if (request.getMethod().equals("POST")) {
            String url = "jdbc:mysql://localhost:3306/GroceryStore";
            String user = "root";
            String passwd = "-----------";
            
            String name = request.getParameter("name");
            String category = request.getParameter("category");
            float price = Float.parseFloat(request.getParameter("price"));
            String unit = request.getParameter("unit");
            int availableQty = Integer.parseInt(request.getParameter("availableQty"));
            String description = request.getParameter("description");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection(url, user, passwd);

                String insertProductSql = "INSERT INTO products (name, category, price, unit, availableQty, description, shopkeeper_username) VALUES (?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement insertProductStatement = connection.prepareStatement(insertProductSql);
                insertProductStatement.setString(1, name);
                insertProductStatement.setString(2, category);
                insertProductStatement.setFloat(3, price);
                insertProductStatement.setString(4, unit);
                insertProductStatement.setInt(5, availableQty);
                insertProductStatement.setString(6, description);
                insertProductStatement.setString(7, shopkeeperUsername);

                insertProductStatement.executeUpdate();
                insertProductStatement.close();
                connection.close();

                // Redirect to a page that displays a success message or the product list
                response.sendRedirect("success1.html");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    
    %>
</body>
</html>
