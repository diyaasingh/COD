<%-- 
    Document   : signup
    Created on : 12 Oct, 2023, 10:10:18 PM
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
        <title>Signup</title>
    </head>
      <%
          Connection con=new Conn().con;
         
        String i = request.getParameter("uid");
        String n = request.getParameter("username");
        String p = request.getParameter("upass");
        String l = request.getParameter("lastname");
        String e = request.getParameter("email");
        String m = request.getParameter("phone");
        String a = request.getParameter("address");
        
        if (i != null){
            System.out.println("1") ;
               PreparedStatement ps = con.prepareStatement("INSERT INTO USERSIGNUP(First_Name,User_Id,Password,LAST_NAME,EMAIL,PHONENO,ADDRESS) VALUES (?,?,?,?,?,?,?)");
            ps.setString(1,n);
            ps.setString(2,i);
            ps.setString(3,p);
            ps.setString(4,l);
            ps.setString(5,e);
            ps.setString(6,m);
            ps.setString(7,a);
            
            int rows = ps.executeUpdate(); 
            String redirectURL = "body-login.html";
            HttpSession sessionn = request.getSession();
            // Set session attribute
            sessionn.setAttribute("USER_ID", i);
            System.out.println("singupJSP"+ i);
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
            
            <%}
else{%>
        <script>
        // Use JavaScript to display an alert
        alert("Invalid Credentials");
    </script>
    <% }%>
    
    <body>
    </body>
</html>
