<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.Base64" %>
<%@ page import="java.sql.Blob" %>
<%@ page import="Admin.BlobUtil" %>

<%@ page import="java.sql.*"%>
<% Class.forName("com.mysql.cj.jdbc.Driver"); %>
<HTML>

<HEAD>
    <TITLE>NGO list </TITLE>
    <link rel="Stylesheet" href="Displayfileforadmin.css">
        <style>
        body {
            background-image: url('https://media.istockphoto.com/id/870402320/photo/a-social-worker-meeting-with-a-group-of-villagers.jpg?s=612x612&w=0&k=20&c=2JlS1vqg4pU5lCp8oiFXjVgMPlHbhrmH4wmtRJdq384=');
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: cover;
        }

        .navbar {
            background-color: #333;
            color: white;
            overflow: hidden;
            padding: 10px;
        }

        .content {
            flex-grow: 1;
            text-align: center;
            padding: 20px;
        }

        /* Custom styles for form */
        form {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        /* Style form labels */
        label {
            color: #333;
            font-weight: bold;
        }

        /* Style form input fields */
        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            transition: border-color 0.3s ease;
        }

        /* Style form input fields on focus */
        input[type="text"]:focus,
        textarea:focus {
            outline: none;
            border-color: #007bff; /* Blue border color on focus */
        }

        /* Style submit button */
        button[type="submit"] {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #007bff; /* Blue button background color */
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        /* Style submit button on hover */
        button[type="submit"]:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }
    </style>
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            margin: 0;
        }

        .navbar {
            background-color: #333;
            color: white;
            overflow: hidden;
            padding: 10px;
        }

        .navbar a {
            margin-right: 20px; /* Adjust the margin as needed */
        }

        .content {
            flex-grow: 1;
            text-align: center;
            overflow-x: auto; /* Add horizontal scrollbar if needed */
        }

        table {
            max-width: 800px;
            text-align: center;
            margin: auto;
            border-collapse: collapse;
            width: 100%;
            border: 2px solid #333;
            background-color: #f2f2f2;
        }

        th,
        td {
            padding: 8px;
            border: 1px solid #333;
            text-align: left;
        }

        th {
            background-color: #444;
            color: white;
        }

        .footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 10px;
            width: 100%;
        }

        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .pagination a {
            color: black;
            padding: 8px 16px;
            text-decoration: none;
            transition: background-color .3s;
            border: 1px solid #ddd;
            cursor: pointer;
        }

        .pagination a.active {
            background-color: #4CAF50;
            color: white;
        }

        .pagination a:hover:not(.active) {
            background-color: #ddd;
        }
        /* Center the form */
.center-form {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    max-width: 600px; /* Limit form width */
    margin: auto;
}

/* Add animation to buttons */
button[type="submit"] {
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    background-color: #007bff; /* Blue button background color */
    color: white;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease; /* Add transition */
}

/* Style submit button on hover */
button[type="submit"]:hover {
    background-color: #0056b3; /* Darker blue on hover */
    transform: scale(1.05); /* Scale up on hover */
}
        
    </style>
</HEAD>

<BODY>

    <div class="navbar">
        <%
        String data = (String) session.getAttribute("aemail");
        if (data != null) {
            PrintWriter pw = response.getWriter();
            pw.print("<h1>welcome " + data + "</h1>");
            session.removeAttribute("aemail");
        } else {
            session.removeAttribute("aemail");
        }
        %>
        <a href="AdminProfile.jsp"><img alt="profileimg"
                src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" height="50" width="50"></a>
        <a href="displayMsgForAdmin.jsp"><img alt="messageimg"
                src="https://e7.pngegg.com/pngimages/914/998/png-clipart-iphone-text-messaging-imessage-ios-icon-message-free-miscellaneous-blue.png"
                width="50" height="50"></a>
                 <a href="addevents.jsp"><img alt="messageimg"
                src="data:image/png;base64,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"
                width="50" height="50"></a>
        <a href="adminlogout"><img alt="logout"
                src="https://cdn3.vectorstock.com/i/1000x1000/99/77/logout-icon-vector-13489977.jpg" width="50"
                height="50"></a>
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


<head>
    <title>Event List</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>

<body>
    <h1>Event List</h1>
    <table>
        <tr>
            <th>Event ID</th>
            <th>Event Title</th>
            <th>Event Description</th>
            <th>Event Image</th>
           
        </tr>
        <% while (resultSet.next()) { %>
            <tr>
                <td><%= resultSet.getInt("id") %></td>
                <td><%= resultSet.getString("title") %></td>
                <td><%= resultSet.getString("description") %></td>
               <td><img src="data:image/jpeg;base64, <%= BlobUtil.blobToBase64(resultSet.getBlob("image")) %>" width="100" /></td>
<td>
            </tr>
        <% } %>
    </table>
</body>

</html>

    
    
    
    

  <div class="content">
        <h1>Add Event</h1>
        <form action="addEventServlet" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="eventTitle" class="form-label">Event Title</label>
                <input type="text" class="form-control" id="eventTitle" name="eventTitle" required>
            </div>
            <div class="mb-3">
                <label for="eventDescription" class="form-label">Event Description</label>
                <textarea class="form-control" id="eventDescription" name="eventDescription" rows="3"
                    required></textarea>
            </div>
            <div class="mb-3">
                <label for="eventImage" class="form-label">Event Image</label>
                <input type="file" class="form-control" id="eventImage" name="eventImage" required>
            </div>
           
            <button type="submit" class="btn btn-primary">Add Event</button>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
        crossorigin="anonymous"></script>


    <div class="footer">
        &copy; 2023 Our NGO. All rights reserved.
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
        crossorigin="anonymous"></script>

</BODY>

</HTML>
