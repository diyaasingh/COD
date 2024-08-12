<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile</title>
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
        .profile-container input[type="email"] {
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

        .profile-container input[type="submit"] {
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

        .profile-container input[type="submit"]:hover {
            background-color: #219dbca0;
        }

        .availability-item button {
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin: 5px;
        }

        .available-btn {
            background-color: #28a745;
            color: white;
        }

        .unavailable-btn {
            background-color: #dc3545;
            color: white;
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
    </style>
</head>
<body>
    <div class="navbar">
        <div class="navbar-item" onclick="showEditProfile()">Edit Profile</div>
        <div class="navbar-item" onclick="showAvailability()">Availability</div>
        <div class="navbar-item" onclick="showRating()">Rating</div>
    </div>

    <div class="profile-container" id="editProfileContainer">
        <h1>Edit Profile</h1>
        <img src="bv.jpg" alt="Profile Picture">
        <input type="file" accept="image/*" id="profile-picture" name="profile-picture" style="display: none;">
        <label for="profile-picture" class="edit-icon">&#9998;</label>
        <br>
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" value="YourUsername" readonly><br>
        <label for="firstName">First Name:</label>
        <input type="text" id="firstName" name="firstName" readonly><br>
        <label for="lastName">Last Name:</label>
        <input type="text" id="lastName" name="lastName" readonly><br>
        <label for="phone">Phone:</label>
        <input type="tel" id="phone" name="phone" pattern="[0-9]{10}" readonly><br>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" readonly><br>
        <label for="address">Address:</label>
        <input type="text" id="address" name="address" readonly><br>
        <label for="aadhar">Aadhar Card:</label>
        <input type="text" id="aadhar" name="aadhar" maxlength="12" readonly><br>
        <label for="serviceType">Service Type:</label>
        <select id="serviceType" name="serviceType" disabled>
            <option value="electrician">Electrician</option>
            <option value="plumber">Plumber</option>
            <option value="mechanic">Mechanic</option>
            <option value="carpenter">Carpenter</option>
            <option value="house-cleaning">House Cleaning</option>
            <option value="tailor">Tailor</option>
        </select><br>
        <br>
        <input type="submit" value="Edit Profile" onclick="enableEdit()">
        <input type="submit" id="saveBtn" value="Save Changes" style="display: none;" onclick="saveChanges()">
    </div>

    <div class="profile-container" id="availabilityContainer" style="display: none;">
        <h1>Availability</h1>
        <div class="availability-container">
            <div class="availability-item">
                <label for="date1">Date 1:</label>
                <input type="text" id="date1" name="date1" value="22/03/2024" readonly>
                <button class="available-btn">Available</button>
                <button class="unavailable-btn">Unavailable</button>
            </div>
            <div class="availability-item">
                <label for="date2">Date 2:</label>
                <input type="text" id="date2" name="date2" value="23/03/2024" readonly>
                <button class="available-btn">Available</button>
                <button class="unavailable-btn">Unavailable</button>
            </div>
            <div class="availability-item">
                <label for="date3">Date 3:</label>
                <input type="text" id="date3" name="date3" value="24/03/2024" readonly>
                <button class="available-btn">Available</button>
                <button class="unavailable-btn">Unavailable</button>
            </div>
            <div class="availability-item">
                <label for="date4">Date 4:</label>
                <input type="text" id="date4" name="date4" value="25/03/2024" readonly>
                <button class="available-btn">Available</button>
                <button class="unavailable-btn">Unavailable</button>
            </div>
        </div>
    </div>

    <div class="rating-container" id="ratingContainer" style="display: none;">
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
            document.getElementById("availabilityContainer").style.display = "none";
            document.getElementById("ratingContainer").style.display = "none";
        }

        function showAvailability() {
            document.getElementById("editProfileContainer").style.display = "none";
            document.getElementById("availabilityContainer").style.display = "block";
            document.getElementById("ratingContainer").style.display = "none";
        }

        function showRating() {
            document.getElementById("editProfileContainer").style.display = "none";
            document.getElementById("availabilityContainer").style.display = "none";
            document.getElementById("ratingContainer").style.display = "block";
        }

        function enableEdit() {
            document.getElementById("firstName").readOnly = false;
            document.getElementById("lastName").readOnly = false;
            document.getElementById("phone").readOnly = false;
            document.getElementById("email").readOnly = false;
            document.getElementById("address").readOnly = false;
            document.getElementById("aadhar").readOnly = false; // Make Aadhar card uneditable
            document.getElementById("serviceType").disabled = false;
            
            document.getElementById("saveBtn").style.display = "inline-block";
        }

        function saveChanges() {
//    var firstName = document.getElementById("firstName").value.trim();
//    var lastName = document.getElementById("lastName").value.trim();
//    var phone = document.getElementById("phone").value.trim();
//    var email = document.getElementById("email").value.trim();
//    var address = document.getElementById("address").value.trim();
//    var aadhar = document.getElementById("aadhar").value.trim();
//    var serviceType = document.getElementById("serviceType").value;
//
//    if (firstName === "" || lastName === "" || phone === "" || email === "" || address === "" || aadhar === "") {
//        alert("Please fill in all fields.");
//        return;
//    }
//
//    var phonePattern = /^[0-9]{10}$/;
//    var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
//    var aadharPattern = /^[0-9]{12}$/;
//
//    if (!phonePattern.test(phone) || !emailPattern.test(email) || !aadharPattern.test(aadhar)) {
//        alert("Please enter valid information.");
//        return;
//    }

    
    document.getElementById("firstName").readOnly = true;
    document.getElementById("lastName").readOnly = true;
    document.getElementById("phone").readOnly = true;
    document.getElementById("email").readOnly = true;
    document.getElementById("address").readOnly = true;
    document.getElementById("aadhar").readOnly = true;
    document.getElementById("serviceType").disabled = true;
    document.getElementById("saveBtn").style.display = "none";
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
    </script>
</body>
</html>