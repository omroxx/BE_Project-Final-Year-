<%@page import="java.io.InputStream"%>
<%@page import="java.io.PrintWriter"%>
<%@page import ="java.util.Base64" %>
<%@page import ="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<% Class.forName("com.mysql.cj.jdbc.Driver");%>
<HTML>
<HEAD>
  <TITLE>NGO List</TITLE>
  <style>
    /* Add your custom styles here */

     body {
            background-image: url('https://media.istockphoto.com/id/870402320/photo/a-social-worker-meeting-with-a-group-of-villagers.jpg?s=612x612&w=0&k=20&c=2JlS1vqg4pU5lCp8oiFXjVgMPlHbhrmH4wmtRJdq384=');
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: cover;
        }

    .navbar {
      background-color: #333;
      overflow: hidden;
      position: fixed;
      top: 0;
      width: 100%;
      animation: slideInDown 0.5s ease-in-out;
    }

    .navbar a {
      float: right;
      display: block;
      color: white;
      text-align: center;
      padding: 14px 16px;
      text-decoration: none;
      transition: background-color 0.3s;
    }

    .navbar a:hover {
      background-color: #ddd;
      color: black;
    }

    h1 {
      color: #333;
      animation: slideInLeft 0.5s ease-in-out;
    }

    table {
      max-width: 800px;
      text-align: center;
      margin: auto;
      border-collapse: collapse;
      width: 100%;
      border: 2px solid #333;
      background-color: #fff;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    th, td {
      padding: 8px;
      border: 1px solid #333;
      text-align: left;
    }

    th {
      background-color: #444;
      color: white;
    }

    .footer {
      background-color: green;
      color: white;
      text-align: center;
      padding: 10px;
      position: fixed;
      bottom: 0;
      width: 100%;
      animation: slideInUp 0.5s ease-in-out;
    }

    input[type="text"] {
      padding: 10px;
      margin: 8px 0;
      box-sizing: border-box;
      animation: fadeInUp 0.5s ease-in-out;
      width: 80%; /* Adjust the width as needed */
      border: 2px solid #333;
      border-radius: 5px;
      background-color: #f2f2f2;
      color: #333;
    }

    /* Add keyframes for animations */
    @keyframes slideInDown {
      from {
        top: -50px;
      }
      to {
        top: 0;
      }
    }

    @keyframes slideInUp {
      from {
        bottom: -50px;
      }
      to {
        bottom: 0;
      }
    }

    @keyframes slideInLeft {
      from {
        left: -50px;
      }
      to {
        left: 0;
      }
    }

    @keyframes fadeIn {
      from {
        opacity: 0;
      }
      to {
        opacity: 1;
      }
    }

    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translateY(20px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }
  </style>

  <!-- Link Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">

</HEAD>
<BODY>
<%
    String data = null;
    try {
      data = (String) session.getAttribute("un");
      PrintWriter pw = response.getWriter();
     
    } catch (Exception ex) {

    }
  %> 
  <div class="navbar">
    <a href="DonorProfile.jsp"><img alt="profileimg" src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" height="50" width="50"></a>
    <h1>Welcome   <%=data %> </h1>
    <a href="donorlogout"><img alt="logout" src="https://cdn3.vectorstock.com/i/1000x1000/99/77/logout-icon-vector-13489977.jpg" width="50" height="50"></a>
  </div>

  <H1>The View Of NGO List</H1>

  <form>
    <input type="text" id="searchInput" placeholder="Search Categories" oninput="searchNGOs()">
  </form>
  
<%
           Connection connection = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/ngo1","root","sql@123");
           Statement statement = connection.createStatement() ;
          ResultSet resultset = statement.executeQuery("select * from ngos") ;
          
       %>
  <TABLE BORDER="1" id="ngoTable">
    <TR>
      <TH>Photo</TH>
      <TH>NGO Name</TH>
      <TH>Contact</TH>
      <TH>Address</TH>
      <TH>Email</TH>
      <TH>Work</TH>
    </TR>

    <%
      while (resultset.next()) { %>
      <% String imglen = ""; %>
      <% imglen = resultset.getString(9);
      int len = imglen.length();
      byte[] rb = new byte[len];
      InputStream readimg = resultset.getBinaryStream(9);
      int index = readimg.read(rb, 0, len);
      %>
      <TR>
        <TD><img src="data:image/jpeg;base64,<%= Base64.getEncoder().encodeToString(rb) %>" width="50" height="50"></TD>
        <TD><%= resultset.getString(2) %></TD>
        <TD><%= resultset.getString(3) %></TD>
        <TD><%= resultset.getString(4) %></TD>
        <TD><%= resultset.getString(5) %></TD>
        <TD><%= resultset.getString(8) %></TD>
        <td><a href="payment.jsp?nid=<%=resultset.getInt(1) %>&&nwork=<%= resultset.getString(8) %>&&nname=<%=resultset.getString(2) %>" class="btn btn-success">Donate</a></td>
      </TR>
      <%  }
      session.removeAttribute("un");
      session.setAttribute("un", data);
    %>
  </TABLE>

  <div class="footer">
    &copy; 2023 Our NGO. All rights reserved.
  </div>

  <!-- Add Bootstrap JS script -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

  <script>
    // Function to search NGOs based on input
    function searchNGOs() {
      var input, filter, table, tr, td,td1, i, txtValue,txtValue1;
      input = document.getElementById("searchInput");
      filter = input.value.toUpperCase();
      table = document.getElementById("ngoTable");
      tr = table.getElementsByTagName("tr");

      for (i = 0; i < tr.length; i++) {
        td = tr[i].getElementsByTagName("td")[3];
        td1 = tr[i].getElementsByTagName("td")[5];// Change index based on the column you want to search
        if (td || td1) {
          txtValue = td.textContent || td.innerText;
          txtValue1 = td1.textContent || td1.innerText;
          
          if( (txtValue.toUpperCase().indexOf(filter) > -1)|| txtValue1.toUpperCase().indexOf(filter) > -1 ){
            tr[i].style.display = "";
          } 
         
          else {
            tr[i].style.display = "none";
          }
        }
      }
    }
  </script>

</BODY>
</HTML>
