<%-- 
    Document   : status-name
    Created on : 3 Mar, 2024, 2:44:20 AM
    Author     : DELL
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="xyz.Conn"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
           
    String sid = request.getParameter("sid");
    String column = request.getParameter("column");
    System.out.println(column);
    try {
        Connection con = new Conn().con;
        PreparedStatement ps = con.prepareStatement("UPDATE sp SET " + column + " = CASE WHEN " + column + " = true THEN false ELSE true END WHERE sp_id=?");
        ps.setString(1, sid);
        if (ps.executeUpdate() > 0) {
            // Successful update
            response.sendRedirect("sp-profile.jsp#availability");
        } else {
            // Failed update
            response.sendRedirect("error.html");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        // Handle SQLException
        response.sendRedirect("error.html");
    }
%>


    </body>
</html>
