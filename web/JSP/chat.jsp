<%@ page import="it.pointPharma.generalClasses.User" %>
<%@ page import="it.pointPharma.generalClasses.Pharmacy" %>
<%@ page import="it.pointPharma.generalClasses.Pharmacist" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Pharmacist user = (Pharmacist) session.getAttribute("pharmacist");
    String lname = user.getlName();
    String fname = user.getfName();
    String email = user.getEmail();
%>

<html>
<head>
    <title><%=lname + " " + fname + "'s chat"%></title>
    <link rel="stylesheet" href="../CSS/ChatStylesheet.css">
</head>
<body>
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
    <script src="../JS/JQuery.js"></script>
    <script>
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
                    url: "../messages.do",
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
                    url: "../messagesGroup.do",
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
                       url: "../receiverCheck.do" ,
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
        var j;
        for(j = 0; j < text.length-1; j++){
          ris += "<tr><td id=\"td" + j + "\">" + text[j] + "</td><td><button onclick=\"selectReceiver("+j+");\">Select</button></td></tr>";
        }
        ris += "</table>";
        return ris;
    }
    function selectReceiver(inv) {
            i = inv;
            $("#rec-Messages").html("");
            $("#TOP").html("Texting to: <b>" + $("#td"+i).text() + "</b>");
            if($("#td"+i).text().indexOf("@") < 0 && $("#td"+i).text() !== "REG")
                $("#receiverType").attr("value", 1);
            else
                $("#receiverType").attr("value", 0);
            if($("#receiverType").val() == 0) {
                $("#receiver").attr("value", $("#td"+i).text());
                $("#receivers").html("");
                readMessages();
            }
            else {
                $("#receivers").html("");
                readMessagesGroup();
            }
            $("#recMail").val("");
    }
    function readMessages() {
        var receiverMail = $("#Top b").html();
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: "../readMessages.do",
                data: {
                    receiver: receiverMail
                },
                success: function (result) {
                    $("#rec-Messages").html(createMessages(result))
                }

            });
        });
    }
    function readMessagesGroup(inv) {
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: "../readMessagesGroup.do",
                data: {
                    receiver: $("#td"+inv).text()
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
