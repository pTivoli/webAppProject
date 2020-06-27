<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>
            REG
        </title>
    </head>
    <body>
        <h1>REG Page!</h1>
        <div id="registerPharmacyAndPharmacistManager">
            PHARMACIST MANAGER DATA<br><br>

            CF<br>
            <input id="cf" name="cf" type="text" required><br>
            First Name<br>
            <input id="fname"  name="fname" type="text" required><br>
            Last Name<br>
            <input id="lname"  name="lname" type="text" required><br>
            Date Of Birth<br>
            <input id="dob"  name="dob" type="date" required><br>
            Username<br>
            <input id="usr"  name="usr" type="text" required><br>
            Password<br>
            <input id="pwd"  name="pwd" type="password" required><br>
            Password confirmation<br>
            <input id="pwdCheck"  name="pwdCheck" type="password" required><br>

            PHARMACY DATA<br><br>

            Pharmacy Name<br>
            <input id="phname"  name="phname" type="text" required><br>
            Pharmacy Address<br>
            <input id="phaddr"  name="phaddr" type="text" required><br>
            Pharmacy Phone Number<br>
            <input id="phtel"  name="phtel" type="tel" required><br><br>

            <button onclick="registerPharmacyAndPharmacistManager()">REGISTER PHARMACY AND HIS PHARMACIST MANAGER</button>
        </div>

        <input type=button onClick="location.href='JSP/REGDashboard.jsp'" value='click here'>

        </div>
        <script src="JS/JQuery.js"></script>
        <script>
            function registerPharmacyAndPharmacistManager() {
                var cf = $("#cf").val();
                var fname = $("#fname").val();
                var lname = $("#lname").val();
                var dob = $("#dob").val();
                var usr = $("#usr").val();
                var pwd = $("#pwd").val();
                var pwdCheck = $("#pwdCheck").val();
                var phname = $("#phname").val();
                var phaddr = $("#phaddr").val();
                var phtel = $("#phtel").val();
                if(validateFormPharmacyAndPharmacistManager(cf, fname, lname, dob, usr, pwd, pwdCheck, phname, phaddr, phtel)) {
                    $(document).ready(function () {
                        $.ajax({
                            type: "POST",
                            url: "registerPharmacyAndPharmacistManager.do",
                            data: {
                                cf: $("#cf").val(),
                                fname: $("#fname").val(),
                                lname: $("#lname").val(),
                                dob: $("#dob").val(),
                                usr: $("#usr").val(),
                                pwd: $("#pwd").val(),
                                phname: $("#phname").val(),
                                phaddr: $("#phaddr").val(),
                                phtel: $("#phtel").val()
                            },
                            success: function () {
                                $('#cfP').val("");
                                $('#fnameP').val("");
                                $('#lnameP').val("");
                                $('#dobP').val("");
                                $("#usr").val("");
                                $("#pwd").val("");
                                $("#pwdCheck").val("");
                                $("#phname").val("");
                                $("#phaddr").val("");
                                $("#phtel").val("");
                                alert("A New Pharmacy has been created successfully!");
                            }
                        });
                    });
                }
            }
            function validateFormPharmacyAndPharmacistManager(cf, fname, lname, dob, usr, pwd, pwdCheck, phname, phaddr, phtel){
                var maskTel = /^[0-9]{10,11}$/;
                if(validatePharmacistData(cf, fname, lname, dob, usr, pwd, pwdCheck) == true) {
                    if(phname.length == 0){
                        alert("Pharmacy name is missed");
                        return false;
                    }else if(phaddr.length == 0){
                        alert("Pharmacy address is missed");
                        return false;
                    }else if(phtel.length == 0){
                        alert("Pharmacy phone number is missed");
                        return false;
                    }else if(!maskTel.test(phtel)){
                        alert("Pharmacy phone number is not valid");
                        return false;
                    }
                    return true;
                }else return false;
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
        </script>
    </body>
</html>