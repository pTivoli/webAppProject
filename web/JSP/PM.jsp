<%@ page import="it.pointPharma.generalClasses.Pharmacy" %>
<%@ page import="it.pointPharma.generalClasses.PharmacistManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>PharmaPoint - Desk Operator</title>
    <link rel="stylesheet" href="CSS/Stylesheet.css"/>
    <link rel="stylesheet" href="CSS/PharmacistsPages.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<%
    PharmacistManager deskOp = (PharmacistManager)session.getAttribute("pharmacist");
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
    <div id="registerUser">
        CF<br>
        <input id="cf" name="cf" type="text" required><br>
        First Name<br>
        <input id="fname"  name="fname" type="text" required><br>
        Last Name<br>
        <input id="lname"  name="lname" type="text" required><br>
        Date Of Birth<br>
        <input id="dob"  name="dob" type="date" required><br>
        <button onclick="registerUser()">ADD USER</button>
    </div>
    <div id="employee_PD_DO">
        CF<br>
        <input id="cfP" name="cfP" type="text" required><br>
        First Name<br>
        <input id="fnameP"  name="fnameP" type="text" required><br>
        Last Name<br>
        <input id="lnameP"  name="lnameP" type="text" required><br>
        Date Of Birth<br>
        <input id="dobP"  name="dobP" type="date" required><br>
        Username<br>
        <input id="usr"  name="usr" type="text" required><br>
        Password<br>
        <input id="pwd"  name="pwd" type="password" required><br>
        Password confirmation<br>
        <input id="pwdCheck"  name="pwdCheck" type="password" required><br>
        Pharmacist Doctor
        <input type="radio" id="pharmacistDoctor" name="role" value="PD">
        Desk Operator
        <input type="radio" id="deskOperator" name="role" value="DO" checked>
        <button onclick="registerPharmacist()">REGISTER</button>
    </div>
</div>
<script src="JS/JQuery.js"></script>
<script>
    function cookieCart(codeMed, nameMed){
        var obj = document.getElementById("objects").innerHTML;
        document.getElementById("objects").innerHTML= obj + "<p>"+nameMed+"</p><br>";
        if(document.cookie == ""){
            $("#cart button").prop("disabled", false);
            document.cookie = "medicine=" + codeMed + "," + nameMed + ",";
        }else{
            document.cookie += codeMed + "," + nameMed + ",";
        }
    }
    function ajaxCall(){
        if($('#medicine').val().length > 0) {
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "checkOutMedicines.do",
                    data: {
                        hint: $('#medicine').val()
                    },
                    success: function (responseText) {
                        //$('#suggestions').text(responseText);
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
                    url: "buyMedicines.do",
                    data: {
                        medicine: document.cookie
                    },
                    success: function () {
                        alert("All the medicines are bought!");
                        document.cookie = "medicine=; expires=Thu, 01 Jan 1970 00:00:00 UTC;";
                        $('#suggestions').html("");
                        $('#medicine').val("");
                        document.getElementById("objects").innerHTML = "";
                    }
                });
            });
        }
    }
    function registerUser(){
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: "registerUser.do",
                data: {
                    cf:     $("#cf").val(),
                    fname:  $("#fname").val(),
                    lname:  $("#lname").val(),
                    dob:    $("#dob").val()
                },
                success: function () {
                    alert("User saved!");
                }
            });
        });
    }
    function registerPharmacist() {
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: "registerPharmacist.do",
                data: {
                    cf:     $("#cfP").val(),
                    fname:  $("#fnameP").val(),
                    lname:  $("#lnameP").val(),
                    dob:    $("#dobP").val(),
                    usr:    $("#usr").val(),
                    pwd:    $("#pwd").val(),
                    role:   $('input[name="role"]:checked').val()
                },
                success: function () {
                    alert("A New Pharmacist has been created successfully!");
                }
            });
        });
    }
    function createTable(text){
        var ris = "<table>";
        text = text.split(";");
        var i;
        for(i = 0; i < text.length-1; i+=2){
            ris += "<tr><td>" + text[i] + "</td><td>" + text[i + 1] + "</td><td><button onclick=\"cookieCart('" + text[i] + "','" + text[i + 1] + "')\">ADD</button></td></tr>";
        }
        ris += "</table>";
        return ris;
    }
</script>
</body>
</html>