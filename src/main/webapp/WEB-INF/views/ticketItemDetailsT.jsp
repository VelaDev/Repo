<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Ticket Details | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/custom/css/orderhistory.css"/>">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/custom/css/vela_custom.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/fonts/font-awesome.min.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" />


<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">
<style type="text/css">
.orderDetails {
    margin-left: -22px;
}

table#orderDetails {
	margin-left: 14%;
	/* margin-right: -9%; */
	width: 73%;
}
</style>
</head>
<body>
	<div class="velaphanda_containter">
		<c:import url="templates/techniciannavbar.jsp"></c:import>
		<div class="container">

			<form:form action="searchOrderNumber" method="post"
				id="searchOrderNumber">

			</form:form>

			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Ticket No : ${ticketObject.ticketNumber}</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">

					<div id="navbar" class="navbar-collapse collapse"
						style="margin-left: -2%">
						<ul class="nav navbar-nav navbar-left">
							
							
							  <c:choose>
								<c:when test="${ticketObject.status =='Open'}">
									<li class="dropdown"><a href="#" class="dropdown-toggle"
									data-toggle="dropdown" role="button" aria-haspopup="true"
									aria-expanded="false">Ticket Action<span class="caret"></span></a>
									<ul class="dropdown-menu">
										<li><a href="acknowledgedTicket?=<c:out value='${ticketObject.ticketNumber}'/>">Acknowledged</a></li>
									</ul>
								</li>				
								</c:when>
								<c:when test="${ticketObject.status =='Acknowledged'}">
									<li class="dropdown"><a href="#" class="dropdown-toggle"
									data-toggle="dropdown" role="button" aria-haspopup="true"
									aria-expanded="false">Ticket Action<span class="caret"></span></a>
									<ul class="dropdown-menu">
										<li><a href="reOpen?=<c:out value='${ticketObject.ticketNumber}'/>">Take Ticket</a></li>
									</ul>
									</li>								
								</c:when>	
								<c:when test="${ticketObject.status =='Taken'}">
									<li class="dropdown"><a href="#" class="dropdown-toggle"
									data-toggle="dropdown" role="button" aria-haspopup="true"
									aria-expanded="false">Ticket Action<span class="caret"></span></a>
									<ul class="dropdown-menu">
										<li><a href="acknowledgedTicket?=<c:out value='${ticketObject.ticketNumber}'/>">Awaiting Spare</a></li>
										<li><a href="acknowledgedTicket?=<c:out value='${ticketObject.ticketNumber}'/>">Escalate Ticket</a></li>
										<li><a href="reOpen?=<c:out value='${ticketObject.ticketNumber}'/>">Resolve</a></li>		
									</ul>
								</li>				
								</c:when>																														
								<c:when test="${ticketObject.status =='Awaiting Spares'}">																	
								</c:when>
								<c:when test="${ticketObject.status =='Escalated'}">
									<li class="dropdown"><a href="#" class="dropdown-toggle"
									data-toggle="dropdown" role="button" aria-haspopup="true"
									aria-expanded="false">Ticket Action<span class="caret"></span></a>
									<ul class="dropdown-menu">
										<li><a href="reOpen?=<c:out value='${ticketObject.ticketNumber}'/>">Escalate ticket</a></li>
										<li><a href="reOpen?=<c:out value='${ticketObject.ticketNumber}'/>">Resolve</a></li>									
									</ul>
									</li>			
								</c:when>
								<c:when test="${ticketObject.status =='Escalated'}">
								</c:when>
								<c:when test="${ticketObject.status =='SLA Bridged'}">
								</c:when>
								<c:when test="${ticketObject.status =='Resolved'}">										
								</c:when>
								<c:when test="${ticketObject.status =='Closed'}">
								</c:when>
								<c:otherwise>
									<c:out value="${ticketObject.status}" />
								</c:otherwise>
							 </c:choose>
						  	
							
							<li><a href="printdeliveryNote?recordID=<c:out value='${ticketObject.ticketNumber}'/>">Download PDF </a></li>

						</ul>
					</div>
					<legend></legend>
					<ul class="nav nav-tabs">
						<li class="active"><a href="#ticketDetails" data-toggle="tab">Ticket
								Details</a></li>
						<li><a href="#ticketHistoryDetails" data-toggle="tab">Ticket History</a></li>
					</ul>

					<div class="tab-content">

						<!--#ticketDetails tab-->
						<div class="tab-pane active" id="ticketDetails">
							<br />
							<br />
							<div id="pagewrap">

								<section id="content" style="width:35%;">
								<div class="groupclientdetails">
									<legend style="font-size: 12px; line-height: 1.42857143;">Device</legend>

									<div class="machinedetailsdetailsfloatleft">

										<label id="serialNumber" name="serialNumber"><b>Serial
												Number: ${ticketObject.device.serialNumber} </b></label> <br>
										<li id="modelNumber" name="modelNumber">Model:
											${ticketObject.device.modelNumber}</li>
										<li id="brand" name="brand">Device Brand:
											${ticketObject.device.modelBrand}</li> <br> <label
											id="location" name=""location""><b>Location</b></label>
										<li id="building" name="building">Floor
											${ticketObject.device.floorNumber}
											${ticketObject.device.buildingName}</li>
										<li id="street" name="street">${ticketObject.device.streetNumber}
											${ticketObject.device.streetName}</li>
										<li id="city" name="city">${ticketObject.device.city_town}</li>
										<li id="province" name=""province"">${ticketObject.device.province}</li>
										<li id="areaCode" name="areaCode">${ticketObject.device.areaCode}</li>

									</div>

								</div>
								</section>

								<section id="middle">

								<div class="groupclientaddress">
									<legend style="font-size: 12px; line-height: 1.42857143;">Ticket
										Contacts</legend>

									<div class="machinedetailsfloatright ">

										<div class="orderDetails">
											<li id="contactName"><b>${ticketObject.firstName}
													${ticketObject.lastName}</b></li>
											<li id="cell">Cell No: ${ticketObject.contactCellNumber}</li>
											<li id="telephone">Telephone No:
												${ticketObject.contactTelephoneNumber}</li>
											<li id="email">E-Mail: ${ticketObject.contactEmail}</li>
										</div>
										<br>
									</div>

								</div>

								</section>

								<aside id="sidebar">

								<div class="groupproductdetails">
									<legend style="font-size: 12px; line-height: 1.42857143;">Ticket</legend>
									<div class="machinedetailsfloatright ">
										<div class="orderDetails">
											<li style="font-size: 15px;" id="ticketNum"><b>${ticketObject.ticketNumber}</b></li>
											<li id="customer">Customer:
												${ticketObject.device.customerDevice.customerName}</li>
											<li id=tcketStatus>Status: ${ticketObject.status}</li>
											<li id=ticketDate>Date: ${ticketObject.dateTime}</li>
											<li id=assignedTo>Assigned To:
												${ticketObject.employee.firstName}
												${ticketObject.employee.lastName}</li> <br>
											<li id="ticket_Description"><b>Description</b></li>
											<li id="ticketDescription">${ticketObject.description}</li>

										</div>
										<br>

									</div>

								</div>
								</aside>

								<div class="limeItems" style="margin-left: 1%;">

									<legend style="font-size: 15px; line-height: 1.42857143;"
										align="center">
										<b>Ticket Details </b>
									</legend>
									<table id="orderInfo" class="display datatable">
										<thead>
											<tr>
												<th>Ticket No</th>
												<th>Status</th>
												<th>Priority</th>
												<th>Technician Email</th>
												<th>Comments</th>
											</tr>
										</thead>
										<tbody>
											<!-- Iterating over the list sent from Controller -->

											<tr>
												<td>${ticketObject.ticketNumber}</td>
												<td>${ticketObject.status}</td>
												<td>${ticketObject.priority}</td>
												<td>${ticketObject.employee.email}</td>
												<td>${ticketObject.comments}</td>
												<%-- <td>${list.technician}</td>
															<td>${list.quantity}</td> --%>
											</tr>

										</tbody>
									</table>
								</div>

							</div>


						</div>

						<!--#ticketHistoryDetails tab-->
						<div class="tab-pane" id="ticketHistoryDetails">

							<div class="groupdetails-row-padding">

								<div class="groupclientdetails">
									<br />
									<legend style="font-size: 15px; line-height: 1.42857143;"
										align="center">
										<b>Ticket History </b>
									</legend>
									<form:form class="well form-horizontal">
										<div class="panel-body">
											<!-- Below table will be displayed as Data table -->
											<table id="tckHistory" class="display datatable">
												<thead>
													<tr>
														<th>Ticket No</th>
														<th>Ticket Status</th>
														<th>Action Taken</th>
														<th>Date</th>
														<th>Assigned To</th>
														<th>Colour Reading</th>
														<th>Mono Reading</th>
														<th>Comment</th>
													</tr>
												</thead>
												<tbody>
													<!-- Iterating over the list sent from Controller -->
													<c:forEach items="${ticketHistoryList}" var="history">
														<tr>
															<td><c:out value="${history.ticketNumber}" /></td>
															<td><c:out value="${history.status}" /></td>
															<c:choose>
																<c:when test="${history.status =='Open'}">
																	<td><c:out value="${history.actionTaken}" />Log Ticket</td>
																</c:when>																
																<c:when test="${history.status =='Awaiting Spares'}">
																	<td>Waiting for Order: <c:out value="${orders.orderNum}" /></td>
																</c:when>
																<c:when test="${history.status =='Escalated'}">
																	<td>Ticket Escalated to Manager</td>
																</c:when>
																<c:when test="${history.status =='SLA Bridged'}">
																	<td><c:out value="${history.actionTaken}" />System update</td>
																</c:when>
																<c:when test="${history.status =='Re-Opened'}">
																	<td>Ticket Re-Opened</td>
																</c:when>
																<c:when test="${history.status =='Acknowledged'}">
																	<td><c:out value="${history.actionTaken}" />Tickets Acknowledged </td>
																</c:when>
																<c:when test="${history.status =='Taken'}">
																	<td>Ticket Taken</td>
																</c:when>
																<c:otherwise>
																	<td><c:out value="${history.actionTaken}" /></td>
																</c:otherwise>
															</c:choose>
															<td><c:out value="${history.escalatedDate}" /></td>
															<td><c:out
																	value="${history.employee.firstName} ${history.employee.lastName}" /></td>
															<td><c:out value="${history.colourReading }" /></td>
															<td><c:out value="${history.monoReading }" /></td>
															<td><c:out value="${history.comment}" /></td>
														</tr>
													</c:forEach>
												</tbody>
											</table>

										</div>
									</form:form>

								</div>
								<!-- group client details -->

							</div>
							<!-- group details-row-padding -->

						</div>

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

</body>
<script type="text/javascript"
	src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>
<!-- Paging the table -->
<script type="text/javascript">
	$(document).ready(function() {
		$('#orderInfo').DataTable({
			"jQueryUI" : true,
			"pagingType" : "full_numbers",
			"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ]
		/* few more options are available to use */
		});
	});
</script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#tckHistory').DataTable({
			"jQueryUI" : true,
			"pagingType" : "full_numbers",
			"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ]
		/* few more options are available to use */
		});
	});
</script>
</html>
