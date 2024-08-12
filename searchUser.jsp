<%-- 
    Document   : searchUser
    Created on : 8 Mar, 2024, 12:48:07 AM
    Author     : DELL
--%>


<%@page import="xyz.Conn"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="java.io.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Search Results</title>
</head>
<body>

<%
    // Establish database connection
    Connection con = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    String fname="";
    String uuid="";
    String uupass = "";

    try {
        // Obtain DataSource from JNDI (Java Naming and Directory Interface)
        InitialContext context = new InitialContext();
       con = new Conn().con;

        // Retrieve user input from the form
        String userId = request.getParameter("userid");

        // Query to fetch data based on user ID
        String query = "SELECT FIRST_NAME,USER_ID,PASSWORD FROM USERSIGNUP WHERE user_id = ?";
        statement = con.prepareStatement(query);
        statement.setString(1, userId);

        // Execute the query
        resultSet = statement.executeQuery();

        while (resultSet.next()) {
           
          fname=resultSet.getString("first_name");
          uuid=resultSet.getString("user_id");
           uupass=resultSet.getString("password");
            
        }

       
      } catch (NamingException e) {
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Close resources
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

</body>
</html>

   <%
    // Retrieve parameters
   
    
    // Redirect to admin.jsp with parameters and anchor
    String redirectURL = "admin.jsp?fname=" + fname + "&uuid=" + uuid + "&uupass=" + uupass + "#searchContainer";
    response.sendRedirect(redirectURL);
%>
