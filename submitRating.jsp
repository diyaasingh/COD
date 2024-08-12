<%-- 
    Document   : submitRating
    Created on : 6 Mar, 2024, 6:19:20 PM
    Author     : DELL
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="xyz.Conn"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <title>JSP Page</title>
    </head>
    <body>

<%
    System.out.println("reached submitRating PAGE");
    // Retrieve form data
    String sid = request.getParameter("sid") ;
    String user_id = (String) session.getAttribute("USER_ID");
//    String user_id = request.getParameter("userid") ;
    int rating = Integer.parseInt(request.getParameter("rating"));
    System.out.println(rating);

    // Database connection and query execution
    Connection con = null;
    PreparedStatement stmt = null;
    try {
        con = new Conn().con;
        
        // Insert rating into database
        String query = "UPDATE srating SET RATING =? WHERE SP_ID =? AND USER_ID =?";
        stmt = con.prepareStatement(query);
        stmt.setInt(1, rating);
        stmt.setString(2, sid);
        stmt.setString(3, user_id);
        System.out.println(rating);
        System.out.println(sid);
        System.out.println(user_id);
        stmt.executeUpdate();
        System.out.println("ggg"+rating);
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close resources
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<!-- Redirect user back to the same page or any other page -->
<%
    response.sendRedirect("Uprofile.jsp#rating");
%>


    </body>
</html>
