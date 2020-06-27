<%@ page import="it.pointPharma.generalClasses.REG" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.LinkedList" %>
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
            <div class="dataTxtObj"> <p>Prova1: </p> <p id="dataTxtObj1">45</p> </div>
            <div class="dataTxtObj"> <p>Prova2: </p> <p id="dataTxtObj2">54</p></div>
        </div>

        <%
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/PharmaPoint", "PharmaPointDBAccess", "PharmaPointDBAccess");
            try {
                Statement st = con.createStatement();
                String queryPharmacies = "SELECT distinct nome\n" +
                        "from farmacia order by nome asc;";
                ResultSet ris = st.executeQuery(queryPharmacies);

                LinkedList<String> pharmacies = new LinkedList<>();

                while(ris.next()){
                    pharmacies.add(ris.getString("nome"));
                }

            } catch (SQLException e) {
                throw new Exception("Error DB");
            }

        %>

        <script src="../JS/JQuery.js"></script>

        <script>
            function getChartNumberDrugsPharmacies(){
                $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: "getChartNumberDrugsPharmacies.do",
                        data: {

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
