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
	href="<c:url value="/resources/custom/css/vela_custom_ticktes.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />" />

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">
<style type="text/css">
.orderDetails {
    margin-left: -15px;
}

.displayNone, .tTakeTicket {
    display:none;
}
.showDIV { display:block; } 
table#orderDetails {
	margin-left: 14%;
	/* margin-right: -9%; */
	width: 73%;
}
table#toOrder thead {
    background-color: #CCCCCC;
    height: 112%;
}
</style>
</head>
<body>
	<div class="velaphanda_containter">
		<c:import url="templates/navbar.jsp"></c:import>
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
				<!-- panel body -->
				<div class="panel-body">

					 <!-- Hidden Mono Reading  -->
					 <input type="hidden" id="availableMonoReading" name="availableMonoReading" class="form-control selectpicker" value="${ticketObject.getDevice().getMonoReading()}">
					 <!-- Hidden Colour Reading  -->
					 <input type="hidden" id="availableColourReading" name="availableColourReading" class="form-control selectpicker" value="${ticketObject.getDevice().getColourReading()}">
					
						
					<!-- navigation for action taken -->
					<div id="navbar" class="navbar-collapse collapse"
						style="margin-left: -2%">
						<ul class="nav navbar-nav navbar-left">
							<!-- resolved details -->

							<c:choose>
							
								<c:when test="${ticketObject.status =='Open'}">
									<li class="dropdown"><a href="#" class="dropdown-toggle"
										data-toggle="dropdown" role="button" aria-haspopup="true"
										aria-expanded="false">Ticket Action<span class="caret"></span></a>
										<ul class="dropdown-menu">
											<li><a id="mTicketOpenReassignLink" href="javascript:;" data-toggle="tab">Re-assign</a></li>
										</ul></li>
								</c:when>
								
								<c:when test="${ticketObject.status =='Acknowledged'}">
									<li class="dropdown"><a href="#" class="dropdown-toggle"
										data-toggle="dropdown" role="button" aria-haspopup="true"
										aria-expanded="false">Ticket Action<span class="caret"></span></a>
										<ul class="dropdown-menu">
											<li><a id="mTicketAcknowledgedReassignLink" href="javascript:;" data-toggle="tab">Re-assign</a></li>
										</ul>
									</li>
								</c:when>

								<c:when test="${ticketObject.status =='Taken'}">
									<li class="dropdown"><a href="#" class="dropdown-toggle"
										data-toggle="dropdown" role="button" aria-haspopup="true"
										aria-expanded="false">Ticket Action<span class="caret"></span></a>
										<ul class="dropdown-menu">
											<li><a id="mTicketTakenAwaitingLink" href="javascript:;" data-toggle="tab">Awaiting Spares</a></li>
											<li><a id="mTicketTakenEscalateLink" href="javascript:;" data-toggle="tab">Escalate</a></li>
										</ul></li>
								</c:when>
								
								<c:when test="${ticketObject.status =='Escalated'}">
									<li class="dropdown"><a href="#" class="dropdown-toggle"
										data-toggle="dropdown" role="button" aria-haspopup="true"
										aria-expanded="false">Ticket Action<span class="caret"></span></a>
										<ul class="dropdown-menu">
											<li><a id="mTicketEscalatedReassignLink" href="javascript:;" data-toggle="tab">Re-assign</a></li>
											<li><a id="mTicketEscalatedResolvedDetailsLink" href="javascript:;" data-toggle="tab">Resolve</a></li>
										</ul></li>
								</c:when>
								
								<c:when test="${ticketObject.status =='SLA Bridged'}">
									<li class="dropdown"><a href="#" class="dropdown-toggle"
										data-toggle="dropdown" role="button" aria-haspopup="true"
										aria-expanded="false">Ticket Action<span class="caret"></span></a>
										<ul class="dropdown-menu">
											<li><a id="mTicketSLABridgedResolvedLink" href="javascript:;" data-toggle="tab">Resolve</a></li>
											
										</ul></li>									
								</c:when>
								
								<c:when test="${ticketObject.status =='Resolved'}">
									<li class="dropdown"><a href="#" class="dropdown-toggle"
										data-toggle="dropdown" role="button" aria-haspopup="true"
										aria-expanded="false">Ticket Action<span class="caret"></span></a>
										<ul class="dropdown-menu">
											<li><a id="mTicketReopenResolvedLink" href="javascript:;" data-toggle="tab">Re-open</a></li>
										</ul></li>
								</c:when>								
							</c:choose>
						</ul>
					</div>
					<!-- //navigation for action taken -->

					<legend></legend>
					<!-- nav sub menu tabs  -->
					<ul class="nav nav-tabs">
						<li class="active"><a href="#ticketDetails" data-toggle="tab">Ticket Details</a></li>
						<li><a href="#ticketHistoryDetails" data-toggle="tab">Ticket History</a></li>
						<c:choose>
							
							<c:when test="${ticketObject.status =='Open'}">
								<li class="mTicketOpenReassign" style="display:none;"><a href="#mTicketOpenReassign" data-toggle="tab">Re-assign</a></li>
							</c:when>	
							
							<c:when test="${ticketObject.status =='Acknowledged'}">
								<li class="mTicketAcknowledgedReassign" style="display:none;"><a href="#mTicketAcknowledgedReassign" data-toggle="tab">Re-assign</a></li>
							</c:when>
							
							<c:when test="${ticketObject.status =='Taken'}">
								<li class="mTicketTakenEscalate" style="display:none;"><a href="#mTicketTakenEscalate" data-toggle="tab">Escalate</a></li>
								<li class="mTicketTakenAwaiting" style="display:none;"><a href="#mTicketTakenAwaiting" data-toggle="tab">Awaiting Spares</a></li>
							</c:when>
							
							<c:when test="${ticketObject.status =='Escalated'}">
								<li class="mTicketEscalatedResolvedDetails" style="display:none;"><a href="#mTicketEscalatedResolvedDetails" data-toggle="tab">Resolve</a></li>
								<li class="mTicketEscalatedReassign" style="display:none;"><a href="#mTicketEscalatedReassign"	data-toggle="tab">Re-assign</a></li>
							</c:when>
							
							<c:when test="${ticketObject.status =='SLA Bridged'}">
							 <li class="mTicketSLABridgedResolved" style="display:none;"><a href="#mTicketSLABridgedResolved" data-toggle="tab">Resolve</a></li>
							</c:when>				
					
							<c:when test="${ticketObject.status =='Resolved'}">
								<li class="mTicketReopenResolved" style="display:none;"><a href="#mTicketReopenResolved" data-toggle="tab">Resolved Ticket Details</a></li>
							</c:when>
				
							<c:when test="${ticketObject.status =='Closed'}">
								<li><a href="#mTicketClosedNoAction" data-toggle="tab">Closed Ticket Details</a></li>
							</c:when>
							
						</c:choose>

					</ul>
					<!-- // nav sub menu tabs-->

					<!-- tab content -->
					<div class="tab-content">

						<!--Ticket Details tab-->
						<div class="tab-pane active" id="ticketDetails">
							<br /> <br />

							<!-- page wrap -->
							<div id="pagewrap">
								<!-- section content -->
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
								<!-- //section content -->
								<!-- section middle -->
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
								<!-- //section middle -->

								<!-- aside sidebar -->
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
								<!-- //aside sidebar -->

								<!-- Lineitems -->
								<div class="lineItems" style="margin-left: 1%;">
									<legend style="font-size: 15px; line-height: 1.42857143;"
										align="center">
										<b>Ticket Details </b>
									</legend>
									<!-- table ticket info -->
									<table id="ticketInfo" class="display datatable">
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
											</tr>
										</tbody>
									</table>
									<!-- //Table ticket Info -->
								</div>
								<!-- Line Item -->
							</div>
							<!-- page wrap -->
						</div>
						<!-- tab for Ticket Details -->

						<!--Ticket History Details tab-->
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
											<!-- table tckHistory -->
											<table id="tckHistory" class="display datatable">
												<thead>
													<tr>
														<th>Ticket No</th>
														<th>Date</th>
														<th>Ticket Status</th>
														<th>Action Taken</th>
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
															<td><c:out value="${history.escalatedDate}" /></td>
															<td><c:out value="${history.status}" /></td>
															<c:choose>
																<c:when test="${history.status =='Open'}">
																	<td><c:out value="${history.actionTaken}" />Log
																		Ticket</td>
																</c:when>
																<c:when test="${history.status =='Awaiting Spares'}">
																	<td>Waiting for Order: <c:out
																			value="${orders.orderNum}" /></td>
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
																<c:when test="${history.status =='Re-assigned'}">
																	<td>Ticket Re-assigned</td>
																</c:when>
																<c:when test="${history.status =='Acknowledged'}">
																	<td><c:out value="${history.actionTaken}" />Ticket Acknowledged</td>
																</c:when>
																<c:when test="${history.status =='Taken'}">
																	<td>Ticket Taken</td>
																</c:when>
																<c:otherwise>
																	<td><c:out value="${history.actionTaken}" /></td>
																</c:otherwise>
															</c:choose>
															<td><c:out
																	value="${history.employee.firstName} ${history.employee.lastName}" /></td>
															<td><c:out value="${history.colourReading }" /></td>
															<td><c:out value="${history.monoReading }" /></td>
															<td><c:out value="${history.comment}" /></td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
											<!--// ticket history details -->

										</div>
										<!--// panel body -->
									</form:form>
								</div>
								<!--// group ticket details -->
							</div>
						</div>
						<!-- 	//Ticket History Details tab -->

						
						<!-- Re-assign ticket if status is Acknowledged -->
						<c:choose>
							<c:when test="${ticketObject.status =='Acknowledged'}">

								<div class="tab-pane" id="mTicketAcknowledgedReassign">

									<div class="panel-body">

										<!-- ticketReassign Details -->
										<form:form action="performTicketAction"
											modelAttribute="performTicketAction" method="post"
											id="ticketAcknowledgedReassign" class="well form-horizontal">

											<legend style="font-size: 15px; line-height: 1.42857143;"
												align="center">
												<b>Re-assign</b>
											</legend>

											<!-- Action Action -->
											<input type="hidden" id="ticketAction" name="ticketAction"
												class="form-control selectpicker" value="Reassign">

											<!-- Text input Ticket Number-->
											<div class="form-group">
												<label class="col-md-3 control-label">Ticket Number</label>
												<div class="col-md-6 inputGroupContainer">
													<div class="input-group">
														<span class="input-group-addon"><i
															class="glyphicon glyphicon-barcode"></i></span> <input
															name="ticketNumber" id="ticketNumber"
															class="form-control" type="text"
															value="${ticketObject.ticketNumber}" readonly>
													</div>
												</div>
											</div>

											<!-- Assign Technician -->
											<div class="form-group">
												<label class="col-md-3 control-label">Assign Technician</label>
												<div class="col-md-6 selectContainer">
													<div class="input-group">
														<span class="input-group-addon"><i
															class="glyphicon glyphicon-list"></i></span> <select
															id="technicianUserName" name="technicianUserName"
															class="form-control selectpicker">
															<option value="">Select Technician</option>
															<c:forEach items="${reassignToTechnician}" var="technician">
																<c:choose>
																	<c:when test="${technician.leaveStatus =='Active'}">
																		<option class="onleave" value="${technician.email}">${technician.firstName}
																			${technician.lastName} (Leave Active)</option>
																	</c:when>
																	<c:when test="${technician.leaveStatus !='Active'}">
																		<option value="${technician.email}">${technician.firstName}
																			${technician.lastName}</option>
																	</c:when>
																</c:choose>
															</c:forEach>
														</select>
													</div>
												</div>
											</div>
											<div class="form-group row">
												<div class="col-sm col-sm-8"
													style="margin-left: 26%; width: 48%;">
													<input type="submit" name=resolve value="Re-assign Ticket"
														class="btn btn-primary btn-block btn-lg" tabindex="9"
														id="resolve">
												</div>
											</div>

										</form:form>
										<!-- ticketReassign Details -->

									</div>
									<!-- /panel body -->
								</div>
								<!-- /re-assign ticket -->
							</c:when>
						</c:choose>
						<!--// Re-assign ticket if status is Acknowledged -->
						

						<!-- Re-assign ticket if status is Escalated -->
						<c:choose>
							<c:when test="${ticketObject.status =='Escalated'}">

								<div class="tab-pane" id="mTicketEscalatedReassign">

									<div class="panel-body">

										<!-- ticketReassign Details -->
										<form:form action="performTicketAction"
											modelAttribute="performTicketAction" method="post"
											id="ticketEscalatedReassign" class="well form-horizontal">

											<legend style="font-size: 15px; line-height: 1.42857143;"
												align="center">
												<b>Re-assign</b>
											</legend>

											<!-- Action Action -->
											<input type="hidden" id="ticketAction" name="ticketAction"
												class="form-control selectpicker" value="Reassign">

											<!-- Text input Ticket Number-->
											<div class="form-group">
												<label class="col-md-3 control-label">Ticket Number</label>
												<div class="col-md-6 inputGroupContainer">
													<div class="input-group">
														<span class="input-group-addon"><i
															class="glyphicon glyphicon-barcode"></i></span> <input
															name="ticketNumber" id="ticketNumber"
															class="form-control" type="text"
															value="${ticketObject.ticketNumber}" readonly>
													</div>
												</div>
											</div>
											<!-- Assign Technician -->
											<div class="form-group">
												<label class="col-md-3 control-label">Assign
													Technician</label>
												<div class="col-md-6 selectContainer">
													<div class="input-group">
														<span class="input-group-addon"><i
															class="glyphicon glyphicon-list"></i></span> <select
															id="technicianUserName" name="technicianUserName"
															class="form-control selectpicker">
															<option value="">Select Technician</option>
															<c:forEach items="${reassignToTechnician}" var="technician">
																<c:choose>
																	<c:when test="${technician.leaveStatus =='Active'}">
																		<option class="onleave" value="${technician.email}">${technician.firstName}
																			${technician.lastName} (Leave Active)</option>
																	</c:when>
																	<c:when test="${technician.leaveStatus !='Active'}">
																		<option value="${technician.email}">${technician.firstName}
																			${technician.lastName}</option>
																	</c:when>
																</c:choose>
															</c:forEach>															
															
														</select>
													</div>
												</div>
											</div>

											<div class="form-group row">
												<div class="col-sm col-sm-8"
													style="margin-left: 26%; width: 48%;">
													<input type="submit" name=resolve value="Re-assign Ticket"
														class="btn btn-primary btn-block btn-lg" tabindex="9"
														id="resolve">
												</div>
											</div>

										</form:form>
										<!-- ticketReassign Details -->


									</div>
									<!-- /panel body -->
								</div>
								<!-- /re-assign ticket -->

							</c:when>
						</c:choose>
						<!-- //Re-assign ticket if status is Escalated -->


						<!-- Re-assign ticket if status is Open -->
						<c:choose>
							<c:when test="${ticketObject.status =='Open'}">

								<div class="tab-pane" id="mTicketOpenReassign">

									<div class="panel-body">

										<!-- ticketReassign Details -->
										<form:form action="performTicketAction"
											modelAttribute="performTicketAction" method="post"
											id="ticketOpenReassign" class="well form-horizontal">

											<legend style="font-size: 15px; line-height: 1.42857143;"
												align="center">
												<b>Re-assign</b>
											</legend>

											<!-- Action Action -->
											<input type="hidden" id="ticketAction" name="ticketAction"
												class="form-control selectpicker" value="Reassign">

											<!-- Text input Ticket Number-->
											<div class="form-group">
												<label class="col-md-3 control-label">Ticket Number</label>
												<div class="col-md-6 inputGroupContainer">
													<div class="input-group">
														<span class="input-group-addon"><i
															class="glyphicon glyphicon-barcode"></i></span> <input
															name="ticketNumber" id="ticketNumber"
															class="form-control" type="text"
															value="${ticketObject.ticketNumber}" readonly>
													</div>
												</div>
											</div>

											<!-- Assign Technician -->
											<div class="form-group">
												<label class="col-md-3 control-label">Assign
													Technician</label>
												<div class="col-md-6 selectContainer">
													<div class="input-group">
														<span class="input-group-addon"><i
															class="glyphicon glyphicon-list"></i></span> <select
															id="technicianUserName" name="technicianUserName"
															class="form-control selectpicker">
															<option value="">Select Technician</option>
															<c:forEach items="${reassignToTechnician}" var="technician">
																<c:choose>
																	<c:when test="${technician.leaveStatus =='Active'}">
																		<option class="onleave" value="${technician.email}">${technician.firstName}
																			${technician.lastName} (Leave Active)</option>
																	</c:when>
																	<c:when test="${technician.leaveStatus !='Active'}">
																		<option value="${technician.email}">${technician.firstName}
																			${technician.lastName}</option>
																	</c:when>
																</c:choose>
															</c:forEach>
														</select>
													</div>
												</div>
											</div>

											<div class="form-group row">
												<div class="col-sm col-sm-8"
													style="margin-left: 26%; width: 48%;">
													<input type="submit" name=resolve value="Re-assign Ticket"
														class="btn btn-primary btn-block btn-lg" tabindex="9"
														id="resolve">
												</div>
											</div>

										</form:form>
										<!-- ticketReassign Details -->


									</div>
									<!-- /panel body -->
								</div>
								<!-- /re-assign ticket -->

							</c:when>
						</c:choose>
						<!-- //Re-assign ticket if status is Open -->
						
						
						<!-- Escalate ticket if status is Taken -->
						<c:choose>
							<c:when test="${ticketObject.status =='Taken'}">

								<div class="tab-pane" id="mTicketTakenEscalate">

									<div class="panel-body">

										<!-- mTicketTakenEscalate Details -->
										<form:form action="performTicketAction"
											modelAttribute="performTicketAction" method="post"
											id="ticketTakenEscalate" class="well form-horizontal">

											<legend style="font-size: 15px; line-height: 1.42857143;"
												align="center">
												<b>Escalate</b>
											</legend>

											<!-- Action Action -->
											<input type="hidden" id="ticketAction" name="ticketAction"
												class="form-control selectpicker" value="Escalate">

											<!-- Text input Ticket Number-->
											<div class="form-group">
												<label class="col-md-3 control-label">Ticket Number</label>
												<div class="col-md-6 inputGroupContainer">
													<div class="input-group">
														<span class="input-group-addon"><i
															class="glyphicon glyphicon-barcode"></i></span> <input
															name="ticketNumber" id="ticketNumber"
															class="form-control" type="text"
															value="${ticketObject.ticketNumber}" readonly>
													</div>
												</div>
											</div>

											<!-- Text input Manager-->
											<div class="form-group">
												<label class="col-md-3 control-label"> Manager</label>
												<div class="col-md-6 inputGroupContainer">
													<div class="input-group">
														<span class="input-group-addon"><i
															class="glyphicon glyphicon-user"></i></span> <select
															id="escalatedTo" name="escalatedTo"
															class="form-control selectpicker">
															<option value="">Select Manager</option>
															<c:forEach items="${managersList}" var="manager">
																<option value="${manager.email}">${manager.email}
																	</option>
															</c:forEach>

														</select>
													</div>
												</div>
											</div>

											<!-- display Comments-->

											<div class="form-group">
												<label class="col-md-3 control-label">Comment</label>
												<div class="col-md-6 inputGroupContainer">
													<div class="input-group">
														<span class="input-group-addon"><i
															class="glyphicon glyphicon-edit"></i></span>
														<textarea class="form-control" id="comments"
															name="comments" maxlength="150"
															onkeydown="upperCaseF(this)"
															placeholder="Please enter comment" style="height: 120px;"></textarea>
													</div>
												</div>
											</div>

											<!--// display Comments-->

											<div class="form-group row">
												<div class="col-sm col-sm-8"
													style="margin-left: 26%; width: 48%;">
													<input type="submit" name=resolve value="Escalate Ticket"
														class="btn btn-primary btn-block btn-lg" tabindex="9"
														id="resolve">
												</div>
											</div>

										</form:form>
										<!-- escalate ticket Details -->


									</div>
									<!-- /panel body -->
								</div>
								<!-- /escalate ticket -->

							</c:when>
						</c:choose>
						<!-- // Escalate ticket if status is Taken -->

						<!-- Ticket Awaiting Spare if status is Taken -->
						<c:choose>
							<c:when test="${ticketObject.status =='Taken'}">

								<div class="tab-pane" id="mTicketTakenAwaiting">

									<div class="panel-body">

										<!-- mTicketTakenEscalate Details -->
										<form:form id="ticketTakenAwaiting"
											class="well form-horizontal" action="performTicketAction"
											modelAttribute="performTicketAction" method="post">

											<legend style="font-size: 15px; line-height: 1.42857143;"
												align="center">
												<b>Awaiting Spares</b>
											</legend>

											<!-- Action Action -->
											<input type="hidden" id="ticketAction" name="ticketAction"
												class="form-control selectpicker" value="awaitingspares">

											<!-- Text input Ticket Number-->
											<div class="form-group">
												<label class="col-md-3 control-label">Ticket Number</label>
												<div class="col-md-6 inputGroupContainer">
													<div class="input-group">
														<span class="input-group-addon"><i
															class="glyphicon glyphicon-barcode"></i></span> <input
															name="ticketNumber" id="ticketNumber"
															class="form-control" type="text"
															value="${ticketObject.ticketNumber}" readonly>
													</div>
												</div>
											</div>

											<!-- Text input Order No-->
											<div class="form-group">
												<label class="col-md-3 control-label"> Order No</label>
												<div class="col-md-6 inputGroupContainer">
													<div class="input-group">
														<span class="input-group-addon"><i
															class="glyphicon glyphicon-user"></i></span> <select
															id="orderNum" name="orderNum"
															class="form-control selectpicker">
															<option value="">Select Order No</option>
															<c:forEach items="${OrderNumber}" var="orders">
																<option value="${orders.recordID}">${orders.orderNum}
																</option>
															</c:forEach>

														</select>
													</div>
												</div>
											</div>

											<div class="form-group row">
												<div class="col-sm col-sm-8"
													style="margin-left: 26%; width: 48%;">
													<input type="submit" name=resolve
														value="Awaiting For Spares"
														class="btn btn-primary btn-block btn-lg" tabindex="9"
														id="resolve">
												</div>
											</div>

										</form:form>
										<!-- Awaiting ticket Details -->

									</div>
								</div>
							</c:when>
						</c:choose>
						<!-- //Ticket Awaiting Spare if status is Taken -->
						
						
						<!-- Details for Resolving ticket if status is Escalated  -->
						<c:choose>
							<c:when test="${ticketObject.status =='Escalated'}">

								<div class="tab-pane" id="mTicketEscalatedResolvedDetails">

									<div class="panel-body">

										<!-- resolved details -->
										<form:form action="performTicketAction"
											modelAttribute="performTicketAction" method="post"
											id="updateResolved" class="well form-horizontal">

											<legend style="font-size: 15px; line-height: 1.42857143;"
												align="center">
												<b>Resolve</b>
											</legend>
											
											<!-- Action Action -->
											<input type="hidden" id="ticketAction" name="ticketAction"
												class="form-control selectpicker" value="Resolve">	

											<!-- Text input Ticket Number-->
											<div class="form-group">
												<label class="col-md-3 control-label">Ticket Number</label>
												<div class="col-md-6 inputGroupContainer">
													<div class="input-group"><span class="input-group-addon"><i
													   class="glyphicon glyphicon-barcode"></i></span>
													   	<input name="ticketNumber" id="ticketNumber" class="form-control" type="text" value="${ticketObject.ticketNumber}" readonly>
													</div>
												</div>
											</div>
											
											<!-- Text area Action Taken-->
											<div class="form-group">
												<label class="col-md-3 control-label">Action Taken</label>
												<div class="col-md-6 selectContainer">
													<div class="input-group">
														<span class="input-group-addon"><i
															class="glyphicon glyphicon-list"></i></span><select
															name="actionTaken" id="actionTaken"
															class="form-control selectpicker"
															onchange="Faulty(this.value);">
															<option value="">Please select Action Taken for
																Repair</option>
															<option value="Replaced Part/Toner">Replaced
																Part/Toner</option>
															<option value="Cleared Paper Jam">Cleared Paper
																Jam</option>
															<option value="Installed Drivers">Installed
																Drivers</option>
															<option value="Configured Drivers">Configured
																Drivers</option>
															<option value="Configured Printer">Configured
																Printer</option>
															<option value="User Error">User Error</option>
															<option value="No fault Found">No fault Found</option>
															<option value="Cleaned Mirrors">Cleaned Mirrors</option>
															<option value="Cleaned Laser Unit">Cleaned Laser Unit</option>
															<option value="Cleaned Charge Rollers">Cleaned Charge Rollers</option>
															<option value="Cleaned ADF Class">Cleaned ADF Class</option>
															<option value="Cleaned Rollers">Cleaned Rollers</option>
														</select>
													</div>
												</div>
											</div>

											<div class="hideMonoAndColour" id="hideMonoAndColour"
												style="display: none">

												<c:if test="${not empty ticketObject.device.colourReading}">
													<!-- Text checkbox Colour Reading-->
													<div class="form-group">
														<label class="col-md-3 control-label">Colour
															Reading</label>
														<div class="col-md-6 inputGroupContainer">
															<div class="input-group">
																<span class="input-group-addon"><i
																	class="glyphicon glyphicon-list"></i></span> <input
																	type="text" class="form-control"
																	onkeypress="return isNumber(event)"
																	placeholder="Enter Colour Reading" id="colourReading"
																	name="colourReading"  onblur="compareColourReading(this, ${ticketObject.device.colourReading})">
															</div>
														</div>
													</div>
												</c:if>
												<div class="form-group">
													<label class="col-md-3 control-label">Mono Reading</label>
													<div class="col-md-6 inputGroupContainer">
														<div class="input-group">
															<span class="input-group-addon"><i
																class="glyphicon glyphicon-list"></i></span> <input type="text"
																class="form-control" onkeypress="return isNumber(event)"
																id="mono" name="monoReading"
																placeholder="Enter Mono Reading" onblur="compareMonoReading(this, ${ticketObject.device.monoReading})">
														</div>
													</div>
												</div>

											</div>
											<!-- HideMonoAndColour if no action is selscted -->
											
											<!-- group Used Part Numbers -->
											<div class="groupsearchdetails">

												<legend id="hideUsedPartNumbersHidding"
													style="display: none; width: 50%; margin-left: 25%;">Used
													Part Numbers </legend>

												<div class="hideIfIsNotPartToner" id="hideIfIsNotPartToner"
													style="display: none">

													<fieldset id="groupstock" style="margin-left: 0%">

														<!-- group Boot Stock -->
														<div class="form-group">
															<label class="col-xs-3 control-label">Boot Stock</label>
															<div class="col-md-6 inputGroupContainer">
																<input type="radio" name="groupboot" required id="checkBootStock" onclick="BootStockChecked()" value="Boot Stock" tittle="You must check Boot Stock or Site Stock to get Used Part Numbers">
															</div>
														</div>														
														<div class="displayNone" id="bootStockItems" style="margin-left: 25.5%;margin-right: 26%;" >
															<table id="bStock" class="display datatable">
																		<thead>
																			<tr>
																				<th>Part No</th>
																				<th>Description</th>
																				<th>Item Type</th>
																				<th>Quantity</th>
																				<th>Tick Used Parts</th>
			
																			</tr>
																		</thead>
																		<tbody>
																			<!-- Iterating over the list sent from Controller -->
																			<c:forEach var="list" items="${bootStock}">
			
																				<tr>
																					<td>${list.partNumber}</td>
																					<td>${list.itemDescription}</td>
																					<td>${list.itemType}</td>
																					<td>${list.quantity}</td>
																					<td><input type="checkbox"
																						id="${list.partNumber}_selectedItem"
																						name="selectedItem"	onClick="checkUsedPartNumbers();"
																						value="${list.partNumber}"></td>
																				</tr>
			
																			</c:forEach>
																		</tbody>
																</table>
														 </div>
														 <input type="hidden" class="form-control" id="bootStockType" name="bootStockType" value="Boot Stock">

														<!-- group Site Stock -->
														<div class="form-group">
															<label class="col-xs-3 control-label">Site Stock</label>
															<div class="col-md-6 inputGroupContainer">
																<input type="radio" name="groupboot" required id="checkSiteStock" onclick="SiteStockChecked()" value="Site Stock" >
															</div>
														</div>
														<div class="displayNone" id="siteStockItems" style="margin-left: 25.5%;margin-right: 26%;">
															<table id="sStock" class="display datatable">
																<thead>
																	<tr>
																		<th>Part No</th>
																		<th>Description</th>
																		<th>Model No</th>
																		<th>Quantity</th>
																		<th>Tick Used Parts</th>
																	</tr>
																</thead>
																<tbody>
																	<!-- Iterating over the list sent from Controller -->
																	<c:forEach var="list" items="${siteStock}">	
																		<tr>
																			<td>${list.partNumber}</td>
																			<td>${list.itemDescription}</td>
																			<td>${list.itemType}</td>
																			<td>${list.quantity}</td>
																			<td><input type="checkbox"
																				id="${list.partNumber}_selectedItem"
																				name="selectedItem" onClick="checkUsedPartNumbers();"
																				value="${list.partNumber}"></td>
																		</tr>
																	</c:forEach>
																</tbody>
															</table>
														</div></br>
														<input type="hidden" class="form-control" id="siteStockType"
															name="siteStockType" value="Site Stock">

													</fieldset>
													
													
													<!-- display ticked Used Part Numbers-->
													<div class="form-group">
														<label class="col-md-3 control-label">Used Part
															Numbers</label>
														<div class="col-md-6 inputGroupContainer">
															<div class="input-group">
																<span class="input-group-addon"><i
																	class="glyphicon glyphicon-list"></i></span>
																<input id="usedPartNumbers" name="usedPartNumbers"
																	 class="form-control" readonly="readonly"
																	style="height: 60px; font-size: 11px;">
													 
															</div>
														</div>
													</div>
													<!--// display ticked Used Part Numbers-->
													
													<!-- Text area comments-->												
													<div class="form-group">
														<label class="col-md-3 control-label">Comment</label>
														<div class="col-md-6 inputGroupContainer">
															<div class="input-group">
																<span class="input-group-addon"><i
																	class="glyphicon glyphicon-edit"></i></span>
																<textarea class="form-control" style="height: 120px;" id="comments" name="comments" maxlength="150"
																	 onkeydown="upperCaseF(this)" placeholder="Please enter comment"
																	></textarea>
															</div>
														</div>
													</div><!--// text area comments-->	
                                                    
												</div>
												<!-- // end hideIfIsNotPartToner -->

												<!-- hideComent-->
												<div class="hideComent" id="hideComent" style="display: none">
													
													<!-- Text area comments-->												
													<div class="form-group">
														<label class="col-md-3 control-label">Comment</label>
														<div class="col-md-6 inputGroupContainer">
															<div class="input-group">
																<span class="input-group-addon"><i
																	class="glyphicon glyphicon-edit"></i></span>
																<textarea class="form-control" style="height: 120px;" id="comments" name="comments" maxlength="150"
																	 onkeydown="upperCaseF(this)" placeholder="Please enter comment"
																	></textarea>
															</div>
														</div>
													</div><!--// text area comments-->	
													
												</div><!-- //hideComent -->												
												
												</div>
												<!-- // group used part numbers -->
										
											<div class="actionTakenSubmit" id="actionTakenSubmit"
												style="display: none;">

												<div class="form-group row">
													<div class="col-sm col-sm-8"
														style="margin-left: 26%; width: 48%;">
														<input type="submit" name=resolve value="Resolve Ticket"
															class="btn btn-primary btn-block btn-lg" tabindex="9"
															id=2>
													</div>
												</div>

											</div>
											<!-- //actionTakenSubmit -->
											
											</form:form>

									</div>
								</div>
								<!-- //resolvedSolution  -->

							</c:when>
						</c:choose>
						<!-- // Details for Resolving ticket if status is Escalated  -->


						<!-- Detials for SLA bridged tickets -->
						<c:choose>
							<c:when test="${ticketObject.status =='SLA Bridged'}">
							 
							 <div class="tab-pane" id="mTicketSLABridgedResolved">

									<div class="panel-body">

										<!-- tTicketTakenResolve Details -->
										<form:form action="performTicketAction" modelAttribute="performTicketAction"
											method="post" id="updateResolved"
											class="well form-horizontal">

											<legend style="font-size: 15px; line-height: 1.42857143;"
												align="center">
												<b>Resolve</b>
											</legend>
											
											<!-- Action Action -->
											<input type="hidden" id="ticketAction" name="ticketAction"
												class="form-control selectpicker" value="Resolve">												
												
											<!-- Text input Ticket Number-->
											<div class="form-group">
												<label class="col-md-3 control-label">Ticket Number</label>
												<div class="col-md-6 inputGroupContainer">
													<div class="input-group"><span class="input-group-addon"><i
													   class="glyphicon glyphicon-barcode"></i></span>
													   	<input name="ticketNumber" id="ticketNumber" class="form-control" type="text" value="${ticketObject.ticketNumber}" readonly>
													</div>
												</div>
											</div>
											
											
											<!-- Text area Action Taken-->
											<div class="form-group">
												<label class="col-md-3 control-label">Action Taken</label>
												<div class="col-md-6 selectContainer">
													<div class="input-group">
														<span class="input-group-addon"><i
															class="glyphicon glyphicon-list"></i></span><select
															name="actionTaken" id="actionTaken"
															class="form-control selectpicker"
															onchange="Faulty(this.value);">
															<option value="">Please select Action Taken for
																Repair</option>
															<option value="Replaced Part/Toner">Replaced
																Part/Toner</option>
															<option value="Cleared Paper Jam">Cleared Paper
																Jam</option>
															<option value="Installed Drivers">Installed
																Drivers</option>
															<option value="Configured Drivers">Configured
																Drivers</option>
															<option value="Configured Printer">Configured
																Printer</option>
															<option value="User Error">User Error</option>
															<option value="No fault Found">No fault Found</option>															
															<option value="Cleaned Mirrors">Cleaned Mirrors</option>
															<option value="Cleaned Laser Unit">Cleaned Laser Unit</option>
															<option value="Cleaned Charge Rollers">Cleaned Charge Rollers</option>
															<option value="Cleaned ADF Class">Cleaned ADF Class</option>
															<option value="Cleaned Rollers">Cleaned Rollers</option>
															
														</select>
													</div>
												</div>
											</div>

											<div class="hideMonoAndColour" id="hideMonoAndColour"
												style="display: none">

												<c:if test="${not empty ticketObject.device.colourReading}">
													<!-- Text checkbox Colour Reading-->
													<div class="form-group">
														<label class="col-md-3 control-label">Colour
															Reading</label>
														<div class="col-md-6 inputGroupContainer">
															<div class="input-group">
																<span class="input-group-addon"><i
																	class="glyphicon glyphicon-list"></i></span> <input
																	type="text" class="form-control"
																	onkeypress="return isNumber(event)"
																	placeholder="Enter Colour Reading" id="colourReading"
																	name="colourReading"  onblur="compareColourReading(this, ${ticketObject.device.colourReading})">
															</div>
														</div>
													</div>
												</c:if>
												<div class="form-group">
													<label class="col-md-3 control-label">Mono Reading</label>
													<div class="col-md-6 inputGroupContainer">
														<div class="input-group">
															<span class="input-group-addon"><i
																class="glyphicon glyphicon-list"></i></span> <input type="text"
																class="form-control" onkeypress="return isNumber(event)"
																id="mono" name="monoReading"
																placeholder="Enter Mono Reading" onblur="compareMonoReading(this, ${ticketObject.device.monoReading})">
														</div>
													</div>
												</div>

											</div>
											<!-- HideMonoAndColour if no action is selscted -->
											
											<!-- group Used Part Numbers -->
											<div class="groupsearchdetails">

												<legend id="hideUsedPartNumbersHidding"
													style="display: none; width: 50%; margin-left: 25%;">Used
													Part Numbers </legend>

												<div class="hideIfIsNotPartToner" id="hideIfIsNotPartToner"
													style="display: none">

													<fieldset id="groupstock" style="margin-left: 0%">

														<!-- group Boot Stock -->
														<div class="form-group">
															<label class="col-xs-3 control-label">Boot Stock</label>
															<div class="col-md-6 inputGroupContainer">
																<input type="radio" name="groupboot" required id="checkBootStock" onclick="BootStockChecked()" value="Boot Stock" tittle="You must check Boot Stock or Site Stock to get Used Part Numbers">
															</div>
														</div>														
														<div class="displayNone" id="bootStockItems" style="margin-left: 25.5%;margin-right: 26%;" >
															<table id="bStock" class="display datatable">
																		<thead>
																			<tr>
																				<th>Part No</th>
																				<th>Description</th>
																				<th>Item Type</th>
																				<th>Quantity</th>
																				<th>Tick Used Parts</th>
			
																			</tr>
																		</thead>
																		<tbody>
																			<!-- Iterating over the list sent from Controller -->
																			<c:forEach var="list" items="${bootStock}">
			
																				<tr>
																					<td>${list.partNumber}</td>
																					<td>${list.itemDescription}</td>
																					<td>${list.itemType}</td>
																					<td>${list.quantity}</td>
																					<td><input type="checkbox"
																						id="${list.partNumber}_selectedItem"
																						name="selectedItem"	onClick="checkUsedPartNumbers();"
																						value="${list.partNumber}"></td>
																				</tr>
			
																			</c:forEach>
																		</tbody>
																</table>
														 </div>
														 <input type="hidden" class="form-control" id="bootStockType" name="bootStockType" value="Boot Stock">

														<!-- group Site Stock -->
														<div class="form-group">
															<label class="col-xs-3 control-label">Site Stock</label>
															<div class="col-md-6 inputGroupContainer">
																<input type="radio" name="groupboot" required id="checkSiteStock" onclick="SiteStockChecked()" value="Site Stock" >
															</div>
														</div>
														<div class="displayNone" id="siteStockItems" style="margin-left: 25.5%;margin-right: 26%;">
															<table id="sStock" class="display datatable">
																<thead>
																	<tr>
																		<th>Part No</th>
																		<th>Description</th>
																		<th>Model No</th>
																		<th>Quantity</th>
																		<th>Tick Used Parts</th>
																	</tr>
																</thead>
																<tbody>
																	<!-- Iterating over the list sent from Controller -->
																	<c:forEach var="list" items="${siteStock}">	
																		<tr>
																			<td>${list.partNumber}</td>
																			<td>${list.itemDescription}</td>
																			<td>${list.itemType}</td>
																			<td>${list.quantity}</td>
																			<td><input type="checkbox"
																				id="${list.partNumber}_selectedItem"
																				name="selectedItem" onClick="checkUsedPartNumbers();"
																				value="${list.partNumber}"></td>
																		</tr>
																	</c:forEach>
																</tbody>
															</table>
														</div></br>
														<input type="hidden" class="form-control" id="siteStockType"
															name="siteStockType" value="Site Stock">

													</fieldset>
													
													
													<!-- display ticked Used Part Numbers-->
													<div class="form-group">
														<label class="col-md-3 control-label">Used Part
															Numbers</label>
														<div class="col-md-6 inputGroupContainer">
															<div class="input-group">
																<span class="input-group-addon"><i
																	class="glyphicon glyphicon-list"></i></span>
																<input id="usedPartNumbers" name="usedPartNumbers"
																	 class="form-control" readonly="readonly"
																	style="height: 60px; font-size: 11px;">
															</div>
														</div>
													</div>
													<!--// display ticked Used Part Numbers-->
                                                    
                                                    <!-- Text area comments-->												
													<div class="form-group">
														<label class="col-md-3 control-label">Comment</label>
														<div class="col-md-6 inputGroupContainer">
															<div class="input-group">
																<span class="input-group-addon"><i
																	class="glyphicon glyphicon-edit"></i></span>
																<textarea class="form-control" style="height: 120px;" id="comments" name="comments" maxlength="150"
																	 onkeydown="upperCaseF(this)" placeholder="Please enter comment"
																	></textarea>
															</div>
														</div>
													</div><!--// text area comments-->	
                                                    
                                                    <!-- display Bridged-->	
													<div class="reseanBridged" id="reseanBridged">
														<div class="form-group">
															<label class="col-md-3 control-label">Bridged Reason</label>
															<div class="col-md-6 inputGroupContainer">
																<div class="input-group">
																	<span class="input-group-addon"><i
																		class="glyphicon glyphicon-edit"></i></span>
																	<textarea class="form-control" style="height: 120px;" id="bridgedReason" name="bridgedReason" maxlength="150"
																		 onkeydown="upperCaseF(this)" placeholder="Please enter reason why ticket Bridged"
																		></textarea>
																</div>
															</div>
														</div>												
													</div><!-- //End display Bridged-->	
                                                    
                                                    
												</div>
												<!-- // end hideIfIsNotPartToner -->

												<!-- hideComent-->
												<div class="hideComent" id="hideComent" style="display: none">
													
													<!-- Text area comments-->												
													<div class="form-group">
														<label class="col-md-3 control-label">Comment</label>
														<div class="col-md-6 inputGroupContainer">
															<div class="input-group">
																<span class="input-group-addon"><i
																	class="glyphicon glyphicon-edit"></i></span>
																<textarea class="form-control" style="height: 120px;" id="comments" name="comments" maxlength="150"
																	 onkeydown="upperCaseF(this)" placeholder="Please enter comment"
																	></textarea>
															</div>
														</div>
													</div><!--// text area comments-->	
													
													 <!-- display Bridged-->	
													<div class="reseanBridged" id="reseanBridged">
														<div class="form-group">
															<label class="col-md-3 control-label">Bridged Reason</label>
															<div class="col-md-6 inputGroupContainer">
																<div class="input-group">
																	<span class="input-group-addon"><i
																		class="glyphicon glyphicon-edit"></i></span>
																	<textarea class="form-control" style="height: 120px;" id="bridgedReason" name="bridgedReason" maxlength="150"
																		 onkeydown="upperCaseF(this)" placeholder="Please enter reason why ticket Bridged"
																		></textarea>
																</div>
															</div>
														</div>												
													</div><!-- //End display Bridged-->													
												
												</div><!-- //hideComent -->												
												
												</div>
												<!-- // group used part numbers -->
										
											<div class="actionTakenSubmit" id="actionTakenSubmit"
												style="display: none;">

												<div class="form-group row">
													<div class="col-sm col-sm-8"
														style="margin-left: 26%; width: 48%;">
														<input type="submit" name=resolve value="Resolve Ticket"
															class="btn btn-primary btn-block btn-lg" tabindex="9"
															id="resolve">
													</div>
												</div>

											</div>
											<!-- //actionTakenSubmit -->
											
					                   </form:form>
					                   
					                   </div>				                   
					              </div>
							 </c:when>						
						</c:choose>
						
						<!-- Re-open ticket if status is Resolved and display resolved details -->
						<c:choose>
							<c:when test="${ticketObject.status =='Resolved'}">

								<!-- ticketReopenResolved -->
								<div class="tab-pane" id="mTicketReopenResolved">

									<div class="panel-body">

										<!-- mTicketTakenEscalate Details -->
										<form:form id="ticketTakenAwaiting"
											class="well form-horizontal" action="performTicketAction"
											modelAttribute="performTicketAction" method="post">

											<legend style="font-size: 15px; line-height: 1.42857143;"
												align="center">
												<b>Resolved Details</b>
											</legend>

											<!-- Action Action -->
											<input type="hidden" id="ticketAction" name="ticketAction"
												class="form-control selectpicker" value="reopen">

											<!-- Text input Ticket Number-->
											<div class="form-group">
												<label class="col-md-3 control-label">Ticket Number</label>
												<div class="col-md-6 inputGroupContainer">
													<div class="input-group">
														<span class="input-group-addon"><i
															class="glyphicon glyphicon-barcode"></i></span> <input
															name="ticketNumber" id="ticketNumber"
															class="form-control" type="text"
															value="${ticketObject.ticketNumber}" readonly>
													</div>
												</div>
											</div>
											
											<!-- Text input Serial No-->
											<div class="form-group">
												<label class="col-md-3 control-label">Serial No</label>
												<div class="col-md-6 inputGroupContainer">
													<div class="input-group">
														<span class="input-group-addon"><i
															class="glyphicon glyphicon-barcode"></i></span> <input
															name="serialNumber" placeholder="Serial Number"
															value="${ticketObject.getDevice().getSerialNumber() }"
															class="form-control" type="text" readonly>
													</div>
												</div>
											</div>

											<!-- Text area Action Taken-->
											<div class="actionTaken">
												<div class="form-group">
												  <label class="col-md-3 control-label">Action Taken</label>
														<div class="col-md-6 inputGroupContainer">
															<div class="input-group">
																<span class="input-group-addon"><i
																	class="glyphicon glyphicon-barcode"></i></span> <input
																	id="actionTaken" class="form-control" type="text"
																	name="actionTaken" value="${ticketObject.actionTaken}"
																	readonly="readonly">
														</div>
													</div>
												</div>
											</div>
										

											<%-- <c:if test="${empty ticketObject.comments}">
											</c:if>
											<c:if test="${not empty ticketObject.comments}">
											</c:if> --%>
												<!-- Text area Comment-->
												<div class="form-group">
													<label class="col-md-3 control-label">Comments</label>
													<div class="col-md-6 inputGroupContainer">
														<div class="input-group">
															<span class="input-group-addon"><i
																class="glyphicon glyphicon-pencil"></i></span>
															<textarea class="form-control" name="comments"
																id="comments" readonly="readonly" style="height: 120px;">${ticketObject.comments}</textarea>
														</div>
													</div>
												</div>
												
										<c:if test="${empty ticketObject.bridgedReason}">
										</c:if>
										<c:if test="${not empty ticketObject.bridgedReason}">
										 <!-- display Bridged-->	
														<div class="reseanBridged" id="reseanBridged">
															<div class="form-group">
																<label class="col-md-3 control-label">Bridged Reason</label>
																<div class="col-md-6 inputGroupContainer">
																	<div class="input-group">
																		<span class="input-group-addon"><i
																			class="glyphicon glyphicon-edit"></i></span>
																		<textarea class="form-control" style="height: 120px;" id="bridgedReason" readonly="readonly" name="bridgedReason" maxlength="150"
																			 onkeydown="upperCaseF(this)">${ticketObject.bridgedReason}</textarea>
																	</div>
																</div>
															</div>												
										  </div><!-- //End display Bridged-->		
										</c:if> 
											

											<c:if test="${empty ticketObject.usedPartNumbers}">
											</c:if>
											<c:if test="${not empty ticketObject.usedPartNumbers}">

												<!-- Text area Used Spare Part-->
												<div class="usedPartNumbersDetails">
													<div class="form-group">
														<label class="col-md-3 control-label">Used
															Spare/Part</label>
														<div class="col-md-6 inputGroupContainer">
															<div class="input-group">
																<span class="input-group-addon"><i
																	class="glyphicon glyphicon-barcode"></i></span> <input
																	id="usedPartNumbers" class="form-control" type="text"
																	name="usedPartNumbers"
																	value="${ticketObject.usedPartNumbers}"
																	readonly="readonly" style="height: 60px; font-size: 11px;">
															</div>
														</div>
													</div>
												</div>
											</c:if>
											
											<c:if
												test="${empty $ticketObject.getDevice().getColourReading()}">
											</c:if>
											<c:if
												test="${not empty $ticketObject.getDevice().getColourReading()}">

												<!-- Text checkbox Colour Reading-->
												<div class="form-group">
													<label class="col-md-3 control-label">Colour
														Reading</label>
													<div class="col-md-6 inputGroupContainer">
														<div class="input-group">
															<span class="input-group-addon"><i
																class="glyphicon glyphicon-barcode"></i></span> <input
																type="text" class="form-control" readonly="readonly"
																onkeypress="return isNumber(event)"
																placeholder="Enter Colour Reading" id="colour"
																name="colourReading"
																value="${ticketObject.getDevice().getColourReading() }"
																name="colourReading">
														</div>
													</div>
												</div>
											</c:if>

											<c:if
												test="${empty $ticketObject.getDevice().getMonoReading()}">
											</c:if>
											<c:if
												test="${not empty $ticketObject.getDevice().getMonoReading()}">

												<div class="form-group">
													<label class="col-md-3 control-label">Mono Reading</label>
													<div class="col-md-6 inputGroupContainer">
														<div class="input-group">
															<span class="input-group-addon"><i
																class="glyphicon glyphicon-barcode"></i></span> <input
																type="text" class="form-control"
																onkeypress="return isNumber(event)" id="mono"
																readonly="readonly" name="monoReading"
																placeholder="Enter Mono Reading" name="monoReading"
																value="${ticketObject.getDevice().getMonoReading() }">
														</div>
													</div>
												</div>
											</c:if>
											<div class="diplayNone" id="getPartTonerResolved"
												style="display: none">

												<!-- display ticked Used Part Numbers-->
												<div class="form-group">
													<label class="col-md-3 control-label">Used Part
														Numbers</label>
													<div class="col-md-6 inputGroupContainer">
														<div class="input-group">
															<span class="input-group-addon"><i
																class="glyphicon glyphicon-barcode"></i></span>
															<input id="tickedUsedPartNumbers" class="form-control"
																readonly="readonly" style="height: 60px; font-size: 11px;" name="usedPartNumbers">
														</div>
													</div>
												</div>
												<!--// display ticked Used Part Numbers-->

											</div>
											<!-- displayNone for getPartToner -->

											<div class="form-group row">
												<div class="col-sm col-sm-8"
													style="margin-left: 26%; width: 48%;">
													<input type="submit" name=resolve value="Re-Open Ticket"
														class="btn btn-primary btn-block btn-lg" tabindex="9"
														id="resolve">
												</div>
											</div>

										</form:form>
									</div>
									<!-- pane body -->
								</div>
							</c:when>
						</c:choose>
						<!-- //Re-open ticket if status is Resolved and display resolved details -->

						<!-- Show ticket details if status is closed with no action and display resolved details -->
						<c:choose>
							<c:when test="${ticketObject.status =='Closed'}">

								<!-- ticketClosedNoAction -->
								<div class="tab-pane" id="mTicketClosedNoAction">

									<div class="panel-body">

										<form:form class="well form-horizontal">
											<legend style="font-size: 15px; line-height: 1.42857143;"
												align="center">
												<b>Closed Details</b>
											</legend>
											<!-- Text input Serial No-->
											<div class="form-group">
												<label class="col-md-3 control-label">Serial No</label>
												<div class="col-md-6 inputGroupContainer">
													<div class="input-group">
														<span class="input-group-addon"><i
															class="glyphicon glyphicon-barcode"></i></span> <input
															name="serialNumber" placeholder="Serial Number"
															value="${ticketObject.getDevice().getSerialNumber() }"
															class="form-control" type="text" readonly>
													</div>
												</div>
											</div>

											<c:if test="${empty ticketObject.actionTaken}">
											</c:if>
											<c:if test="${not empty ticketObject.actionTaken}">

												<!-- Text area Action Taken-->
												<div class="actionTaken">
													<div class="form-group">
														<label class="col-md-3 control-label">Action Taken</label>
														<div class="col-md-6 inputGroupContainer">
															<div class="input-group">
																<span class="input-group-addon"><i
																	class="glyphicon glyphicon-barcode"></i></span> <input
																	id="actionTaken" class="form-control" type="text"
																	name="actionTaken" value="${ticketObject.actionTaken}"
																	readonly="readonly">
															</div>
														</div>
													</div>
												</div>
											</c:if>

											<c:if test="${empty ticketObject.comments}">
											</c:if>
											<c:if test="${not empty ticketObject.comments}">
												<!-- Text area Comment-->
												<div class="form-group">
													<label class="col-md-3 control-label">Comments</label>
													<div class="col-md-6 inputGroupContainer">
														<div class="input-group">
															<span class="input-group-addon"><i
																class="glyphicon glyphicon-pencil"></i></span>
															<textarea class="form-control" name="comments"
																id="comment" readonly="readonly" style="height: 120px;">${ticketObject.comments}</textarea>
														</div>
													</div>
												</div>
											</c:if>
											
											<c:if test="${empty ticketObject.bridgedReason}">
									</c:if>
									<c:if test="${not empty ticketObject.bridgedReason}">
									 <!-- display Bridged-->	
													<div class="reseanBridged" id="reseanBridged">
														<div class="form-group">
															<label class="col-md-3 control-label">Bridged Reason</label>
															<div class="col-md-6 inputGroupContainer">
																<div class="input-group">
																	<span class="input-group-addon"><i
																		class="glyphicon glyphicon-edit"></i></span>
																	<textarea class="form-control" style="height: 120px;" id="bridgedReason" readonly="readonly" name="bridgedReason" maxlength="150"
																		 onkeydown="upperCaseF(this)">${ticketObject.bridgedReason}</textarea>
																</div>
															</div>
														</div>												
									  </div><!-- //End display Bridged-->		
									</c:if> 

											<c:if test="${empty ticketObject.usedPartNumbers}">
											</c:if>
											<c:if test="${not empty ticketObject.usedPartNumbers}">

												<!-- Text area Used Spare Part-->
												<div class="usedPartNumbersDetails">
													<div class="form-group">
														<label class="col-md-3 control-label">Used
															Spare/Part</label>
														<div class="col-md-6 inputGroupContainer">
															<div class="input-group">
																<span class="input-group-addon"><i
																	class="glyphicon glyphicon-barcode"></i></span> <input
																	id="usedPartNumbers" class="form-control" type="text"
																	name="usedPartNumbers" value="${ticketObject.usedPartNumbers}"
																	readonly="readonly" style="height: 60px; font-size: 11px;">
															</div>
														</div>
													</div>
												</div>
											</c:if>
											<c:if
												test="${empty $ticketObject.getDevice().getColourReading()}">
											</c:if>
											<c:if
												test="${not empty $ticketObject.getDevice().getColourReading()}">

												<!-- Text checkbox Colour Reading-->
												<div class="form-group">
													<label class="col-md-3 control-label">Colour
														Reading</label>
													<div class="col-md-6 inputGroupContainer">
														<div class="input-group">
															<span class="input-group-addon"><i
																class="glyphicon glyphicon-barcode"></i></span> <input
																type="text" class="form-control" readonly="readonly"
																onkeypress="return isNumber(event)"
																placeholder="Enter Colour Reading" id="colour"
																name="colourReading"
																value="${ticketObject.getDevice().getColourReading() }"
																name="colourReading">
														</div>
													</div>
												</div>
											</c:if>

											<c:if
												test="${empty $ticketObject.getDevice().getMonoReading()}">
											</c:if>
											<c:if
												test="${not empty $ticketObject.getDevice().getMonoReading()}">

												<div class="form-group">
													<label class="col-md-3 control-label">Mono Reading</label>
													<div class="col-md-6 inputGroupContainer">
														<div class="input-group">
															<span class="input-group-addon"><i
																class="glyphicon glyphicon-barcode"></i></span> <input
																type="text" class="form-control"
																onkeypress="return isNumber(event)" id="mono"
																readonly="readonly" name="monoReading"
																placeholder="Enter Mono Reading" name="monoReading"
																value="${ticketObject.getDevice().getMonoReading() }">
														</div>
													</div>
												</div>
											</c:if>

											<div class="diplayNone" id="getPartTonerResolved"
												style="display: none">

												<!-- display ticked Used Part Numbers-->
												<div class="form-group">
													<label class="col-md-3 control-label">Used Part
														Numbers</label>
													<div class="col-md-6 inputGroupContainer">
														<div class="input-group">
															<span class="input-group-addon"><i
																class="glyphicon glyphicon-barcode"></i></span>
															<input id="tickedUsedPartNumbers" class="form-control"
																readonly="readonly" name="usedPartNumbers" style="height: 60px; font-size: 11px;">
														</div>
													</div>
												</div>
												<!--// display ticked Used Part Numbers-->
											</div>
											<!-- displayNone for getPartToner -->

										</form:form>
									</div>
									<!-- pane body -->
								</div>
							</c:when>
						</c:choose>
						<!-- //Show ticket details if status is closed with no action and display resolved details -->
					</div>
					<!-- group details-row-padding -->
				</div>
				<!-- /tab-content -->
			</div>
			<!-- /panel body -->
		</div>
		<!-- /Container -->

		<!-- Footer -->
		<c:import url="templates/footer.jsp"></c:import>
		<!--/ Footer -->

		<!-- / velaphanda_containter -->
	</div>
	<!--/panel success class-->

