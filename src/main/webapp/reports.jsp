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
    <title>Generate Reports</title>
    <%@include file="headers.jsp"%>
    <style>
        .container {
            margin-top: 100px;
        }

        h1 {
            text-align: center;
        }

        h2 {
            margin-top: 20px;
        }

        form {
            margin-top: 10px;
        }

        label {
            display: block;
        }

        input[type="text"],
        input[type="date"] {
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

        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
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
    <div class="container">
        <h1>Generate Reports</h1>

        <h2>User Purchases Report</h2>
        <form method="post" action="reports.jsp">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username">
            <button type="submit">Generate User Purchases Report</button>
        </form>

        <h2>Date Range Report</h2>
        <form method="post" action="reports.jsp">
            <label for="startDate">Start Date:</label>
            <input type="date" id="startDate" name="startDate" required>
            <label for="endDate">End Date:</label>
            <input type="date" id="endDate" name="endDate" required>
            <button type="submit">Generate Date Range Report</button>
        </form>

        <%
            String url = "jdbc:mysql://localhost:3306/GroceryStore";
            String user = "root";
            String passwd = "-----------";

            String username = request.getParameter("username");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");

            if (username != null && !username.isEmpty()) {
                // Generate user purchases report
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection(url, user, passwd);
                    String userPurchasesSql = "SELECT op.orderid, p.name, op.quantity, op.price " +
                            "FROM orderProducts op INNER JOIN products p ON op.productId = p.id " +
                            "WHERE op.username = ?";
                    PreparedStatement userPurchasesStatement = connection.prepareStatement(userPurchasesSql);
                    userPurchasesStatement.setString(1, username);
                    ResultSet userPurchasesResult = userPurchasesStatement.executeQuery();
        %>
            <h3>User Purchases Report for <%= username %>:</h3>
            <table>
                <tr>
                    <th>Order ID</th>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                </tr>
                <%
                    while (userPurchasesResult.next()) {
                %>
                <tr>
                    <td><%= userPurchasesResult.getString("orderid") %></td>
                    <td><%= userPurchasesResult.getString("name") %></td>
                    <td><%= userPurchasesResult.getInt("quantity") %></td>
                    <td><%= userPurchasesResult.getFloat("price") %></td>
                </tr>
                <%
                    }
                    userPurchasesResult.close();
                    userPurchasesStatement.close();
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
        %>
            </table>
        <%
            } else if (startDate != null && endDate != null) {
                // Generate date range report
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection(url, user, passwd);
                    String dateRangeSql = "SELECT o.id, o.username, o.total, o.orderDate, GROUP_CONCAT(p.name, ' (Qty: ', op.quantity, ')') as products " +
                            "FROM orders o " +
                            "INNER JOIN orderProducts op ON o.id = op.orderid " +
                            "INNER JOIN products p ON op.productId = p.id " +
                            "WHERE o.orderDate BETWEEN ? AND ? " +
                            "GROUP BY o.id";
                    PreparedStatement dateRangeStatement = connection.prepareStatement(dateRangeSql);
                    dateRangeStatement.setString(1, startDate);
                    dateRangeStatement.setString(2, endDate);
                    ResultSet dateRangeResult = dateRangeStatement.executeQuery();
        %>
            <h3>Purchases Between <%= startDate %> and <%= endDate %>:</h3>
            <table>
                <tr>
                    <th>Order ID</th>
                    <th>Username</th>
                    <th>Total</th>
                    <th>Order Date</th>
                    <th>Products</th>
                </tr>
                <%
                    while (dateRangeResult.next()) {
                %>
                <tr>
                    <td><%= dateRangeResult.getInt("id") %></td>
                    <td><%= dateRangeResult.getString("username") %></td>
                    <td><%= dateRangeResult.getFloat("total") %></td>
                    <td><%= dateRangeResult.getDate("orderDate") %></td>
                    <td><%= dateRangeResult.getString("products") %></td>
                </tr>
                <%
                    }
                    dateRangeResult.close();
                    dateRangeStatement.close();
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
        %>
            </table>
        <%
            }
        %>
        <%@ include file="footer.jsp" %>
    </div>
</body>
</html>
