<%@page import="java.time.LocalDate"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="xyz.Conn" %>
<%@page import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html>
<head>
    <title>Electricians</title>
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
                width: 50%;
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
                font-size: 1.5rem;
                margin-bottom: 5px;
                color: #007185; 
                cursor: pointer;
            }
            .star-rating {
    font-size: 35px; /* Adjust the font-size to increase or decrease the size of the stars */
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
                margin-top: 30px;
            }
            .in{
                margin-top: 10px;
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
        }
        a {
    text-decoration: none;
}     
    </style>
</head>
<body>
    <%
            LocalDate currentDate = LocalDate.now();
            LocalDate nextDate = currentDate.plusDays(1);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yy");

    // Format the dates using the defined format
    String formattedCurrentDate = currentDate.format(formatter);
    String formattedNextDate = nextDate.format(formatter);
         %>
    

    <%-- JavaScript to add highlight class to the selected button --%>
   <script>
    document.querySelectorAll('button[name="buttonValue"]').forEach(button => {
        button.addEventListener('click', () => {
            // Remove highlight class from all buttons
            document.querySelectorAll('button[name="buttonValue"]').forEach(btn => {
                btn.classList.remove('highlight');
            });
            // Add highlight class to the clicked button
            button.classList.add('highlight');
        });
    });
</script>
<div class="container">
        <center>
            <h1>Pay after service | Super fast service</h1>
            <h2>Electricians near me!</h2>
            <div>
                <form id="myForm" action="date-action.jsp" method="post">
                    <button id="button1" name="buttonValue" value="button1"><%= formattedCurrentDate%></button>
                    <button id="button2" name="buttonValue" value="button2"><%= formattedNextDate%></button>
                   
                </form>
                
         <br>
         
<select id="timeSlot" name="timeSlot" onchange="submitForm()">
  <option value="Select a Time Slot">Select a Time Slot</option>
  <option value="10:00 AM - 11:00 AM">10:00 AM - 11:00 AM</option>
  <option value="11:00 AM - 12:00 PM">11:00 AM - 12:00 PM</option>
  <option value="12:00 PM - 1:00 PM">12:00 PM - 1:00 PM</option>
  <option value="1:00 PM - 2:00 PM">1:00 PM - 2:00 PM</option>
  <option value="2:00 PM - 3:00 PM">2:00 PM - 3:00 PM</option>
  <option value="3:00 PM - 4:00 PM">3:00 PM - 4:00 PM</option>
  <option value="4:00 PM - 5:00 PM">4:00 PM - 5:00 PM</option>
</select>
         
    <form id="myForm1" action="date-action.jsp" method="post">
             <!-- Hidden input field to store the selected time slot -->
            <input type="hidden" id="selectedTimeSlotInput" name="selectedTimeSlot">
            <!-- Hidden input field to store the button value -->
            <%String buttondate = request.getParameter("buttonValue");%>
            <input type="hidden" name="buttonValue" value="<%= buttondate %>">

    </form>
<script>
  // Function to submit the form when dropdown selection changes
  var storedTimeSlot = "ASDF"
  function submitForm() {
    // Get the selected time slot from the dropdown
    var selectedTimeSlot = document.getElementById("timeSlot").value;
    
    // Update the value of the hidden input field
    document.getElementById("selectedTimeSlotInput").value = selectedTimeSlot;
    
    // Submit the form
    document.getElementById("myForm1").submit();
  }
  // Retrieve the selected time slot from local storage on page load
  window.onload = function() {
    storedTimeSlot = localStorage.getItem("selectedTimeSlot");
    if (storedTimeSlot) {
      document.getElementById("timeSlot").value = storedTimeSlot;
    }
  }
