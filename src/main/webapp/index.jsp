<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.Base64" %>
<%@ page import="java.sql.Blob" %>
<%@ page import="Admin.BlobUtil" %>

<%@ page import="java.sql.*"%>
<% Class.forName("com.mysql.cj.jdbc.Driver"); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NGO</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: url("https://img.freepik.com/premium-photo/group-colorful-hands-wall-volenteer-concept-charity-friendship-support-teamwork_738732-1605.jpg");
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }
        .navbar {
            background-color: #2c3e50; /* Advanced color */
            overflow: hidden;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
        }
        .navbar a {
            float: left;
            display: block;
            color: #ecf0f1; /* Advanced color */
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
            transition: background-color 0.3s;
        }
        .navbar a:hover {
            background-color: #3498db; /* Advanced color on hover */
            color: #fff; /* Advanced color on hover */
        }
        .footer {
            background-color: #2c3e50; /* Advanced color */
            color: #ecf0f1; /* Advanced color */
            text-align: center;
            padding: 10px;
            position: fixed;
            bottom: 0;
            width: 100%;
            z-index: 1000;
        }
        .event-container {
            padding: 80px 20px 20px; /* Adjusted padding to accommodate fixed navbar */
        }
        .event-card {
            margin-bottom: 20px;
            border: 2px solid #34495e; /* Advanced color */
            border-radius: 10px;
            padding: 15px;
            background-color: #ecf0f1; /* Advanced color */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            position: relative;
            transition: transform 0.3s ease-in-out;
        }
        .event-card:hover {
            transform: translateX(10px);
        }
        .event-card img {
            width: 100%;
            height: 200px; /* Adjusted height for uniformity */
            object-fit: cover;
            border-bottom: 1px solid #bdc3c7; /* Advanced color */
            margin-bottom: 10px;
        }
        .event-card h3 {
            color: #34495e; /* Advanced color */
        }
        .event-card p {
            color: #7f8c8d; /* Advanced color */
        }
        .event-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
        }
        .btn-primary,
        .btn-success {
            transition: transform 0.2s ease-in-out;
        }
        .btn-primary:hover,
        .btn-success:hover {
            transform: scale(1.1);
        }
    </style>
</head>
<body>

<div class="navbar">
    <a href="admin.html">Admin</a>
    <a href="donorloginreg.html">Donor</a>
    <a href="ngologreg.html">NGO</a>
    <a href="aboutus.html">About</a>
    <a href="contactus.html">Contact Us</a>
</div>
<%
// Establishing connection to the database
String url = "jdbc:mysql://localhost:3306/ngo1";
String username = "root";
String password = "sql@123";
Connection connection = null;
ResultSet resultSet = null;
PreparedStatement statement = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    connection = DriverManager.getConnection(url, username, password);
    String query = "SELECT * FROM events";
    statement = connection.prepareStatement(query);
    resultSet = statement.executeQuery();
} catch (Exception e) {
    e.printStackTrace();
}
%>
<div class="event-container">
    <h1>Welcome to Our NGO</h1>
    <p>We are dedicated to making a positive impact in the world.</p>
	 <% while (resultSet.next()) { %>
    <!-- Event Section -->
    <div class="row">
        <div class="col-lg-4 event-card">
            
            <img class="img-fluid" src="data:image/jpeg;base64, <%= BlobUtil.blobToBase64(resultSet.getBlob("image")) %>" width="100"  alt="Event 1"/></td>
            
            <h3><%= resultSet.getString("title") %></h3>
            <p><%= resultSet.getString("description") %></p>
            <div class="event-buttons">
                <button class="btn btn-primary">Participate</button>
                <button class="btn btn-success">Donate</button>
            </div>
        </div>
 <% } %>
            </div>
</div>

<div class="footer">
    &copy; 2023 Our NGO. All rights reserved.
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</body>
</html>
