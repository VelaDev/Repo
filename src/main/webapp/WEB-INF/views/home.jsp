<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Home | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/custom/css/vela_custom.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/fonts/font-awesome.min.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" />

<!-- Little Dash-board -->
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/ticketoverview.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/common-9a01e5a5a5a2f97d04552fa65cc3846b.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/sprites-b23bb97cb281c684a70d957ed91664df.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/app-310c175202e0f34694cea021357db448.css" />" />
<!-- //Little Dash-board -->

<!-- Data table -->
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">
<!-- //Data table -->
</head>

<body>
	<div class="velaphanda_containter" id="velaphanda_containter">
		<c:import url="templates/navbar.jsp"></c:import>
		<div class="container">

			<div class="panel panel-success">

				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Tickets</b>
						</div>
					</h3>
				</div>

				<div class="ticket-summary row-fluid">

					<ul class="db-summary clearfix pb20 pt20 clear" id="ticket-summary">
					
						
						<li><a href='<c:url value="openTickets.html"/>' data-parallel-url="#"
							data-parallel-placeholder="#ticket-leftFilter"
							class="summery-filter clearfix" data-pjax="#body-container">
								<div class="db-icon-wrap center pull-left">
									<i class="ficon-db-calendar dbicon-red"></i>
								</div>
								<div class="summary-count pull-left ml20">
									<h4>${openTickets}</h4>
									<p>Open Tickets</p>
								</div>
						</a></li>

						<li><a href='<c:url value="awaitingSpares.html"/>' class="summery-filter clearfix"
							data-parallel-url="#"
							data-parallel-placeholder="#ticket-leftFilter"
							data-pjax="#body-container">
								<div class="db-icon-wrap center pull-left">
									<i class="ficon-db-sand-clock dbicon-orange"></i>
								</div>
								<div class="summary-count pull-left ml20">
									<h4>${awaitingSparesTickets}</h4>
									<p>Awaiting Spare</p>
								</div>
						</a></li>

						<li><a href='<c:url value="bridgedTickets.html"/>' data-parallel-url="#"
							data-parallel-placeholder="#ticket-leftFilter"
							class="summery-filter clearfix" data-pjax="#body-container">
								<div class="db-icon-wrap center pull-left">
									<i class="ficon-ticket dbicon-red"></i>
								</div>
								<div class="summary-count pull-left ml20">
									<h4>${bridgedTickets}</h4>
									<p>SLA Bridged</p>
								</div>

						</a></li>

						
						
						<li><a href='<c:url value="escalatedTickes.html"/>' data-parallel-url="#"
							data-parallel-placeholder="#ticket-leftFilter"
							class="summery-filter clearfix" data-pjax="#body-container">
								<div class="db-icon-wrap center pull-left">
									<i class="ficon-db-unassigned dbicon-brown"></i>
								</div>
								<div class="summary-count pull-left">
									<h4>${escalatedTickets}</h4>
									<p>Escalated Tickets</p>
								</div>
						</a>
						</li>
						<li><a href='<c:url value="closedTickets.html"/>'
							data-parallel-url="#"
							data-parallel-placeholder="#ticket-leftFilter"
							class="summery-filter clearfix" data-orig-name="new"
							data-pjax="#body-container">
								<div class="db-icon-wrap center pull-left">
									<i class="ficon-db-unassigned dbicon-brown"></i>
								</div>
								<div class="summary-count pull-left ml20">
									<h4>${closedTickets}</h4>
									<p>Closed Tickets</p>
								</div>
						</a></li>
						
					</ul>
				</div>

				<div class="panel-body">
				
					<%-- <ul class="nav nav-tabs">
						<li class="active"><a href="#home" data-toggle="tab">Ticket
								Overall</a></li>
						<li><a href="#ticketDetails" data-toggle="tab">Ticket
								Details</a></li>
						<li ><a href='<c:url value="pendingOrders.html"/>'> Order Inbox <span class="badge"> ${inboxCount}</span></a></li>
						
					</ul> --%>
					
					<div class="tab-content">

						<%-- <!--home tab-->
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
											<div id="ticket_details_pie" align='center'></div>
										</div>
									</div>
								</div>
								<!-- /panel body -->
							</div>
							<!-- /panel panel-success -->
						</div>
						<!-- /home tab-->

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
										<!-- Below table will be displayed as Data table -->
										<table id="myDatatable" class="display datatable">
											<thead>
												<tr>
													<th>Ticket No</th>
													<th>Subject</th>
													<th>Description</th>
													<th>Date</th>
													<th>Status</th>
													<th>Technician</th>
													<th>Update</th>

												</tr>
											</thead>
											<tbody>
												<!-- Iterating over the list sent from Controller -->
												<c:forEach items="${home}" var="ticket" varStatus="itr">
													<tr>
														<td><c:out value="${ticket.ticketNumber}" /></td>
														<!-- Subject must be included from ticket model -->
														<td><c:out value="${ticket.subject}" /></td>
														<!-- /Subject must be included from ticket model -->
														<td><c:out value="${ticket.description}" /></td>
														<td><c:out value="${ticket.dateTime}" /></td>
														<td><c:out value="${ticket.status}" /></td>
														<td><c:out
																value="${ticket.employee.firstName} ${ticket.employee.lastName}" /></td>
														<td><a
															href="AssignTicketToOtherTechnician?ticketNumber=<c:out value='${ticket.ticketNumber}'/>"><button
																	class="btn btn-info">Edit</button></a></td>

													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
								<!-- /panel body -->
							</div>
							<!-- /panel panel-success -->

						</div>
						<!-- Ticket Detials -->
						<input type="button" id="btnPrint" class="btn btn-info"
							value="Export to pdf and Print" /> --%>

					</div>
					<!-- /tab-content -->

				</div>
				<!-- /panel body -->
			</div>
			<!--/panel success class-->
		</div>
		<!-- /Container -->
		<!-- Footer -->
		<c:import url="templates/footer.jsp"></c:import>
		<!--/ Footer -->
	</div>
	<!-- / velaphanda_containter -->
	<script type="text/javascript"
		src="<c:url value="/resources/jquery/1.8.3/jquery.min.js" />"></script>
	<script type="text/javascript">
        $("#btnPrint").live("click", function () {
            var divContents = $("#ticketDetails").html();
            var printWindow = window.open('', '', 'height=400,width=800');
            printWindow.document.write('<html><head><title>Ticket List</title>');
            printWindow.document.write('</head><body >');
            printWindow.document.write(divContents);
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            printWindow.print();
        });
    </script>


	<!-- google chart api  -->
	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
	<!-- Google API Script -->
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
	<!-- /google chart api  -->

	<!-- Data tables search -->
	<script type="text/javascript"
		src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>

	<script type="text/javascript"
		src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>

	<script type="text/javascript">
		$(document).ready(function() {
			$('#myDatatable').DataTable({
				"jQueryUI" : true,
				"pagingType" : "full_numbers",
				"lengthMenu" : [ [ 5, 10, 50, -1 ], [ 5, 10, 50, "All" ] ]
			/* few more options are available to use */
			});
		});
	</script>
	<!-- / Data tables search -->

</body>
</html>
