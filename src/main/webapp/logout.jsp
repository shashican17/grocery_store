<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logout</title>
</head>
<body>
    <%
        // Invalidate the user's session
        session.invalidate();
    %>
    <h2>You have been logged out.</h2>
    <p><a href="index.html">Click here to log in again</a></p>
</body>
</html>
