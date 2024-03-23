<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <%@include file="header.jsp"%>
    <title>Categories</title>
    <style>
        .category-card {
            border: 1px solid #ccc;
            margin: 10px;
            padding: 20px;
            text-align: center;
            cursor: pointer;
            width: 200px;
            display: inline-block;
        }
        .category-container {
            text-align: center;
            font-size: 30px;
        }
                table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid #000;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        
         td {
            font-size: 16px;
        }
    </style>
</head>
<body>
    <div style="margin-top: 100px;">
        <h1>Categories</h1>
        <div class="category-container">
            <div class="category-card" onclick="showCategory('Vegetable')">Vegetables</div>
            <div class="category-card" onclick="showCategory('Fruit')">Fruits</div>
            <div class="category-card" onclick="showCategory('Meat')">Meat</div>
            <div class="category-card" onclick="showCategory('Dairy')">Dairy</div>
        </div>

        <div id="products-list">
            <!-- This is where the product list will be displayed. It will be populated using JavaScript. -->
        </div>
    </div>

    <script>
        function showCategory(category) {
            // Redirect to the 'categories.jsp' page with the 'category' parameter
            window.location.href = 'categories.jsp?category=' + category;
        }
    </script>

    <%
    String category = request.getParameter("category");
    String url = "jdbc:mysql://localhost:3306/GroceryStore";
    String user = "root";
    String passwd = "-----------";
    if (category != null && !category.isEmpty()) {
        try {
            
        	Class.forName("com.mysql.cj.jdbc.Driver");
            java.sql.Connection connection = java.sql.DriverManager.getConnection(url, user, passwd);
            String sql = "SELECT * FROM products WHERE category = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, category);
            ResultSet resultSet = statement.executeQuery();
    %>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Photo</th>
                <th>Price</th>
                <th>Unit</th>
                <th>Available Quantity</th>
                <th>Description</th>
            </tr>
    <%
            while (resultSet.next()) {
            	String str=resultSet.getString("name");
    %>
                <tr>
                    <td><%= resultSet.getInt("id") %></td>
                    <td><%= resultSet.getString("name") %></td>
                    <td><img src="img/<%= str %>.jpg" alt="Image Description" width="100" height="100"></td>
                    <td><%= resultSet.getFloat("price") %></td>
                    <td><%= resultSet.getString("unit") %></td>
                    <td><%= resultSet.getInt("availableQty") %></td>
                    <td><%= resultSet.getString("description") %></td>
                </tr>
    <%
            }
            resultSet.close();
            statement.close();
            connection.close();
    %>
        </table>
    <%
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    %>
    <%@ include file="footer.jsp" %>
    
</body>
</html>
