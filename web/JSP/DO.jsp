<%@ page import="it.pointPharma.generalClasses.DeskOperator" %>
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
            <form>
                <input id="medicine" onkeyup="ajaxCall();" type="text" placeholder="Medicine">
                <input type="submit" value="ADD">
            </form>
            <div id="suggestions">
                PRINT:
            </div>
        </div>
        <script
                src="https://code.jquery.com/jquery-3.5.1.js"
                integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
                crossorigin="anonymous"></script> <!-- SCARICATE IL CODICE PER FAVORE -->
        <script>
            function ajaxCall(){
                $(document).ready(function() {
                    $.ajax({
                        type: "POST",
                        url: "checkOutMedicines.do",
                        data : {
                            hint : $('#medicine').val()
                        },
                        success : function(responseText) {
                            //$('#suggestions').text(responseText);
                            $('#suggestions').html(createTable(responseText));
                        }
                    });
                });
            }
            function createTable(text){
                var ris = "<table>";
                text = text.split(";");
                for(var i = 0; i < text.length; i+=2){
                    ris += "<tr><td>" + text[i] + "</td><td>" + text[i + 1] + "</td></tr>";
                }
                ris += "</table>";
                return ris;
            }
        </script>
    </body>
</html>