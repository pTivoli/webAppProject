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
        <div>
            <button onclick="window.location='chat.jsp'">Chat</button>
        </div>
        <script src="JS/JQuery.js"></script>
        <script>
            function registerPharmacyAndPharmacistManager() {
                $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: "registerPharmacyAndPharmacistManager.do",
                        data: {
                            cf:     $("#cf").val(),
                            fname:  $("#fname").val(),
                            lname:  $("#lname").val(),
                            dob:    $("#dob").val(),
                            usr:    $("#usr").val(),
                            pwd:    $("#pwd").val(),
                            phname: $("#phname").val(),
                            phaddr: $("#phaddr").val(),
                            phtel:  $("#phtel").val()
                        },
                        success: function () {
                            alert("A New Pharmacy has been created successfully!");
                        }
                    });
                });
            }
        </script>
    </body>
</html>