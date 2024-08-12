<%-- 
    Document   : userRating
    Created on : 7 Mar, 2024, 2:42:59 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <div class="navbar">
        <div class="navbar-item" onclick="showEditProfile()">Profile</div>
        <div class="navbar-item" onclick="showBookings()">Bookings</div>
        <div class="navbar-item" onclick="showRating()">Rating</div>
    </div>

    <div class="profile-container" id="editProfileContainer">
        <h1>Edit Profile</h1>
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" value="YourUsername" readonly><br>
        <label for="fname">First Name</label>
        <input type="text" id="fname" name="fname" required readonly><br>
        <label for="mname">Middle Name</label>
        <input type="text" id="mname" name="mname" readonly><br>
        <label for="lname">Last Name</label>
        <input type="text" id="lname" name="lname" required readonly><br>
        <label for="phone">Phone Number</label>
        <input type="tel" id="phone" name="phone" pattern="[0-9]{10}" required readonly><br>
        <label for="password">Password</label>
        <div class="password-container">
            <input type="password" id="password" name="password" required readonly>
            <span class="eye-icon" onclick="togglePasswordVisibility()">👁️</span>
        </div>
        <label for="email">E-Mail</label>
        <input type="email" id="email" name="email" pattern=".+@banasthali\.in" required readonly><br>
        <label for="address">Address</label>
        <input type="text" id="address" name="address" required readonly><br>
        <input type="button" value="Edit Profile" onclick="enableEdit()">
        <input type="button" value="Save Changes" id="saveChangesBtn" style="display: none;" onclick="saveChanges()">
    </div>

    <div class="profile-container" id="bookingsContainer" style="display: none;">
        <h1>Bookings</h1>
        <!-- Add your bookings content here -->
    </div>

    <div class="profile-container" id="ratingContainer" style="display: none;">
        <h1>Rating</h1>
        <div class="rating-item">
            <label for="name">Service Provider:</label>
            <input type="text" id="name" name="name" readonly><br>
            <div class="stars" onclick="rate(event)">
                <span class="star" data-value="1">&#9733;</span>
                <span class="star" data-value="2">&#9733;</span>
                <span class="star" data-value="3">&#9733;</span>
                <span class="star" data-value="4">&#9733;</span>
                <span class="star" data-value="5">&#9733;</span>
            </div>
            <input type="submit" class="submit-btn" value="Submit Rating">
        </div>
    </div>

    <script>
        function showEditProfile() {
            document.getElementById("editProfileContainer").style.display = "block";
            document.getElementById("bookingsContainer").style.display = "none";
            document.getElementById("ratingContainer").style.display = "none";
        }

        function showBookings() {
            document.getElementById("editProfileContainer").style.display = "none";
            document.getElementById("bookingsContainer").style.display = "block";
            document.getElementById("ratingContainer").style.display = "none";
        }

        function showRating() {
            document.getElementById("editProfileContainer").style.display = "none";
            document.getElementById("bookingsContainer").style.display = "none";
            document.getElementById("ratingContainer").style.display = "block";
        }

        function enableEdit() {
            document.getElementById("fname").readOnly = false;
            document.getElementById("lname").readOnly = false;
            document.getElementById("phone").readOnly = false;
            document.getElementById("email").readOnly = false;
            document.getElementById("address").readOnly = false;
            document.getElementById("password").readOnly = false;
            document.getElementById("mname").readOnly = false;
            document.getElementById("saveChangesBtn").style.display = "inline-block";
        }

        function saveChanges() {
    var firstName = document.getElementById("fname").value.trim();
    var lastName = document.getElementById("lname").value.trim();
    var phone = document.getElementById("phone").value.trim();
    var email = document.getElementById("email").value.trim();
    var address = document.getElementById("address").value.trim();
    var password = document.getElementById("password").value.trim();
    var middleName = document.getElementById("mname").value.trim();

//    if (firstName === "" || lastName === "" || phone === "" || email === "" || address === "" || password === "") {
//        alert("Please fill in all fields.");
//        return;
//    }

    var phonePattern = /^[0-9]{10}$/;
    var emailPattern = /^[^\s@]+@banasthali\.in$/;

//    if (!phonePattern.test(phone)) {
//        alert("Please enter valid phone number");
//        return;
//    }
//   
//    if ( !emailPattern.test(email)) {
//        alert("Please enter valid email id");
//        return;
//    }

    document.getElementById("fname").readOnly = true;
    document.getElementById("lname").readOnly = true;
    document.getElementById("phone").readOnly = true;
    document.getElementById("email").readOnly = true;
    document.getElementById("address").readOnly = true;
    document.getElementById("password").readOnly = true;
    document.getElementById("mname").readOnly = true;
    document.getElementById("saveChangesBtn").style.display = "none";
    document.getElementById("password").type = "password";
}


        function rate(event) {
            const stars = document.querySelectorAll('.star');
            const target = event.target;
            const value = parseInt(target.getAttribute('data-value'));

            stars.forEach((star, index) => {
                if (index < value) {
                    star.classList.add('active');
                } else {
                    star.classList.remove('active');
                }
            });
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
</body>
</html>

