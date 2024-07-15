<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<% Class.forName("com.mysql.cj.jdbc.Driver");%>
<HTML>
       <HEAD>
       <TITLE>Donor list </TITLE>
       <style>
                body {
            background-image: url('https://media.istockphoto.com/id/870402320/photo/a-social-worker-meeting-with-a-group-of-villagers.jpg?s=612x612&w=0&k=20&c=2JlS1vqg4pU5lCp8oiFXjVgMPlHbhrmH4wmtRJdq384=');
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: cover;
        }
          
  table {
    
    max-width: 800px;
    text-align: center;
    margin: auto; 
     border-collapse: collapse;
  width: 100%;
  border: 2px solid #333; /* Border color */
  background-color: #f2f2f2;
  }

  th, td {
    
    padding: 8px;
    border: 1px solid #333; /* Border color for table cells */	
  text-align: left;
  }

  th {
     background-color: #444; /* Header cell background color */
  color: white;
  }  
    .navbar {
    background-color: #333;
    overflow: hidden;
  }

  /* Style for the navigation bar links */
  .navbar a {
    float: right;
    display: block;
    color: white;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
  }

  /* Change color on hover */
  .navbar a:hover {
    background-color: #ddd;
    color: black;
  }
 


h1 {
  color: #333; /* Heading color */
}

p {
  color: #666; /* Paragraph text color */
}

span.highlight {
  color: red; /* Specific span element text color */
}
.footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 10px;
            position: absolute;
            bottom: 0;
            width: 100%;
        }
    </style>
       </HEAD>
       <BODY >
       <div class="navbar">
<a href="AdminProfile.jsp"><img alt="profileimg" src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" heigth="50" width="50"></a>
  <a href="displayMsgForAdmin.jsp"><img alt="messageimg" src="https://e7.pngegg.com/pngimages/914/998/png-clipart-iphone-text-messaging-imessage-ios-icon-message-free-miscellaneous-blue.png" width="50" height="50"></a>
</div>
       <H1>The View Of msg Table 
       <%
       String data=(String)session.getAttribute("admin");
       if(data!=null){
       PrintWriter pw=response.getWriter();
       pw.print("<h1>welcome "+data+"</h1>");
       session.removeAttribute("admin");
       }
       else
       {
    	   session.removeAttribute("admin");
       }
       %></H1>
       <%
           Connection connection = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/ngo1","root","sql@123");
           Statement statement = connection.createStatement() ;
          ResultSet resultset = statement.executeQuery("select * from contactus") ;
       %>
       <form >
      <TABLE BORDER="1">
      <TR>
      
      <TH>Donor name</TH>
      <TH>email</TH>
      <TH>Message</TH>
     
      
      
    
      </TR>
      <% 
      while(resultset.next()){ %>
      <TR>
       
       <TD> <%= resultset.getString(2) %></TD>
       <TD> <%= resultset.getString(3) %></TD>
       <TD> <%= resultset.getString(4) %></TD>
       
       
      </TR>
      <%  } 
      session.setAttribute("admin", data);
      %>
     </TABLE>
     </form>
     <div class="footer">
    &copy; 2023 Our NGO. All rights reserved.
</div>
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
     
     </BODY>
</HTML>
    