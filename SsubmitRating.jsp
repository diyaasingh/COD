<%-- 
    Document   : SsubmitRating
    Created on : 7 Mar, 2024, 2:01:58 PM
    Author     : DELL
--%>


<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="xyz.Conn"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <%
     String user_id = request.getParameter("userid") ;
    String sid = (String) session.getAttribute("sp_id");
    int rating = Integer.parseInt(request.getParameter("rating"));
    System.out.println(user_id);

    // Database connection and query execution
    Connection con = null;
    PreparedStatement stmt = null;
    try {
        con = new Conn().con;
        
        // Insert rating into database
        String query = "UPDATE urating SET RATING =? WHERE SP_ID =? AND USER_ID =?";
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
    response.sendRedirect("sp-profile.jsp#rating");
%>

    </body>
</html>