</script>
<%-- Retrieve the selected time slot from the request parameters --%>
<%      String selectedTimeSlot = "10:00 AM - 11:00 AM";
                        selectedTimeSlot = request.getParameter("selectedTimeSlot");
        if ("button1".equals(buttondate)) {
if (selectedTimeSlot == null || selectedTimeSlot.equals("null")) {
    selectedTimeSlot = "10:00 AM - 11:00 AM";%>
        <h3><%=formattedCurrentDate%> || <%= selectedTimeSlot %></h3>
       <% }else if ("10:00 AM - 11:00 AM".equals(selectedTimeSlot)){%>
<h3><%=formattedCurrentDate%> || <%= selectedTimeSlot %></h3>
<%}
else if ("11:00 AM - 12:00 PM".equals(selectedTimeSlot)){%>
<h3><%=formattedCurrentDate%> || <%= selectedTimeSlot %></h3>
<%}else if ("12:00 PM - 1:00 PM".equals(selectedTimeSlot)){%>
<h3><%=formattedCurrentDate%> || <%= selectedTimeSlot %></h3>
<%}else if ("1:00 PM - 2:00 PM".equals(selectedTimeSlot)){%>
<h3><%=formattedCurrentDate%> || <%= selectedTimeSlot %></h3>
<%}else if ("2:00 PM - 3:00 PM".equals(selectedTimeSlot)){%>
<h3><%=formattedCurrentDate%> || <%= selectedTimeSlot %></h3>
<%}else if ("3:00 PM - 4:00 PM".equals(selectedTimeSlot)){%>
<h3><%=formattedCurrentDate%> || <%= selectedTimeSlot %></h3>
<%}else if ("4:00 PM - 5:00 PM".equals(selectedTimeSlot)){%>
<h3><%=formattedCurrentDate%> || <%= selectedTimeSlot %></h3>
<%}} else if ("button2".equals(buttondate)) {
if (selectedTimeSlot == null || selectedTimeSlot.equals("null")) {
    selectedTimeSlot = "10:00 AM - 11:00 AM";%>
        <h3><%=formattedNextDate%> || <%= selectedTimeSlot %></h3>
       <% }else if ("10:00 AM - 11:00 AM".equals(selectedTimeSlot)){%>
<h3><%=formattedNextDate%> || <%= selectedTimeSlot %></h3>
<%}
else if ("11:00 AM - 12:00 PM".equals(selectedTimeSlot)){%>
<h3><%=formattedNextDate%> || <%= selectedTimeSlot %></h3>
<%}else if ("12:00 PM - 1:00 PM".equals(selectedTimeSlot)){%>
<h3><%=formattedNextDate%> || <%= selectedTimeSlot %></h3>
<%}else if ("1:00 PM - 2:00 PM".equals(selectedTimeSlot)){%>
<h3><%=formattedNextDate%> || <%= selectedTimeSlot %></h3>
<%}else if ("2:00 PM - 3:00 PM".equals(selectedTimeSlot)){%>
<h3><%=formattedNextDate%> || <%= selectedTimeSlot %></h3>
<%}else if ("3:00 PM - 4:00 PM".equals(selectedTimeSlot)){%>
<h3><%=formattedNextDate%> || <%= selectedTimeSlot %></h3>
<%}else if ("4:00 PM - 5:00 PM".equals(selectedTimeSlot)){%>
<h3><%=formattedNextDate%> || <%= selectedTimeSlot %></h3>
<%}} else {
            // Handle invalid button value
            out.println("Invalid button value");
        }
                        %>

                        <br>
            </div>
<!--            <button onclick="window.location.href='electrician.jsp'">ALL</button>-->
        
                    
                        </center>
    </div>
    <%
        String buttonValue = request.getParameter("buttonValue");
        String sqlQuery1 = "";
        String sqlQuery = "";
        if ("button1".equals(buttonValue)) {
            if ("11:00 AM - 12:00 PM".equals(selectedTimeSlot)) {
            sqlQuery = "SELECT FIRST_NAME,SP_ID FROM SP WHERE TYPE = 'Electrician' AND CD_2 = true";
        } else if ("12:00 PM - 1:00 PM".equals(selectedTimeSlot)) {
            sqlQuery = "SELECT FIRST_NAME,SP_ID FROM SP WHERE TYPE = 'Electrician' AND CD_3 = true";
        } else if ("1:00 PM - 2:00 PM".equals(selectedTimeSlot)) {
            sqlQuery = "SELECT FIRST_NAME,SP_ID FROM SP WHERE TYPE = 'Electrician' AND CD_4 = true";
        } else if ("2:00 PM - 3:00 PM".equals(selectedTimeSlot)) {
            sqlQuery = "SELECT FIRST_NAME,SP_ID FROM SP WHERE TYPE = 'Electrician' AND CD_5 = true";
        } else if ("3:00 PM - 4:00 PM".equals(selectedTimeSlot)) {
            sqlQuery = "SELECT FIRST_NAME,SP_ID FROM SP WHERE TYPE = 'Electrician' AND CD_6 = true";
        } else if ("4:00 PM - 5:00 PM".equals(selectedTimeSlot)) {
            sqlQuery = "SELECT FIRST_NAME,SP_ID FROM SP WHERE TYPE = 'Electrician' AND CD_7 = true";
        } else {
            // Handle invalid button value
            sqlQuery="SELECT FIRST_NAME,SP_ID FROM SP WHERE TYPE = 'Electrician' AND CD_1 = TRUE";
        }
        } else if ("button2".equals(buttonValue)) { 
            if ("11:00 AM - 12:00 PM".equals(selectedTimeSlot)) {
            sqlQuery = "SELECT FIRST_NAME,SP_ID FROM SP WHERE TYPE = 'Electrician' AND CD1_2 = true";}
         else if ("12:00 PM - 1:00 PM".equals(selectedTimeSlot)) {
            sqlQuery = "SELECT FIRST_NAME,SP_ID FROM SP WHERE TYPE = 'Electrician' AND CD1_3 = true";
        } else if ("1:00 PM - 2:00 PM".equals(selectedTimeSlot)) {
            sqlQuery = "SELECT FIRST_NAME,SP_ID FROM SP WHERE TYPE = 'Electrician' AND CD1_4 = true";
        } else if ("2:00 PM - 3:00 PM".equals(selectedTimeSlot)) {
            sqlQuery = "SELECT FIRST_NAME,SP_ID FROM SP WHERE TYPE = 'Electrician' AND CD1_5 = true";
        } else if ("3:00 PM - 4:00 PM".equals(selectedTimeSlot)) {
            sqlQuery = "SELECT FIRST_NAME,SP_ID FROM SP WHERE TYPE = 'Electrician' AND CD1_6 = true";
        } else if ("4:00 PM - 5:00 PM".equals(selectedTimeSlot)) {
            sqlQuery = "SELECT FIRST_NAME,SP_ID FROM SP WHERE TYPE = 'Electrician' AND CD1_7 = true";
        } else {
        sqlQuery = "SELECT FIRST_NAME,SP_ID FROM SP WHERE TYPE = 'Electrician' AND CD1_1 = true";
        }} 
        else {
            // Handle invalid button value
            out.println("Invalid button value");
        }
  System.out.println(buttonValue);
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = new Conn().con;
            ps = con.prepareStatement(sqlQuery);
            rs = ps.executeQuery();
