<%@ page import="it.pointPharma.generalClasses.DeskOperator" %>
<%@ page import="it.pointPharma.generalClasses.Pharmacy" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>PharmaPoint - Desk Operator</title>
    <link rel="stylesheet" href="../CSS/Stylesheet.css"/>
    <link rel="stylesheet" href="../CSS/PharmacistsPages.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<%
    DeskOperator deskOp = (DeskOperator)session.getAttribute("pharmacist");
    String fname = deskOp.getfName();
    String lname = deskOp.getlName();
    String cf = deskOp.getCF();
    String email = deskOp.getEmail();

    Pharmacy pharm = (Pharmacy)session.getAttribute("pharmacy");
    String pharmName = pharm.getName();
    String pharmAddress = pharm.getAddress();
    String pharmPN = pharm.getPhoneNumber();
    String pharmCFPM = pharm.getPharmacyManager().getCF();
    String pharmEmail = pharm.getPharmacyManager().getEmail();

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
        <p>Name: <%= pharmName%></p><br>
        <p>Address: <%= pharmAddress%></p><br>
        <p>Tel: <%= "+39" + pharmPN%></p><br>
        <p>Mail PM: <%= pharmEmail%></p><br>
        <p>PM CF: <%= pharmCFPM%></p><br>
    </div>
</div>
<div id="mainContent">
    <div id="formBox">
        <form>
            <input id="medicine" onkeyup="ajaxCall();" type="text" placeholder="Medicine">
        </form><br><br>
        <div id="suggestions">
        </div>
    </div>
    <div id="cart">
        <p>CART</p><br/>
        <p><button onclick="buyFn();" disabled>BUY</button></p><br/>
        <div id="objects"></div>
    </div>
    <a href="JSP/chat.jsp" id="openChat">C<br>H<br>A<br>T<br></a>
</div>
<script src="../JS/JQuery.js"></script>
<script>
    var totPriceMed;
    $(document).ready(function () {
        if(document.cookie != ""){
            document.cookie = "medicine=; expires=Thu, 01 Jan 1970 00:00:00 UTC;";
        }
        totPriceMed = 0.0;
    });
    function cookieCart(codeMed, nameMed, priceFn){
        totPriceMed += parseFloat(priceFn);
        var obj = document.getElementById("objects").innerHTML;
        document.getElementById("objects").innerHTML= "<p>"+nameMed+"</p><br>" + obj;
        $("#cart button").html("BUY - " + totPriceMed + "€");
        if(document.cookie == ""){
            $("#cart button").prop("disabled", false);
            document.cookie = "medicine=" + codeMed + ",";
        }else{
            document.cookie += codeMed + ",";
        }
    }
    function ajaxCall(){
        if($('#medicine').val().length > 0) {
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "checkOutMedicinesForPharamacy.do",
                    data: {
                        hint: $('#medicine').val()
                    },
                    success: function (responseText) {
                        $('#suggestions').html(createTable(responseText));
                    }
                });
            });
        }else{
            $('#suggestions').html("");
        }
    }
    function buyFn(){
        if(document.cookie != ""){
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "buyMedicinesForPharmacy.do",
                    data: {
                        medicine: document.cookie
                    },
                    success: function () {
                        alert("All the medicines are now in your pharmacy!");
                        document.cookie = "medicine=; expires=Thu, 01 Jan 1970 00:00:00 UTC;";
                        $('#suggestions').html("");
                        $('#medicine').val("");
                        $("#cart button").html("BUY");
                        document.getElementById("objects").innerHTML = "";
                        totPriceMed = 0.0;
                    }
                });
            });
        }
    }
    function createTable(text){
        var ris = "<table>";
        text = text.split(";");
        var i;
        for(i = 0; i < text.length-1; i += 5){
            ris += "<tr><td>" + text[i] + "</td><td>" + text[i + 1] + "</td><td>" + text[i + 2] + "</td><td>" + text[i + 3] + "</td><td>" + text[i + 4] + "</td><td><button onclick=\"cookieCart('" + text[i] + "', '" + text[i + 1] + "', '" + text[i + 2] + "')\">ADD</button></td></tr>";
        }
        ris += "</table>";
        return ris;
    }
</script>
</body>
</html>