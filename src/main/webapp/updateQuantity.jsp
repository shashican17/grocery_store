<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
    <%
    String url = "jdbc:mysql://localhost:3306/GroceryStore";
    String user = "root";
    String passwd = "-----------";

    int productId = Integer.parseInt(request.getParameter("productId"));
    int currentQuantity = Integer.parseInt(request.getParameter("quantity"));
    String action = request.getParameter("action");

    int newQuantity = currentQuantity;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        java.sql.Connection connection = java.sql.DriverManager.getConnection(url, user, passwd);

        // Retrieve the available quantity from the products table
        String availableQtySql = "SELECT availableQty FROM products WHERE id = ?";
        java.sql.PreparedStatement availableQtyStatement = connection.prepareStatement(availableQtySql);
        availableQtyStatement.setInt(1, productId);
        java.sql.ResultSet availableQtyResult = availableQtyStatement.executeQuery();
        int availableQty = 0;
        if (availableQtyResult.next()) {
            availableQty = availableQtyResult.getInt("availableQty");
        }
        availableQtyStatement.close();

        if ("increment".equals(action) && currentQuantity < availableQty) {
            newQuantity = currentQuantity + 1;
        } else if ("decrement".equals(action) && currentQuantity > 0) {
            newQuantity = currentQuantity - 1;
        }

        if (newQuantity == 0) {
            // If the new quantity is 0, delete the item from the Wishlist
            String deleteSql = "DELETE FROM Wishlist WHERE product_id = ?";
            java.sql.PreparedStatement deleteStatement = connection.prepareStatement(deleteSql);
            deleteStatement.setInt(1, productId);
            deleteStatement.executeUpdate();
            deleteStatement.close();
        } else {
            String updateSql = "UPDATE Wishlist SET quantity = ? WHERE product_id = ?";
            java.sql.PreparedStatement updateStatement = connection.prepareStatement(updateSql);
            updateStatement.setInt(1, newQuantity);
            updateStatement.setInt(2, productId);
            updateStatement.executeUpdate();
            updateStatement.close();
        }

        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    response.sendRedirect("cart.jsp"); // Redirect back to the wishlist page
    %>

</body>
</html>
