<%-- 
    Document   : adminvalidate
    Created on : 8 Mar, 2024, 11:07:24 PM
    Author     : DELL
--%>

<%@page import="java.sql.ResultSet"%>
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
          Connection con=new Conn().con;
         
        String a = request.getParameter("adminid");
       
        if (a != null){
               PreparedStatement ps = con.prepareStatement("select * from admin where admin_id = ?");
            
            ps.setString(1,a);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
            HttpSession sessionn = request.getSession();
            // Set session attribute
            sessionn.setAttribute("ADMIN_ID", a);
            
            System.out.println("log-validate-jsp"+ a);
 %>
            <script>
                function showAlert() {
                    alert("Welcome!");}
                function changeContent() {
                    // Access the content frame and update its source
                        parent.frames['_body1'].location.href = 'nav-bar4.jsp';
                        parent.frames['_body'].location.href = 'admin.jsp';}
                 setTimeout(changeContent, 50);

                
            </script>
            
<%      }
else{System.out.println("error");}
}%>
    </body>
</html>
