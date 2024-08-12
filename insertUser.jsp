<%-- 
    Document   : insertUser
    Created on : 7 Mar, 2024, 3:29:18 PM
    Author     : DELL
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="xyz.Conn"%>
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
    Connection con = new Conn().con;
    
    String iufirst_name = request.getParameter("firstName");
    String iuuser_id = request.getParameter("username");
    String iupassword = request.getParameter("password");
    
    try {
        if (request.getParameter("iaction") != null && request.getParameter("iaction").equalsIgnoreCase("Insert")) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO USERSIGNUP (FIRST_NAME, USER_ID, PASSWORD) VALUES (?, ?, ?)");
            ps.setString(1, iufirst_name);
            ps.setString(2, iuuser_id);
            ps.setString(3, iupassword);
            
            int rows = ps.executeUpdate();
            
            if (rows > 0) {
                %>
                <script> function showAlert() {
            alert("Inserted!");} window.location.href='admin.jsp'</script>;
                
                <%
            } else {
                out.println("<script>window.location.href='error.html';</script>");
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
}
%>
    </body>
</html>
