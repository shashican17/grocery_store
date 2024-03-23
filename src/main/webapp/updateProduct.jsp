<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Product</title>
    <%@include file="header.jsp"%>
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
        <h1>Update Product</h1>

        <%
            String url = "jdbc:mysql://localhost:3306/GroceryStore";
            String user = "root";
            String passwd = "-----------";
            
            // Get product details from the form
            int productId = Integer.parseInt(request.getParameter("productId"));
            String name = request.getParameter("name");
            String category = request.getParameter("category");
            float price = Float.parseFloat(request.getParameter("price"));
            String unit = request.getParameter("unit");
            int availableQty = Integer.parseInt(request.getParameter("availableQty"));
            String description = request.getParameter("description");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection(url, user, passwd);

                // Update the product in the database
                String updateProductSql = "UPDATE products SET name = ?, category = ?, price = ?, unit = ?, availableQty = ?, description = ? WHERE id = ?";
                PreparedStatement updateProductStatement = connection.prepareStatement(updateProductSql);
                updateProductStatement.setString(1, name);
                updateProductStatement.setString(2, category);
                updateProductStatement.setFloat(3, price);
                updateProductStatement.setString(4, unit);
                updateProductStatement.setInt(5, availableQty);
                updateProductStatement.setString(6, description);
                updateProductStatement.setInt(7, productId);

                updateProductStatement.executeUpdate();
                updateProductStatement.close();
                connection.close();

                // Redirect to a product listing page or any other page as needed
                response.sendRedirect("shopkeeper.jsp");
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>
</body>
</html>
