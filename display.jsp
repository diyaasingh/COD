<%-- 
    Document   : display
    Created on : 3 Mar, 2024, 12:06:09 AM
    Author     : DELL
--%>

<%@ page import="java.sql.*" %>
<%@ page import="javax.swing.table.*" %>
<%@ page import="javax.swing.*" %>
<%@ page import="javax.swing.table.DefaultTableModel" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Information</title>
    <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0; 
                color: #fff; 
                background: linear-gradient(to bottom,  #219dbca0, #007185);
            }
    
            h1 {
                margin-bottom: 10px;
            }
    
            .profiles {
                display: flex;
                flex-wrap: wrap;
                justify-content: center; 
                gap: 20px; 
            }
    
            .profile {
                background-color: #fff; 
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(00.3s, 00.3s, 00.3s, 0.0.3s);
                text-align: left;
                width: 90%;
                cursor: pointer;
                margin-bottom: 20px;
                margin-left: 20px;
                margin-right: 20px;
                transition: transform 0.3s ease;
            }
    
            .profile:hover {
                transform: translateY(-5px);
            }
    
            .profile-pic {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                margin-bottom: 10px;
            }
    
            .name {
                font-weight: bold;
                font-size: 1.2rem;
                margin-bottom: 5px;
                color: #007185; 
                cursor: pointer;
            }
    
            .details {
                color: #666; 
                margin-bottom: 10px;
            }
    
            .book-now {
                background-color: #007185; 
                color: #fff;
                border: none;
                padding: 10px 20px;
                font-size: 1rem;
                cursor: pointer;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }
    
            .book-now:hover {
                background-color: #219dbca0; 
            }
            h1, h2 {
            color: #fff; 
            margin-bottom: 10px; 
            animation: slideUp 0.5s ease; 
            text-align: center;
            padding: 20px;
        }
        @keyframes slideUp {
            from {
                transform: translateY(100px); 
                opacity: 20; 
            }
            to {
                transform: translateY(0); 
                opacity: 1; 
            }
        }

        h1 {
            font-size: 2.5rem; 
        }

        h2 {
            font-size: 1.8rem;
            text-align: left;
        }
        a {
    text-decoration: none;
}     
        </style>
</head>
<body>
    <div class="container">
        <center>
            <h1>Pay after service | Super fast service</h1>
            <h2>Electricians near me!</h2>
        </center>
<br>
</div>
    <div id="userInfoContainer">
        <%
            // Define database connection variables
            Connection con = null;
            ResultSet rs = null;
            try {
                // Establish database connection
                con = DriverManager.getConnection("jdbc:derby://localhost:1527/cod");
                
                // Prepare and execute SQL query
                PreparedStatement ps = con.prepareStatement("SELECT FIRST_NAME FROM SP WHERE TYPE = 'Electrician' AND AVAILABLE = true");
                rs = ps.executeQuery();

                // Display the data in <p> elements within the <div> container
                while (rs.next()) {
                    // Access each column of the result set and display it in <p> elements
                    %>
                    
                    
                    <div class="profile" >
                        <a href="service-provider-info.html" ><img src="user-icon.png" alt="Electrician Profile Picture" class="profile-pic"></a>
                        <div class="info">
                            <a href="service-provider-info.html">
                            <div class="name" id="fname"><%= rs.getString("FIRST_NAME") %></div>
                            <div class="details">Lorem ipsum dolor sit amet consectetur adipisicing</div>
                            </a>
                        </div>
                        <a href="book-electrician.jsp?name=<%= rs.getString("FIRST_NAME") %>"><button class="book-now" onclick="window.location.href='sp-register.html'">Book Now</button></a>
                    </div>
                    <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                // Close database resources
                try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </div>
</body>
</html>

