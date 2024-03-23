<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Product</title>
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
    </style>
</head>
<body>

    <div class="container" style="margin-top: 100px;">
        <h1>Edit Product</h1>
        <form method="post" action="editProducts.jsp">
            <label for="productId">Product ID:</label>
            <input type="text" id="productId" name="productId" required><br>
			<br>
            <button type="submit">Edit Product</button>
        </form>

        <%
            if (request.getMethod().equals("POST")) {
                String url = "jdbc:mysql://localhost:3306/GroceryStore";
                String user = "root";
                String passwd = "-----------";
                int productId = Integer.parseInt(request.getParameter("productId"));

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection(url, user, passwd);

                    // Retrieve the product details based on the provided product ID
                    String selectProductSql = "SELECT * FROM products WHERE id = ?";
                    PreparedStatement selectProductStatement = connection.prepareStatement(selectProductSql);
                    selectProductStatement.setInt(1, productId);
                    ResultSet productResultSet = selectProductStatement.executeQuery();

                    if (productResultSet.next()) {
                        String name = productResultSet.getString("name");
                        String category = productResultSet.getString("category");
                        float price = productResultSet.getFloat("price");
                        String unit = productResultSet.getString("unit");
                        int availableQty = productResultSet.getInt("availableQty");
                        String description = productResultSet.getString("description");
        %>

        <form method="post" action="updateProduct.jsp">
            <input type="hidden" name="productId" value="<%= productId %>">

            <label for="name">Product Name:</label>
            <input type="text" id="name" name="name" value="<%= name %>" required><br>

            <label for="category">Category:</label>
            <input type="text" id="category" name="category" value="<%= category %>" required><br>

            <label for="price">Price:</label>
            <input type="text" id="price" name="price" value="<%= price %>" required><br>

            <label for="unit">Unit:</label>
            <input type="text" id="unit" name="unit" value="<%= unit %>" required><br>

            <label for="availableQty">Available Quantity:</label>
            <input type="text" id="availableQty" name="availableQty" value="<%= availableQty %>" required><br>

            <label for="description">Description:</label>
            <input type="text" id="description" name="description" value="<%= description %>" required><br>
			<br>
            <button type="submit">Update Product</button>
        </form>

        <%
                    }
                    productResultSet.close();
                    selectProductStatement.close();
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
        
        
    </div>
</body>
</html>
