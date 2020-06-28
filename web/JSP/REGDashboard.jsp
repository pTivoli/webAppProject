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
            <div class="dataTxtObj"> <p>Prova1: </p> <p id="dataTxtObj1">--</p> </div>
            <div class="dataTxtObj"> <p>Prova2: </p> <p id="dataTxtObj2">--</p></div>
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

                        }
                    })
                })
            }


        </script>

    </body>
</html>
