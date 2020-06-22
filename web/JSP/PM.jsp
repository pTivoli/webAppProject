<%@ page import="it.pointPharma.generalClasses.DeskOperator" %>
<%@ page import="it.pointPharma.generalClasses.PharmacistManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>PharmaPoint - Pharmacist Manager</title>
    <link rel="stylesheet" href="CSS/Stylesheet.css"/>
    <link rel="stylesheet" href="CSS/PharmacistsPages.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300&display=swap" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<%
    PharmacistManager deskOp = (PharmacistManager)request.getAttribute("pharmacist");
    String fname = deskOp.getfName();
    String lname = deskOp.getlName();
    String cf = deskOp.getCF();
    String email = deskOp.getEmail();
%>
<div id="header">
    <div id="pharmacist">
        <p>Welcome <%= fname + " " + lname + "!" %></p><br/>
        <p>First Name: <%= fname %></p><br/>
        <p>Last Name: <%= lname %></p><br/>
        <p>CF: <%= cf %></p><br/>
        <p>E-mail: <%= email %></p><br/>
    </div>
    <div id="pharmacy">
        <p>Pharmacy</p><br>
        <p>Name: Default Pharmacy</p><br>
        <p>Address: Default Address</p><br>
        <p>Tel: +39 0123 45678</p><br>
        <p>Mail PM: pm@gmail.com</p><br>
    </div>
</div>
<div id="mainContent">
    //forms will be there
</div>
</body>
</html>