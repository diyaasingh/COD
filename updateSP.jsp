<%-- 
    Document   : updateSP
    Created on : 8 Mar, 2024, 2:00:30 AM
    Author     : DELL
--%>

<%@page import="xyz.Conn"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
          Connection con=new Conn().con;
        String i = request.getParameter("spid");
        String n = request.getParameter("firstName");
        String p = request.getParameter("password");
        String t = request.getParameter("type");
        String m = request.getParameter("spmail");
        String ph = request.getParameter("spphone");
        
        
       if (request.getParameter("uaction") != null && request.getParameter("uaction").equalsIgnoreCase("Update")) { System.out.println("1111111111111111111");
         try{
             System.out.println("2222222222222222222222222222");
            PreparedStatement ps = con.prepareStatement("UPDATE SP SET FIRST_NAME=?,TYPE=?,SPEMAIL,SPPHONE,SPPASS,SP_ID WHERE SP_ID=?");
            ps.setString(1,n);
            ps.setString(2,t);
            ps.setString(3,m);
            ps.setString(4,ph);
            ps.setString(5,p);
            ps.setString(6,i);
            System.out.println("3333333333333333333333333");
            int rows = ps.executeUpdate();
            System.out.println("44444444444444444444444444444");
            if(rows >0)            // The update was successful, and one or more rows were affected.
                {%>
                 <script>
        // Display an alert when the page loads
        window.onload = function() {
            alert("User Updated!");
        };
    </script>
                <%response.sendRedirect("admin.jsp");}
            else                                  // No rows were updated, indicating the update failed.
                { %>
                  <h3>Update Failed, no row affected</h3>
                <%}
          }
         catch(Exception e)
           { e.printStackTrace();%>
          
             <p>An error has occured</p>
             
            <%}
       }else{ System.out.println("555555555555555555");%>
                <h3>Invalid UserId</h3>   
            <%}%>
    </body>
</html>
