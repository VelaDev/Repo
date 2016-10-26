<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Home</title>
</head>
<body>
	<div id="container">
		<div class="sidebar">
			<ul id="nav">
				<li><a class="selected" href="home.html">Dashboard</a></li>
				<li><a href="ticketDetails.html">Tickets Details</a></li>
			</ul>
		</div>
		<div class="content">
			<div class="container">
				<c:import url="templates/navbar.jsp"></c:import>
				<div class="pie_content">
					<div id="ticket_details_pie" style="width: 900px; height: 500px;"></div>
				</div>
			</div><!--/Container class-->
		</div><!--/Content-->
	</div><!-- Container id-->
</body>

<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script>

   google.load("visualization", "1", {packages:["corechart"]});

   google.setOnLoadCallback(drawChart);

   function drawChart() {

    // Create and populate the data table.

    var data = google.visualization.arrayToDataTable([

      ['Tickts', 'Percent'],
      
       <c:forEach items="${ticketResults}" var="pie">
		[ '${pie.status}', ${pie.numberTicket}],
	  </c:forEach> 
     
    ]);

    var options = {

      title: 'Tickets overall',
      is3D: true,
     

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

<link href="<c:url value="/resources/custom/css/vela_custom.css" />"
	rel="stylesheet" type="text/css" />
	<link href="<c:url value="/resources/custom/css/homenav.css" />"
	rel="stylesheet" type="text/css" />

</html>