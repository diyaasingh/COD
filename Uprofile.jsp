<%-- 
    Document   : Uprofile
    Created on : 6 Mar, 2024, 11:18:19 PM
    Author     : DELL
--%>

<%@page import="java.text.ParseException"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="xyz.Conn"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.time.LocalTime" %>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
</head>
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
             .rating-container {
            width: 60%;
            margin: 0 auto;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
            text-align: center;
            display: none;
        }
        .rating-container h1 {
            font-size: 2rem;
            margin-bottom: 20px;
            color: #023047;
        }

    </style>
</head>
<body>
    
    <% response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
        ResultSet rs = null;
    // Retrieve session attribute
    String uid = (String) session.getAttribute("USER_ID");
    Connection con = new Conn().con;
    
    String firstname = "";
    String password = "";
    String lastname = "";
    String email = "";
    String phone = "";
    String address = "";
    String user_id = "" ;
    
    if (uid != null && session.getAttribute("USER_ID") != null) {
        PreparedStatement ps = con.prepareStatement("SELECT FIRST_NAME, PASSWORD,LAST_NAME,EMAIL,PHONENO,ADDRESS,USER_ID FROM USERSIGNUP WHERE USER_ID = ?");
        ps.setString(1, uid);
        rs = ps.executeQuery();
        
        if (rs.next()) {
            firstname = rs.getString("FIRST_NAME");
            password = rs.getString("PASSWORD");
            lastname = rs.getString("LAST_NAME");
            email = rs.getString("EMAIL");
            phone = rs.getString("PHONENO");
            address = rs.getString("ADDRESS");
            user_id = rs.getString("USER_ID");
        } else {
            System.out.println("User not found");
        }
    }
