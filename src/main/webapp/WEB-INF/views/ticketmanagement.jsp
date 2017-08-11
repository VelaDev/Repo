<%@include file="templates/taglibs.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ticket Management</title>

<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/custom/css/vela_custom.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/fonts/font-awesome.min.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/daterangepicker.css" />" />

<!-- Little Dash-board -->
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/ticketoverview.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/common-9a01e5a5a5a2f97d04552fa65cc3846b.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/fonts/sprites-b23bb97cb281c684a70d957ed91664df.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/app-310c175202e0f34694cea021357db448.css" />" />
<!-- //Little Dash-board -->

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">
<!--/style-->

<style type="text/css">
.selectDate {
    position: relative;
    display: inline-block;
    height: 28px;
    width: 48%;
    margin-left: 25%; 
}

.selectDate input {
	width: 100%; /* Arbitrary number */
	height: 100%;
	padding-right: 40px;
	box-sizing: border-box;
}

#calendar {
	height: 100%;
	width: 40px;
	background-image: url(resources/images/calendar.png),url(resources/images/down_arrow.png);
	background-repeat: no-repeat;
	background-position: 50% 50%;
	border: none;
	background-color: transparent;
	position: absolute;
	top: 50%;
	right: 0;
	transform: translateY(-50%);
}

i.glyphicon.glyphicon-calendar.col-sm-pull-2 {
	right: -29%;
}

input#selectDateRange {
	cursor: pointer;
}

.db-summary li:first-child:nth-last-child(5), .db-summary li:first-child:nth-last-child(5) 
	~ li {
	width: 12%;
}

.db-summary li:first-child:nth-last-child(6), .db-summary li:first-child:nth-last-child(9) ~ li {
    width: 11%;
}

.db-summary li:first-child:nth-last-child(4), .db-summary li:first-child:nth-last-child(4) 
	 ~ li {
	width: 10%;
}
.db-summary li:first-child a {
    padding-left: 23px;
}
.input-group-btn:last-child>.btn, .input-group-btn:last-child>.btn-group
	{
	z-index: 2;
	height: 26px;
	margin-left: -1px;
	padding-bottom: 17px;
}

.db-summary li:first-child {
	border-right: 1px #dfdfdf solid;
}

.db-summary li {
	float: left;
	box-sizing: border-box;
	border-right: 1px #dfdfdf solid;
}
</style>

