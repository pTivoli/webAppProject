<%@ page import="it.pointPharma.generalClasses.User" %>
<%@ page import="it.pointPharma.generalClasses.Pharmacy" %>
<%@ page import="it.pointPharma.generalClasses.Pharmacist" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chat</title>
    <link rel="stylesheet" href="CSS/Stylesheet.css">
</head>
<body>
<%
    Pharmacist user = (Pharmacist) session.getAttribute("pharmacist");
    String lname = user.getlName();
    String fname = user.getfName();
    String email = user.getEmail();
%>
    <div>
        <p>Welcome <%= lname + " " + fname + " " + " " + email + "\n"%></p>
        <div class="left-pane" >
            <!--
                ajax load chat
            -->
        </div>
        <div class="rigth-pane">
            <div class="TOP">

            </div>
            <div id="rec-Messages">

            </div>
            <div class="rigth-foot">
                <input id="receiver" type="hidden" name="receiver" value="matteo.strawberry@gmail.com">
                <input id="message" type="text" name="message" placeholder="" required/>
                <button onclick="senF();">Send</button>
            </div>
        </div>
    </div>
    <script src="JS/JQuery.js"></script>
    <script >
        function senF() {
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "messages.do",
                    data: {
                        message:  $("#message").val(),
                        receiver: $("#receiver").val()
                    },
                    success: function () {
                        alert("Message sent");
                    }
                });
            });
        }
    </script>
</body>
</html>
