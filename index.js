function sendMail() {
    var params = {
      name: document.getElementById("name").value,
      email: document.getElementById("email").value,
      message: document.getElementById("message").value,
    };
  
    const serviceID = "service_nv93e9w";
    const templateID = "template_7u6y156";
  
      emailjs.send(serviceID, templateID, params)
      .then(res=>{
           document.getElementById("name").value = "";
          document.getElementById("email").value = "";
          document.getElementById("date").value = "";
          document.getElementById("service").value = "";
          console.log(res);
          alert("Your message sent successfully!!")
  
      })
      .catch(err=>console.log(err));
  
  }