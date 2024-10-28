<%-- 
    Document   : logged
    Created on : 27-Oct-2024, 12:28:50 am
    Author     : rguktrkvalley
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/logged.css"> <!-- Link to your CSS file -->
</head>
<body>
    <div class="container">
        <h1>Welcome to the Hotel</h1>
        
        <div id="hotelCarousel" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="https://plus.unsplash.com/premium_photo-1661964071015-d97428970584?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aG90ZWx8ZW58MHx8MHx8fDA%3D" alt="Hotel Image 1">
                </div>
                <div class="carousel-item">
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmVBBG2nPwGQPO3qiCbizRb7Bu8MbjdHHCdg&s" alt="Hotel Image 2">
                </div>
                <div class="carousel-item">
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQf5JbWUQApKbde0mcDHJ-DxU3llLO1070PA&s" alt="Hotel Image 3">
                </div>
            </div>
            <a class="carousel-control-prev" href="#hotelCarousel" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#hotelCarousel" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>

        <h2>Please choose an option:</h2>
        <ul class="list-group">
            <li class="list-group-item"><a href="foodmenu.jsp">View Food Menu</a></li>
            <li class="list-group-item"><a href="feedback.jsp">Submit Feedback</a></li>
        </ul>

        <a href="logout.jsp" class="btn btn-danger">Logout</a>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>