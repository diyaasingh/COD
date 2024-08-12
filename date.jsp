<%-- 
    Document   : date.jsp
    Created on : 3 Mar, 2024, 5:28:26 PM
    Author     : DELL
--%><%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DATE</title>
    </head>
    <body>
        <%
            LocalDate currentDate = LocalDate.now();
            System.out.println(currentDate);
            LocalDate nextDate = currentDate.plusDays(1);
            LocalDate nextNextDate = currentDate.plusDays(2);
         %>
         <form id="myForm" action="date-action.jsp" method="post">
         <label for='dates'>Book for</label>
         <a href="book-electrician.jsp?name='kamal'"> <button name="buttonValue" value="button1"><%= currentDate%></button></a>
         <a href="book-electrician.jsp?name='Ram'"><button name="buttonValue" value="button2"><%= nextDate%></button></a>
         <a href="book-electrician.jsp?name='kamal'"><button name="buttonValue" value="button3"><%= nextNextDate%></button></a>
         </form>
    </body>



<script>
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.button').forEach(function(button) {
        button.addEventListener('click', function() {
            document.getElementById('myForm').submit();
        });
    });
});
</script>

</body>
</html>