</head>
<body>

	<div class="velaphanda_containter">
		<c:import url="templates/navbar.jsp"></c:import>
		<div class="container">
			<form:form action="searchOrderNumber" method="post"
				id="searchOrderNumber" modelAttribute="searchOrderNumber">

				<div style="margin-bottom: -3px; margin-left: -1px;" align=left>
					<!-- Select type customers-->
					<div class="form-group ">
						<div class="col-md-3 selectContainer">
							<div class="input-group">
								<span class="input-group-addon"><i
									class="glyphicon glyphicon-list"></i></span> <select
									name="customerName" id="customerName"
									class="form-control selectpicker" onchange="location = this.value;">
									<c:if test="${not empty selectedName }">
									   <option value="${ selectedName}">${ selectedName}</option>
									</c:if>
									<option value="getTicketByCustomer?customerName=<c:out value="All Customers"/>">All Customers</option>
									<c:forEach items="${customers}" var="customer">
										<option value="getTicketByCustomer?customerName=<c:out value='${customer.customerName}'/>">${customer.customerName}</option>
									</c:forEach>
								</select>

							</div>
						</div>
					</div>
					<!-- Select type selectDateRange-->
					<div class="form-group ">
						<div class="col-md-3 selectContainer">
							<div class="input-group">
								<span class="input-group-addon"><i
									class="glyphicon glyphicon-list"></i></span> <select
									name="getTicketDateRange" id="selectDateRange"
									class="form-control selectpicker" onchange="location = this.value;">
									<c:if test="${empty newDate }">
									   <option>Select a date</option>
									</c:if>
									<c:if test="${not empty newDate }">
									   <option value="${ newDate}">${ newDate}</option>
									</c:if>
									     <c:forEach items="${dates}" var="date">
										   <option value="getTicketBySelectedDate?selectedDate=<c:out value='${date}'/>">${date}</option>
									 </c:forEach>		
								</select>

							</div>
						</div>
					</div>
					
						<!-- Select type selectTehnnician-->
					<div class="form-group ">
						<div class="col-md-3 selectContainer">
							<div class="input-group">
								<span class="input-group-addon"><i
									class="glyphicon glyphicon-list"></i></span> <select
									name="technicianName" id="technicianName"
									class="form-control selectpicker" onchange="location = this.value;">
									<c:if test="${not empty selectedTechnician }">
									   <option >${ selectedTechnician.firstName} ${ selectedTechnician.lastName}</option>
									</c:if>
									   <option value="getTechnicianName?technicianName=<c:out value="All Technicians"/>">All Technicians</option>
									<c:forEach items="${technicians}" var="technician">
												<option value="getTechnicianName?technicianName=<c:out value='${technician.email}'/>">${technician.firstName} ${technician.lastName}</option>	
										</c:forEach>
																	
								</select>
							</div>
						</div>
					</div>
					<div align=right>
						<!-- Text input Search-->
						<div class="form-group">
							<div class="col-md-3 inputGroupContainer">
								<div class="input-group">
									<input name="ticketNumbers" list="ticketNumbers"
													class="form-control" type="text"
													onkeydown="upperCaseF(this)"
													placeholder='Enter Ticket Number' /> <span
										class="input-group-btn">
										<button class="btn btn-success" type="submit">
											<div class="up" style="margin-top: -8%; color: white;">Search</div>
										</button>
									</span>
								</div>
								<!-- /input-group -->
							</div>

							<!-- Iterating over the list sent from Controller -->
							<datalist id="ticketNumbers"> 
								<c:forEach var="list"
									items="">
									<option value="">
								</c:forEach>
							 </datalist>

						</div>
					</div>


				</div>

			</form:form>

			<div class="panel panel-success">
				<!--Search-->
				<div class="panel-heading">
					<h3 class="panel-title">
						<br /> <br />
						<div align="left">
							<b>Tickets</b>
						</div>
					</h3>
				</div>

				<div class="panel-body">
					<div class="tab-content">

						<div class="ticket-summary row-fluid">

							<ul class="db-summary clearfix pb20 pt20 clear"
								id="ticket-summary" class="nav nav-tabs">

								<li><a href='logTicket.html'
									data-parallel-url=""
									data-parallel-placeholder="#ticket-leftFilter"
									class="summery-filter clearfix" data-pjax="#body-container">

										<div class="summary-count pull-left"
											style="margin-left: -10%;padding-right: 17%;">
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
											<br /> <br />
											<p align="center">Create Ticket</p>
										</div>
								</a></li>

									<li><a href='<c:url value="openTickets"/>'
									class="summery-filter clearfix"
									data-parallel-url="openTickets"
									data-parallel-placeholder="#ticket-leftFilter"
									data-pjax="#body-container">

										<div class="summary-count pull-left"
											style="margin-left: 7%;">
											<h4 align="center" style="color:#01960C;">${countOpenTickets}</h4>
											<p align="center">Open Tickets</p>
										</div>
								</a></li>
								
								<li><a href='<c:url value="acknowledgedTickets"/>'
									data-parallel-url="AcknowledgedTickets"
									data-parallel-placeholder="#ticket-leftFilter"
									class="summery-filter clearfix" data-pjax="#body-container">

										<div class="summary-count pull-left"
											style="margin-left: -11%;">
											<h4 align="center">${countAcknowledgedTickets}</h4>
											<p align="center">Acknowledged Tickets</p>
										</div>
								</a></li>								
								
								<li><a href='<c:url value="takenTickets"/>'
									class="summery-filter clearfix"
									data-parallel-url="TakenTickets"
									data-parallel-placeholder="#ticket-leftFilter"
									data-pjax="#body-container">

										<div class="summary-count pull-left"
											style="margin-left: 8%;">
											<h4 align="center">${countTakenTickets}</h4>
											<p align="center">Taken Tickets</p>
										</div>
								</a></li>

								<li><a href='<c:url value="ticketsAwaitingSpares"/>'
									class="summery-filter clearfix"
									data-parallel-url="TicketsAwaitingSpares"
									data-parallel-placeholder="#ticket-leftFilter"
									data-pjax="#body-container">
										<div class="summary-count pull-left"
											style="margin-left: -16%;">
											<h4 align="center">${countAwaitingSparesTickets}</h4>
											<p align="center">Tickets Awaiting Spares</p>
										</div>
								</a></li>
																
								<li><a href='<c:url value="escalatedTickets"/>'
									class="summery-filter clearfix"
									data-parallel-url="escalatedTickets"
									data-parallel-placeholder="#ticket-leftFilter"
									data-pjax="#body-container">

										<div class="summary-count pull-left"
											style="margin-left: 2%;">
											<h4 align="center">${countEscalatedTickets}</h4>
											<p align="center">Escalated Tickets</p>
										</div>
								</a>
								</li>
								
								<li><a href='<c:url value="sLABridgedTickets"/>'
									class="summery-filter clearfix"
									data-parallel-url="sLABridgedTickets"
									data-parallel-placeholder="#ticket-leftFilter"
									data-pjax="#body-container">

										<div class="summary-count pull-left"
											style="margin-left: -5%;">
											<h4 align="center" style="color:red;">${countBridgedTickets}</h4>
											<p align="center">SLA Bridged Tickets</p>
										</div>
								</a>
								</li>
																
								<li><a href='<c:url value="resolvedTickets"/>'
									class="summery-filter clearfix"
									data-parallel-url="resolvedTickets"
									data-parallel-placeholder="#ticket-leftFilter"
									data-pjax="#body-container">

										<div class="summary-count pull-left"
											style="margin-left: 2%;">
											<h4 align="center">${countResolvedTickets}</h4>
											<p align="center">Resolved Tickets</p>
										</div>
								</a>
								</li>								
																
								<li><a href='<c:url value="closedTickets"/>'
									class="summery-filter clearfix"
									data-parallel-url="closedTickets"
									data-parallel-placeholder="#ticket-leftFilter"
									data-pjax="#body-container">

										<div class="summary-count pull-left"
											style="margin-left: 4%">
											<h4 align="center">${countClosedTickets}</h4>
											<p align="center">Closed Tickets</p>
										</div>
								</a>
								</li>
								
							
							</ul>
						</div>
						
						<form:form class="well form-horizontal" method="post"
							action="ticketManage" id="ticketManage"
							modelAttribute="ticketManage">

							<!-- tab nav -->
							<div class="tab-content">

									<form:form modelAttribute="ticketHistory" method="post"
										action="ticketHistory" id="ticketHistory" name="ticketHistory">

										<!-- Below table will be displayed as Data table -->
										<table id="displayTicketsDetails" class="display datatable">
											<thead>
												<tr>
													<th>Ticket Number</th>
													<th>Ticket Date</th>
													<th>Description</th>
													<th>Status</th>
													<th>Customer</th>
													<th>Serial Number</th>
													<th>Model</th>
													<th>Assigned To</th>
												</tr>
											</thead>
											<tbody>
												<!-- Iterating over the list sent from Controller -->
												<c:forEach var="list" items="${lastForteenList}">
													<tr>
														<td><a
															href="ticketItemDetailsM?recordID=<c:out value='${list.recordID}'/>">${list.ticketNumber}</a></td>
														<td>${list.dateTime}</td>
														<td>${list.description}</td>
														<td>${list.status}</td>
														<td>${list.device.customerDevice.customerName}</td>
														<td>${list.device.serialNumber}</td>
														<td>${list.device.modelNumber}</td>
														<td>${list.employee.firstName}
															${list.employee.lastName}</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
										<!-- table ticket -->
									</form:form>
									<!-- form ticket -->

								
							</div>
							<!-- /tab-content -->

						</form:form>

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

		<!-- Script -->
		<script type="text/javascript"
			src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
		
		<script type="text/javascript"
			src="<c:url value="/resources/bootstrap-3.3.7/js/daterangepicker.js"/>"></script>

		<script type="text/javascript"
			src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>

		<!-- Datatables -->
		<script type="text/javascript"
			src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>
		<!-- /Scripts -->

		<!-- Paging the table -->
		<script type="text/javascript">
			$(document).ready(function() {
				$('#displayTicketsDetails').DataTable({
					"jQueryUI" : true,
					"pagingType" : "full_numbers",
					"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ],
					"order": [[1 , "desc" ]]
				/* few more options are available to use */
				});
			});
		</script>
		
	<!-- Create datalist to populate search -->
	<script type="text/javascript">
		// Get the <datalist> and <input> elements.
		var dataList = document.getElementById('json-datalist');
		var input = document.getElementById('ajax');

		// Create a new XMLHttpRequest.
		var request = new XMLHttpRequest();

		// Handle state changes for the request.
		request.onreadystatechange = function(response) {
			if (request.readyState === 4) {
				if (request.status === 200) {
					// Parse the JSON
					var jsonOptions = JSON.parse(request.responseText);

					// Loop over the JSON array.
					jsonOptions.forEach(function(item) {
						// Create a new <option> element.
						var option = document.createElement('option');
						// Set the value using the item in the JSON array.
						option.value = item;
						// Add the <option> element to the <datalist>.
						dataList.appendChild(option);
					});

					// Update the placeholder text.
					input.placeholder = "e.g. datalist";
				} else {
					// An error occured :(
					input.placeholder = "Couldn't load datalist options :(";
				}
			}
		};

		// Update the placeholder text.
		input.placeholder = "Loading options...";

		// Set up and make the request.
		request
				.open(
						'GET',
						'https://s3-us-west-2.amazonaws.com/s.cdpn.io/4621/html-elements.json',
						true);
		request.send();
	</script>
		
</body>
</html>
