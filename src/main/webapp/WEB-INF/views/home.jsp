<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <title>Home | Velaphanda Trading & Projects</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">  
</head>
<body>
	<div class="velaphanda_containter">	
		<c:import url="templates/navbar.jsp"></c:import>
		<div class="container">
		<br/>
			<div class="panel panel-success">    
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="left"><b>Tickets</b> </div>
					</h3>
				</div>
				<div class="panel-body">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#home" data-toggle="tab">Ticket
								Overall</a></li>
						<li><a href="#ticketDetails" data-toggle="tab">Ticket
								Details</a></li>
					</ul>
					<div class="tab-content">
					
						<!--home tab-->
						<div class="tab-pane active" id="home">
							<div class="panel panel-success">
								<div class="panel-heading">
									<h3 class="panel-title">
										<div align="center">
											<b>Tickets Overall</b>
										</div>
									</h3>
								</div>
								<div class="panel-body">
									<!-- <div class="col-lg-10"> -->
									<div class="panel-body">
										<div class="pie_content">
											<div id="ticket_details_pie"  align='center'></div>
										</div>
									</div>
								</div><!-- /panel body -->
							</div><!-- /panel panel-success -->
						</div><!-- /home tab-->
						
						<!--Tickets Details tab-->
						<div class="tab-pane" id="ticketDetails">
							
							<div class="panel panel-success">
								<div class="panel-heading">
									<h3 class="panel-title">
										<div align="center">
											<b>Tickets List</b>
										</div>
									</h3>
								</div>
								<div class="panel-body">
									<!-- <div class="col-lg-10"> -->
									<div class="panel-body">
									<%-- 	<table class="table table-striped custab">
												<thead style="background-color: #bce8f1;">
													<tr>
														<th>Ticket No</th>
														<th>Description</th>
														<!-- <th>Date</th> -->
														<th>Status</th>
														<th>Technician</th>
														<th>Edit</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${ticketList}" var="ticket">
														<tr>
															<th><c:out value="${ticket.ticketNumber}" /></th>
															<th><c:out value="${ticket.description}" /></th>
															<th><c:out value="${ticket.dateTime}"/></th>
															<th><c:out value="${ticket.status}" /></th>
															<th><c:out value="${ticket.employee.getUsername()}" /></th>
															<th><a href="editEmployee?id=<c:out value='${emp.id}'/>">Edit</a></th>
														</tr>
													</c:forEach>
												</tbody>
										</table> --%>
									</div>
								</div><!-- /panel body -->
							</div><!-- /panel panel-success -->
							
						</div><!-- Ticket Detials -->
						
					</div><!-- /tab-content -->
									
				</div><!-- /panel body -->
			</div><!--/panel success class-->
		</div><!-- /Container -->
		<!-- Footer -->
		<c:import url="templates/footer.jsp"></c:import>
		<!--/ Footer -->
	</div><!-- / velaphanda_containter -->

	
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

    // Set chart options
		var options = {
			'title' : 'Ticket Overall',
			 is3D : true,
			//pieSliceText: 'label',
			tooltip :  {showColorCode: true},
			'width' : 700,
			'height' : 400
		};

     // Create and draw the visualization.

    new google.visualization.PieChart(

      document.getElementById('ticket_details_pie')).draw(data, options);

  }

</script> 

</body>
</html>
