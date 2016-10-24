<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
</head>

<c:import url="templates/navbar.jsp"></c:import>
<body class=".container-fluid">
	<div class="container" style="width: 90%">
		<div class="sidebar">
			<ul id="nav">
				<li><a class="selected" href="index.html">Dashboard</a></li>
				<li><a href="ticketdemo.html">Tickets Details</a></li>
			</ul>
		</div>
		<div id="content">
			<div class="pie_content">
				
				<div id="ticket_details_pie" style="width: 500px; height: 300px">

				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript" src="https://www.google.com/jsapi"></script> 
<script>

   google.load("visualization", "1", {packages:["corechart"]});

   google.setOnLoadCallback(drawChart);

   function drawChart() {

    // Create and populate the data table.

    var data = google.visualization.arrayToDataTable([

      ['Tickts', 'Percent'],

      ['Open Tickets', 17.36],

      ['Closed Tickets', 15.62],

      ['Logged Tickets', 13.63],

      ['Escalated Tickets', 11.25]
     
    ]);

    var options = {

      title: 'Tickets overall'

    };

     // Create and draw the visualization.

    new google.visualization.PieChart(

      document.getElementById('ticket_details_pie')).draw(data, options);

  }

</script> 

<script type="text/javascript"
	src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js" />"></script>
<link
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
	
<link
	href="<c:url value="/resources/custom/css/pie_chart.css" />"
	rel="stylesheet" type="text/css" />

</html>