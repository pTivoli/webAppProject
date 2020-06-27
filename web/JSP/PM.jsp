<%@ page import="it.pointPharma.generalClasses.Pharmacy" %>
<%@ page import="it.pointPharma.generalClasses.PharmacistManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>PharmaPoint - Pharmacist Manager</title>
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
    <a href="JSP/PharmacistManagerDashboard.jsp">MIAO</a>
</div>
<script src="JS/JQuery.js"></script>
<script>
    var receipt = false;
    function cookieCart(codeMed, nameMed, receiptMedicine){
        var obj = document.getElementById("objects").innerHTML;
        document.getElementById("objects").innerHTML= obj + "<p>"+nameMed+"</p><br>";
        if(receiptMedicine == 't') receipt = true;
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
        var cf = $("#cf").val();
        var fname = $("#fname").val();
        var lname = $("#lname").val();
        var dob = $("#dob").val();
        if(validateFormUser(cf, fname, lname, dob) == true) {
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "registerUser.do",
                    data: {
                        cf: $("#cf").val(),
                        fname: $("#fname").val(),
                        lname: $("#lname").val(),
                        dob: $("#dob").val()
                    },
                    success: function () {
                        $('#cf').val("");
                        $('#fname').val("");
                        $('#lname').val("");
                        $('#dob').val("");
                        alert("User saved!");
                    }
                });
            });
        }
    }
    function validateFormUser(cf, fname, lname, dob){
        var mask = /^[A-Z]{6}[0-9]{2}[A-Z]{1}[0-9]{2}[A-Z]{1}[0-9]{3}[A-Z]{1}$/i;
        if(cf.length == 0) {
            alert("CF is missed");
            return false;
        }else if(fname.length == 0){
            alert("First Name is missed");
            return false;
        }else if(lname.length == 0){
            alert("Last Name is missed");
            return false;
        }else if(dob.length == 0){
            alert("Date Of Birth is missed");
            return false;
        }else if(!mask.test(cf)){
            alert("CF is not valid");
            return false;
        }
        return true;
    }
    function validatePharmacistData(cf, fname, lname, dob, usr, pwd, pwdCheck){
        var mask2 = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
        if(validateFormUser(cf, fname, lname, dob) == true) {
            if(usr.length == 0){
                alert("Email is missed");
                return false;
            }else if(pwd.length == 0){
                alert("Password is missed");
                return false;
            }else if(pwd != pwdCheck){
                alert("Passwords are different");
                return false;
            }else if(!mask2.test(pwd)){
                alert("Passwords should contain minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character");
                return false;
            }
            return true;
        }else
            return false;
    }
    function registerPharmacist() {
        var cf = $("#cfP").val();
        var fname = $("#fnameP").val();
        var lname = $("#lnameP").val();
        var dob = $("#dobP").val();
        var usr = $("#dobP").val();
        var pwd = $("#pwd").val();
        var pwdCheck = $("#pwdCheck").val();
        if(validatePharmacistData(cf, fname, lname, dob, usr, pwd, pwdCheck) == true) {
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "registerPharmacist.do",
                    data: {
                        cf: $("#cfP").val(),
                        fname: $("#fnameP").val(),
                        lname: $("#lnameP").val(),
                        dob: $("#dobP").val(),
                        usr: $("#usr").val(),
                        pwd: $("#pwd").val(),
                        role: $('input[name="role"]:checked').val()
                    },
                    success: function () {
                        $('#cfP').val("");
                        $('#fnameP').val("");
                        $('#lnameP').val("");
                        $('#dobP').val("");
                        $("#usr").val("");
                        $("#pwd").val("");
                        $("#pwdCheck").val("");
                        alert("A New Pharmacist has been created successfully!");
                    }
                });
            });
        }
    }
    function createTable(text){
        var ris = "<table>";
        text = text.split(";");
        var i;
        for(i = 0; i < text.length-1; i+=3){
            ris += "<tr><td>" + text[i] + "</td><td>" + text[i + 1] + "</td><td><button onclick=\"cookieCart('" + text[i] + "','" + text[i + 1] + "','" + text[i + 2] + "')\">ADD</button></td></tr>";
        }
        ris += "</table>";
        return ris;
    }
</script>
</body>
</html>