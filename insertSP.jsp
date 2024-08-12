<%-- 
    Document   : insertSP
    Created on : 8 Mar, 2024, 2:00:13 AM
    Author     : DELL
--%>

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
    Connection con = new Conn().con;
    
    String iufirst_name = request.getParameter("firstName");
    String iuuser_id = request.getParameter("username");
    String iupassword = request.getParameter("password");
    String type = request.getParameter("type");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone-number");
    
    
    try {
        if (request.getParameter("iaction") != null && request.getParameter("iaction").equalsIgnoreCase("Insert")) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO sp (FIRST_NAME,TYPE,SPEMAIL,SPPHONE,SP_ID,SPPASS) VALUES (?, ?, ?,?,?,?)");
            ps.setString(1, iufirst_name);
            ps.setString(2, type);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, iuuser_id);
            ps.setString(6, iupassword);
            
            int rows = ps.executeUpdate();
            
            if (rows > 0) {
                %>
                <script> function showAlert() {
            alert("Inserted!"); window.location.href='admin.jsp'</script>;
                
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
