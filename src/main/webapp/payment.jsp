<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Form</title>
    
    <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"
        integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
    <link rel="stylesheet" href="paymentstyle.css">
    <style>
         body {
            background-image: url('https://media.istockphoto.com/id/870402320/photo/a-social-worker-meeting-with-a-group-of-villagers.jpg?s=612x612&w=0&k=20&c=2JlS1vqg4pU5lCp8oiFXjVgMPlHbhrmH4wmtRJdq384=');
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: cover;
        }

        .navbar {
            background-color: #3498db;
            overflow: hidden;
            position: fixed;
            top: 0;
            width: 100%;
            animation: slideInDown 0.5s ease-in-out;
            z-index: 1000;
        }

        .navbar a {
            display: inline-block;
            color: #fff;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
            transition: background-color 0.3s, color 0.3s; /* Added color transition */
            margin: 0 15px; /* Adjusted spacing between links */
        }

        .navbar a:hover {
            background-color: #2c3e50;
            color: #3498db; /* Different color on hover */
        }

        h1 {
            color: #333;
            animation: slideInLeft 0.5s ease-in-out;
        }

        .wrapper {
            margin-top: 80px; /* Adjusted top margin for content */
        }

        /* Add your other styles here */

        @keyframes slideInDown {
            from {
                top: -50px;
            }
            to {
                top: 0;
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
    </style>
</head>

<body>
<%
String data = null;
try {
    data = (String) session.getAttribute("un");

    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ngo1", "root", "sql@123");
    String query = "SELECT * FROM donor WHERE fname = ?";
    PreparedStatement pstmt = connection.prepareStatement(query);
    pstmt.setString(1, data);
    ResultSet donorResultSet = pstmt.executeQuery();

String nid=request.getParameter("nid").trim();
int id=Integer.parseInt(nid);
HttpSession s=request.getSession();
s.setAttribute("nid", id);
session.setAttribute("un", data);

    // Get the 'nwork' parameter from the URL
    String nwork = request.getParameter("nwork");

    // Use the 'nwork' value as needed
    out.println("Value of nwork: " + nwork);
    String nname = request.getParameter("nname");

    // Use the 'nwork' value as needed
    out.println("Value of nwork: " + nname);

        if (donorResultSet.next()) {
            String donorEmail = donorResultSet.getString("email");
%>
    <div class="navbar">
        <a href="DonorProfile.jsp"><img alt="profileimg" src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" height="50" width="50"></a>
        <a href="#"> <%=data %></a>
        <a href="DisplayforDonor.jsp">NGOs</a>
        <a href="donorlogout"><img alt="logout" src="https://cdn3.vectorstock.com/i/1000x1000/99/77/logout-icon-vector-13489977.jpg" width="50" height="50"></a>
    </div>
    <div class="wrapper">
     <h2>Choose Action</h2>
    <form action="" method="POST" id="actionForm">
        <div class="input-group">
            <div class="input-box">
                <select id="actionSelect" name="action">
                    <option value="payment">Make Payment</option>
                    <option value="other">Other Details</option>
                </select>
            </div>
        </div>
        <div class="input-group">
            <div class="input-box">
                <button type="button" onclick="selectAction()">Next</button>
            </div>
        </div>
    </form>
    
         <div id="paymentForm" style="display: none;"><h2>Payment Form</h2>
        <form action="donate" method="POST">
            <!-- ... other form elements ... -->
             <div class="input-group">
                <div class="input-box">
                    <input type="text" placeholder="name" required class="name" name="name" value="<%=donorResultSet.getString(2) %>">
                    <i class="fa fa-profile icon"></i>
                </div>
            </div>
            <div class="input-group">
                <div class="input-box">
                    <input type="email" placeholder="Email Address" required class="name" name="email" value="<%=donorEmail %>">
                    <i class="fa fa-envelope icon"></i>
                </div>
            </div>
            <div class="input-group">
                <div class="input-box">
                    <h4> Date of Birth</h4>
                    <input type="date" placeholder="YYYY-MM-DD" class="dob" name="bob">
                </div>
                <div class="input-box">
                    <h4> Gender</h4>
                    <input type="radio" id="male" value="Male" checked class="radio" name="gender">
                    <label for="male">Male</label>
                    <input type="radio" id="female" value="Female" class="radio" name="gender">
                    <label for="female">Female</label>
                </div>
            </div>
            <div class="input-group">
                <div class="input-box">
                    <h4>Payment Details</h4>
                </div>
            </div>
            <div class="input-group">
                <div class="input-box">
                    <input type="number" placeholder="Amount to donate" required class="name" name="amt">
                    <i class="fa fa-inr icon"></i>
                </div>
            </div>
            <div class="input-group">
                <div class="input-box">
                    <input type="tel" placeholder="Card Number" required class="name" name="cardn">
                    <i class="fa fa-credit-card icon"></i>
                </div>
            </div>
            <div class="input-group">
                <div class="input-box">
                    <h4>Card cvv</h4>
                    <input type="tel" placeholder="Card CVv" required class="name" name="cardcvv">
                </div>
                <div class="input-box">
                    <h4>Expiry date:</h4>
                    <input type="date" placeholder="ExpiryDate" class="dob" name="ed">
                </div>
            </div>
            <div class="input-group">
                <div class="input-box">
                    <button type="submit">DONATE NOW</button>
                </div>
            </div>
        </form>
    </div>
     <div id="otherForm" style="display: none;">
        <h2>Other Details Form</h2>
        <form action="donateot" method="POST" enctype="multipart/form-data">
            <div class="input-group">
                <div class="input-box">
                    <input type="text" placeholder="Donor Email" required class="name" name="donorEmail" value="<%=donorEmail %>">
                    <i class="fa fa-envelope icon"></i>
                </div>
            </div>
            <div class="input-group">
                <div class="input-box">
                    <input type="text" placeholder="Donor Name" required class="name" name="donorName" value="<%=donorResultSet.getString(2) %>">
                    <i class="fa fa-profile icon"></i>
                </div>
            </div>
            <div class="input-group">
                <div class="input-box">
                   <input type="text" placeholder="Donation Category" required class="name" name="donationCategory" value="<%= nwork %>">
 <i class="fa fa-box icon"></i>
                </div>
            </div>
             <div class="input-group">
                <div class="input-box">
                   <input type="text" placeholder="Donation Category" required class="name" name="ngoName" value="<%= nname %>" hidden="true">
 <i class="fa fa-box icon"></i>
                </div>
            </div>
            <div class="input-group">
                <div class="input-box">
                    <textarea placeholder="Description" required class="name" name="description"></textarea>
                    <i class="fa fa-info-circle icon"></i>
                </div>
            </div>
            <div class="input-group">
                <div class="input-box">
                    <input type="file" name="donationImage" accept="image/*">
                    <i class="fa fa-image icon"></i>
                </div>
            </div>
            <div class="input-group">
                <div class="input-box">
                    <button type="submit">DONATE</button>
                </div>
            </div>
        </form>
    </div>
<%
        } else {
            out.println("Donor details not found!");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
%>
</body>
<script>
    function selectAction() {
        var selectedAction = document.getElementById("actionSelect").value;

        if (selectedAction === "payment") {
            document.getElementById("paymentForm").style.display = "block";
            document.getElementById("otherForm").style.display = "none";
        } else if (selectedAction === "other") {
            document.getElementById("otherForm").style.display = "block";
            document.getElementById("paymentForm").style.display = "none";
        }

        document.getElementById("actionForm").style.display = "none";
    }
</script>


</html>
