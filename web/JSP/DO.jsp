<%@ page import="it.pointPharma.generalClasses.DeskOperator" %>
<%@ page import="it.pointPharma.generalClasses.Pharmacy" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>PharmaPoint - Desk Operator</title>
        <link rel="stylesheet" href="CSS/Stylesheet.css"/>
        <link rel="stylesheet" href="CSS/PharmacistsPages.css">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300&display=swap" rel="stylesheet">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <%
            DeskOperator deskOp = (DeskOperator)request.getAttribute("pharmacist");
            String fname = deskOp.getfName();
            String lname = deskOp.getlName();
            String cf = deskOp.getCF();
            String email = deskOp.getEmail();

            Pharmacy pharm = (Pharmacy)request.getAttribute("pharmacy");
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
                <p><button onclick="">BUY</button></p><br/>
                <div id="objects"></div>
            </div>
        </div>
        <script
                src="https://code.jquery.com/jquery-3.5.1.js"
                integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
                crossorigin="anonymous"></script> <!-- SCARICATE IL CODICE PER FAVORE -->
        <script>
            function cookieCart(codeMed, nameMed){
                var obj = document.getElementById("objects").innerHTML;
                document.getElementById("objects").innerHTML= obj + "<p>"+nameMed+"</p><br>";
                if(document.cookie == ""){
                    document.cookie = "medicine=" + codeMed + "," + nameMed + ",";
                }else{
                    document.cookie += codeMed + "," + nameMed + ",";
                }
            }
            function ajaxCall(){
                if($('#medicine').val().length > 0) {
                    $("#mainContent form input[type=submit]").prop("disabled", false);
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
                    $("#mainContent form input[type=submit]").prop("disabled", true);
                    $('#suggestions').html("");
                }
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