%>
    
    <% 
    String reviewsp = "";
    String spid = "";
    try {                                               
        PreparedStatement ps = con.prepareStatement("SELECT s.first_name as sp_name,s.sp_id FROM booking b JOIN usersignup u ON b.user_id = u.user_id JOIN sp s ON b.sp_id = s.sp_id WHERE b.user_id =?");
        ps.setString(1, uid);
        ResultSet rs1 = ps.executeQuery();
        if (rs1.next()) {
            reviewsp = rs1.getString(1);
            spid = rs1.getString(2);
            System.out.println(reviewsp);
            System.out.println(spid);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } 
%>


<div class="navbar">
        <div class="navbar-item" onclick="showEditProfile()">Profile</div>
        <div class="navbar-item" onclick="showBookings()">Bookings</div>
        <div class="navbar-item" onclick="showRating()">Rating</div>
        <div class="navbar-item" onclick="showCancel()">Cancel Booking</div>
</div>

<div class="profile-container" id="editProfileContainer" >
    <h1>Edit Profile</h1>
    <form action="user-profile.jsp" method="post">
        
        <!-- Input fields for editing profile -->
        <label for="username">Username:</label>
        <input type="text" id="uid" name="uid" value="<%= user_id %>" readonly><br>
        <label for="fname">First Name</label>
        <input type="text" id="fname" name="fname" value="<%= firstname %>" readonly><br>
        <label for="lname">Last Name</label>
        <input type="text" id="lname" name="lname" value="<%= lastname %>" readonly><br>
        <label for="password">Password</label>
        <div class="password-container">
        <input type="password" id="password" name="password" value="<%= password %>" readonly><br>
         <span class="eye-icon" onclick="togglePasswordVisibility()">👁️</span>
        </div>
         <label for="address">Address</label>
        <input type="text" id="address" name="address" value="<%= address %>" readonly><br>
        <label for="email">Email</label>
        <input type="text" id="email" name="email" value="<%= email %>" readonly><br>
        <label for="phone">Phone No</label>
        <input type="text" id="phone" name="phone" value="<%= phone %>" readonly><br>
        <!-- Other input fields -->
        <input type="button" value="Edit Profile" onclick="enableEdit()">
<input type="button" value="Save Changes" id="submitButton" style="display: none;" onclick="saveChanges()">
<input type="submit" value="Save Change" id="saveChangesBtn" style="display: none; background-color: #023047;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 1.2rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
            border-radius: 5px;
            margin: 10px;">

        
          
    </form>
</div>
        

    <div class="profile-container" id="bookingsContainer" style="display: none; height: auto;">
    <h1>Bookings</h1>
    <div>
       <%
LocalDate currentDate = LocalDate.now();
LocalDate nextDate = currentDate.plusDays(1);
LocalDate nextNextDate = currentDate.plusDays(2);

DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yy");

// Format the current date using the defined format
String formattedCurrentDate = currentDate.format(formatter);

try {
    con = new Conn().con;
    PreparedStatement pps = con.prepareStatement("SELECT SP_ID, DATE, TIME FROM BOOKING WHERE USER_ID = ?");
    pps.setString(1, uid);
    rs = pps.executeQuery();
    String sp_iid = "";

    while (rs.next()) {
        String dateString = rs.getString("DATE");
        String timeString = rs.getString("TIME");
        sp_iid = rs.getString("SP_ID");

        // Parse the date string from the database into a LocalDate object
        LocalDate bookingDate = LocalDate.parse(dateString, formatter);
        System.out.println("bookingDate"+bookingDate);
        System.out.println("currentDate"+currentDate);
        System.out.println("timeString"+timeString);
        String[] timeParts = timeString.split(" - ");

        // Parse the start and end time strings into LocalTime objects
        DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("h:mm a");
        LocalTime startTime = LocalTime.parse(timeParts[0], formatter1);
        LocalTime endTime = LocalTime.parse(timeParts[1], formatter1);

        // Get the current time
        LocalTime currentTime = LocalTime.now();

        // Compare start time with current time
        int startTimeComparison = currentTime.compareTo(startTime);

        // Compare end time with current time
        int endTimeComparison = currentTime.compareTo(endTime);
        String divColor = "";
        // Compare the current date with the booking date
        if (currentDate.isBefore(bookingDate)) {
            divColor = "green"; // Past date
        } else if (currentDate.isAfter(bookingDate)) {
            divColor = "red"; // Future date
        } else {
            if (startTimeComparison >= 0 && endTimeComparison <= 0) {
            System.out.println("Current time is within the time range.");
             divColor = "yellow";
        } else if (startTimeComparison < 0) {
            System.out.println("Current time is before the time range.");
             divColor = "green";
        } else {
            System.out.println("Current time is after the time range.");
             divColor = "red";
        }// Or any other color
        }

        String spname = "";
        String type = "";
        PreparedStatement ps = con.prepareStatement("SELECT FIRST_NAME, TYPE FROM SP WHERE SP_ID = ?");
        ps.setString(1, sp_iid);
        ResultSet sr = ps.executeQuery();
        if (sr.next()) {
            spname = sr.getString("FIRST_NAME");
            type = sr.getString("TYPE");
        }
%> 
<div class="profile" style="background-color: <%=divColor%>;">
    <h2> <%=type%> Booking </h2>
    <h3><%= rs.getString("DATE") %></h3>
    <h4><%= rs.getString("TIME") %></h4>
    <h3>Service Provider - <%=spname%></h3>
    </div>
<%
    }
} catch (SQLException e) {
    e.printStackTrace();
}
%>


    </div>
    </div>
<div class="profile-container" id="ratingContainer" style="display: none; height: auto;">
    <h1>Rating</h1>
<%
//    String valueToCheck = reviewsp; // The value you want to check
//    String message = ""; // Initialize message variable
//
//    try {
//        
//        PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) AS count_value FROM srating WHERE sp_id IN (SELECT s.sp_id FROM sp s WHERE s.first_name = ?)");
//        ps.setString(1, valueToCheck);
//        ResultSet sr = ps.executeQuery();
//
//        if (sr.next()) {
//            int count = sr.getInt("count_value");
//            if (count > 0) {
//                message = "Thanks for the rating";
//            } else {
//                message = "Please give rating";
//            }
//        }
//    } catch (SQLException e) {
//        e.printStackTrace();
//        // Handle SQLException
//        message = "An error occurred while checking the value.";
//    }
//    
//int ratingValue = 0;
//    PreparedStatement ps = con.prepareStatement("select rating from srating where sp_id in(SELECT s.sp_id FROM sp s WHERE s.first_name = ?)");
//    ps.setString(1,valueToCheck);
//    ResultSet sr = ps.executeQuery();
//    if(sr.next()){
//        ratingValue = sr.getInt("RATING") ;
//        System.out.println(ratingValue);
//    }

        
        String query = "SELECT * FROM srating WHERE user_id = ? AND RATING IS NULL";try{
    PreparedStatement stmt = con.prepareStatement(query);
//    stmt.setString(1, spid);
    stmt.setString(1, user_id);
    ResultSet rs11 = stmt.executeQuery();

    int rating = 0; // Initialize with default value
    if (!rs11.next()) {
    // If there are no results in the ResultSet rs11
    System.out.println("in if");
%>
<br>
<div>No ratings found.</div>
     
<%
} else {
System.out.println("in else");
   do {
System.out.println("in while");
        rating = rs11.getInt("rating");
        spid = rs11.getString("sp_id");
    %>
   <center>
    <div class="rating-item">
        <form id="ratingForm" method="post">
        <label for="name">Service Provider:</label>
          <input type="text" value="<%= spid %>" readonly><br>
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
    </div></center><br>
    <%
            } while (rs11.next());}} catch (SQLException e) {
                e.printStackTrace();
            }
System.out.println("THIS IS POINT A");
            %>
    </div>
    <div id="cancelContainer" class="profile-container" style="display:none">
        <h1>Cancel Booking</h1>
    <div>
       <%
try {
    con = new Conn().con;
    PreparedStatement pps = con.prepareStatement("SELECT SP_ID, DATE, TIME FROM BOOKING WHERE USER_ID = ?");
    pps.setString(1, uid);
    rs = pps.executeQuery();
    String sp_iid = "";

    while (rs.next()) {
        String dateString = rs.getString("DATE");
        String timeString = rs.getString("TIME");
        sp_iid = rs.getString("SP_ID");
         String spname = "";
        String type = "";
        PreparedStatement ps = con.prepareStatement("SELECT FIRST_NAME, TYPE FROM SP WHERE SP_ID = ?");
        ps.setString(1, sp_iid);
        ResultSet sr = ps.executeQuery();

        // Parse the date string from the database into a LocalDate object
        LocalDate bookingDate = LocalDate.parse(dateString, formatter);
        System.out.println("bookingDate"+bookingDate);
        System.out.println("currentDate"+currentDate);
        System.out.println("timeString"+timeString);
        String[] timeParts = timeString.split(" - ");

        // Parse the start and end time strings into LocalTime objects
        DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("h:mm a");
        LocalTime startTime = LocalTime.parse(timeParts[0], formatter1);
        LocalTime endTime = LocalTime.parse(timeParts[1], formatter1);

        // Get the current time
        LocalTime currentTime = LocalTime.now();

        // Compare start time with current time
        int startTimeComparison = currentTime.compareTo(startTime);

        // Compare end time with current time
        int endTimeComparison = currentTime.compareTo(endTime);
        
        // Compare the current date with the booking date
        if (currentDate.isBefore(bookingDate)) {
           System.out.println("YES");
           if (sr.next()) {
            spname = sr.getString("FIRST_NAME");
            type = sr.getString("TYPE");
        
%> 
<div class="profile" style="color: black;">
   
    <h3 class="date"><%=sp_iid%></h3>
    <h3 class="date"><%= rs.getString("DATE") %></h3>
    <h4 class="date"><%= rs.getString("TIME") %></h4>
     <h2 class="date"> <%=type%> Booking </h2>
    <h3 class="date">Service Provider - <%=spname%></h3>
    <button style="background-color: #023047;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 1.2rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
            border-radius: 5px;
            margin: 10px;" class="cancel-btn">Cancel</button>
    </div>

<%
    }
        } else if (currentDate.isAfter(bookingDate)) {
            System.out.println("nothing");
        } else {
            if (startTimeComparison >= 0 && endTimeComparison <= 0) {
            System.out.println("Current time is within the time range.");
            
        } else if (startTimeComparison < 0) {
            System.out.println("Current time is before the time range.");
             System.out.println("future");
if (sr.next()) {
            spname = sr.getString("FIRST_NAME");
            type = sr.getString("TYPE");
        
%> 
<div class="profile" style="color: black;">
    
     <h3 class="date"><%=spid%></h3>
    <h3 class="date"><%= rs.getString("DATE") %></h3>
    <h4 class="date"><%= rs.getString("TIME") %></h4>
   <h2 class="date"> <%=type%> Booking </h2>
    <h3 class="date">Service Provider - <%=spname%></h3>
    
    <button style="background-color: #023047;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 1.2rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
            border-radius: 5px;
            margin: 10px;" class="cancel-btn">Cancel</button>
    </div>
<%
    }
        } else {
            System.out.println("Current time is after the time range.");
             System.out.println("nothing-time");
        }// Or any other color
        }
}
} catch (SQLException e) {
    e.printStackTrace();
}
%>


    </div>
    </div>

    <script>
        
    // JavaScript code here
   function showRating(){
      console.log("showRating() function called");
            document.getElementById("editProfileContainer").style.display = "none";
            
            document.getElementById("bookingsContainer").style.display = "none";
            
            document.getElementById("ratingContainer").style.display = "block";
            document.getElementById("cancelContainer").style.display = "none";
            
        }
      function showEditProfile() {
            document.getElementById("editProfileContainer").style.display = "block";
            document.getElementById("bookingsContainer").style.display = "none";
            document.getElementById("ratingContainer").style.display = "none";
            document.getElementById("cancelContainer").style.display = "none";
        }

        function showBookings() {
            document.getElementById("editProfileContainer").style.display = "none";
            document.getElementById("bookingsContainer").style.display = "block";
            document.getElementById("ratingContainer").style.display = "none";
            document.getElementById("cancelContainer").style.display = "none";
        }
        function showCancel(){
            document.getElementById("cancelContainer").style.display = "block";
            document.getElementById("editProfileContainer").style.display = "none";
            document.getElementById("bookingsContainer").style.display = "none";
            document.getElementById("ratingContainer").style.display = "none";
        }
        

       

        function enableEdit() {
            document.getElementById("saveChangesBtn").style.display = "none";
    document.getElementById("submitButton").style.display = "none";
            document.getElementById("saveChangesBtn").style.display = "inline-block";
            document.getElementById("password").readOnly = false;
            document.getElementById("fname").readOnly = false;
            document.getElementById("lname").readOnly = false;
            document.getElementById("phone").readOnly = false;
            document.getElementById("email").readOnly = false;
            document.getElementById("address").readOnly = false;
            
            document.getElementById("mname").readOnly = false;
            
        }

        function saveChanges() {
            document.getElementById("saveChangesBtn").style.display = "none";
            window.location.href = 'user-profile.jsp';
    var firstName = document.getElementById("fname").value.trim();
    var lastName = document.getElementById("lname").value.trim();
    var phone = document.getElementById("phone").value.trim();
    var email = document.getElementById("email").value.trim();
    var address = document.getElementById("address").value.trim();
    var password = document.getElementById("password").value.trim();
    var middleName = document.getElementById("mname").value.trim();

    if (firstName === "" || lastName === "" || phone === "" || email === "" || address === "" || password === "") {
        alert("Please fill in all fields.");
        return;
    }

    var phonePattern = /^[0-9]{10}$/;
    var emailPattern = /^[^\s@]+@banasthali\.in$/;

    if (!phonePattern.test(phone)) {
        alert("Please enter valid phone number");
        return;
    }
   
    if ( !emailPattern.test(email)) {
        alert("Please enter valid email id");
        return;
    }

    document.getElementById("fname").readOnly = true;
    document.getElementById("lname").readOnly = true;
    document.getElementById("phone").readOnly = true;
    document.getElementById("email").readOnly = true;
    document.getElementById("address").readOnly = true;
    document.getElementById("password").readOnly = true;
    document.getElementById("mname").readOnly = true;
    
    document.getElementById("password").type = "password";
}

//    let value = 0;
//        function rate(event) {
//            const stars = document.querySelectorAll('.star');
//            const target = event.target;
//            const value = parseInt(target.getAttribute('data-value'));
//
//            stars.forEach((star, index) => {
//                if (index < value) {
//                    star.classList.add('active');
//                } else {
//                    star.classList.remove('active');
//                }
//            });
//        }
//        function redirectToRatingPage() {
//        const reviewsp = "";
//        window.location.href = 'SsubmitRating.jsp?name=' + encodeURIComponent(reviewsp) + '&rating=' + encodeURIComponent(value);
//    }
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

// Function to set the initial appearance of stars based on the existing rating value
function setInitialRating(rating) {
    const stars = document.querySelectorAll('.star');
    stars.forEach((star, index) => {
        if (index < rating) {
            star.classList.add('active');
        } else {
            star.classList.remove('active');
        }
    });
}

// Call setInitialRating function when the page loads
document.addEventListener('DOMContentLoaded', function() {
    // Retrieve existing rating value from hidden input field
    const rating = parseInt(document.getElementById('rating').value);
    // Set the initial appearance of stars based on the existing rating value
    setInitialRating(rating);
});



    function submitRating() {
        // Retrieve rating value from hidden input field
        const rating = document.getElementById('rating').value;

        // Make sure rating is not empty or invalid
        if (rating.trim() === '' || isNaN(rating)) {
            alert('Please select a rating.');
            return;
        }

        // Set the action attribute of the form to submitrating.jsp
        document.getElementById('ratingForm').action = 'submitRating.jsp?userid=<%=uid%>&sid=<%=spid%>';


        // Submit the form
        document.getElementById('ratingForm').submit();
    }
    
        function togglePasswordVisibility() {
            var x = document.getElementById("password");
            if (x.type === "password") {
                x.type = "text";
            } else {
                x.type = "password";
            }
        }
    </script>
    
     <script>
    // Check if the URL contains the anchor ID
    if (window.location.hash === "#rating") {
        // Call the showAvailability() function
        showRating();
    }
</script>
<script>
    // Check if the URL contains the anchor ID
    if (window.location.hash === "#cancel") {
        // Call the showAvailability() function
        showCancel();
    }
</script>
<script>
    // Function to parse URL parameters
    function getParameterByName(name, url) {
        if (!url) url = window.location.href;
        name = name.replace(/[\[\]]/g, "\\$&");
        var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, " "));
    }
