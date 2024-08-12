<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="xyz.Conn"%>
<!DOCTYPE html>
<html>
   <head>
    <title>Book Electrician</title>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Contact Us</title>
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
      integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
      crossorigin="anonymous"
    />
    <script src="https://cdn.jsdelivr.net/npm/@emailjs/browser@4/dist/email.min.js"></script>

    <script
      type="text/javascript"
      src="https://cdn.jsdelivr.net/npm/@emailjs/browser@3/dist/email.min.js"></script>
      
    <script type="text/javascript"
        src="https://cdn.jsdelivr.net/npm/@emailjs/browser@4/dist/email.min.js">
</script>
<script type="text/javascript">
   (function(){
      emailjs.init({
        publicKey: "pba55pPIMLw5OvMRo",
      });
   })();
</script>
    
     <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to bottom,  #219dbca0, #007185);
            color: #000; /* Changed text color to black */
        }

        h1 {
            font-size: 2rem;
            padding: 10px 20px;
            margin-top: 20px;
            background: linear-gradient(to bottom,  #219dbca0, #007185);
            color: white;
            text-align: center;
            border-radius: 5px;
        }

        fieldset {
            width: 800px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin: 20px auto;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        fieldset:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        button {
            background-color:  #023047;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 1.2rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color:  #219dbca0;
        }

        textarea {
            width: 100%;
            height: 100px;
            resize: none;
            padding: 5px;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        h3{
            color: #219dbca0;
            text-align: left;
        }
        h4{
            color: #219dbca0;
            text-align: left;
        }
        h1{
            color: white;
        }
        input[type="date"] {
            width: 50%;
            text-align: left;
            padding: 5px;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box; 
        }
        fieldset.date-field {
    text-align: left;
}

       
    </style>
</head>
<body>
    <%response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
            String uid = (String) session.getAttribute("USER_ID");
            
        
            LocalDate currentDate = LocalDate.now();
            LocalDate nextDate = currentDate.plusDays(1);
            LocalDate nextNextDate = currentDate.plusDays(2);
             DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yy");

    // Format the dates using the defined format
    String formattedCurrentDate = currentDate.format(formatter);
    String formattedNextDate = nextDate.format(formatter);
    String formattedNextNextDate = nextNextDate.format(formatter);
        
        
            String fname = request.getParameter("name");
            String date = request.getParameter("buttonvalue");
            
String timeSlot = request.getParameter("timeSlot");
 System.out.println(timeSlot);
            
            String cd=String.valueOf(formattedCurrentDate);
            System.out.println(date);
            if(date.equals("button1")){
                cd = String.valueOf(formattedCurrentDate);
                 
            }
            else if(date.equals("button2")){
                cd = String.valueOf(formattedNextDate);
            }
            else if(date.equals("button3")){
                cd = String.valueOf(formattedNextNextDate);
            }
            else{
                System.out.println("error");
            }
            
            System.out.println(cd);
                    
            String type="";
            String spemail="";
            String spphone = "";
            String spid ="";
            String aadhar = "";
            if(fname != null){
                PreparedStatement ps = new Conn().con.prepareStatement("SELECT TYPE,SPEMAIL,SPPHONE,SP_ID,AADHAR_NO FROM SP WHERE FIRST_NAME =?");
                ps.setString(1,fname);
                ResultSet rs = ps.executeQuery();
                if(rs.next()){
                    type = rs.getString(1);
                    spemail=rs.getString(2);
                    spphone =rs.getString(3);
                    spid =rs.getString(4);
                    aadhar = rs.getString(5);
                    System.out.println(aadhar);
                }else{
                    %>
                    <script type="text/javascript">
                        alert("Provider does not exist");
                    </script>
                <%  }
            }
           
               
               String ufname ="";
               String uaddress ="";
               String uemail ="";
               PreparedStatement ps  = new Conn().con.prepareStatement("Select first_name,address,email from usersignup where user_id=?");
               ps.setString(1,uid);
                ResultSet rs = ps.executeQuery();
                if(rs.next()){
                    ufname = rs.getString(1);
                    uaddress = rs.getString(2);
                    uemail = rs.getString(3);}else {%>
                    <script type="text/javascript">
                        alert("error");
                    </script>
                <%  }

        %>

<center>
    <h1>
        Book <%=type%> Now
    </h1>
    <form>
        <fieldset>
            <h4>Service Provider Name:</h4>
            <input
              type="sname"
              class="form-control"
              id="sname"
              placeholder="Enter email"
              value="<%=fname%>" readonly
            />
            <h4 style="margin-top:5px;">Service Type:</h4>
            <input
              type="sname"
              class="form-control"
              id="stype"
              placeholder="Enter email"
              value="<%=type%>" readonly
            />
            <h4 style="margin-top:5px;">Email Id:</h4>
            <input
              type="sname"
              class="form-control"
              id="semail"
              placeholder="Enter email"
              value="<%=spemail%>" readonly
            />
            <h4 style="margin-top:5px;">Phone Number:</h4>
            <input
              type="sname"
              class="form-control"
              id="spphone"
              placeholder="Enter email"
              value="<%=spphone%>" readonly
            />
            <h4 style="margin-top:5px;">Email Id:</h4>
            <input
              type="sname"
              class="form-control"
              id="saadhar"
              placeholder="Enter email"
              value="<%=aadhar%>" readonly
            />
        </fieldset>
        <br>
        <fieldset>
            <h3 for="email">Email</h3>
            <input
              type="email"
              class="form-control"
              id="email"
              placeholder="Enter email"
              value="<%=uemail%>"
            />
        </fieldset>
        <fieldset>
            <h3 for="name">Name</h3>
            <input
              type="text"
              class="form-control"
              id="name"
              placeholder="Enter name"
              value="<%=ufname%>"
            />
            </fieldset>
            <fieldset>
            <h3 for="name">Address</h3>
            <input
              type="text"
              class="form-control"
              id="address"
              placeholder="Enter name"
              value="<%=uaddress%>"
            />
        </fieldset>
        <fieldset class="date-field">
            <h3 for="date">Date</h3>
            <input type="text" id="date" name="date" value="<%=cd%>" readonly>
            
        </fieldset>
        <fieldset class="date-field">
            <h3 for="time">Time</h3>
            <input type="text" id="time_slot" name="time" value="<%=timeSlot%>" readonly>
            
        </fieldset>
            <br>
        <fieldset>
            <h6>Payment is to be made directly to the service provider upon completion of the service. </h6>
        </fieldset>
        
        <hr>
        <button type="button" class="btn btn-primary" onclick="sendMail()">Book Now</button>
    </form>
</center>
<script>
    
    
var url = "redirect.jsp?sid=<%=spid%>&date=<%=date%>&time=<%=timeSlot%>";
    function sendMail() {
              var name = document.getElementById("name").value;
              var date = document.getElementById("date").value;
              var time = document.getElementById("time_slot").value;
              
    var params = {
      name: name,
      email: document.getElementById("email").value,
      date: date,
      time: time,
      service: "<%=type%>",
      spphone: "<%=spphone%>",
      aadhar: "<%=aadhar%>",
      spname: "<%=fname%>",
      phone: "<%=spphone%>",
      
    };
  
    const serviceID = "service_nv93e9w";
    const templateID = "template_7u6y156";
  
      emailjs.send(serviceID, templateID, params)
      .then(res=>{
          document.getElementById("name").value = "";
          document.getElementById("email").value = "";
          document.getElementById("date").value = "";
          console.log(res);
          alert("Booking Confirmed!")
          sendSecondMail("service_nv93e9w",name,date);

      })
      .catch(err=>console.log(err));
  
  }
 
    function sendSecondMail(serviceID,name,date) {
    var tiime = document.getElementById("time_slot").value;
    var secondParams = {
        name: name, // Added colon after "name"
        spemail: "<%=spemail%>",
        fname: "<%=fname%>",
        service:"<%=type%>",
        address: document.getElementById("address").value, // Added colon after "address"
        message: "This is the second email message content.",
        date: date,
        time: tiime,
        // Add other parameters as needed
    };

    const secondTemplateID = "template_7apwwbf"; // Replace with your second template ID

    emailjs.send(serviceID, secondTemplateID, secondParams)
        .then(res => {
            document.getElementById("address").value = "";
            document.getElementById("name").value = "";
            document.getElementById("date").value = "";
            console.log(res);
            window.open(url, '_self');
        })
        .catch(err => console.log(err));
}


  
      </script>
      
      
       
   
      
      
</body>
</html>