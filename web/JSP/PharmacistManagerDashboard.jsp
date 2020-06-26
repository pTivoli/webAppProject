<%@ page import="it.pointPharma.generalClasses.PharmacistManager" %>
<%@ page import="it.pointPharma.generalClasses.Pharmacy" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Dashboard</title>
        <link rel="stylesheet" href="../CSS/dashboards.css"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <header>
            Pharmacist Manager Dashboard
        </header>
        <div id="dataTxt">
            <div class="dataTxtObj"> <p>General Items Sold: </p> <p id="dataTxtObj1">--</p> </div>
            <div class="dataTxtObj"> <p>Number of Pieces Sold: </p> <p id="dataTxtObj2">--</p> </div>

        </div>
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
        <script src="../JS/JQuery.js"></script>
        <script>
            function getChartNumberDrugsPharmacies(){
                $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: "getChartNumberDrugsPharmacies.do",
                        data: {
                            phname: "<%= pharmName%>",
                            phaddr: "<%= pharmAddress%>",
                            phpm: "<%= pharmCFPM%>",
                            stat: "getChartNumberDrugsPharmacies"
                        },
                        success: function (responseText) {
                            var str = responseText.split(";");
                            var i;
                            for(i = 0; i < str.length - 1; i+=2){
                                var obj = document.getElementById("dataTxt").innerHTML;
                                document.getElementById("dataTxt").innerHTML= obj + "<div class=\"dataTxtObj\"> <p>"+str[i]+"</p> <p>"+str[i + 1]+"</p> </div>";
                            }
                        }
                    });
                });
            }
            function getChartPharmacies(){
                $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: "getChartPharmacies.do",
                        data: {
                            phname: "<%= pharmName%>",
                            phaddr: "<%= pharmAddress%>",
                            phpm: "<%= pharmCFPM%>",
                            stat: "getChartPharmacies"
                        },
                        success: function (responseText) {
                            var str = responseText.split(";");
                            var i;
                            for(i = 0; i < str.length - 1; i+=2){
                                var obj = document.getElementById("dataTxt").innerHTML;
                                document.getElementById("dataTxt").innerHTML= obj + "<div class=\"dataTxtObj\"> <p>"+str[i]+"</p> <p>"+str[i + 1]+"</p> </div>";
                            }
                        }
                    });
                });
            }
            function getChartPharmacists(){
                $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: "getChartPharmacists.do",
                        data: {
                            phname: "<%= pharmName%>",
                            phaddr: "<%= pharmAddress%>",
                            phpm: "<%= pharmCFPM%>",
                            stat: "getChartPharmacists"
                        },
                        success: function (responseText) {
                            var str = responseText.split(";");
                            var i;
                            for(i = 0; i < str.length-1; i+=2){
                                var obj = document.getElementById("dataTxt").innerHTML;
                                document.getElementById("dataTxt").innerHTML= obj + "<div class=\"dataTxtObj\"> <p>"+str[i+1]+" </p> <p>"+str[i]+"</p> </div>";
                            }
                        }
                    });
                });
            }
            function getDrugsMoreSold(){
                $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: "getDrugsMoreSold.do",
                        data: {
                            phname: "<%= pharmName%>",
                            phaddr: "<%= pharmAddress%>",
                            phpm: "<%= pharmCFPM%>",
                            stat: "getDrugsMoreSold"
                        },
                        success: function (responseText) {
                            var str = responseText.split(";");
                            var i;
                            for(i = 0; i < str.length-1; i+=2){
                                var obj = document.getElementById("dataTxt").innerHTML;
                                document.getElementById("dataTxt").innerHTML= obj + "<div class=\"dataTxtObj\"> <p>"+str[i+1]+": </p> <p>"+str[i]+"</p> </div>";
                            }
                        }
                    });
                });
            }
            function getGeneralNumberItems(){
                $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: "getGeneralNumberItems.do",
                        data: {
                            phname: "<%= pharmName%>",
                            phaddr: "<%= pharmAddress%>",
                            phpm: "<%= pharmCFPM%>",
                            stat: "getGeneralNumberItems"
                        },
                        success: function (responseText) {
                            $("#dataTxtObj1").html(responseText);
                        }
                    });
                });
            }
            function getPiecesSold(){
                $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: "getPiecesSold.do",
                        data: {
                            phname: "<%= pharmName%>",
                            phaddr: "<%= pharmAddress%>",
                            phpm: "<%= pharmCFPM%>",
                            stat: "getPiecesSold"
                        },
                        success: function (responseText) {
                            $("#dataTxtObj2").html(responseText);
                        }
                    });
                });
            }
            $(document).ready(function () {
                getGeneralNumberItems();
                getPiecesSold();
                getDrugsMoreSold();
                getChartPharmacists();
                getChartPharmacies();
                getChartNumberDrugsPharmacies();
            });
        </script>

    </body>
</html>
