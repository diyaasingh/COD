<%-- 
    Document   : BothLoginValidate
    Created on : 5 Mar, 2024, 2:52:52 PM
    Author     : DELL
--%>

<%@page import="xyz.Conn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="javax.servlet.http.*" %>

 <%
          Connection con=new Conn().con;
         
        String i = request.getParameter("uid");
        String p = request.getParameter("upass");
       
        if (i != null & p !=null){
               PreparedStatement ps = con.prepareStatement("select USER_ID, PASSWORD from usersignup where user_id = ? AND PASSWORD = ?");
            
            ps.setString(1,i);
            ps.setString(2,p);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
//            HttpSession sessionn = request.getSession();
            // Set session attribute
            session.setAttribute("USER_ID", i);
            System.out.println("log-validate-jsp"+ i);
 %>
            <script>
                function showAlert() {
                    alert("Welcome!");}
                function changeContent() {
                    // Access the content frame and update its source
                        parent.frames['_body1'].location.href = 'nav-bar2.jsp';
                        parent.frames['_body'].location.href = 'body-login.html';}
                 setTimeout(changeContent, 50);

                
            </script>
            
<%      }
else{
        ps = con.prepareStatement("select sp_id, sppass from sp where sp_id = ? and sppass=?");
            
            ps.setString(1,i);
ps.setString(2, p);
            rs = ps.executeQuery();
            if(rs.next()){
//            HttpSession sessionn = request.getSession();
            // Set session attribute
            session.setAttribute("SP_ID", i);
            System.out.println("SP-VALIDATE-JSP"+ i);
 %>
            <script>
                
                function showAlert() {
                    alert("Welcome!");}
                function changeContent() {
                    // Access the content frame and update its source
                        parent.frames['_body1'].location.href = 'nav-bar3.jsp';
                        parent.frames['_body'].location.href = 'sp-profile.jsp'}
                 setTimeout(changeContent, 50);

                
            </script>
            
<%      }else {
                // Neither user nor SP found, show alert and redirect to body.html
%>
                <script>
                    function showAlert() {
                        alert("Invalid credentials! Please try again.");
                    }
                    showAlert();
                    setTimeout(function() {
                        window.location.href = 'body.html';
                    }, 100); // Redirect after 2 seconds
                </script>
<%
            }
        }
    } else
response.sendRedirect("body.html");
    %>

    </body>
</html>
