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
<title>donor profile</title>
<link rel="stylesheet" href="./donorrlstyle.css">
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  
</head>
<body>
<%
String msg=(String) session.getAttribute("msg");
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


String data=(String)session.getAttribute("un");
if(data!=null)
{
	 PrintWriter pw=response.getWriter();
	  pw.print("<h1>welcome "+data+"</h1>"); 
	  session.removeAttribute("fname");

}
else
	{
	 session.removeAttribute("fname");
		
	}

Connection connection = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/ngo1","root","sql@123");
       Statement statement = connection.createStatement() ;
      ResultSet rs = statement.executeQuery("select * from donor where fname='"+data+"'") ;
      if (rs.next()) {

%>
<div id="form">
  <div class="container">
    <div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-md-8 col-md-offset-2">
      <div id="userform">
        <ul class="nav nav-tabs nav-justified" role="tablist">
          <li class="active"><a href="#signup"  role="tab" data-toggle="tab">Donor</a></li>
          
        </ul>
        <div class="tab-content">
          <div class="tab-pane fade active in" id="signup">
            <h2 class="text-uppercase text-center"> Your Profile</h2>
            <form id="signup" action="editd" method="post">
              <div class="row">
                <div class="col-xs-12 col-sm-6">
                  <div class="form-group">
                    <label>First Name<span class="req">*</span> </label>
                    <input type="text" class="form-control" id="first_name" name="fn" value="<%=rs.getString(2) %>" required data-validation-required-message="Please enter your name." autocomplete="off">
                    <p class="help-block text-danger"></p>
                  </div>
                </div>
                <div class="col-xs-12 col-sm-6">
                  <div class="form-group">
                    <label> Last Name<span class="req">*</span> </label>
                    <input type="text" class="form-control" id="last_name" value="<%=rs.getString(3) %>" name="ln" required data-validation-required-message="Please enter your name." autocomplete="off">
                    <p class="help-block text-danger"></p>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label> Your Email<span class="req">*</span> </label>
                <input type="email" class="form-control" id="email" name="email" value="<%=rs.getString(4) %>" required data-validation-required-message="Please enter your email address." autocomplete="off">
                <p class="help-block text-danger"></p>
              </div>
              <div class="form-group">
                <label> Your Phone<span class="req">*</span> </label>
                <input type="tel" class="form-control" id="phone" name="tel" value="<%=rs.getInt(5) %>" required data-validation-required-message="Please enter your phone number." autocomplete="off">
                <p class="help-block text-danger"></p>
              </div>
              <div class="form-group">
                <label> Password<span class="req">*</span> </label>
                <input type="password" class="form-control" id="password" name="pass" value="<%=rs.getString(6) %>" required data-validation-required-message="Please enter your password" autocomplete="off">
                <p class="help-block text-danger"></p>
              </div>
              <div class="mrgn-30-top">
                <button type="submit" class="btn btn-larger btn-block"/>
                Update
                </button>
              </div>
               <%} 
       session.setAttribute("fname", data);
        %>
</form>
</div>
</div>
</div>
</div>
</div>
</div>


<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

<!-- partial -->
  <script  src="./script.js"></script>

</body>
</html>
