<%@ page import="it.pointPharma.generalClasses.REG" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="it.pointPharma.generalClasses.Pharmacy" %>
<%@ page import="it.pointPharma.generalClasses.PharmacistManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Dashboard</title>
        <link rel="stylesheet" href="../CSS/dashboards.css"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <header>
            REG Dashboard
        </header>

        <div id="dataTxt">
            <div class="dataTxtObj"> <p>Pharmacies: </p><p id="dataTxtObj1"></p> </div>
            <div class="dataTxtObj"> <p>Sales: </p> <p id="dataTxtObj2"></p></div>
            <div class="dataTxtObj"> <p>Most Sold Medicine: </p> <p id="dataTxtObj3"></p></div>
            <div class="dataTxtObj"> <p>PlaceHolder: </p> <p id="dataTxtObj4"></p></div>
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
