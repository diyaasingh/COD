<%-- 
    Document   : try-rating
    Created on : 9 Mar, 2024, 11:37:25 PM
    Author     : DELL
--%>
<%@page import="xyz.Conn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
    
    
  Connection con = new Conn().con;
    // Retrieve session attributes
    String sp_id = "Har-car-22";
    String user_id = "bhavya27";
    String user_name = "";
    PreparedStatement ps = con.prepareStatement("SELECT FIRST_NAME FROM SP WHERE SP_ID = ?");
    ps.setString(1,sp_id);
    ResultSet sr = ps.executeQuery();
    if (sr.next()){
        user_name = sr.getString("FIRST_NAME");
    }

    // Check if a rating exists for the current user and service provider
    String query = "SELECT * FROM srating WHERE sp_id = ? AND user_id = ?";
    PreparedStatement stmt = con.prepareStatement(query);
    stmt.setString(1, sp_id);
    stmt.setString(2, user_id);
    ResultSet rs = stmt.executeQuery();

    int rating = 0; // Initialize with default value
    if (rs.next()) {
        // Rating already exists
        rating = rs.getInt("rating");
    }
    // Close database resources
    rs.close();
    stmt.close();
    con.close();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Rating</title>
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

    </style>
    <!-- Your styles -->
</head>
<body>
    <!-- Your navbar and other HTML elements -->

    <div class="profile-container" id="ratingContainer" style="display: block;">
    <h1>Rating</h1>
    <div class="rating-item">
        <form id="ratingForm" method="post">
        <label for="name">Service Provider:</label>
        <input type="text" id="name" name="name" value="<%= user_name %>" readonly><br>
        <div class="stars" onclick="rate(event)" data-rating="<%= rating %>">
            <span class="star" data-value="1">&#9733;</span>
            <span class="star" data-value="2">&#9733;</span>
            <span class="star" data-value="3">&#9733;</span>
            <span class="star" data-value="4">&#9733;</span>
            <span class="star" data-value="5">&#9733;</span>
        </div>
        <% if (rating == 0) { %>
            <p>Please give a rating:</p>
        <% } %>
        <!-- Add hidden input field to store rating value -->
        <input type="hidden" id="rating" name="rating" value="<%= rating %>">
        <input type="submit" class="submit-btn" onclick="submitRating()" value="Submit Rating">
        </form>
    </div>
</div>

    <script>
    function rate(event) {
        const stars = document.querySelectorAll('.star');
        const target = event.target;
        const value = parseInt(target.getAttribute('data-value'));

        // Update hidden input field with selected rating value
        document.getElementById('rating').value = value;

        stars.forEach((star, index) => {
            if (index < value) {
                star.classList.add('active');
            } else {
                star.classList.remove('active');
            }
        });
    }

    function submitRating() {
        // Retrieve rating value from hidden input field
        const rating = document.getElementById('rating').value;

        // Make sure rating is not empty or invalid
        if (rating.trim() === '' || isNaN(rating)) {
            alert('Please select a rating.');
            return;
        }

        // Set the action attribute of the form to submitrating.jsp
        document.getElementById('ratingForm').action = 'submitRating.jsp';

        // Submit the form
        document.getElementById('ratingForm').submit();
    }
</script>


</body>
</html>

