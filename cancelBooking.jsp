<%-- 
    Document   : cancelBooking
    Created on : 5 Apr, 2024, 4:56:59 PM
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
        <title>Cancel Booking</title>
        <style>
            body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(to bottom, #007185, white);
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

            </style>
     <script src="https://cdn.jsdelivr.net/npm/@emailjs/browser@4/dist/email.min.js"></script>

    <script type="text/javascript">
        (function(){
            emailjs.init({
                publicKey: "XedhrWtDuiZQpUC8B",
            });
        })();
</script>
    </head>
    <body>
       <%
           System.out.println("reached cancel pagwe");
// Retrieve the SQL query parameter from the request
String sqlQuery = request.getParameter("sqlQuery");
String date = request.getParameter("date");
String time = request.getParameter("time");
String spid = request.getParameter("spid");
String email = request.getParameter("email");

System.out.println(date+"date");
System.out.println(time+"time");
System.out.println(spid+"spid");
System.out.println(email+"email");


System.out.println(sqlQuery+"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
        Connection con = null;
        PreparedStatement ps = null;
         ResultSet rs = null;
         String spemail ="";
         String type = "";
         try {
             System.out.println("bbb");
            con = new Conn().con;
             ps = con.prepareStatement(sqlQuery);
  System.out.println("cccc");
    // Execute the SQL query
    int rowsAffected = ps.executeUpdate();
      System.out.println("dddd");
    PreparedStatement ps1 = con.prepareStatement("Select spemail , type from sp where sp_id=?");
    ps1.setString(1,spid);
    ResultSet rs1 = ps1.executeQuery();
      System.out.println("eee");
                if(rs1.next()){
                      System.out.println("fff");
                    spemail = rs1.getString("spemail");
                    type = rs1.getString("type");
                }else{ System.out.println("fff1");}
       System.out.println("this is where i check for if condition"+ spemail);
       %>
  <script>
      var email = "<%=email%>";
            var date = "<%=date%>";
            var time = "<%=time%>";
      console.log(email);
      console.log(date);
      console.log(time);
        function sendMail() {
            
            var params = {
                email: email,
                date: date,
                time: time,
                type: "<%=type%>",
                spemail: "<%=rs1.getString("spemail")%>",
            };
            const serviceID = "service_nw9nyi9";
            const templateID = "template_jq9230o";

            emailjs.send(serviceID, templateID, params)
                .then(res => {
                    console.log(res);
                    alert("Cancellation Mail sent!")
                })
                .catch(err => console.log(err));
        }
        sendMail();
       
    // Delay the redirection to the home page
    setTimeout(function() {
        // Redirect to the home page
        window.location.href = "Uprofile.jsp#cancel";
    }, 5000); // Delay for 1 minute (600 milliseconds)
   
    </script>
   <%
//       response.sendRedirect("Uprofile.jsp#cancel");
} catch (SQLException e) {
    e.printStackTrace();
}

// Use the SQL query parameter as needed
// Ensure proper validation and security measures are in place before executing the SQL query
%>


   

    </body>
</html>