</body>

<script type="text/javascript" src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jquery/1.13.1/jquery.validate.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>

<!-- Datatables -->
<script type="text/javascript" src="<c:url value="/resources/datatables/datatables.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/datatables/1.10.13/js/jquery-ui.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/datatables/1.10.13/js/dataTables.buttons.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/datatables/1.10.13/js/dataTables.jqueryui.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/datatables/1.10.13/js/dataTables.select.js" />"></script>
<!-- //Datatables -->

<script type="text/javascript" src="<c:url value="/resources/custom/js/velas_ticketdetails.js" />"></script>

<!-- Set active to selected tab -->
<script type="text/javascript">


	//hide tabs of actions on page load
	
	//Do not show tabs, up until user click on action
	$('.mTicketOpenReassign').hide();
	//end hide of Take tabs 
	
	//Do not shw tabs for status that is Acknowledged, up until user click on action
	$('.mTicketAcknowledgedReassign').hide();
	//end hide of Acknowledged tabs 
	
	//Do not shw tabs for status that is Taken, up until user click on action 
	$('.mTicketTakenAwaiting').hide();
	$('.mTicketTakenEscalate').hide();
	$('.mTicketEscalatedReassign').hide();
	//end hide of taken tabs 
	
	//Do not shw tabs for status that is Awaitng Spares, up until user click on action
	$('.mTicketReopenResolved').hide();
	//end hide of awaiting Spares tabs
	
	//end hide of tabs actions on page load	
	
	//Open Ticket
	$("#mTicketOpenReassignLink").click(function(){
	     $('.nav-tabs li').removeClass('active');
	     $('.mTicketOpenReassign').addClass('active');
	     $('.mTicketOpenReassign').show();
	     $('.tab-pane').removeClass('in active');
	     $('.tab-content div#mTicketOpenReassign').addClass('in active');
	     console.log("Status is Acknowledged: Ticket can be reassign");
	 });//end Open ticket
	
	//Acknowledged ticket
	$("#mTicketAcknowledgedReassignLink").click(function(){
		 $('.nav-tabs li').removeClass('active');
		 $('.mTicketAcknowledgedReassign').addClass('active');
		 $('.mTicketAcknowledgedReassign').show();
		 $('.tab-pane').removeClass('in active');
		 $('.tab-content div#mTicketAcknowledgedReassign').addClass('in active');
		 console.log("Status is Acknowledged: Ticket can be reassign");
	});//end Acknowledged Tickit
	
	//Taken Tickets
	$("#mTicketTakenAwaitingLink").click(function(){
		 $('.nav-tabs li').removeClass('active');
		 $('.mTicketTakenAwaiting').addClass('active');
		 $('.mTicketTakenAwaiting').show();
		 $('.tab-pane').removeClass('in active');
		 $('.tab-content div#mTicketTakenAwaiting').addClass('in active');
		 console.log("Status is Taken: Ticket can be on Awaiting Spares if no order is recived");
	});	
	$("#mTicketTakenEscalateLink").click(function(){
		 $('.nav-tabs li').removeClass('active');
		 $('.mTicketTakenEscalate').addClass('active');
		 $('.mTicketTakenEscalate').show();
		 $('.tab-pane').removeClass('in active');
		 $('.tab-content div#mTicketTakenEscalate').addClass('in active');
		 console.log("Status is Taken: Ticket can be Escalated");
	});//end Taken Tickets
	
	
	$("#mTicketEscalatedReassignLink").click(function(){
		 $('.nav-tabs li').removeClass('active');
		 $('.mTicketEscalatedReassign').addClass('active');
		 $('.mTicketEscalatedReassign').show();
		 $('.tab-pane').removeClass('in active');
		 $('.tab-content div#mTicketEscalatedReassign').addClass('in active');
		 console.log("Status is Taken: Ticket can be Resolved");
	});
	$("#mTicketEscalatedResolvedDetailsLink").click(function(){
		 $('.nav-tabs li').removeClass('active');
		 $('.mTicketEscalatedResolvedDetails').addClass('active');
		 $('.mTicketEscalatedResolvedDetails').show();
		 $('.tab-pane').removeClass('in active');
		 $('.tab-content div#mTicketEscalatedResolvedDetails').addClass('in active');
		 console.log("Status is Escalated: Ticket can be Escalated");
	});	
	
	$("#mTicketSLABridgedResolvedLink").click(function(){
		 $('.nav-tabs li').removeClass('active');
		 $('.mTicketSLABridgedResolved').addClass('active');
		 $('.mTicketSLABridgedResolved').show();
		 $('.tab-pane').removeClass('in active');
		 $('.tab-content div#mTicketSLABridgedResolved').addClass('in active');
		 console.log("Status is SLABridged: Ticket can be Resolved");
	});
	
	$("#mTicketReopenResolvedLink").click(function(){
		 $('.nav-tabs li').removeClass('active');
		 $('.mTicketReopenResolved').addClass('active');
		 $('.mTicketReopenResolved').show();
		 $('.tab-pane').removeClass('in active');
		 $('.tab-content div#mTicketReopenResolved').addClass('in active');
		 console.log("Status is Resolved: Ticket can be Re-Open");
	});
	
	//end Escalated tickets
	
	function BootStockChecked(){
				
	  $("#bootStockItems").removeClass("displayBone");
	  $("#bootStockItems").addClass("showDIV");
	
		//Make sure siteStockItems is not visible
	  $("#siteStockItems").removeClass("showDIV");
	  $("#siteStockItems").addClass("displayBone");
	  
	}

	function SiteStockChecked(){
	
	  $("#siteStockItems").removeClass("displayBone");
	  $("#siteStockItems").addClass("showDIV");
	
	  //Make sure bootStockItems is not visible
	  $("#bootStockItems").removeClass("showDIV");
      $("#bootStockItems").addClass("displayBone");
      
	}
	
	
	//Compare available mono reading with updated mono reading
	function compareMonoReading(element, availableMonoReading){				
			
		if (availableMonoReading < element.value ){		
			console.log("True,",element.value + " is more than " + availableMonoReading);
				}
		if (element.value == ''){
			alert("Mono reading can not be empty");
			console.log(element.value);
			element.value = null;
		}		
		else if(availableMonoReading > element.value) {
			alert("Entered mono reading "+ element.value +", must be greater than available mono reading "+ availableMonoReading +"");
			element.value = null;		
		}
	}
	//End Compare available mono reading with updated mono reading
	
	//Compare available colour reading with updated colour reading
	function compareColourReading(element, availableColourReading){				
			
		if (availableColourReading < element.value ){		
			console.log("True,",element.value + " is more than " + availableColourReading);
		}
		if (element.value == ''){
			alert("Colour reading cant not be empty");
		}
		else if(availableColourReading > element.value  ) {
			alert("Entered colour reading "+ element.value +", must be greater than available colour reading "+ availableColourReading +"");
			element.value = null;		
		}
	}
	//End Compare available colour reading with updated colour reading	


	
	
</script>



</html>
