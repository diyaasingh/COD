<%-- 
    Document   : validate
    Created on : 11 Oct, 2023, 10:35:53 PM
    Author     : DELL
--%>


<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="xyz.Conn" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Validation Page</title>
    </head>
    <%
        Connection con = new Conn().con;
        String u = request.getParameter("uid");
        String p = request.getParameter("upass");
        PreparedStatement ps = con.prepareStatement("SELECT first_name,sppass FROM SP WHERE first_name=? AND sppass =?");
        ps.setString(1,u);
        ps.setString(2,p);
        ResultSet rs = ps.executeQuery();
        String redirectURL = "available-status.jsp";
        if(rs.next())
            response.sendRedirect(redirectURL);
        else
            response.sendRedirect("error.html");
        
%>
<body>
        
    </body>
</html>




<!-- Create a link with an onclick event to open in a new tab -->

