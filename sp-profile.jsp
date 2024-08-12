<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="xyz.Conn"%>
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
        h6{
            color: black;
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
    
    <%  response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
        HttpSession sessionn = request.getSession();
        String sid = (String) sessionn.getAttribute("SP_ID");
        
        System.out.println(sid);
         Connection con = new Conn().con;
        
         String type="";
         String spemail="";
         String spphone = "";
         String name = "";
         String lname = "";
         String aadhar = "";
         String sppass = "";
         if(sid != null){
                PreparedStatement ps = con.prepareStatement ("SELECT TYPE,SPEMAIL,SPPHONE,FIRST_NAME,SP_ID,LAST_NAME,AADHAR_NO,SPPASS FROM SP WHERE SP_ID =?");
                ps.setString(1,sid);
                ResultSet rs = ps.executeQuery();
                if(rs.next()){
                    type = rs.getString(1);
                    spemail=rs.getString(2);
                    spphone =rs.getString(3);
                    name=rs.getString(4);
                    sid = rs.getString(5);
                    lname = rs.getString(6);
                    aadhar = rs.getString(7);
                    sppass = rs.getString(8);
                    
                }else{
                    System.out.println("h");
}}
   %>

    
    
    <div class="navbar">
        <div class="navbar-item" onclick="showEditProfile()">Edit Profile</div>
        <div class="navbar-item" onclick="showAvailability()">Availability</div>
    </div>

    <div class="profile-container" id="editProfileContainer">
        <h1>Edit Profile</h1>
        <img src="bv.jpg" alt="Profile Picture">
        <input type="file" accept="image/*" id="profile-picture" name="profile-picture" style="display: none;">
        <label for="profile-picture" class="edit-icon">&#9998;</label>
        <br>
        <form method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" value=<%=sid%> readonly><br>
        <label for="firstName">First Name:</label>
        <input type="text" id="firstName" name="firstName" value=<%=name%> readonly><br>
        <label for="lastName">Last Name:</label>
        <input type="text" id="lastName" name="lastName" value=<%=lname%> readonly><br>
         <label for="password">Password:</label>
         <input type="password" id="password"  name="password" value="<%= sppass %>" readonly>
         <span class="eye-icon" onclick="togglePasswordVisibility()">&#128065;</span> 
        
        <label for="phone">Phone:</label>
        <input type="tel" id="phone" name="phone" pattern="[0-9]{10}" value=<%=spphone%> readonly><br>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" value=<%=spemail%> readonly><br>
       
        <label for="aadhar">Aadhar Card:</label>
        <input type="text" id="aadhar" name="aadhar" value=<%=aadhar%> maxlength="12" readonly><br>
        <label for="serviceType">Service Type:</label>
        <select id="serviceType" name="serviceType" disabled>
            <option value="Electrician" <%= type.equals("Electrician") ? "selected" : "" %>>Electrician</option>
             <option value="Plumber" <%= type.equals("Plumber") ? "selected" : "" %>>Plumber</option>
    <option value="Mechanic" <%= type.equals("Mechanic") ? "selected" : "" %>>Mechanic</option>
    <option value="Carpenter" <%= type.equals("Carpenter") ? "selected" : "" %>>Carpenter</option>
    <option value="Home-Cleaning" <%= type.equals("Home-Cleaning") ? "selected" : "" %>>Home-Cleaning</option>
    <option value="tailor" <%= type.equals("Tailor") ? "selected" : "" %>>Tailor</option>
        </select><br>
        <br>
<!--        <button onclick="enableEdit()">Edit Profile</button>-->
<button type="button" onclick="enableEdit()" style="background-color: #023047;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 1.2rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
            border-radius: 5px;
            margin: 10px;">Edit Profile</button>

<!--<button type="button" id="saveBtn" style="display: none;" onclick="saveChanges()">save changes</button>-->
        <input type="submit" id="saveBtn" name="action" style="display: none;" value="UpdateProfile">
        <input type="hidden" name="sid" value="<%=sid%>">
        <input type="hidden"  name="action" value="UpdateProfile">
    </form>
        
    </div>

    <%
            LocalDate currentDate = LocalDate.now();
            LocalDate nextDate = currentDate.plusDays(1);
            LocalDate nextNextDate = currentDate.plusDays(2);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yy");

    // Format the dates using the defined format
    String formattedCurrentDate = currentDate.format(formatter);
    String formattedNextDate = nextDate.format(formatter);
    String formattedNextNextDate = nextNextDate.format(formatter);
         %>
        
         <% 
    ResultSet rs1 = null;
    String availableStatus1 = ""; // Variable to hold the available status
    String ssid = sid;
    try {
        PreparedStatement ps = con.prepareStatement("SELECT cd_1 FROM SP WHERE sp_id = ?");
        ps.setString(1, ssid);
        rs1 = ps.executeQuery();
        if (rs1.next()) {
            boolean status = rs1.getBoolean("cd_1");
            availableStatus1 = status ? "AVAILABLE" : "UNAVAILABLE";
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } 
%>
    
    <%ResultSet rrs = null;
    String cd1 = ""; // Variable to hold the available status
    try {
        PreparedStatement ps = con.prepareStatement("SELECT cd_2 FROM SP WHERE FIRST_NAME = ?");
        ps.setString(1, name);
        rrs = ps.executeQuery();
        if (rrs.next()) {
            boolean status = rrs.getBoolean("cd_2");
            cd1 = status ? "AVAILABLE" : "UNAVAILABLE";
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } %>
    
    <%ResultSet rrss = null;
    String cd2 = ""; // Variable to hold the available status
    try {
        PreparedStatement ps = con.prepareStatement("SELECT cd_3 FROM SP WHERE FIRST_NAME = ?");
        ps.setString(1, name);
        rrss = ps.executeQuery();
        if (rrss.next()) {
            boolean status = rrss.getBoolean("cd_3");
            cd2 = status ? "AVAILABLE" : "UNAVAILABLE";
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } %>
    <%
    String cd3 = ""; // Variable to hold the available status
    try {
        PreparedStatement ps = con.prepareStatement("SELECT cd_4 FROM SP WHERE FIRST_NAME = ?");
        ps.setString(1, name);
        rrss = ps.executeQuery();
        if (rrss.next()) {
            boolean status = rrss.getBoolean("cd_4");
            cd3 = status ? "AVAILABLE" : "UNAVAILABLE";
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } %>
    <%
    String cd4 = ""; // Variable to hold the available status
    try {
        PreparedStatement ps = con.prepareStatement("SELECT cd_5 FROM SP WHERE FIRST_NAME = ?");
        ps.setString(1, name);
        rrss = ps.executeQuery();
        if (rrss.next()) {
            boolean status = rrss.getBoolean("cd_5");
            cd4 = status ? "AVAILABLE" : "UNAVAILABLE";
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } %>
    <%
    String cd5 = ""; // Variable to hold the available status
    try {
        PreparedStatement ps = con.prepareStatement("SELECT cd_6 FROM SP WHERE FIRST_NAME = ?");
        ps.setString(1, name);
        rrss = ps.executeQuery();
        if (rrss.next()) {
            boolean status = rrss.getBoolean("cd_6");
            cd5 = status ? "AVAILABLE" : "UNAVAILABLE";
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } %>
    <%
    String cd6 = ""; // Variable to hold the available status
    try {
        PreparedStatement ps = con.prepareStatement("SELECT cd_7 FROM SP WHERE FIRST_NAME = ?");
        ps.setString(1, name);
        rrss = ps.executeQuery();
        if (rrss.next()) {
            boolean status = rrss.getBoolean("cd_7");
            cd6 = status ? "AVAILABLE" : "UNAVAILABLE";
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } %>
    <%
    String cd1_1 = ""; // Variable to hold the available status
    try {
        PreparedStatement ps = con.prepareStatement("SELECT cd1_1 FROM SP WHERE FIRST_NAME = ?");
        ps.setString(1, name);
        rrss = ps.executeQuery();
        if (rrss.next()) {
            boolean status = rrss.getBoolean("cd1_1");
            cd1_1 = status ? "AVAILABLE" : "UNAVAILABLE";
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } %>
    <%
    String cd1_2 = ""; // Variable to hold the available status
    try {
        PreparedStatement ps = con.prepareStatement("SELECT cd1_2 FROM SP WHERE FIRST_NAME = ?");
        ps.setString(1, name);
        rrss = ps.executeQuery();
        if (rrss.next()) {
            boolean status = rrss.getBoolean("cd1_2");
            cd1_2 = status ? "AVAILABLE" : "UNAVAILABLE";
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } %>
    <%
    String cd1_3 = ""; // Variable to hold the available status
    try {
        PreparedStatement ps = con.prepareStatement("SELECT cd1_3 FROM SP WHERE FIRST_NAME = ?");
        ps.setString(1, name);
        rrss = ps.executeQuery();
        if (rrss.next()) {
            boolean status = rrss.getBoolean("cd1_3");
            cd1_3 = status ? "AVAILABLE" : "UNAVAILABLE";
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } %>
    <%
    String cd1_4 = ""; // Variable to hold the available status
    try {
        PreparedStatement ps = con.prepareStatement("SELECT cd1_4 FROM SP WHERE FIRST_NAME = ?");
        ps.setString(1, name);
        rrss = ps.executeQuery();
        if (rrss.next()) {
            boolean status = rrss.getBoolean("cd1_4");
            cd1_4 = status ? "AVAILABLE" : "UNAVAILABLE";
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } %>
    <%
    String cd1_5 = ""; // Variable to hold the available status
    try {
        PreparedStatement ps = con.prepareStatement("SELECT cd1_5 FROM SP WHERE FIRST_NAME = ?");
        ps.setString(1, name);
        rrss = ps.executeQuery();
        if (rrss.next()) {
            boolean status = rrss.getBoolean("cd1_5");
            cd1_5 = status ? "AVAILABLE" : "UNAVAILABLE";
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } %>
    <%
    String cd1_6 = ""; // Variable to hold the available status
    try {
        PreparedStatement ps = con.prepareStatement("SELECT cd1_6 FROM SP WHERE FIRST_NAME = ?");
        ps.setString(1, name);
        rrss = ps.executeQuery();
        if (rrss.next()) {
            boolean status = rrss.getBoolean("cd1_6");
            cd1_6 = status ? "AVAILABLE" : "UNAVAILABLE";
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } %><%
    String cd1_7 = ""; // Variable to hold the available status
    try {
        PreparedStatement ps = con.prepareStatement("SELECT cd1_7 FROM SP WHERE FIRST_NAME = ?");
        ps.setString(1, name);
        rrss = ps.executeQuery();
        if (rrss.next()) {
            boolean status = rrss.getBoolean("cd1_7");
            cd1_7 = status ? "AVAILABLE" : "UNAVAILABLE";
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } %>
    
         
    <div class="profile-container" id="availabilityContainer" style="display: none;">
        
    <script>
    var sid = "<%= sid %>";

    function redirectToStatusPage(columnName) {
        window.location.href = 'status-name.jsp?sid=' + encodeURIComponent(sid) + '&column=' + encodeURIComponent(columnName);
        console.log(columnName);
    }
</script>



        <h1>Availability</h1>
        <div class="availability-container">
            <div class="availability-item">
                <hr>
                <label for="date1"><%=formattedCurrentDate%></label>
                <hr>
                <h6>10:00 AM - 11:00 AM</h6>
                <input type="text" id="date1" name="date1" value="<%=availableStatus1%>" readonly>
                <button class="available-btn" onclick="redirectToStatusPage('cd_1')">Change Status</button>
                <h6>11:00 AM - 12:00 PM</h6>
                <input type="text" id="date2" name="date1" value="<%=cd1%>" readonly>
                <button class="available-btn" onclick="redirectToStatusPage('cd_2')">Change Status</button>
                <h6>12:00 PM - 1:00 PM</h6>
                <input type="text" id="date3" name="date1" value="<%=cd2%>" readonly>
                <button class="available-btn" onclick="redirectToStatusPage('cd_3')">Change Status</button>
                <h6>1:00 PM - 2:00 PM</h6>
                <input type="text" id="date4" name="date1" value="<%=cd3%>" readonly>
                <button class="available-btn" onclick="redirectToStatusPage('cd_4')">Change Status</button>
                <h6>2:00 PM - 3:00 PM</h6>
                <input type="text" id="date5" name="date1" value="<%=cd4%>" readonly>
                <button class="available-btn" onclick="redirectToStatusPage('cd_5')">Change Status</button>
                <h6>3:00 PM - 4:00 PM</h6>
                <input type="text" id="date6" name="date1" value="<%=cd5%>" readonly> 
                <button class="available-btn" onclick="redirectToStatusPage('cd_6')">Change Status</button>
                <h6>4:00 PM - 5:00 PM</h6>
                <input type="text" id="date7" name="date1" value="<%=cd6%>" readonly>
                <button class="available-btn" onclick="redirectToStatusPage('cd_7')">Change Status</button>
            </div>
                <br>
                <div class="availability-item">
                    <hr>
                <label for="date1"><%=formattedNextDate%></label>
                <hr>
                <h6>10:00 AM - 11:00 AM</h6>
                <input type="text" id="date1" name="date1" value="<%=cd1_1%>" readonly>
                <button class="available-btn" onclick="redirectToStatusPage('cd1_1')">Change Status</button>
                <h6>11:00 AM - 12:00 PM</h6>
                <input type="text" id="date2" name="date1" value="<%=cd1_2%>" readonly>
                <button class="available-btn" onclick="redirectToStatusPage('cd1_2')">Change Status</button>
                <h6>12:00 PM - 1:00 PM</h6>
                <input type="text" id="date3" name="date1" value="<%=cd1_3%>" readonly>
                <button class="available-btn" onclick="redirectToStatusPage('cd1_3')">Change Status</button>
                <h6>1:00 PM - 2:00 PM</h6>
                <input type="text" id="date4" name="date1" value="<%=cd1_4%>" readonly>
                <button class="available-btn" onclick="redirectToStatusPage('cd1_4')">Change Status</button>
                <h6>2:00 PM - 3:00 PM</h6>
                <input type="text" id="date5" name="date1" value="<%=cd1_5%>" readonly>
                <button class="available-btn" onclick="redirectToStatusPage('cd1_5')">Change Status</button>
                <h6>3:00 PM - 4:00 PM</h6>
                <input type="text" id="date6" name="date1" value="<%=cd1_6%>" readonly> 
                <button class="available-btn" onclick="redirectToStatusPage('cd1_6')">Change Status</button>
                <h6>4:00 PM - 5:00 PM</h6>
                <input type="text" id="date7" name="date1" value="<%=cd1_7%>" readonly>
                <button class="available-btn" onclick="redirectToStatusPage('cd1_7')">Change Status</button>
            </div>
</div>
</div>
               <% 
    String reviewsp = "";
    String spid = "";
    try {                                               
        PreparedStatement ps = con.prepareStatement("SELECT u.first_name as u_name,u.user_id FROM booking b JOIN sp s ON b.sp_id = s.sp_id JOIN usersignup u ON b.user_id = u.user_id WHERE b.sp_id =?");
        ps.setString(1, sid);
        ResultSet rs2 = ps.executeQuery();
        if (rs1.next()) {
            reviewsp = rs2.getString(1);
            spid = rs2.getString(2);
            System.out.println(reviewsp);
            System.out.println(spid);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } 
%>


           

    
        

<!-- Display the message below the field -->


        
<script>
        function showEditProfile() {
            document.getElementById("editProfileContainer").style.display = "block";
            document.getElementById("availabilityContainer").style.display = "none";
            
        }

        function showAvailability() {
            document.getElementById("editProfileContainer").style.display = "none";
            document.getElementById("availabilityContainer").style.display = "block";
            
        }

        

        function enableEdit() {
            document.getElementById("firstName").readOnly = false;
            document.getElementById("lastName").readOnly = false;
            document.getElementById("phone").readOnly = false;
            document.getElementById("email").readOnly = false;
            
            document.getElementById("aadhar").readOnly = false; // Make Aadhar card uneditable
            document.getElementById("serviceType").disabled = false;
            
            document.getElementById("saveBtn").style.display = "inline-block";
        }

        function saveChanges() {
    
    document.getElementById("firstName").readOnly = true;
    document.getElementById("lastName").readOnly = true;
    document.getElementById("phone").readOnly = true;
    document.getElementById("email").readOnly = true;
    document.getElementById("aadhar").readOnly = true;
    document.getElementById("serviceType").disabled = true;
    document.getElementById("saveBtn").style.display = "none";
}


        
        
        
    </script>
     <%
    // Retrieve form data
    String id = request.getParameter("sid");
    String firstName = request.getParameter("firstName");
    String phone = request.getParameter("phone");
    String email = request.getParameter("email");
    String serviceType = request.getParameter("serviceType");
    String aadhar_no = request.getParameter("aadhar");
    
    // Process form submission
    if (request.getParameter("action") != null && request.getParameter("action").equals("UpdateProfile")) {
        try {
            // Prepare and execute update query
            PreparedStatement pss = con.prepareStatement("UPDATE SP SET FIRST_NAME=?, SPPHONE=?, SPEMAIL=?, TYPE=?, AADHAR_NO =? WHERE SP_ID=?");
            pss.setString(1, firstName);
            pss.setString(2, phone);
            pss.setString(3, email);
            pss.setString(4, serviceType);
            pss.setString(5, aadhar_no);
            pss.setString(6, id);
            
            int rows = pss.executeUpdate();
             if (rows > 0) { %>
             update successfull
                <script type="text/javascript">
                    // Redirect to the same page after successful update
                    window.location.href = window.location.href;
                </script>
            <% } else { %>
                <h3>Update Failed, no row affected</h3>
            <% }
        } catch(Exception e) { 
            e.printStackTrace(); %>
            <p>An error has occurred: <%= e.getMessage() %></p>
       <% }
    }
%>

<script>
    // Check if the URL contains the anchor ID
    if (window.location.hash === "#availability") {
        // Call the showAvailability() function
        showAvailability();
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