var uid = document.getElementById("uid").value
    // Function to clear personal information fields
    function clearPersonalInfo() {
        document.getElementById("fname").value = "";
        document.getElementById("lname").value = "";
        document.getElementById("password").value = "";
        document.getElementById("address").value = "";
        document.getElementById("email").value = "";
        document.getElementById("phone").value = "";
        // Add additional lines to clear other personal information fields if necessary
    }

   
</script>

<script>
   var cancelButtons = document.querySelectorAll('.cancel-btn');

// Loop through each cancel button and attach click event listener
cancelButtons.forEach(function(button) {
    button.addEventListener('click', function() {
        // Retrieve parent div within the event listener function
        var parentDiv = this.parentElement;

        // Retrieve spId, date, and time within the parentDiv
        var spIdElement = parentDiv.querySelector('h3.date:nth-of-type(1)');
var dateElement = parentDiv.querySelector('h3.date:nth-of-type(2)');
var timeElement = parentDiv.querySelector('h4.date');

var spId = spIdElement.textContent;
var date = dateElement.textContent;
var time = timeElement.textContent;

console.log("SPID: " + spId);
console.log("DATE: " + date);
console.log("TIME: " + time);

            var sqlQuery = "DELETE FROM booking WHERE SP_ID = '" + spId + "' AND DATE = '" + date + "' AND TIME = '" + time + "' AND user_id = '" + uid + "'";

            // Perform AJAX call to pass the sqlQuery variable to your JSP
            fetch('Uprofile.jsp', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'sqlQuery=' + encodeURIComponent(sqlQuery)
            })
            .then(response => response.text())
            .then(data => {
                // Handle response from the server
//                console.log(data);
                // You can perform additional actions based on the response
                window.location.href = 'cancelBooking.jsp?sqlQuery=' + encodeURIComponent(sqlQuery) + '&spid=' + encodeURIComponent(spId) + '&date=' + encodeURIComponent(date) + '&time=' + encodeURIComponent(time) + '&email=' + encodeURIComponent('<%=email%>');
            })
            .catch(error => {
                console.error('Error:', error);
            });
        });
    // Assuming you're redirecting to another JSP page


    });
</script>

 
    </body>
    </html>