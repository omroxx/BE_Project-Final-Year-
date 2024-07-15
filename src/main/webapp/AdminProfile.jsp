<%@page import="java.io.InputStream"%>
<%@page import="java.io.PrintWriter"%>
<%@page import ="java.util.Base64" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<% Class.forName("com.mysql.cj.jdbc.Driver");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Profile</title>
<style type="text/css">              
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
</style>

</head>
<body>
<div class="navbar">
<a href="AdminProfile.jsp"><img alt="profileimg" src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" heigth="50" width="50"></a>
  <a href="displayMsgForAdmin.jsp"><img alt="messageimg" src="https://e7.pngegg.com/pngimages/914/998/png-clipart-iphone-text-messaging-imessage-ios-icon-message-free-miscellaneous-blue.png" width="50" height="50"></a>
</div>
 <%		String msg=(String) session.getAttribute("msg");
 		if(msg!=null){
 			%>
 			<div class="alert alert-primary" role="alert">
  profile updated successfully
</div>
 			<%
 		session.removeAttribute("msg");	
 		} 
 		else
 		{
 			session.removeAttribute("msg");	
 		}
 
 String data=(String)session.getAttribute("admin");
 if(data!=null)
 {
	 PrintWriter pw=response.getWriter();
	  pw.print("<h1>welcome "+data+"</h1>"); 
	  session.removeAttribute("admin");
 
 }
 else
	{
	 session.removeAttribute("admin");
		
	}
 
 
           Connection connection = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/ngo1","root","sql@123");
           Statement statement = connection.createStatement() ;
          ResultSet resultset = statement.executeQuery("select * from admins where aemail='"+data+"'") ;
          if (resultset.next()) {
          %>
       
<form action="aedit" method="post">
       <p>Adminemail:</p>
        <input type="text"   id="username" name="aemail" value="<%=resultset.getString("aemail") %>" required><br>

        <p>Password:</p>
        <input type="text" id="password" name="apass" value="<%=resultset.getString("apass") %>" required><br>

        <input type="submit" value="Edit">
        <%} 
       session.setAttribute("aemail", data);
        %>
</form>

</body>
</html>