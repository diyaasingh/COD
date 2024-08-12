<%-- 
    Document   : logout
    Created on : 8 Mar, 2024, 4:27:40 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
      <%
    // Invalidate the session
    if (session != null) {
    session.invalidate(); // Invalidate the session
}


%>

<script>
                function showAlert() {
                    alert("Logout!");}
                function changeContent() {
                    // Access the content frame and update its source
                        parent.frames['_body1'].location.href = 'logo-bar.html';
                        parent.frames['_body'].location.href = 'body.html';
                    setTimeout(showAlert, 5);}
                 setTimeout(changeContent, 10);

                
</script>
    </body>
</html>
