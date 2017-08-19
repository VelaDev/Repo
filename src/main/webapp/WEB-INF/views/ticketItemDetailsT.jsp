<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Ticket Details | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/custom/css/orderhistory.css"/>">

<link type="text/css" rel="stylesheet"
      href="<c:url value="/resources/custom/css/vela_details.css" />">

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
										<li><a id="tAcknowledgedTicketLink" href="javascript:;" data-toggle="tab">Acknowledge</a></li>
									</ul>
								</li>				
								</c:when>
								
								<c:when test="${ticketObject.status =='Acknowledged'}">
									<li class="dropdown"><a href="#" class="dropdown-toggle"
									data-toggle="dropdown" role="button" aria-haspopup="true"
									aria-expanded="false">Ticket Action<span class="caret"></span></a>
									<ul class="dropdown-menu">
										<li><a id="tTakeTicketLink" href="javascript:;" data-toggle="tab">Take Ticket</a></li>
									</ul>
									</li>								
								</c:when>
									
								<c:when test="${ticketObject.status =='Taken'}">
									<li class="dropdown"><a href="#" class="dropdown-toggle"
									data-toggle="dropdown" role="button" aria-haspopup="true"
									aria-expanded="false">Ticket Action<span class="caret"></span></a>
									<ul class="dropdown-menu">
										<li><a id="tTicketTakenAwaitingSparesLink" href="javascript:;" data-toggle="tab">Awaiting Spares</a></li>
										<li><a id="tTicketTakenEscalateLink" href="javascript:;" data-toggle="tab">Escalate</a></li>
										<li><a id="tTicketTakenResolveLink" href="javascript:;" data-toggle="tab">Resolve</a></li>		
									</ul>
								</li>				
								</c:when>
																																						
								<c:when test="${ticketObject.status =='Awaiting Spares'}">
									<li class="dropdown"><a href="#" class="dropdown-toggle"
										data-toggle="dropdown" role="button" aria-haspopup="true"
										aria-expanded="false">Ticket Action<span class="caret"></span></a>
										<ul class="dropdown-menu">
											<li><a id="tTicketAwaitingSparesEscalateLink" href="javascript:;" data-toggle="tab">Escalate</a></li>
											<li><a id="tTicketAwaitingSparesResolveLink" href="javascript:;" data-toggle="tab">Resolve</a></li>
											
										</ul></li>									
								</c:when>
								
								<c:when test="${ticketObject.status =='SLA Bridged'}">
									<li class="dropdown"><a href="#" class="dropdown-toggle"
										data-toggle="dropdown" role="button" aria-haspopup="true"
										aria-expanded="false">Ticket Action<span class="caret"></span></a>
										<ul class="dropdown-menu">
											<li><a id="tTicketSLABridgedEscalateLink" href="javascript:;" data-toggle="tab">Escalate</a></li>
											<li><a id="tTicketSLABridgedResolvedLink" href="javascript:;" data-toggle="tab">Resolve</a></li>
											
										</ul></li>									
								</c:when>
								
								<%-- 
								<c:otherwise>
									<c:out value="${ticketObject.status}" />
								</c:otherwise> --%>
								
							 </c:choose>
						  	
						</ul>
					</div>
					<legend></legend>
					<ul class="nav nav-tabs">
						
								<li class="active"><a href="#ticketDetails" data-toggle="tab">Ticket Details</a></li>						
								<li ><a href="#ticketHistoryDetails" data-toggle="tab">Ticket History</a></li>
								
						<c:choose>
						
							<c:when test="${ticketObject.status =='Open'}">
							 	<li class="tAcknowledgedTicket" style="display:none;"><a href="#tAcknowledgedTicket" data-toggle="tab">Acknowledged</a>							  
							</c:when>
													
							<c:when test="${ticketObject.status =='Acknowledged'}">
							 	<li class="tTakeTicket" style="display:none;"><a href="#tTakeTicket" data-toggle="tab">Take Ticket</a>							  
							</c:when>
								
							<c:when test="${ticketObject.status =='Taken'}">
								<li class="tTicketTakenAwaitingSpares" style="display:none;"><a href="#tTicketTakenAwaitingSpares" data-toggle="tab">Awaiting Spares</a></li>
								<li class="tTicketTakenEscalate" style="display:none;"><a href="#tTicketTakenEscalate" data-toggle="tab">Escalate</a></li>
								<li class="tTicketTakenResolve" style="display:none;"><a href="#tTicketTakenResolve" data-toggle="tab">Resolve</a></li>	
							</c:when>
							
							<c:when test="${ticketObject.status == 'Awaiting Spares' }">
								<li class="tTicketAwaitingSparesResolve" style="display:none;"><a href="#tTicketAwaitingSparesResolve" data-toggle="tab">Resolve</a></li>
								<li class="tTicketAwaitingSparesEscalate" style="display:none;"><a href="#tTicketAwaitingSparesEscalate" data-toggle="tab">Escalate</a></li>									
							</c:when>
							
							<c:when test="${ticketObject.status =='SLA Bridged'}">
								<li class="tTicketSLABridgedResolved" style="display:none;"><a href="#tTicketSLABridgedResolved" data-toggle="tab">Resolve</a></li>
							 	<li class="tTicketSLABridgedEscalate" style="display:none;"><a href="#tTicketSLABridgedEscalate" data-toggle="tab">Escalate</a>	
							 </c:when>
													
							<c:when test="${ticketObject.status =='Resolved'}">
								<li><a href="#tTicketReopenResolved" data-toggle="tab">Resolved Ticket Details</a></li>							  
							</c:when>
							
							<c:when test="${ticketObject.status =='Closed'}">
								<li><a href="#tTicketClosedNoAction" data-toggle="tab">Closed Ticket Details</a></li>							  
							</c:when>						
						</c:choose>
												
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
															<td><c:out value="${history.employee.firstName} ${history.employee.lastName}" /></td>
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
						
						<!--Acknowledged Ticket when is open-->						
						<c:choose>
							 <c:when test="${ticketObject.status =='Open'}">				
									
									
									<div class="tab-pane" id="tAcknowledgedTicket">

										<div class="panel-body">
	
											<!-- tTicketTakenAwaitingSpares Details -->
											<form:form action="acknowledgedTicket" modelAttribute="performTicketAction"
												method="post" id="updateResolved"
												class="well form-horizontal">
	
												<legend style="font-size: 15px; line-height: 1.42857143;"
													align="center">
													<b>Acknowledge</b>
												</legend>
												
												<!-- Action Action -->
												<input type="hidden" id="ticketAction" name="ticketAction"
												class="form-control selectpicker" value="Acknowledge">
												
												
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
													
													<div class="form-group row">
												<div class="col-sm col-sm-8"
													style="margin-left: 26%; width: 48%;">
													<input type="submit" name=resolve value="Acknowledge Ticket"
														class="btn btn-primary btn-block btn-lg" tabindex="9"
														id="resolve">
												</div>
											</div>
												
											</form:form>
											
										</div>
									
									</div>									
									
							</c:when>
						</c:choose>
						
						
						<!--Take ticket when is  Acknowledged-->						
						<c:choose>
							 <c:when test="${ticketObject.status =='Acknowledged'}">				
									<div class="tab-pane" id="tTakeTicket">
										<div class="panel-body">
	
											<!-- tTicketTakenAwaitingSpares Details -->
											<form:form action="taketicket" modelAttribute="performTicketAction"
												method="post" id="updateResolved"
												class="well form-horizontal">
	
												<legend style="font-size: 15px; line-height: 1.42857143;"
													align="center">
													<b>Take Ticket</b>
												</legend>
												
												<!-- Ticket Action -->
												<input type="hidden" id="ticketAction" name="ticketAction"
												class="form-control selectpicker" value="taketicket">
												
												
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
													
													<div class="form-group row">
												<div class="col-sm col-sm-8"
													style="margin-left: 26%; width: 48%;">
													<input type="submit" name=resolve value="Take Ticket"
														class="btn btn-primary btn-block btn-lg" tabindex="9"
														id="resolve">
												</div>
											</div>
												
											</form:form>
											
										</div>
									
									</div>									
									
							</c:when>
						</c:choose><!--// End Take ticket when is  Acknowledged-->
						
						<!--Taken and Awaiting spares -->
						<c:choose>
							 <c:when test="${ticketObject.status =='Taken'}">
							
								<div class="tab-pane" id="tTicketTakenAwaitingSpares">

									<div class="panel-body">

										<!-- tTicketTakenAwaitingSpares Details -->
										<form:form action="performTicketAction" modelAttribute="performTicketAction"
											method="post" id="updateResolved"
											class="well form-horizontal">

											<legend style="font-size: 15px; line-height: 1.42857143;"
												align="center">
												<b>Awaiting Spares</b>
											</legend>
											
											<!-- Action Action -->
												<input type="hidden" id="ticketAction" name="ticketAction"
												class="form-control selectpicker" value="Awaiting Spares">												
												
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
																	class="form-control selectpicker" >
																	<option value="">Select Order No</option>
																	<c:forEach items="${OrderNumber}" var="orders">
																		<option value="${orders.recordID}">${order.recordID}
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
																<textarea class="form-control" id="comments" name="comments" maxlength="150"
																	 onkeydown="upperCaseF(this)" style="margin: 0px; height: 129px; width: 536px;" placeholder="Please enter comment"
																	></textarea>
															</div>
														</div>
													</div>
													
												<!--// display Comments-->

											<div class="form-group row">
												<div class="col-sm col-sm-8"
													style="margin-left: 26%; width: 48%;">
													<input type="submit" name=resolve value="Awaiting For Spares"
														class="btn btn-primary btn-block btn-lg" tabindex="9"
														id="resolve">
												</div>
											</div>											
											
					                   </form:form>
					            	
					            	</div>
					            </div>
					           </c:when>
						</c:choose><!--// End Taken and Awaiting spares -->
						
						
						<!--Taken and Escalate to manager -->
						<c:choose>
							 <c:when test="${ticketObject.status =='Taken'}">
							
								<div class="tab-pane" id="tTicketTakenEscalate">

									<div class="panel-body">

										<!-- If ticket is taken, action available is Escalate -->
										<form:form action="escalateticket" modelAttribute="performTicketAction"
											method="post" id="ticketTakenEscalate"
											class="well form-horizontal">

											<legend style="font-size: 15px; line-height: 1.42857143;"
												align="center">
												<b>Escalate</b>
											</legend>
											
											<!-- Action Action -->
												<input type="hidden" id="ticketAction" name="ticketAction"
												class="form-control selectpicker" value="escalate">												
												
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
																	class="form-control selectpicker" >
																	<option value="">Select Manager</option>
																	<c:forEach items="${managersList}" var="manager">
																		<option value="${manager.email}">${manager.email}</option>
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
																<textarea class="form-control" id="comments" name="comments" style="margin: 0px; height: 129px; width: 536px;" maxlength="150"
																	 onkeydown="upperCaseF(this)" placeholder="Please enter comment"
																	></textarea>
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
										<!-- tTicketTakenEscalate Details -->
											
					            	</div>
					            </div>
					           </c:when>
						</c:choose><!--//End Taken and Escalate to manager --> 
						
						
						<!--Ticket Taken and must be Resolve -->
						<c:choose>
							 <c:when test="${ticketObject.status =='Taken'}">
							
								<div class="tab-pane" id="tTicketTakenResolve">

									<div class="panel-body">

										<!-- If ticket is taken, action available is Resolve -->										
										<form:form action="performTicketAction" modelAttribute="performTicketAction"
											method="post" id="ticketTakenResolve"
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
																	name="colourReading">
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
																placeholder="Enter Mono Reading">
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
																<input type="radio" name="stockType" required id="checkBootStock" onclick="BootStockChecked()" value="Boot Stock" tittle="You must check Boot Stock or Site Stock to get Used Part Numbers">
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
														 <input type="hidden" class="form-control" id="bootStockType"
															name="bootStockType" value="Boot Stock">

														<!-- group Site Stock -->
														<div class="form-group">
															<label class="col-xs-3 control-label">Site Stock</label>
															<div class="col-md-6 inputGroupContainer">
																<input type="radio" name="stockType" required id="checkSiteStock" onclick="SiteStockChecked()" value="Site Stock" >
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
																<textarea id="usedPartNumbers" name="usedPartNumbers"
																	 class="form-control" readonly="readonly"
																	style="height: 60px; font-size: 11px;">
													 </textarea>
															</div>
														</div>
													</div>
													<!--// display ticked Used Part Numbers-->
                                                    
                                                    <!-- display Bridged-->	
													<div class="reseanBridged" id="reseanBridged">
														<div class="form-group">
															<label class="col-md-3 control-label">Reason Why Bridged</label>
															<div class="col-md-6 inputGroupContainer">
																<div class="input-group">
																	<span class="input-group-addon"><i
																		class="glyphicon glyphicon-edit"></i></span>
																	<textarea class="form-control" style="width: 517px; height: 120px;" id="reasonBridge" name="reasonBridge" maxlength="150"
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
																<textarea class="form-control" style="width: 517px; height: 120px;" id="comments" name="comments" maxlength="150"
																	 onkeydown="upperCaseF(this)" placeholder="Please enter comment"
																	></textarea>
															</div>
														</div>
													</div><!--// text area comments-->	
													
													 <!-- display Bridged-->	
													<div class="reseanBridged" id="reseanBridged">
														<div class="form-group">
															<label class="col-md-3 control-label">Reason Why Bridged</label>
															<div class="col-md-6 inputGroupContainer">
																<div class="input-group">
																	<span class="input-group-addon"><i
																		class="glyphicon glyphicon-edit"></i></span>
																	<textarea class="form-control" style="width: 517px; height: 120px;" id="reasonBridge" name="reasonBridge" maxlength="150"
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
						</c:choose><!--Ticket Taken and must be Resolve -->
						
						
						<!--tTicketAwaitingSparesEscalate -->
						<c:choose>
							 <c:when test="${ticketObject.status =='Awaiting Spares'}">
							
								<div class="tab-pane" id="tTicketAwaitingSparesEscalate">

									<div class="panel-body">

										<!-- tTicketTakenResolve Details -->
										<form:form action="performTicketAction" modelAttribute="performTicketAction"
											method="post" id="updateResolved"
											class="well form-horizontal">

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
													<div class="input-group"><span class="input-group-addon"><i
													   class="glyphicon glyphicon-barcode"></i></span>
													   	<input name="ticketNumber" id="ticketNumber" class="form-control" type="text" value="${ticketObject.ticketNumber}" readonly>
													</div>
												</div>
											</div>
											
											 	 <!-- Text input Manager-->
												<div class="form-group">
													<label class="col-md-3 control-label"> Manager</label>
														<div class="col-md-6 inputGroupContainer">
															<div class="input-group">
																<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span> <select
																	id="escalatedTo" name="escalatedTo"
																	class="form-control selectpicker" >
																	<option value="">Select Manager</option>
																	<c:forEach items="${managersList}" var="manager">
																		<option value="${manager.email}">${manager.email}</option>
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
																<textarea class="form-control" id="comments" name="comments" maxlength="150"
																	 onkeydown="upperCaseF(this)" style="width: 517px; height: 120px;" placeholder="Please enter comment"
																	></textarea>
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
					            	
					            	</div>
					            </div>
					           </c:when>
						</c:choose><!--tTicketAwaitingSparesEscalate -->
						
						<!--tTicketAwaitingSparesResolve -->
						<c:choose>
							 <c:when test="${ticketObject.status =='Awaiting Spares'}">
							
								<div class="tab-pane" id="tTicketAwaitingSparesResolve">

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
																	name="colourReading">
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
																placeholder="Enter Mono Reading">
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
																<input type="radio" name="stockType" required id="checkBootStock" onclick="BootStockChecked()" value="Boot Stock" tittle="You must check Boot Stock or Site Stock to get Used Part Numbers">
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
														 <input type="hidden" class="form-control" id="bootStockType"
															name="bootStockType" value="Boot Stock">

														<!-- group Site Stock -->
														<div class="form-group">
															<label class="col-xs-3 control-label">Site Stock</label>
															<div class="col-md-6 inputGroupContainer">
																<input type="radio" name="stockType" required id="checkSiteStock" onclick="SiteStockChecked()" value="Site Stock" >
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
																<textarea id="usedPartNumbers" name="usedPartNumbers"
																	 class="form-control" readonly="readonly"
																	style="height: 60px; font-size: 11px;">
													 </textarea>
															</div>
														</div>
													</div>
													<!--// display ticked Used Part Numbers-->
                                                    
                                                    <!-- display Bridged-->	
													<div class="reseanBridged" id="reseanBridged">
														<div class="form-group">
															<label class="col-md-3 control-label">Reason Why Bridged</label>
															<div class="col-md-6 inputGroupContainer">
																<div class="input-group">
																	<span class="input-group-addon"><i
																		class="glyphicon glyphicon-edit"></i></span>
																	<textarea class="form-control" style="width: 517px; height: 120px;" id="reasonBridge" name="reasonBridge" maxlength="150"
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
																<textarea class="form-control" style="width: 517px; height: 120px;" id="comments" name="comments" maxlength="150"
																	 onkeydown="upperCaseF(this)" placeholder="Please enter comment"
																	></textarea>
															</div>
														</div>
													</div><!--// text area comments-->	
													
													 <!-- display Bridged-->	
													<div class="reseanBridged" id="reseanBridged">
														<div class="form-group">
															<label class="col-md-3 control-label">Reason Why Bridged</label>
															<div class="col-md-6 inputGroupContainer">
																<div class="input-group">
																	<span class="input-group-addon"><i
																		class="glyphicon glyphicon-edit"></i></span>
																	<textarea class="form-control" style="width: 517px; height: 120px;" id="reasonBridge" name="reasonBridge" maxlength="150"
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
						</c:choose><!--tTicketAwaitingSparesResolve -->
						
						
						
						<c:choose>
							<c:when test="${ticketObject.status =='SLA Bridged'}">							
							 
							 
							 <div class="tab-pane" id="tTicketSLABridgedEscalate">

									<div class="panel-body">

										<!-- tTicketTakenEscalate Details -->
										<form:form action="performTicketAction" modelAttribute="performTicketAction"
											method="post" id="ticketTakenEscalate"
											class="well form-horizontal">

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
													<div class="input-group"><span class="input-group-addon"><i
													   class="glyphicon glyphicon-barcode"></i></span>
													   	<input name="ticketNumber" id="ticketNumber" class="form-control" type="text" value="${ticketObject.ticketNumber}" readonly>
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
																	class="form-control selectpicker" >
																	<option value="">Select Manager</option>
																	<c:forEach items="${managersList}" var="manager">
																		<option value="${manager.email}">${manager.email}</option>
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
																<textarea class="form-control" style="width: 517px; height: 120px;" id="comments" name="comments" maxlength="150"
																	 onkeydown="upperCaseF(this)" placeholder="Please enter comment"
																	></textarea>
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
										<!-- tTicketSLABridgedEscalate Details -->
											
					            	</div>
					            </div>
							 
							 						  
						</c:when>						
						</c:choose>
						
						
						<c:choose>
							<c:when test="${ticketObject.status =='SLA Bridged'}">
							 
							 <div class="tab-pane" id="tTicketSLABridgedResolved">

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
																	name="colourReading">
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
																placeholder="Enter Mono Reading">
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
																<input type="radio" name="stockType" required id="checkBootStock" onclick="BootStockChecked()" value="Boot Stock" tittle="You must check Boot Stock or Site Stock to get Used Part Numbers">
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
														 <input type="hidden" class="form-control" id="bootStockType"
															name="bootStockType" value="Boot Stock">

														<!-- group Site Stock -->
														<div class="form-group">
															<label class="col-xs-3 control-label">Site Stock</label>
															<div class="col-md-6 inputGroupContainer">
																<input type="radio" name="stockType" required id="checkSiteStock" onclick="SiteStockChecked()" value="Site Stock" >
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
																<textarea id="usedPartNumbers" name="usedPartNumbers"
																	 class="form-control" readonly="readonly"
																	style="height: 60px; font-size: 11px;">
													 </textarea>
															</div>
														</div>
													</div>
													<!--// display ticked Used Part Numbers-->
                                                    
                                                    <!-- display Bridged-->	
													<div class="reseanBridged" id="reseanBridged">
														<div class="form-group">
															<label class="col-md-3 control-label">Reason Why Bridged</label>
															<div class="col-md-6 inputGroupContainer">
																<div class="input-group">
																	<span class="input-group-addon"><i
																		class="glyphicon glyphicon-edit"></i></span>
																	<textarea class="form-control" style="width: 517px; height: 120px;" id="reasonBridge" name="reasonBridge" maxlength="150"
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
																<textarea class="form-control" style="width: 517px; height: 120px;" id="comments" name="comments" maxlength="150"
																	 onkeydown="upperCaseF(this)" placeholder="Please enter comment"
																	></textarea>
															</div>
														</div>
													</div><!--// text area comments-->	
													
													 <!-- display Bridged-->	
													<div class="reseanBridged" id="reseanBridged">
														<div class="form-group">
															<label class="col-md-3 control-label">Reason Why Bridged</label>
															<div class="col-md-6 inputGroupContainer">
																<div class="input-group">
																	<span class="input-group-addon"><i
																		class="glyphicon glyphicon-edit"></i></span>
																	<textarea class="form-control" style="width: 517px; height: 120px;" id="reasonBridge" name="reasonBridge" maxlength="150"
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
						
						<c:choose>
							<c:when test="${ticketObject.status =='Resolved'}">
						
						      <!-- ticketReopenResolved -->
						      <div class="tab-pane" id="tTicketReopenResolved">
						      
						      <div class="panel-body">									
						      			
								<form:form class="well form-horizontal">
										
										<legend style="font-size: 15px; line-height: 1.42857143;"
												align="center">
												<b>Resolved Details</b>
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
	
										<!-- Text area Action Taken-->
											<div class="actionTaken">
												<div class="form-group">
													<label class="col-md-3 control-label">Action Taken</label>
													<div class="col-md-6 inputGroupContainer">
														<div class="input-group">
															<span class="input-group-addon"><i
																class="glyphicon glyphicon-barcode"></i></span> <input id="actionTaken"
																class="form-control" type="text" name="actionTaken"
																value="${ticketObject.actionTaken }" readonly="readonly">
														</div>
													</div>
												</div>
											</div>
										
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
															<textarea class="form-control" style="width: 517px; height: 120px;" name="comments" id="comment"readonly="readonly"
															 style="height: 100px;">${ticketObject.comments}</textarea>
														</div>
													</div>
											</div>
									</c:if>
									
									<c:if test="${empty ticketObject.usedPartNumbers}">
									</c:if>
									<c:if test="${not empty ticketObject.usedPartNumbers}">
																
										<!-- Text area Used Spare Part-->
										<div class="usedPartNumbersDetails">
											<div class="form-group">
												<label class="col-md-3 control-label">Used Spare/Part</label>
												<div class="col-md-6 inputGroupContainer">
													<div class="input-group">
														<span class="input-group-addon"><i
															class="glyphicon glyphicon-barcode"></i></span> <input id="usedPartNumbers"
															class="form-control" type="text" name="usedPartNumbers"
															value="${ticketObject.usedPartNumbers}" readonly="readonly">
													</div>
												</div>
											</div>
										</div>
									</c:if>	
										<!-- Text checkbox Colour Reading-->
										<div class="form-group">
											<label class="col-md-3 control-label">Colour Reading</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-barcode"></i></span> <input type="text"
														class="form-control" readonly="readonly"
														onkeypress="return isNumber(event)"
														placeholder="Enter Colour Reading" id="colour"
														name="colourReading"
														value="${ticketObject.getDevice().getColourReading() }"
														name="colourReading">
												</div>
											</div>
										</div>
	
										<div class="form-group">
											<label class="col-md-3 control-label">Mono Reading</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-barcode"></i></span> <input type="text"
														class="form-control" onkeypress="return isNumber(event)"
														id="mono" readonly="readonly" name="monoReading"
														placeholder="Enter Mono Reading" name="monoReading"
														value="${ticketObject.getDevice().getMonoReading() }">
												</div>
											</div>
										</div>
	
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
														<textarea id="tickedUsedPartNumbers" class="form-control"
															readonly="readonly" name="usedPartNumbers"></textarea>
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
						</c:choose><!-- tTicketReopenResolved -->
						
						<c:choose>
							<c:when test="${ticketObject.status =='Closed'}">
						
							<!-- ticketClosedNoAction -->
							<div class="tab-pane" id="tTicketClosedNoAction">
							
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
											
											<!-- Text area Action Taken-->
											<div class="actionTaken">
												<div class="form-group">
													<label class="col-md-3 control-label">Action Taken</label>
													<div class="col-md-6 inputGroupContainer">
														<div class="input-group">
															<span class="input-group-addon"><i
																class="glyphicon glyphicon-barcode"></i></span> <input id="actionTaken"
																class="form-control" type="text" name="actionTaken"
																value="${ticketObject.actionTaken }" readonly="readonly">
														</div>
													</div>
												</div>
											</div>
											
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
																<textarea class="form-control" name="comments" id="comment"readonly="readonly"
																 style="width: 517px; height: 120px;">${ticketObject.comments}</textarea>
															</div>
														</div>
												</div>
										</c:if>
										
										<c:if test="${empty ticketObject.usedPartNumbers}">
										</c:if>
										<c:if test="${not empty ticketObject.usedPartNumbers}">
																	
											<!-- Text area Used Spare Part-->
											<div class="usedPartNumbersDetails">
												<div class="form-group">
													<label class="col-md-3 control-label">Used Spare/Part</label>
													<div class="col-md-6 inputGroupContainer">
														<div class="input-group">
															<span class="input-group-addon"><i
																class="glyphicon glyphicon-barcode"></i></span> <input id="usedPartNumbers"
																class="form-control" type="text" name="usedPartNumbers"
																value="${ticketObject.usedPartNumbers}" readonly="readonly">
														</div>
													</div>
												</div>
											</div>
										</c:if>	
											<!-- Text checkbox Colour Reading-->
											<div class="form-group">
												<label class="col-md-3 control-label">Colour Reading</label>
												<div class="col-md-6 inputGroupContainer">
													<div class="input-group">
														<span class="input-group-addon"><i
															class="glyphicon glyphicon-barcode"></i></span> <input type="text"
															class="form-control" readonly="readonly"
															onkeypress="return isNumber(event)"
															 id="colour" name="colourReading"
															value="${ticketObject.getDevice().getColourReading() }"
															name="colourReading">
													</div>
												</div>
											</div>
		
											<div class="form-group">
												<label class="col-md-3 control-label">Mono Reading</label>
												<div class="col-md-6 inputGroupContainer">
													<div class="input-group">
														<span class="input-group-addon"><i
															class="glyphicon glyphicon-barcode"></i></span> <input type="text"
															class="form-control" onkeypress="return isNumber(event)"
															id="mono" readonly="readonly" name="monoReading"
															name="monoReading"
															value="${ticketObject.getDevice().getMonoReading() }">
													</div>
												</div>
											</div>
		
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
															<textarea id="tickedUsedPartNumbers" class="form-control"
																readonly="readonly" name="usedPartNumbers"></textarea>
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
						</c:choose><!-- tTicketClosedNoAction -->
						
						
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
	
	//Do not shw tabs for status that is Take, up until user click on action
	$('.tTakeTicket').hide();
	//end hide of Take tabs 
	
	//Do not shw tabs for status that is Acknowledged, up until user click on action
	$('.tAcknowledgedTicket').hide();
	//end hide of Acknowledged tabs 
	
	//Do not shw tabs for status that is Taken, up until user click on action 
	$('.tTicketTakenAwaitingSpares').hide();
	$('.tTicketTakenEscalate').hide();
	$('.tTicketTakenResolve').hide();
	//end hide of taken tabs 
	
	//Do not shw tabs for status that is Awaitng Spares, up until user click on action
	$('.tTicketAwaitingSparesEscalate').hide();
	$('.tTicketAwaitingSparesResolve').hide();
	//end hide of awaiting Spares tabs
	
	//Do not shw tabs for status that is SLA Bridge, up until user click on action
	 $('.tTicketSLABridgedEscalate').hide();
	 $('.tTicketSLABridgedResolved').hide();
	//end hide of SLA Bridge tabs
	
	//end hide of tabs actions on page load
	
	
	//Acknowledged Ticket
	$("#tAcknowledgedTicketLink").click(function(){
	     $('.nav-tabs li').removeClass('active');
	     $('.tAcknowledgedTicket').addClass('active');
	     $('.tAcknowledgedTicket').show();
	     $('.tab-pane').removeClass('in active');
	     $('.tab-content div#tAcknowledgedTicket').addClass('in active');
	     console.log("Acknowledged Ticket Active");
	 });//end Acknowledged
	
	//Take ticket
	$("#tTakeTicketLink").click(function(){
		 $('.nav-tabs li').removeClass('active');
		 $('.tTakeTicket').addClass('active');
		 $('.tTakeTicket').show();
		 $('.tab-pane').removeClass('in active');
		 $('.tab-content div#tTakeTicket').addClass('in active');
		 console.log("Take Ticket Active");
	});//end Take Tickit
	
	//Taken Tickets
	$("#tTicketTakenAwaitingSparesLink").click(function(){
		 $('.nav-tabs li').removeClass('active');
		 $('.tTicketTakenAwaitingSpares').addClass('active');
		 $('.tTicketTakenAwaitingSpares').show();
		 $('.tab-pane').removeClass('in active');
		 $('.tab-content div#tTicketTakenAwaitingSpares').addClass('in active');
		 console.log("Status is Taken: Ticket can be on Awaiting Spares if no order is recived");
	});	
	$("#tTicketTakenEscalateLink").click(function(){
		 $('.nav-tabs li').removeClass('active');
		 $('.tTicketTakenEscalate').addClass('active');
		 $('.tTicketTakenEscalate').show();
		 $('.tab-pane').removeClass('in active');
		 $('.tab-content div#tTicketTakenEscalate').addClass('in active');
		 console.log("Status is Taken: Ticket can be Escalated");
	});	
	$("#tTicketTakenResolveLink").click(function(){
		 $('.nav-tabs li').removeClass('active');
		 $('.tTicketTakenResolve').addClass('active');
		 $('.tTicketTakenResolve').show();
		 $('.tab-pane').removeClass('in active');
		 $('.tab-content div#tTicketTakenResolve').addClass('in active');
		 console.log("Status is Taken: Ticket can be Resolved");
	});//end Taken tickets
	
	//Awaitng Spares tickets
	$("#tTicketAwaitingSparesEscalateLink").click(function(){
		 $('.nav-tabs li').removeClass('active');
		 $('.tTicketAwaitingSparesEscalate').addClass('active');
		 $('.tTicketAwaitingSparesEscalate').show();
		 $('.tab-pane').removeClass('in active');
		 $('.tab-content div#tTicketAwaitingSparesEscalate').addClass('in active');
		 console.log("Status is Awaiting Spare: Ticket can be Escalated");
	});	
	$("#tTicketAwaitingSparesResolveLink").click(function(){
		 $('.nav-tabs li').removeClass('active');
		 $('.tTicketAwaitingSparesResolve').addClass('active');
		 $('.tTicketAwaitingSparesResolve').show();
		 $('.tab-pane').removeClass('in active');
		 $('.tab-content div#tTicketAwaitingSparesResolve').addClass('in active');
		 console.log("Status is Awaiting Spare: Resolved");
	});//end Awaitng Spares tickets
	
	//SLA Bridged Tickets
	$("#tTicketSLABridgedEscalateLink").click(function(){
		 $('.nav-tabs li').removeClass('active');
		 $('.tTicketSLABridgedEscalate').addClass('active');
		 $('.tTicketSLABridgedEscalate').show();
		 $('.tab-pane').removeClass('in active');
		 $('.tab-content div#tTicketSLABridgedEscalate').addClass('in active');
		 console.log("Status is SLA Bridge: Ticket can be Ticket must can be Escalated");
	});	
	$("#tTicketSLABridgedResolvedLink").click(function(){
		 $('.nav-tabs li').removeClass('active');
		 $('.tTicketSLABridgedResolved').addClass('active');
		 $('.tTicketSLABridgedResolved').show();
		 $('.tab-pane').removeClass('in active');
		 $('.tab-content div#tTicketSLABridgedResolved').addClass('in active');
		 console.log("Status is SLA Bridge: Ticket must be Resolved");
	});//end SLA Bridged Tickets
		
	
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
	
	
</script>

</html>
