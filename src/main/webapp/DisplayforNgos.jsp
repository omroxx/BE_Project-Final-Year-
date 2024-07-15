<%@page import="java.util.Base64"%>
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
            background-color: green;
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
       <a href="#"><img alt="profileimg" src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" heigth="50" width="50"></a>
  <a href="ngologout"><img alt="logout" src="https://cdn3.vectorstock.com/i/1000x1000/99/77/logout-icon-vector-13489977.jpg" width="50" height="50"></a>
	
       </div>
       <H1>The View Of Donor Table 
       <%
       String data=session.getAttribute("name").toString();
       PrintWriter pw=response.getWriter();
       pw.print("<h1>welcome "+data+"</h1>");
       %></H1>
       <%
           Connection connection = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/ngo1","root","sql@123");
           Statement statement = connection.createStatement() ;
          ResultSet resultset = statement.executeQuery("select * from paymentdata where ngo_name='"+data+"'") ;
       %>
       <form >
      <TABLE BORDER="1">
      <TR>
      
      <TH>Donor name</TH>
      <TH>email</TH>
      <TH>Donation Amount</TH>
      <TH>DOnation Date</TH>
      
      
    
      </TR>
      <% 
      while(resultset.next()){ %>
      <TR>
       
       <TD> <%= resultset.getString(3) %></TD>
       <TD> <%= resultset.getString(4) %></TD>
       <TD> <%= resultset.getString(6) %></TD>
       <TD> <%= resultset.getString(7) %></TD>
       
      </TR>
      <%  } 
      session.removeAttribute("name");%>
     </TABLE>
     </form>
    
       </div>
       <H1>The View Of others Donor Table 
      </H1>
       <%
           Statement statement1 = connection.createStatement() ;
          ResultSet resultset1 = statement1.executeQuery("select * from donation_details where ngo_name='"+data+"'") ;
       %>
       <form >
      <TABLE BORDER="1">
      <TR>
       <TH>Doneted</TH>
      <TH>Donor name</TH>
      <TH>email</TH>
      <TH>Donation Category</TH>
      <TH>DOnation desc</TH>
      
      
    
      </TR>
      <% 
      while(resultset1.next()){ %>
      <TR>
       <TD>
    <img src="data:image/jpg;base64, <%= Base64.getEncoder().encodeToString(resultset1.getBytes(6)) %>" alt="Donation Image" height="100" width="100">
</TD>

       <TD> <%= resultset1.getString(3) %></TD>
       <TD> <%= resultset1.getString(2) %></TD>
       <TD> <%= resultset1.getString(4) %></TD>
       <TD> <%= resultset1.getString(5) %></TD>
       
      </TR>
      <%  } 
      %>
     </TABLE>
     </form>
    
    
    
   
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
     
     </BODY>
</HTML>
    