
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
      <%  ResultSet rs =null;
          Connection con=new Conn().con;
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String type = request.getParameter("type");
        String spemail = request.getParameter("spemail");
        String spphone = request.getParameter("spphone");
        String spid = request.getParameter("spid");
        String sppass = request.getParameter("sppass");
        String aadhar = request.getParameter("aadhar_no");
      %>
        
        
        
      <% System.out.println(spid + sppass+"df");
            if (spid != null && sppass!= null ){
            PreparedStatement ps = con.prepareStatement("INSERT INTO SP(FIRST_NAME,LAST_NAME,TYPE,SPEMAIL,SPPHONE,SP_ID,SPPASS,aadhar_no) VALUES (?,?,?,?,?,?,?,?)");
            ps.setString(1,fname);
            ps.setString(2,lname);
            ps.setString(3,type);
            ps.setString(4,spemail);
            ps.setString(5,spphone);
            ps.setString(6,spid);
            ps.setString(7,sppass);
            ps.setString(8,aadhar);
            int rows = ps.executeUpdate(); 
            
            HttpSession sessionn = request.getSession();
            // Set session attribute
            sessionn.setAttribute("SP_ID", spid);
            System.out.println("singupJSP"+ spid);%>
            <script>
                function showAlert() {
                    alert("Welcome!");}
                function changeContent() {
                    // Access the content frame and update its source
                        parent.frames['_body1'].location.href = 'nav-bar3.jsp';
                        parent.frames['_body'].location.href = 'sp-profile.jsp'}
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

