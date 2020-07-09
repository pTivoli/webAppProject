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
        <div id="formReceipt">
            Codice Ricetta<br>
            <input type="text" id="codRec"/><br>
            Data Ricetta<br>
            <input type="date" id="dateRec"/><br>
            Codice Medico<br>
            <input type="text" id="codDocRec"/><br>
            CF<br>
            <input type="text" id="cfRec"><br>
        </div>
        <p><button onclick="buyFn();" disabled class="buyBTN">BUY</button></p><br/>
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
        Pharmacist Doctor<br>
        <input type="radio" id="pharmacistDoctor" name="role" value="PD"><br>
        Desk Operator<br>
        <input type="radio" id="deskOperator" name="role" value="DO" checked><br>
        <button onclick="registerPharmacist()">REGISTER</button><br>
    </div>
    <a href="JSP/PharmacistManagerDashboard.jsp" id="dashboardButton">D<br>A<br>S<br>H<br>B<br>O<br>A<br>R<br>D<br></a>
    <a href="JSP/chat.jsp" id="openChat3">C<br>H<br>A<br>T<br></a>
    <a href="JSP/OrderMedicines.jsp" id="openMedicine">M<br>E<br>D<br>I<br>C<br>I<br>N<br>E<br>S<br></a>
</div>
<script src="JS/JQuery.js"></script>
<script>
    var receipt = false;
    var totPriceMed;
    $(document).ready(function () {
        if(document.cookie != ""){
            document.cookie = "medicine=; expires=Thu, 01 Jan 1970 00:00:00 UTC;";
        }
        totPriceMed = 0;
    });
    function cookieCart(codeMed, nameMed, receiptMedicine, priceMed){
        totPriceMed += priceMed;
        $("#cart button").html("BUY - " + totPriceMed + "€");
        var obj = document.getElementById("objects").innerHTML;
        document.getElementById("objects").innerHTML= "<p>"+nameMed+"</p><br>" + obj;
        if(receiptMedicine == 't'){
            receipt = true;
            $("#formReceipt").css("display", "block");
            $("#formReceipt").css("height", "50%");
        }
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
            if(receipt){
                var codRec = $("#codRec").val();
                var dateRec = $("#dateRec").val();
                var codDocRec = $("#codDocRec").val();
                var cfRec = $("#cfRec").val();
                if(codRec == "" || dateRec == "" || codDocRec == "" || cfRec == ""){
                    alert("You must insert the data of the receipt before buying everything!");
                    return;
                }
                var mask = /^[A-Z]{6}[0-9]{2}[A-Z]{1}[0-9]{2}[A-Z]{1}[0-9]{3}[A-Z]{1}$/i;
                if(!mask.test(cfRec)){
                    alert("CF is not valid");
                    return;
                }
            }
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "buyMedicines.do",
                    data: {
                        medicine: document.cookie,
                        codRec: $("#codRec").val(),
                        dateRec: $("#dateRec").val(),
                        codDocRec: $("#codDocRec").val(),
                        cfRec: $("#cfRec").val()
                    },
                    success: function (responseText) {
                        if(responseText != "") {
                            alert(responseText);
                        }
                        else {
                            alert("All the medicines are bought!");
                            document.cookie = "medicine=; expires=Thu, 01 Jan 1970 00:00:00 UTC;";
                            $('#suggestions').html("");
                            $('#medicine').val("");
                            $("#cart button").html("BUY");
                            document.getElementById("objects").innerHTML = "";
                            document.getElementById("codRec").innerHTML = "";
                            document.getElementById("dateRec").innerHTML = "";
                            document.getElementById("codDocRec").innerHTML = "";
                            document.getElementById("cfRec").innerHTML = "";
                            $("#formReceipt").css("height", "0px");
                            $("#formReceipt").css("display", "none");
                            totPriceMed = 0.0;
                            receipt = false;
                        }
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
                    success: function (responseText) {
                        if(responseText != ""){
                            alert(responseText);
                        }else {
                            $('#cf').val("");
                            $('#fname').val("");
                            $('#lname').val("");
                            $('#dob').val("");
                            alert("User saved!");
                        }
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
        var mask = /^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/;
        var mask2 = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
        if(validateFormUser(cf, fname, lname, dob) == true) {
            if(usr.length == 0){
                alert("Email is missed");
                return false;
            }else if(!mask.test(usr)){
                alert("Email format not valid");
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
        var usr = $("#usr").val();
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
                        role: $("input[name=role]:checked").val()
                    },
                    success: function (responseText) {
                        if(responseText != ""){
                            alert(responseText);
                        }else {
                            $('#cfP').val("");
                            $('#fnameP').val("");
                            $('#lnameP').val("");
                            $('#dobP').val("");
                            $("#usr").val("");
                            $("#pwd").val("");
                            $("#pwdCheck").val("");
                            alert("A new pharmacist has been created successfully!");
                        }
                    }
                });
            });
        }
    }
    function createTable(text){
        var ris = "<table>";
        text = text.split(";");
        var i;
        ris += "<tr><td>Code</td><td>Name</td><td>Price</td><td><button>Chart</button></td></tr>";
        for(i = 0; i < text.length-1; i+=4){
            ris += "<tr><td>" + text[i] + "</td><td>" + text[i + 1] + "</td><td>" + text[i + 2] + "</td><td><button onclick=\"cookieCart('" + text[i] + "','" + text[i + 1] + "','" + text[i + 3] + "', "+text[i+2]+")\">ADD</button></td></tr>";
        }
        ris += "</table>";
        return ris;
    }
</script>
</body>
</html>