<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Date" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<%
String url = "jdbc:mysql://localhost:3306/GroceryStore";
String user = "root";
String passwd = "-----------";

String username = (String) session.getAttribute("username");
session.setAttribute("username", username);
int totalCartValue = (int) session.getAttribute("totalCartValue");

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection connection = DriverManager.getConnection(url, user, passwd);

    // Get the current date for orderDate
    Calendar calendar = Calendar.getInstance();
    java.util.Date currentDate = calendar.getTime();
    java.sql.Date orderDate = new java.sql.Date(currentDate.getTime());

    // Calculate the delivery date (3 days later)
    calendar.add(Calendar.DAY_OF_YEAR, 3);
    java.util.Date deliveryDate = calendar.getTime();
    java.sql.Date sqlDeliveryDate = new java.sql.Date(deliveryDate.getTime());

    // Insert the order into the "orders" table
    String insertOrderSql = "INSERT INTO orders (username, total, orderDate, deliveryDate) VALUES (?, ?, ?, ?)";
    PreparedStatement insertOrderStatement = connection.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS);
    insertOrderStatement.setString(1, username);
    insertOrderStatement.setFloat(2, totalCartValue);
    insertOrderStatement.setDate(3, orderDate);
    insertOrderStatement.setDate(4, sqlDeliveryDate);
    insertOrderStatement.executeUpdate();

    // Retrieve the auto-generated order ID
    ResultSet generatedKeys = insertOrderStatement.getGeneratedKeys();
    int orderId = -1;
    if (generatedKeys.next()) {
        orderId = generatedKeys.getInt(1);
    }

    // Insert the products from the cart into the "orderProducts" table
    String selectCartSql = "SELECT * FROM Wishlist WHERE username = ?";
    PreparedStatement selectCartStatement = connection.prepareStatement(selectCartSql);
    selectCartStatement.setString(1, username);
    ResultSet cartResultSet = selectCartStatement.executeQuery();

    String insertOrderProductsSql = "INSERT INTO orderProducts (orderid, productId, username, quantity, price) VALUES (?, ?, ?, ?, ?)";
    PreparedStatement insertOrderProductsStatement = connection.prepareStatement(insertOrderProductsSql);

    /*//while (cartResultSet.next()) {
        int productId = cartResultSet.getInt("product_id");
        int quantity = cartResultSet.getInt("quantity");
        int price = cartResultSet.getInt("price");
        String updateProductSql = "UPDATE products SET availableQty = availableQty - ? WHERE id = ?";
        PreparedStatement updateProductStatement = connection.prepareStatement(updateProductSql);
        updateProductStatement.setInt(1, quantity);
        updateProductStatement.setInt(2, productId);
        updateProductStatement.executeUpdate();
        
        String checkQuantitySql = "SELECT availableQty FROM products WHERE id = ?";
        PreparedStatement checkQuantityStatement = connection.prepareStatement(checkQuantitySql);
        checkQuantityStatement.setInt(1, productId);
        ResultSet quantityResultSet = checkQuantityStatement.executeQuery();

        if (quantityResultSet.next()) {
            int newQuantity = quantityResultSet.getInt("availableQty");
            if (newQuantity <= 0) {
                // Delete the item from the products table
                String deleteProductSql = "DELETE FROM products WHERE id = ?";
                PreparedStatement deleteProductStatement = connection.prepareStatement(deleteProductSql);
                deleteProductStatement.setInt(1, productId);
                deleteProductStatement.executeUpdate();
            }
        }
        
        insertOrderProductsStatement.setInt(1, orderId);
        insertOrderProductsStatement.setInt(2, productId);
        insertOrderProductsStatement.setString(3, username);
        insertOrderProductsStatement.setInt(4, quantity);
        insertOrderProductsStatement.setInt(5, price);
        insertOrderProductsStatement.executeUpdate();
    }*/
    while (cartResultSet.next()) {
    int productId = cartResultSet.getInt("product_id");
    int quantity = cartResultSet.getInt("quantity");
    int price = cartResultSet.getInt("price");

    // Check if the available quantity is sufficient
    String checkQuantitySql = "SELECT availableQty FROM products WHERE id = ?";
    PreparedStatement checkQuantityStatement = connection.prepareStatement(checkQuantitySql);
    checkQuantityStatement.setInt(1, productId);
    ResultSet quantityResultSet = checkQuantityStatement.executeQuery();

    if (quantityResultSet.next()) {
        int availableQuantity = quantityResultSet.getInt("availableQty");

        if (availableQuantity >= quantity) {
            // There is enough quantity available, so proceed with the order
            insertOrderProductsStatement.setInt(1, orderId);
            insertOrderProductsStatement.setInt(2, productId);
            insertOrderProductsStatement.setString(3, username);
            insertOrderProductsStatement.setInt(4, quantity);
            insertOrderProductsStatement.setInt(5, price);
            insertOrderProductsStatement.executeUpdate();

            // Update the available quantity in the products table
            String updateProductSql = "UPDATE products SET availableQty = availableQty - ? WHERE id = ?";
            PreparedStatement updateProductStatement = connection.prepareStatement(updateProductSql);
            updateProductStatement.setInt(1, quantity);
            updateProductStatement.setInt(2, productId);
            updateProductStatement.executeUpdate();

            // Check if the available quantity is now zero and delete the product
            if (availableQuantity - quantity < 0) {
                String deleteProductSql = "UPDATE products SET availableQty=1 WHERE id = ?";
                PreparedStatement deleteProductStatement = connection.prepareStatement(deleteProductSql);
                deleteProductStatement.setInt(1, productId);
                deleteProductStatement.executeUpdate();
            }
        } else {
            // Handle insufficient quantity here (e.g., show an error message)
            // You can add error handling logic or redirect the user to a page with an error message
        }
    }
}


    // Clear the user's cart (wishlist)
    String clearCartSql = "DELETE FROM Wishlist WHERE username = ?";
    PreparedStatement clearCartStatement = connection.prepareStatement(clearCartSql);
    clearCartStatement.setString(1, username);
    clearCartStatement.executeUpdate();

    // Redirect to the order confirmation page or any other page as needed
    response.sendRedirect("order.jsp");
    
    insertOrderStatement.close();
    insertOrderProductsStatement.close();
    selectCartStatement.close();
    cartResultSet.close();
    clearCartStatement.close();
    connection.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>
