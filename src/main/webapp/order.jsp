<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <%@include file="header.jsp"%>
    <title>Order Details</title>
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
    </style>
</head>
<body>
    <div style="margin-top: 100px;">
        <h1>Order Details</h1>
        <table>
            <tr>
                <th>Order ID</th>
                <th>Username</th>
                <th>Total</th>
                <th>Order Date</th>
                <th>Delivery Date</th>
                <th>Products</th>
            </tr>
            <%
                String url = "jdbc:mysql://localhost:3306/GroceryStore";
                String user = "root";
                String passwd = "P@ritosh_2004";
                String usern = (String) session.getAttribute("username");
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection(url, user, passwd);
                    String selectOrderSql = "SELECT * FROM orders WHERE username = ?";
                    PreparedStatement selectOrderStatement = connection.prepareStatement(selectOrderSql);
                    selectOrderStatement.setString(1, usern);
                    ResultSet orderResultSet = selectOrderStatement.executeQuery();
                    while (orderResultSet.next()) {
                        int orderId = orderResultSet.getInt("id");
                        String username = orderResultSet.getString("username");
                        float total = orderResultSet.getFloat("total");
                        Date orderDate = orderResultSet.getDate("orderDate");
                        Date deliveryDate = orderResultSet.getDate("deliveryDate");
            %>
            <tr>
                <td><%= orderId %></td>
                <td><%= username %></td>
                <td><%= total %></td>
                <td><%= orderDate %></td>
                <td><%= deliveryDate %></td>
                <td>
                    <ul>
                        <%
                            String selectProductsSql = "SELECT p.name, op.quantity, p.description FROM orderProducts op INNER JOIN products p ON op.productId = p.id WHERE op.orderId = ?";
                            PreparedStatement selectProductsStatement = connection.prepareStatement(selectProductsSql);
                            selectProductsStatement.setInt(1, orderId);
                            ResultSet productResultSet = selectProductsStatement.executeQuery();
                            while (productResultSet.next()) {
                                String productName = productResultSet.getString("name");
                                int productQuantity = productResultSet.getInt("quantity");
                                String productDescription = productResultSet.getString("description");
                        %>
                        <li><strong><%= productName %></strong> - Quantity: <%= productQuantity %>, Description: <%= productDescription %></li>
                        <%
                            }
                            productResultSet.close();
                            selectProductsStatement.close();
                        %>
                    </ul>
                </td>
            </tr>
            <%
                    }
                    orderResultSet.close();
                    selectOrderStatement.close();
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </table>
        <%@ include file="footer.jsp" %>
        
    </div>
</body>
</html>
