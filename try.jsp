

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="xyz.Conn"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html>
    <head>
        <title>SP-REGISTER</title>
        <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to bottom, #219dbca0, #ffffff);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-size: 1.0rem;
            color: #fff; 
        }
        .signup-container {
            background-color: rgba(255, 255, 255, 0.8); 
            border-radius: 10px;
            padding: 20px;
            width: 100%;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.3); 
            color:  #007185;
            overflow-y: auto; 
        }
        h1 {
            color: #007185;
            text-align: center;
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        .input-group {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px; 
        }
        .input-group label {
            width: 40%;
        }
        .input-group input, .input-group select {
            width: 45%;
        }
        button {
            background-color: #007185;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 1.5rem;
            cursor: pointer;
            width: 100%;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        input[type=submit]:hover {
            background-color:  #007185;
        }
        @keyframes pulse {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
            100% {
                transform: scale(1);
            }
        }
        .animated-button {
            animation: pulse 1.5s infinite alternate;
        }
        </style>
    </head>
    <body>
   <%
    String i = request.getParameter("spid");
    String message = "";
    if (i != null) {
        Connection con = new Conn().con;
        try {
            PreparedStatement ps = con.prepareStatement("SELECT sp_id FROM SP WHERE sp_id=?");
            ps.setString(1, i);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                message = "ID Already exists";
            } else {
                // Proceed with form submission
            }
            System.out.println(message);
        } catch (SQLException e) {
            e.printStackTrace();
            message = "Error executing SQL query: " + e.getMessage();
        } finally {
            // Close database connection here
        }
    }
%>

    <center>
        <form id="signupForm" method="post" action="try.jsp" onsubmit="return validateForm()">
            <div class="signup-container">
                <h1>SIGNUP</h1>
                <!-- Input fields here -->
                <div class="input-group">
                    <label>ID</label>
                    <input type="text" name="spid" pattern="[a-zA-Z0-9._]{6,10}" title="Username must be at least 6 and at most 10 characters long and can contain letters, digits, dots, and underscores." required />
                </div>
                <!-- Error message -->
                <% if (!message.isEmpty()) { %>
                    <div class="error-message"><%= message %></div>
                <% } %>
                <!-- Other input fields and buttons -->
            </div>
            <button type="submit" class="animated-button">Signup</button>
        </form>
    </center>
</body>
</html>