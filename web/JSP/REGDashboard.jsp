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
        <div class="charts">
            <div id="chartsObj1" class="chartsObj">

            </div>
            <div id="chartsObj2" class="chartsObj">

            </div>
            <div id="chartsObj3" class="chartsObj">

            </div>
            <div id="chartsObj4" class="chartsObj">

            </div>
        </div>
        <div id="dataTxt">
            <div class="dataTxtObj"> <p>Prova: </p> <p id="dataTxtObj1">45</p> </div>
            <div class="dataTxtObj"> <p>Prova: </p> <p id="dataTxtObj2">54</p></div>
        </div>

        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script>
            // Load the Visualization API and the corechart package.
            google.charts.load('current', {'packages':['corechart']});

            // Set a callback to run when the Google Visualization API is loaded.
            google.charts.setOnLoadCallback(drawChart);

            // Callback that creates and populates a data table,
            // instantiates the pie chart, passes in the data and
            // draws it.
            function drawChart() {

                // Create the data table.
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'Topping');
                data.addColumn('number', 'Slices');
                data.addRows([
                    ['Mushrooms', 3],
                    ['Onions', 1],
                    ['Olives', 1],
                    ['Zucchini', 1],
                    ['Pepperoni', 2]
                ]);

                // Set chart options
                var options = {'title':'How Much Pizza I Ate Last Night',
                    //'width':400,
                    //'height':300
                    };

                // Instantiate and draw our chart, passing in some options.
                var chart1 = new google.visualization.PieChart(document.getElementById('chartsObj1'));
                var chart2 = new google.visualization.PieChart(document.getElementById('chartsObj2'));
                var chart3 = new google.visualization.PieChart(document.getElementById('chartsObj3'));
                var chart4 = new google.visualization.PieChart(document.getElementById('chartsObj4'));
                chart1.draw(data, options);
                chart2.draw(data, options);
                chart3.draw(data, options);
                chart4.draw(data, options);
            }
        </script>
    </body>
</html>
