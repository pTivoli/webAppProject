<%@ page import="it.pointPharma.generalClasses.REG" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Dashboard</title>
        <link rel="stylesheet" type="text/css" href="../CSS/REGDashboard.css"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <header>
            REG Dashboard
        </header>

        <div class="accordion">
            <div class="accordion-item">
                <div class="accordion-item-header" id="aic1">See All Pharmacies</div>
                <div class="accordion-item-body">
                    <div class="accordion-item-body-content">
                        <div class="dataTxtObj"> <p id="dataTxtObj1"></p> </div>
                    </div>
                </div>
            </div>

            <div class="accordion-item">
                <div class="accordion-item-header" id="aic2">See Total Sales from All Pharmacies</div>
                <div class="accordion-item-body">
                    <div class="accordion-item-body-content">
                        <div class="dataTxtObj"><p id="dataTxtObj2"></p></div>
                    </div>
                </div>
            </div>

            <div class="accordion-item">
                <div class="accordion-item-header" id="aic3">Most Sold Medicine</div>
                <div class="accordion-item-body">
                    <div class="accordion-item-body-content">
                        <div class="dataTxtObj"><p id="dataTxtObj3"></p></div>
                    </div>
                </div>
            </div>
        </div>

        <%
            REG reg = (REG)session.getAttribute("pharmacist");
            String regFName = reg.getfName();
            String regLName = reg.getlName();
            String regCF = reg.getCF();
            String regEmail = reg.getEmail();
            String regDoB = reg.getDOB();
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
            });

        </script>

        <script>
            function getTotalSalesPerPharmacy(){
                $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: "getTotalSalesPerPharmacy.do",
                        data: {
                            regFName: "<%= regFName%>",
                            regLName: "<%= regLName%>",
                            regCF: "<%= regCF%>",
                            regEmail: "<%= regEmail%>",
                            regDoB: "<%= regDoB%>",
                            stat: "getTotalSalesPerPharmacy"
                        },
                        success: function(responseText){
                            var str = responseText.split(";");
                            var i;
                            document.getElementById("dataTxtObj2").innerHTML += "<div id='getTotalSalesPerPharmacy'></div>";
                            for(i = 0; i < str.length - 2; i += 3){
                                document.getElementById("getTotalSalesPerPharmacy").innerHTML  += "<div class=\"dataTxtObj\"> <p>"+str[i]+"</p> <p>"+str[i + 1]+"</p> <p>" + str[i + 2] + "</p> </div>";
                            }
                        }
                    });
                });
            }
            function getPharmacyInfo(){
                $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: "getPharmacyInfo.do",
                        data: {
                            regFName: "<%= regFName%>",
                            regLName: "<%= regLName%>",
                            regCF: "<%= regCF%>",
                            regEmail: "<%= regEmail%>",
                            regDoB: "<%= regDoB%>",
                            stat: "getPharmacyInfo"
                        },
                        success: function(responseText){
                            var str = responseText.split(";");
                            var i;
                            document.getElementById("dataTxtObj1").innerHTML += "<div id='getPharmacyInfo'></div>";
                            for(i = 0; i < str.length - 3; i += 4){
                                document.getElementById("getPharmacyInfo").innerHTML  += "<div class=\"dataTxtObj\"> <p>" + str[i] + "</p> <p>" + str[i+1] + " " + str[i+2] +"</p> <p>" + str[i+3] + "</p></div>";
                            }
                        }
                    });
                });
            }
            function getMostSoldMeds(){
                $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: "getTotalSalesPerPharmacy.do",
                        data: {
                            regFName: "<%= regFName%>",
                            regLName: "<%= regLName%>",
                            regCF: "<%= regCF%>",
                            regEmail: "<%= regEmail%>",
                            regDoB: "<%= regDoB%>",
                            stat: "getMostSoldMeds"
                        },
                        success: function(responseText){
                            var str = responseText.split(";");
                            var i = 0;
                            document.getElementById("dataTxtObj3").innerHTML += "<div id='getMostSoldMeds'></div>";
                            document.getElementById("getMostSoldMeds").innerHTML  += "<div class=\"dataTxtObj\"> <p>"+str[i]+"</p> <p>"+str[i + 1]+"</p></div>";

                        }
                    });
                });
            }

            $(document).ready(function () {
                getPharmacyInfo();
                getTotalSalesPerPharmacy();
                getMostSoldMeds();
            });

        </script>

    </body>
</html>
