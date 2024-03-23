<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="header.jsp"%>
<title>Buyer</title>
<style>
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

    .pagination {
        text-align: center;
        margin-top: 10px;
    }
        /* Style for the pagination buttons */
    .pagination-button {
        display: inline-block;
        padding: 8px 16px;
        text-decoration: none;
        background-color: #007BFF;
        color: #fff;
        border: 1px solid #007BFF;
        border-radius: 4px;
        margin: 5px;
        cursor: pointer;
    }

    .pagination-button:hover {
        background-color: #0056b3;
    }
    
</style>

<script>
    function showAlert(productName) {
        alert(productName + " has been added to your cart.");
    }
</script>
</head>
<body>
<%
    String username = (String) session.getAttribute("username");
    int itemsPerPage = 10; // Default number of items per page
    String itemsPerPageParam = request.getParameter("itemsPerPage");
    
    if (itemsPerPageParam != null && !itemsPerPageParam.isEmpty()) {
        itemsPerPage = Integer.parseInt(itemsPerPageParam);
    }
    
    int currentPage = 1; // Default current page
    String pageParam = request.getParameter("page");
    
    if (pageParam != null && !pageParam.isEmpty()) {
        currentPage = Integer.parseInt(pageParam);
    }
	
    String url = "jdbc:mysql://localhost:3306/GroceryStore";
    String user = "root";
    String passwd = "-----------";

    
    String searchName = request.getParameter("search");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        java.sql.Connection connection = java.sql.DriverManager.getConnection(url, user, passwd);
        String sql;
        java.sql.PreparedStatement statement;
        
        if (searchName != null && !searchName.isEmpty()) {
            // If a search name is provided, filter products by name
            sql = "SELECT * FROM Products WHERE name LIKE ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, "%" + searchName + "%");
        } else {
            sql = "SELECT * FROM Products";
            statement = connection.prepareStatement(sql);
        }
        java.sql.ResultSet resultSet = statement.executeQuery();
        int totalItems = 0;

        while (resultSet.next()) {
            totalItems++;
        }
        resultSet.close();
        statement.close();

        int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
        int startIndex = (currentPage - 1) * itemsPerPage;

        // Query the database to fetch a specific range of products
        String rangeSql = "SELECT * FROM Products";
        
        if (searchName != null && !searchName.isEmpty()) {
            rangeSql = "SELECT * FROM Products WHERE name LIKE ?";
        }
        
        rangeSql += " LIMIT ?, ?";
        statement = connection.prepareStatement(rangeSql);

        if (searchName != null && !searchName.isEmpty()) {
            statement.setString(1, "%" + searchName + "%");
            statement.setInt(2, startIndex);
            statement.setInt(3, itemsPerPage);
        } else {
            statement.setInt(1, startIndex);
            statement.setInt(2, itemsPerPage);
        }
        
        resultSet = statement.executeQuery();
%>

<div style="margin-top: 100px;">
    <h1>Products</h1>

    <form method="post" action="products.jsp">
        <label for="search" style="font-size: 16px;">Search by Name:</label>
        <input type="text" id="search" name="search" placeholder="Enter product name">
        <input type="submit" value="Search">
    </form>

    <!-- Add a form to allow users to choose items per page -->
    <form method="get" action="products.jsp" class="items-per-page-form">
        <label for="itemsPerPage" style="font-size: 16px;">Items per Page:</label>
        <select id="itemsPerPage" name="itemsPerPage" onchange="this.form.submit()">
            <option value="5" <%= itemsPerPage == 5 ? "selected" : "" %> style="font-size: 16px;">5</option>
            <option value="10" <%= itemsPerPage == 10 ? "selected" : "" %> style="font-size: 16px;">10</option>
            <option value="20" <%= itemsPerPage == 20 ? "selected" : "" %> style="font-size: 16px;">20</option>
        </select>
    </form>

    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Photo</th>
            <th>Price</th>
            <th>Unit</th>
            <th>Available Quantity</th>
            <th>Description</th>
            <th>Action</th>
        </tr>

        <%
            while (resultSet.next()) {
                String str = resultSet.getString("name");
        %>

        <tr>
            <td><%= resultSet.getInt("id") %></td>
            <td><%= resultSet.getString("name") %></td>
            <td><img src="img/<%= str %>.jpg" alt="Image Description" width="100" height="100"></td>
            <td><%= resultSet.getFloat("price") %></td>
            <td><%= resultSet.getString("unit") %></td>
            <td><%= resultSet.getInt("availableQty") %></td>
            <td><%= resultSet.getString("description") %></td>
            <td>
                <form action="add_to_wishlist.jsp" method="post">
                    <input type="hidden" name="product_id" value="<%= resultSet.getInt("id") %>">
                    <input type="hidden" name="quantity" value="1">
                    <input type="hidden" name="price" value="<%= resultSet.getFloat("price") %>">
                    <input type="submit" value="Add to Wishlist" <%= resultSet.getInt("availableQty") == 0 ? "disabled" : "" %> onclick="showAlert('<%= resultSet.getString("name") %>');">
                </form>
            </td>
        </tr>
        <%
            }
        %>
    </table>
    <div class="pagination">
        <%
            if (totalPages > 1) {
                if (currentPage > 1) {
        %>
        <a href="products.jsp?page=<%= currentPage - 1 %>&itemsPerPage=<%= itemsPerPage %>" class="pagination-button">Previous</a>
        <%
                }
                if (currentPage < totalPages) {
        %>
        <a href="products.jsp?page=<%= currentPage + 1 %>&itemsPerPage=<%= itemsPerPage %>" class="pagination-button">Next</a>
        <%
                }
            }
        %>
    </div>
</div>

<%
        resultSet.close();
        statement.close();
        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<br>
<%@ include file="footer.jsp" %>
</body>
</html>
