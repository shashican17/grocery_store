<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="header.jsp"%>
<title>Insert title here</title>
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
          .quantity-input {
        width: 40px;
    }
    
    .quantity-button {
        cursor: pointer;
        font-weight: bold;
    }
    .order-button {
        background-color: white;
        color: black;
        border: 2px solid black;
        padding: 10px 20px;
        border-radius: 5px;
        font-weight: bold;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        cursor: pointer;
    }
    .empty-button {
        background-color: white;
        color: black;
        border: 2px solid black;
        padding: 10px 20px;
        border-radius: 5px;
        font-weight: bold;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        cursor: pointer;
    }
    </style>
</head>
<body>
	
<div style="margin-top: 100px;">
         <h1>Products</h1>
	    <%
        String url = "jdbc:mysql://localhost:3306/GroceryStore";
        String user = "root";
        String passwd = "-----------";

        String username = (String) session.getAttribute("username");
        int totalCartValue = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            java.sql.Connection connection = java.sql.DriverManager.getConnection(url, user, passwd);
            String sql = "SELECT w.product_id, p.name, w.quantity, p.unit, w.price FROM Wishlist w INNER JOIN products p ON w.product_id = p.id WHERE w.username = ?";
            java.sql.PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,username);
            java.sql.ResultSet resultSet = statement.executeQuery();
    %>
    
        <table>
        <tr>
        	<th>ID</th>
            <th>Name</th>
            <th>Photo</th>
            <th>Quantity</th>
            <th>Unit</th>
            <th>Price</th>
            <th>Action</th>
            <th>Total Price</th>
            <!-- Add more table headers based on your database columns -->
        </tr>
        <%
            while (resultSet.next()) {
                String str=resultSet.getString("name");
                int productId = resultSet.getInt("product_id");
                int quantity = resultSet.getInt("quantity");
                int price = resultSet.getInt("price");
                int totalPrice = quantity * price;
                totalCartValue += totalPrice;
        %>

        <tr>
        	<td><%= resultSet.getInt(1) %>
            <td><%= resultSet.getString(2) %></td>
            <td><img src="img/<%= str %>.jpg" alt="Image Description" width="100" height="100"></td>
            <td><%= resultSet.getFloat(3) %></td>
            <td><%= resultSet.getString(4) %></td>
            <td><%= resultSet.getInt(5) %></td>
               <td>
                <div class="quantity-container">
                    <form method="post" action="updateQuantity.jsp">
                        <input type="hidden" name="productId" value="<%= productId %>">
                        <button type="submit" class="quantity-button" name="action" value="decrement">-</button>
                        <input type="number" name="quantity" class="quantity-input" value="<%= quantity %>" readonly>
                        <button type="submit" class="quantity-button" name="action" value="increment">+</button>
                    </form>
                </div>
            </td>
            <td><%= totalPrice %></td>
            <!-- Replace 'id' and 'name' with your actual column names -->
        </tr>
        <%
            }
        %>
    </table>
    <%
        session.setAttribute("username", username);
        session.setAttribute("totalCartValue", totalCartValue);
    %>
    <h1>Total Cart Value: <%= totalCartValue %></h1>
    <form method="post" action="updateOrder.jsp">
    <button type="submit" class="order-button">Proceed to Order</button>
	</form>
	<form method="post" action="emptyWishlist.jsp">
    <button type="submit" class="empty-button">Empty Wishlist</button>
	</form>
     <%
        resultSet.close();
        statement.close();
        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    %>
    <%@ include file="footer.jsp" %>
    
    </div>
</body>
</html>