<%@ page import="it.pointPharma.generalClasses.*" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Pharmacist user = (Pharmacist) session.getAttribute("pharmacist");
    String lname = user.getlName();
    String fname = user.getfName();
    String email = user.getEmail();
    Pharmacy pharmacy = (Pharmacy) session.getAttribute("pharmacy");
    String phName = pharmacy.getName();
    String role = "";
    if(user instanceof PharmacistManager)
        role = "PD";
    if(user instanceof REG) {
        role = "REG";
    }
%>

<html>
<head>
    <title><%=fname + " " + lname + "'s chat"%></title>
    <link rel="stylesheet" href="../CSS/ChatStylesheet.css">
</head>
<body>
    <div>
        <div id="header">
            <p>Welcome <%= fname + " " + lname %></p>
        </div>
        <div id="container">
            <div class="left-pane" >
                <input type="text" name="receiver" id="recMail" placeholder="Search" autocomplete="off" onpaste="return false;" onkeyup="lfReceiver();">
                <div id="receivers">

                </div>
            </div>
            <div id="right-pane">
                <div id="TOP">

                </div>
                <div id="rec-Messages">

                </div>
                <div class="right-foot">
                    <input id="receiverType" type="hidden" name="receiverType">
                    <input id="mitType" type="hidden" value='<%=role%>'>
                    <input id="pharmacy" type="hidden" name="pharmacy" value="<%=phName%>">
                    <input id="receiver" type="hidden" name="receiver">
                    <input id="message" type="text" name="message" placeholder="Write a message here..." autocomplete="off" onpaste="return false;" required/>
                    <button id="send" onclick="senF();" disabled>Send</button>
                </div>
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
                        $('#message').val("");
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
                        $('#message').val("");
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
          ris += "<tr><td id=\"td" + j + "\">" + text[j] + "</td><td><button onclick=\"selectReceiver("+j+");\">"+text[j]+"</button></td></tr>";
        }
        ris += "</table>";
        return ris;
    }
    function selectReceiver(inv) {
            i = inv;
            $("#TOP").css("display", "block");
            $(".right-foot").css("display", "block");
            $("#send").prop("disabled", false);
            $("#rec-Messages").html("");
            $("#TOP").html("<b>" + $("#td"+i).text() + "</b>");
            if($("#TOP b").html().indexOf("@") < 0 && $("#td"+i).text() !== "REG" && $("#mitType").val() !== "REG" || $("#td"+i).text() === "PM")
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
                if($("#TOP b").html() === $("#pharmacy").val() && ($("#mitType").val() !== "PD" && $("#mitType").val() !== "REG"))
                   $("#send").prop("disabled", true);
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
                    $("#rec-Messages").html(createMessages(result));
                    $("#textMessagesBox").animate({
                        scrollTop: $(".message:last-of-type").offset().top
                    }, 1000);
                }

            });
        });
    }
    function readMessagesGroup() {
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: "../readMessagesGroup.do",
                data: {
                    receiver: $("#TOP b").html()
                },
                success: function (result) {
                    $("#rec-Messages").html(createMessages(result));
                    $("#textMessagesBox").animate({
                        scrollTop: $(".message:last-of-type").offset().top
                    }, 1000);
                }
            });
        });
    }

    function createMessages(text) {
        var ris = '<div id="textMessagesBox">';
        text = text.split(";");
        var i;
        for(i = 0; i < text.length-1; i+=2)
        {
            //ris += "<tr><td>" + text[i] + "</td><td>" + text[i + 1] + "</td></tr>";
            //ris += text[i] + "<br>" + text[i+1];
            ris += "<div class='message'><p>" + text[i] + "</p><p>" + text[i + 1] + "</p></div><br>";
        }
        ris += '</div>';
        return ris;
    }
    $('#message').keypress(function(event){
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if(keycode == '13'){
            if($('#message').val.length != "") {
                senF();
            }
        }
    });
    </script>
</body>
</html>
