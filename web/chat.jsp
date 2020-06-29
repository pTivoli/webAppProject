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
            <input type="text" name="receiver" id="recMail" autocomplete="off" onpaste="return false;" onkeyup="lfReceiver();">
            <div id="receivers">

            </div>
        </div>
        <div id="rigth-pane">
            <div id="TOP">

            </div>
            <div id="rec-Messages">

            </div>
            <div class="rigth-foot">
                <input id="receiverType" type="hidden" name="receiverType">
                <input id="receiver" type="hidden" name="receiver">
                <input id="message" type="text" name="message" placeholder="message" autocomplete="off" onpaste="return false;" required/>
                <button onclick="senF();">Send</button>
            </div>
        </div>
    </div>
    <script src="JS/JQuery.js"></script>
    <script >
        var i;
        function senF() {
            if($("#receiverType").val() == 0) {
                messages();
            }
            else if($("#receiverType").val() == 1) {
                messagesGroup();
            }
        }
        function messages() {
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "messages.do",
                    data: {
                        message:  $("#message").val(),
                        receiver: $("#receiver").val()
                    },
                    success: function () {
                        readMessages();
                    }
                });
            });
        }
        function messagesGroup() {
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "messagesGroup.do",
                    data: {
                        message:  $("#message").val()
                    },
                    success: function () {
                        readMessagesGroup();
                    }
                });
        });
        }
        function lfReceiver() {
            if($('#recMail').val().length > 0) {
                $(document).ready(function () {
                    $.ajax({
                       type: "POST",
                       url: "receiverCheck.do" ,
                        data: {
                           hint: $('#recMail').val()
                        },
                        success: function (responseText) {
                            $('#receivers').html(createTable(responseText))
                        }
                    });
                });
            }else {
                $('#receivers').html("");
            }
        }
    function createTable(text) {
        var ris = "<table>";
        text = text.split(";");
        var i;
        for(i = 0; i < text.length-1; i++){
          ris += "<tr><td id=\"td" + i + "\">" + text[i] + "</td><td><button onclick=\"selectReceiver("+i+");\">Select</button></td></tr>";
        }
        ris += "</table>";
        return ris;
    }
    function selectReceiver(inv) {
            i = inv;
            $("#rec-Messages").html("");
            $("#TOP").html("Texting to: " + $("#td"+i).text());
            if($("#td"+i).text().indexOf("@") > -1)
                $("#receiverType").attr("value", 0);
            else if($("#td"+i).text().indexOf("@") > 0)
                $("#receiverType").attr("value", 1);
            else
                $("#receiverType").attr("value", 0);
            alert($("#receiverType").attr("value"));
            if($("#receiverType").val() == 0) {
                $("#receiver").attr("value", $("#td"+i).text());
                $("#receivers").html("");
                readMessages();
            }
            else {
                $("#receivers").html("");
                readMessagesGroup();
            }
    }
    function readMessages() {
        var receiverMail = $("#td"+i).text();
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: "readMessages.do",
                data: {
                    receiver: receiverMail
                },
                success: function (result) {
                    $("#rec-Messages").html(createMessages(result))
                }

            });
        });
    }
    function readMessagesGroup() {
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: "readMessagesGroup.do",
                data: {
                    receiver: $("#td"+i).text()
                },
                success: function (result) {
                    $("#rec-Messages").html(createMessages(result))
                }
            });
        });
    }

    function createMessages(text) {
        var ris = "<table>";
        text = text.split(";");
        var i;
        for(i = 0; i < text.length-1; i+=2)
        {
            ris += "<tr><td>from: " + text[i] + "</td><td> text: " + text[i + 1] + "</td></tr>";
        }
        ris += "</table>";
        return ris;
    }
    </script>
</body>
</html>
