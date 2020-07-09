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
        <div class="accordion">

            <!--general Items-->
            <div class="accordion-item">
                <div class="accordion-item-header" id="aic1">
                    <a href="#aic1">General Items Sold</a>
                </div>
                <div class="accordion-item-body">
                    <div class="accordion-item-body-content">
                        <div class="dataTxtObj"> <p id="dataTxtObj1">--</p> </div>
                    </div>
                </div>
            </div>

            <!--number of pieces sold-->
            <div class="accordion-item">
                <div class="accordion-item-header" id="aic2">
                    <a href="#aic2">Number of Pieces Sold</a>
                </div>
                <div class="accordion-item-body">
                    <div class="accordion-item-body-content">
                        <div class="dataTxtObj"> <p id="dataTxtObj2">--</p> </div>
                    </div>
                </div>
            </div>

            <!--more drugs sold-->
            <div class="accordion-item">
                <div class="accordion-item-header" id="aic3">
                    <a href="#aic3">Most Sold Drug</a>
                </div>
                <div class="accordion-item-body">
                    <div class="accordion-item-body-content">
                        <div class="dataTxtObj"> <p id="dataTxtObj3"></p> </div>
                    </div>
                </div>
            </div>

            <!--get chart pharmacists-->
            <div class="accordion-item">
                <div class="accordion-item-header" id="aic4">
                    <a href="#aic4">See Chart Best Sellers</a>
                </div>
                <div class="accordion-item-body">
                    <div class="accordion-item-body-content">
                        <div class="dataTxtObj"> <p id="dataTxtObj4"></p> </div>
                    </div>
                </div>
            </div>

            <!--get chart pharmacies-->
            <div class="accordion-item">
                <div class="accordion-item-header" id="aic5">
                    <a href="#aic5">See your competition</a>
                </div>
                <div class="accordion-item-body">
                    <div class="accordion-item-body-content">
                        <div class="dataTxtObj"> <p id="dataTxtObj5"></p> </div>
                    </div>
                </div>
            </div>

            <!--get chart number drug pharmacies-->
            <div class="accordion-item">
                <div class="accordion-item-header" id="aic6">
                    <a href="#aic6">Number of medicines sold per pharmacy</a>
                </div>
                <div class="accordion-item-body">
                    <div class="accordion-item-body-content">
                        <div class="dataTxtObj"> <p id="dataTxtObj6"></p> </div>
                    </div>
                </div>
            </div>

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

            $(function(){
                $('#aic1').on('click', function(){
                    $('#aic1').toggleClass("active");
                });

                $('#aic2').on('click', function(){
                    $('#aic2').toggleClass("active");
                });

                $('#aic3').on('click', function(){
                    $('#aic3').toggleClass("active");
                });
                $('#aic4').on('click', function(){
                    $('#aic4').toggleClass("active");
                });
                $('#aic5').on('click', function(){
                    $('#aic5').toggleClass("active");
                });
                $('#aic6').on('click', function(){
                    $('#aic6').toggleClass("active");
                });
            });

        </script>

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
                            document.getElementById("dataTxtObj6").innerHTML += "<div id='getChartNumberDrugsPharmacies'></div>";
                            document.getElementById("getChartNumberDrugsPharmacies").innerHTML += "<div class=\"dataTxtObj\"> <p>Pharmacy</p> <p>Number</p> </div>";
                            for(i = 0; i < str.length - 1; i+=2){
                                document.getElementById("getChartNumberDrugsPharmacies").innerHTML += "<div class=\"dataTxtObj\"> <p>"+str[i]+"</p> <p>"+str[i + 1]+"</p> </div>";
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
                            document.getElementById("dataTxtObj5").innerHTML += "<div id='getChartPharmacies'></div>";
                            document.getElementById("getChartPharmacies").innerHTML += "<div class=\"dataTxtObj\"> <p>Pharmacy</p> <p>Amount</p> </div>";
                            for(i = 0; i < str.length - 1; i+=2){
                                document.getElementById("getChartPharmacies").innerHTML += "<div class=\"dataTxtObj\"> <p>"+str[i]+"</p> <p>"+str[i + 1]+"</p> </div>";
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
                            document.getElementById("dataTxtObj4").innerHTML += "<div id='getChartPharmacists'></div>";
                            document.getElementById("getChartPharmacists").innerHTML += "<div class=\"dataTxtObj\"> <p>Last Name</p> <p>First Name</p> </div>";
                            for(i = 0; i < str.length-1; i+=2){
                                document.getElementById("getChartPharmacists").innerHTML += "<div class=\"dataTxtObj\"> <p>"+str[i+1]+" </p> <p>"+str[i]+"</p> </div>";
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
                            document.getElementById("dataTxtObj3").innerHTML += "<div id='getDrugsMoreSold'></div>";
                            document.getElementById("getDrugsMoreSold").innerHTML += "<div class=\"dataTxtObj\"> <p>Name</p> <p>Quantity</p> </div>";
                            for(i = 0; i < str.length-1; i+=2){
                                document.getElementById("getDrugsMoreSold").innerHTML += "<div class=\"dataTxtObj\"> <p>"+str[i+1]+"</p> <p>"+str[i]+"</p> </div>";
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
