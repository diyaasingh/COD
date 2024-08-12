<%-- 
    Document   : admin
    Created on : 7 Mar, 2024, 2:32:24 PM
    Author     : DELL
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="xyz.Conn"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%-- 
    Document   : Admin
    Created on : 11 Oct, 2023, 9:16:21 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Profiiiile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background:#219dbc;
            
        }

        .navbar {
            background-color: #007185;
            overflow: hidden;
        }

        .navbar a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 20px;
            text-decoration: none;
        }

        .navbar a:hover {
            background-color: #ddd;
            color: black;
        }

        .admin-content {
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
            margin: 20px;
           
        }

        .admin-content button {
            background-color: #023047;
            color: white;
            border: none;
            padding: 10px 20px;
            margin: 5px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .admin-content button:hover {
            background-color:  #219dbc;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        .fade-in {
            animation-name: fadeIn;
            animation-duration: 1s;
        }
        
        .admin-content label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
    
       
        .admin-content input[type="text"],
        .admin-content input[type="password"],
        .admin-content input[type="tel"],
        .admin-content input[type="email"],
        .admin-content input[type="number"] {
            width: 50%;
            padding: 8px;
            margin-bottom: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box; /* Ensure padding and border are included in width */
        }
    
        
        .admin-content button[type="button"],
        .admin-content input[type="submit"] {
            background-color: #023047;
            color: white;
            border: none;
            padding: 10px 20px;
            margin: 5px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
    
        
        .admin-content button:hover,
        .admin-content input[type="submit"]:hover {
            background-color:  #219dbc;
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
    </style>
    
</head>
<body>
    <%response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
     String aid = (String) session.getAttribute("ADMIN_ID");
    %>
    <div class="navbar">
        <a href="#" onclick="showUserOperations()">User Operations</a>
        <a href="#" onclick="showServiceProviderOperations()">Service Provider Operations</a>
        <a href="#" onclick="showAdminProfile()">Admin Profile</a>
    </div>

   
        <div class="admin-content fade-in" id="userOperations">
        <h2>User Operations</h2>
        <button onclick="insertUser()">Insert User</button>
        <br>
        <button onclick="updateUser()">Update User</button>
        <br>
        <button onclick="searchUser()">Search User</button>
        <br>
        <button onclick="deleteUser()">Delete User</button>
    </div>

        <div class="admin-content fade-in" id="serviceProviderOperations" style="display: none;">
        <h2>Service Provider Operations</h2>
        <button onclick="insertServiceProvider()">Insert Service Provider</button>
        <br>
        <button onclick="updateServiceProvider()">Update Service Provider</button>
        <br>
        <button onclick="searchServiceProviders()">Search Service Providers</button>
        <br>
        <button onclick="deleteServiceProvider()">Delete Service Provider</button>
    </div>
    
    <div class="admin-content fade-in" id="AdminProfile" style="display: none;">
        <h2>Admin Profile</h2>
        <%ResultSet rs = null;
    Connection con = new Conn().con;
    
    String firstname = "";
    String password = "";
    String lastname = "";
    String email = "";
    int phone = 0;
    String address = "";
    String admin_id = "" ;
    
    if (aid != null && session.getAttribute("ADMIN_ID") != null) {
        PreparedStatement ps = con.prepareStatement("SELECT FIRST_NAME, LAST_NAME, PASSWORD,EMAIL,PHONE,ADMIN_ID FROM ADMIN WHERE ADMIN_ID = ?");
        ps.setString(1, aid);
        rs = ps.executeQuery();
        
        if (rs.next()) {
            firstname = rs.getString("FIRST_NAME");
            lastname = rs.getString("LAST_NAME");
            password = rs.getString("PASSWORD");
            email = rs.getString("EMAIL");
            phone = rs.getInt("PHONE");
            admin_id = rs.getString("ADMIN_ID");
        } else {
            System.out.println("User not found");
        }
    }
%>

<div class="profile-container" id="editProfileContainer" >
    <h1>Edit Profile</h1>
    <form action="adminSaveChanges.jsp" method="post">
        
        <!-- Input fields for editing profile -->
        <label for="username">Username:</label>
        <input type="text" id="uid" name="uid" value="<%= admin_id %>" readonly><br>
        <label for="fname">First Name</label>
        <input type="text" id="fname" name="fname" value="<%= firstname %>" readonly><br>
        <label for="lname">Last Name</label>
        <input type="text" id="lname" name="lname" value="<%= lastname %>" readonly><br>
        <label for="password">Password</label>
        <div class="password-container" style="display:flex;">
        <input type="password" id="password" name="password" value="<%= password %>" readonly><br>
         <span class="eye-icon" onclick="togglePasswordVisibility()">👁️</span>
        </div>
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
    </div>
    
    
    
    <div class="admin-content" id="insertContainer" style="display: none;">
        <form action="insertUser.jsp" method="post">
            <h2>Insert User</h2>
            <label for="username">Username:</label>
            <input type="text" id="username" name="username"><br>
            <label for="firstName">First Name:</label>
            <input type="text" id="firstName" name="firstName"><br>
            <label for="lastName">Password:</label>
            <input type="password" id="password" name="password"><br>
            <label for="phone">Phone:</label>
            <input type="tel" id="phone" name="phone" pattern="[0-9]{10}"><br>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email"><br>
            <button type="button" onclick="showUserOperations()">Back</button>
        <input type="submit" value="Insert" name="iaction">
        </form>
    </div>
    
    <div class="admin-content" id="updateContainer" style="display: none;">
        <form action="updateUser.jsp" method="post">
            <h2>Update User</h2>
            <label for="username">Username:</label>
            <input type="text" id="userid" name="userid"><br>
            <label for="firstName">First Name:</label>
            <input type="text" id="firstName" name="firstName"><br>
             <label for="lastName">Password:</label>
            <input type="password" id="password" name="password"><br>
            <label for="phone">Phone:</label>
            <input type="tel" id="phone" name="phone" pattern="[0-9]{10}"><br>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email"><br>
            <button type="button" onclick="showUserOperations()">Back</button>
        <input type="submit" value="Update" name="uaction">
        </form>
    </div>
    <% String uuid="";
    String fname="";
    String uupass="";
        uuid = request.getParameter("uuid");
        fname = request.getParameter("fname");
        uupass = request.getParameter("uupass");
        %>
    <div class="admin-content" id="searchContainer" style="display: none;">
        <form action="searchUser.jsp" method="post">
            <h2>Search User</h2>
            <label for="username">UserID:</label>
            <input type="text" id="userid" value="<%=uuid%>" name="userid"><br>
            <label for="firstName">First Name:</label>
            <input type="text" id="firstName" value="<%=fname%>" name="firstName"><br>
             <label for="lastName">Password:</label>
            <input type="password" id="password" value="<%=uupass%>" name="password"><br>
            <label for="phone">Phone:</label>
            <input type="tel" id="phone" name="phone" pattern="[0-9]{10}"><br>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email"><br>
            <button type="button" onclick="showUserOperations()">Back</button>
        <input type="submit" value="Search" name="saction">
        </form>
        <script>
    // Check if the URL contains the anchor ID
    if (window.location.hash === "#searchContainer") {
        // Call the showAvailability() function
        searchUser();
    }
</script>
    </div>
    <div class="admin-content" id="deleteContainer" style="display: none;">
    <form action="deleteUser.jsp" method="post">
        <h2>Delete User</h2>
        <label for="username">Username to delete:</label>
        <input type="text" id="username" name="username"><br>
       <button type="button" onclick="showUserOperations()">Back</button>
        <input type="submit" value="Delete" name="daction">
    </form>
</div>

<div class="admin-content" id="insertServiceProviderContainer" style="display: none;">
    <form action="insertSP.jsp">
    <h2>Insert Service Provider</h2>
    <div class="input-group">
        <label>User ID</label>
        <input type="text" name="uid" />
    </div>
    <div class="input-group">
        <label>First Name</label>
        <input type="text" name="username" />
    </div>
    <div class="input-group">
        <label>Middle Name</label>
        <input type="text" name="middle-name"/>
    </div>
    <div class="input-group">
        <label>Last Name</label>
        <input type="text" name="last-name" />
    </div>
    <div class="input-group">
        <label>Phone Number</label>
        <input type="tel" name="phone-number" pattern="[0-9]{10}" />
    </div>
    
    <div class="input-group">
        <label>Password</label>
        <input type="password" name="upass" />
    </div>
    <div class="input-group">
        <label>E-Mail</label>
        <input type="email" name="email" />
    </div>
    <div class="input-group">
        <label>Aadhar Number</label>
        <input type="number" name="aadhar_no" />
    </div>
    <div class="input-group">
        <label>Service</label>
        <input type="text" name="type"/>
    </div>
    <button type="button" onclick="showServiceProviderOperations()">Back</button>
    <button type="button">Insert</button>
    </form>
</div>

<div class="admin-content" id="updateServiceProviderContainer" style="display: none;">
    <h2>Update Service Provider</h2>
    <form action="updateSP.jsp">
    <div class="input-group">
        <label>User ID</label>
        <input type="text" name="uid" />
    </div>
    <div class="input-group">
        <label>First Name</label>
        <input type="text" name="username" />
    </div>
    <div class="input-group">
        <label>Middle Name</label>
        <input type="text" name="middle-name"/>
    </div>
    <div class="input-group">
        <label>Last Name</label>
        <input type="text" name="last-name" />
    </div>
    <div class="input-group">
        <label>Phone Number</label>
        <input type="tel" name="phone-number" pattern="[0-9]{10}" />
    </div>
    
    <div class="input-group">
        <label>Password</label>
        <input type="password" name="upass" />
    </div>
    <div class="input-group">
        <label>E-Mail</label>
        <input type="email" name="email" />
    </div>
    <div class="input-group">
        <label>Aadhar Number</label>
        <input type="number" name="aadhar_no" />
    </div>
    <div class="input-group">
        <label>Address</label>
        <input type="text" name="address"/>
    </div>
    <button type="button" onclick="showServiceProviderOperations()">Back</button>
    <button type="button">Update</button>
    </form>
    
</div>

<div class="admin-content" id="searchServiceProviderContainer" style="display: none;">
    <form action="searchSP.jsp">
    <h2>Search Service Provider</h2>
    <div class="input-group">
        <label>User ID</label>
        <input type="text" name="uid"/>
    </div>
    <div class="input-group">
        <label>First Name</label>
        <input type="text" name="username"/>
    </div>
    <div class="input-group">
        <label>Middle Name</label>
        <input type="text" name="middle-name"/>
    </div>
    <div class="input-group">
        <label>Last Name</label>
        <input type="text" name="last-name" />
    </div>
    <div class="input-group">
        <label>Phone Number</label>
        <input type="tel" name="phone-number" pattern="[0-9]{10}" />
    </div>
    
    <div class="input-group">
        <label>Password</label>
        <input type="password" name="upass" />
    </div>
    <div class="input-group">
        <label>E-Mail</label>
        <input type="email" name="email" />
    </div>
    <div class="input-group">
        <label>Aadhar Number</label>
        <input type="number" name="aadhar_no" />
    </div>
    <div class="input-group">
        <label>Address</label>
        <input type="text" name="address"/>
    </div>
    <button type="button" onclick="showServiceProviderOperations()">Back</button>
    <button type="button">Search</button>
    <!-- Search service provider form content here -->
    </form>
</div>

<div class="admin-content" id="deleteServiceProviderContainer" style="display: none;">
    <form action="deleteSP.jsp" method="post">
        <h2>Delete User</h2>
        <label for="username">Service Provider ID to delete:</label>
        <input type="text" id="username" name="username"><br>
       <button type="button" onclick="showServiceProviderOperations()">Back</button>
        <input type="submit" value="Delete" name="daction">
    </form>
</div>


    <script>
        function showUserOperations() {
    document.getElementById("userOperations").style.display = "block";
    document.getElementById("insertContainer").style.display = "none";
    document.getElementById("serviceProviderOperations").style.display = "none";
    document.getElementById("updateContainer").style.display = "none";
    document.getElementById("deleteContainer").style.display = "none";
    document.getElementById("searchContainer").style.display = "none";
    document.getElementById("insertServiceProviderContainer").style.display = "none";
    document.getElementById("updateServiceProviderContainer").style.display = "none";
    document.getElementById("searchServiceProviderContainer").style.display = "none";
    document.getElementById("deleteServiceProviderContainer").style.display = "none";
    document.getElementById("AdminProfile").style.display = "none";
}

function showServiceProviderOperations() {
    document.getElementById("userOperations").style.display = "none";
    document.getElementById("serviceProviderOperations").style.display = "block";
    document.getElementById("insertContainer").style.display = "none";
    document.getElementById("updateContainer").style.display = "none";
    document.getElementById("deleteContainer").style.display = "none";
    document.getElementById("searchContainer").style.display = "none";
    document.getElementById("insertServiceProviderContainer").style.display = "none";
    document.getElementById("updateServiceProviderContainer").style.display = "none";
    document.getElementById("searchServiceProviderContainer").style.display = "none";
    document.getElementById("deleteServiceProviderContainer").style.display = "none";
    document.getElementById("AdminProfile").style.display = "none";
}
function showAdminProfile() {
    document.getElementById("AdminProfile").style.display = "block";
    document.getElementById("userOperations").style.display = "none";
    document.getElementById("serviceProviderOperations").style.display = "none";
    document.getElementById("insertContainer").style.display = "none";
    document.getElementById("updateContainer").style.display = "none";
    document.getElementById("deleteContainer").style.display = "none";
    document.getElementById("searchContainer").style.display = "none";
    document.getElementById("insertServiceProviderContainer").style.display = "none";
    document.getElementById("updateServiceProviderContainer").style.display = "none";
    document.getElementById("searchServiceProviderContainer").style.display = "none";
    document.getElementById("deleteServiceProviderContainer").style.display = "none";
}

        function insertUser() {
            document.getElementById("userOperations").style.display = "none";
            document.getElementById("insertContainer").style.display = "block";
            document.getElementById("serviceProviderOperations").style.display = "none";
            document.getElementById("updateContainer").style.display = "none";
            document.getElementById("deleteContainer").style.display = "none";
            document.getElementById("searchContainer").style.display = "none";
            document.getElementById("AdminProfile").style.display = "none";
        }
        function updateUser() {
            document.getElementById("userOperations").style.display = "none";
            document.getElementById("serviceProviderOperations").style.display = "none";
            document.getElementById("insertContainer").style.display = "none";
            document.getElementById("updateContainer").style.display = "block";
            document.getElementById("deleteContainer").style.display = "none";
            document.getElementById("searchContainer").style.display = "none";
            document.getElementById("AdminProfile").style.display = "none";
        }
        function searchUser(){
            document.getElementById("userOperations").style.display = "none";
            document.getElementById("insertContainer").style.display = "none";
            document.getElementById("serviceProviderOperations").style.display = "none";
            document.getElementById("updateContainer").style.display = "none";
            document.getElementById("deleteContainer").style.display = "none";
            document.getElementById("searchContainer").style.display = "block";
            document.getElementById("AdminProfile").style.display = "none";
        }
        function deleteUser(){
            document.getElementById("deleteContainer").style.display = "block";
            document.getElementById("userOperations").style.display = "none";
            document.getElementById("insertContainer").style.display = "none";
            document.getElementById("serviceProviderOperations").style.display = "none";
            document.getElementById("updateContainer").style.display = "none";
            document.getElementById("searchContainer").style.display = "none";
            document.getElementById("AdminProfile").style.display = "none";
        }
        function insertServiceProvider() {
    document.getElementById("serviceProviderOperations").style.display = "none";
    document.getElementById("userOperations").style.display = "none";
    document.getElementById("insertServiceProviderContainer").style.display = "block";
    document.getElementById("AdminProfile").style.display = "none";
}

function updateServiceProvider() {
    document.getElementById("serviceProviderOperations").style.display = "none";
    document.getElementById("userOperations").style.display = "none";
    document.getElementById("updateServiceProviderContainer").style.display = "block";
    document.getElementById("AdminProfile").style.display = "none";
}

function searchServiceProviders() {
    document.getElementById("serviceProviderOperations").style.display = "none";
    document.getElementById("userOperations").style.display = "none";
    document.getElementById("searchServiceProviderContainer").style.display = "block";
    document.getElementById("AdminProfile").style.display = "none";
}

function deleteServiceProvider() {
    document.getElementById("serviceProviderOperations").style.display = "none";
    document.getElementById("userOperations").style.display = "none";
    document.getElementById("deleteServiceProviderContainer").style.display = "block";
    document.getElementById("AdminProfile").style.display = "none";
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
            
        }

        function saveChanges() {
            document.getElementById("saveChangesBtn").style.display = "none";
            console.log("redirecting yu ");
            window.location.href = 'adminSaveChanges.jsp?firstname=' + encodeURIComponent(firstname) + '&lastname=' + encodeURIComponent(lastname) + '&phone=' + encodeURIComponent(phone) + '&email=' + encodeURIComponent(email) + '&password=' + encodeURIComponent(password);

    var firstName = document.getElementById("fname").value.trim();
    var lastName = document.getElementById("lname").value.trim();
    var phone = document.getElementById("phone").value.trim();
    var email = document.getElementById("email").value.trim();
    var address = document.getElementById("address").value.trim();
    var password = document.getElementById("password").value.trim();

    if (firstName === "" || lastName === "" || phone === "" || email === "" || address === "" || password === "") {
        alert("Please fill in all fields.");
        return;
    }

    var phonePattern = /^[0-9]{10}$/;
   

    if (!phonePattern.test(phone)) {
        alert("Please enter valid phone number");
        return;
    }

    document.getElementById("fname").readOnly = true;
    document.getElementById("lname").readOnly = true;
    document.getElementById("phone").readOnly = true;
    document.getElementById("email").readOnly = true;
    document.getElementById("password").readOnly = true;
    
    document.getElementById("password").type = "password";
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



