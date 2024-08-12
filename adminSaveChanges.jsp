<%-- 
    Document   : adminSaveChanges
    Created on : 7 Apr, 2024, 2:13:49 AM
    Author     : DELL
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="xyz.Conn"%>
<%@page import="java.sql.Connection"%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit User Profile</title>
<style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #007185;
            color: #fff;
        }

        .navbar {
            background-color: #023047;
            color: #fff;
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100vh;
            width: 15%;
            position: fixed;
            left: 0;
            top: 0;
            overflow-x: hidden;
            z-index: 1;
        }

        .navbar-item {
            margin: 20px 0;
            cursor: pointer;
        }

        .navbar-item:hover {
            background-color: #079DD9;
        }

        .profile-container {
            width: 60%;
            margin: 0 auto;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
            margin-left: 26%;
            text-align: center;
        }

        .profile-container h1 {
            font-size: 2rem;
            margin-bottom: 20px;
            color: #219dbca0;
        }

        .profile-container img {
            width: 15%;
            height: auto;
            border-radius: 50%;
            margin-bottom: 20px;
        }

        .profile-container label {
            display: block;
            margin-bottom: 10px;
            color: #333;
        }

        .profile-container input[type="text"],
        .profile-container input[type="tel"],
        .profile-container input[type="email"],
        .profile-container input[type="password"] {
            width: 70%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            margin: 10px auto;
        }

        .profile-container select {
            width: 70%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            margin: 10px auto;
        }

        .profile-container input[type="button"] {
            background-color: #023047;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 1.2rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
            border-radius: 5px;
            margin: 10px;
        }
        .saveChangesBtn{
             background-color: #023047;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 1.2rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
            border-radius: 5px;
            margin: 10px;
        }
        .saveChangesBtn:hover {
            background-color: #219dbca0;
        }

        .profile-container input[type="button"]:hover {
            background-color: #219dbca0;
        }

        .submit-btn {
            background-color: #023047;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 1.2rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
            border-radius: 5px;
            margin-top: 20px;
        }

        .submit-btn:hover {
            background-color: #219dbca0;
        }

        .star {
            font-size: 2rem;
            color: #079DD9 ;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .star:hover,
        .star.active {
            color:#023047;
        }
        .password-container {
             position: relative;
        }

        #password {
            padding-right: 30px; /* Adjust as needed */
        }

        .eye-icon {
            position: absolute;
            right: 16%;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
        }

        .eye-icon i {
            font-size: 1.2rem;
        }


    </style>
</head>
<body>

<!-- user-profile.jsp -->
<%
    System.out.println("THIS IS ADMINSAVECHANGES PAGE");
    // Retrieve form data
   String uid = (String) session.getAttribute("ADMIN_ID");
    String firstname = request.getParameter("fname");
    String password = request.getParameter("password");
    String lname = request.getParameter("lname");
    String email = request.getParameter("email");
    System.out.println(uid + firstname + lname + email );
    int phone = Integer.parseInt(request.getParameter("phone"));
    System.out.println(uid + firstname + lname + email + phone);
    
    
    // Establish database connection
    Connection con = new Conn().con;
    
    try {
        // Prepare and execute update query
        PreparedStatement pss = con.prepareStatement("UPDATE ADMIN SET FIRST_NAME=?, PASSWORD=? , LAST_NAME=?, EMAIL=?,PHONE=? WHERE ADMIN_ID=?");
        pss.setString(1, firstname);
        pss.setString(2, password);
        pss.setString(3, lname);
        pss.setString(4, email);
        pss.setInt(5, phone);
        pss.setString(6, uid);
        
        int rows = pss.executeUpdate();
        
        if (rows > 0) {
            // Redirect to a success page or display a success message
            response.sendRedirect("admin.jsp");
        } else {
            // Redirect to an error page or display an error message
            response.sendRedirect("abc.jsp");
        }
    } catch(SQLException e) {
        // Handle database errors
        e.printStackTrace();
        // Redirect to an error page or display an error message
        response.sendRedirect("abc.jsp");
    }
%>


</body>
