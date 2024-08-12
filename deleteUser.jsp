<%-- 
    Document   : deleteUser
    Created on : 7 Mar, 2024, 7:59:54 PM
    Author     : DELL
--%>

<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="xyz.Conn"%>
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
        String i = request.getParameter("username");
        if (request.getParameter("daction") != null && request.getParameter("daction").equalsIgnoreCase("Delete")) { System.out.println("1111111111111111111");
         try{
             System.out.println("2222222222222222222222222222");
            PreparedStatement ps = con.prepareStatement("DELETE FROM USERSIGNUP WHERE USER_ID=?");
            
            ps.setString(1,i);
            System.out.println("3333333333333333333333333");
            int rows = ps.executeUpdate();
            System.out.println("44444444444444444444444444444");
            if(rows >0)            // The update was successful, and one or more rows were affected.
                {%>
                
                <script> function showAlert() {
            alert("Deleted!"); window.location.href='admin.jsp'</script>
                
               
                <%}
            else                              // No rows were updated, indicating the update failed.
                { %>
                  <h3>Delete Failed, no row affected</h3>
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