int rating;

             while (rs.next()) { 
                System.out.println("in while");
                String id = rs.getString("sp_id");
                String name = rs.getString("first_name");
                System.out.println(id);
                String sqlQuery11="SELECT RATING FROM SRATING WHERE SP_ID =?";
                ResultSet rs1 = null;
                PreparedStatement ps1 = null;
                 
                ps1 = con.prepareStatement(sqlQuery11);
                
                ps1.setString(1,id);
                rs1 = ps1.executeQuery();
                if(rs1.next()){
                    rating = rs1.getInt("rating");
                   System.out.println("in if");System.out.println(rating+"rating");
    %>
    <script> var rating = <%=rating%></script>
                    <center>
                    <div class="profile" style="display:flex;">
    <a href="service-provider-info.html" >
        <img src="user-icon.png" alt="Electrician Profile Picture" class="profile-pic">
    </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <div class="info" style="display:flex;">
        <div class="in">
            <div class="name" id="fname"><%= name %></div>
            <div class="details"><span id="rating_<%= rating %>" class="star-rating"></span></div>
        </div>
    </div>
            <div style="margin-left: auto;">
        <a href="book-electrician.jsp?name=<%= rs.getString("FIRST_NAME") %>&buttonvalue=<%= buttonValue %>&timeSlot=<%=selectedTimeSlot%>"><button class="book-now" >Book Now</button></a>
        </div>
</div>
<script>
    // Define the displayRatingStars function
    function displayRatingStars(rating) {
        let stars = '';
        for (let i = 0; i < rating; i++) {
            stars += '&#9733;'; // Unicode for star character
        }
        return stars;
    }
    
    // Fetch the rating for this electrician and update the corresponding span element
    let ratingValue = rating; // Assuming rating is passed from server-side
    console.log(ratingValue);
    document.getElementById("rating_<%= rating %>").innerHTML = displayRatingStars(ratingValue);
</script>

              </center>
                    <%
                }else{ System.out.println("in else");%>
        <center>
                   <div class="profile" style="display:flex;">
    <a href="service-provider-info.html" >
        <img src="user-icon.png" alt="Electrician Profile Picture" class="profile-pic">
    </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <div class="info" style="display:flex;">
        <div>
        <a href="service-provider-info.html">
            <div class="name" id="fname"><%= name %></div>
            
        </a>
        </div>
        
    </div>
            <div style="margin-left: auto;">
        <a href="book-electrician.jsp?name=<%= rs.getString("FIRST_NAME") %>&buttonvalue=<%= buttonValue %>&timeSlot=<%=selectedTimeSlot%>"><button class="book-now" >Book Now</button></a>
                       
        </div>
</div>
              </center>
        <%

}}
}catch (SQLException e) {
            e.printStackTrace();
            out.println("Error executing SQL query: " + e.getMessage());
        } finally {
            // Close database resources
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
</body>
</html>
