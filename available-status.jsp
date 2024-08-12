<%-- 
    Document   : available-status
    Created on : 3 Mar, 2024, 1:52:58 AM
    Author     : DELL
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>AVAILABLE STATUS</title>
</head>
<body>
    
<%
    // Define database connection variables
    Connection con = null;
    ResultSet rs = null;
    String name = "Keshav";
    String availableStatus = ""; // Variable to hold the available status

    try {
        // Establish database connection
        con = DriverManager.getConnection("jdbc:derby://localhost:1527/cod");

        // Prepare and execute SQL query
        PreparedStatement ps = con.prepareStatement("SELECT cd FROM SP WHERE FIRST_NAME = ?");
        ps.setString(1, name);
        rs = ps.executeQuery();

        // Process the ResultSet
        if (rs.next()) {
            // Retrieve the available status from the ResultSet
            availableStatus = rs.getString("cd");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Close database resources
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<h1 name="name">Available Status for <%= name %>:</h1>
<div class="available" id="available"><%= availableStatus %></div>

<a href="status-name.jsp?name=<%=name%>"<button onclick="window.location.href ='status-name.jsp' ">Change Status</button></a>
</body>
</html>
