<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Ticket Details | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="shortcut icon" href="<c:url value="images/favicon.ico" />"
	type="image/ico" />
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/custom/css/vela_custom.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">

<style>
li {
	list-style: none;
}

.groupsparedetails, .groupsearchdetails {
	padding: 20px;
}

.groupsparedetails {
	float: left;
	width: 50%;
}

.groupsearchdetails {
	overflow: hidden;
}

.tick {
	display: none;
}

input:checked+div, input:checked+input {
	display: block;
}

.machinedetailsfloatright {
	float: left;
	/* margin-right: 40%; */
	padding-left: 23px;
}

.machinedetailsdetailsfloatleft {
	float: left;
	margin-left: 10px;
}

#customerr_container {
	/* padding: 25px; */
	/* margin-bottom: -7em; */
	width: auto;
	display: table;
	font-size: 100%;
	margin-left: -15%;
}

p.contactPerson_title, p.customerAddress_title {
	font-size: 1.1em;
	font-weight: bolder;
	margin-left: -11%;
}

ul.address_list {
	margin-left: -31%;
}
/* STRUCTURE */
#content {
	width: 55%;
	float: left;
	padding: 5px 15px;
}

#middle {
	width: 22%; /* Account for margins + border values */
	float: left;
	padding: 5px 15px;
	margin: 0px 5px 5px 5px;
}

#sidebar {
	width: 19%;
	padding: 5px 15px;
	float: left;
}

/************************************************************************************
MEDIA QUERIES
*************************************************************************************/
@media only screen and (max-width: 760px) , ( max-device-width : 1024px)
	and (min-device-width: 768px) {
	.machinedetailsfloatright {
		float: left;
		margin-right: -31%;
		padding-left: 9%;
		margin-top: 0%;
	}
}
/* for 980px or less */
@media screen and (max-width: 980px) {
	#pagewrap {
		width: 94%;
	}
	#content {
		width: 40%;
		padding: 1% 4%;
	}
	#middle {
		width: 41%;
		padding: 1% 4%;
		margin: 0px 0px 5px 5px;
		float: right;
	}
	#sidebar {
		clear: both;
		padding: 1% 4%;
		width: auto;
		float: none;
	}
}

/* for 700px or less */
@media screen and (max-width: 600px) {
	#content {
		width: auto;
		float: none;
	}
	#middle {
		width: auto;
		float: none;
		margin-left: 0px;
	}
	#sidebar {
		width: auto;
		float: none;
	}
}

/* for 480px or less */
@media screen and (max-width: 480px) {
	#sidebar {
		display: none;
	}
}

header, #content, #middle, #sidebar {
	margin-bottom: 5px;
}
</style>
</head>
<body>
	<div class="velaphanda_containter">
		<c:import url="templates/techniciannavbar.jsp"></c:import>
		<div class="container">
		<c:if test="${not empty retMessage }">
				<div class="alert alert-info" role="alert">
					<c:out value="${ retMessage}">
					</c:out>

				</div>
			</c:if>
			<div class="panel panel-success">
				<div class="panel-heading">
					<div align="center">
						<b>Ticket Details</b>
					</div>
				</div>

				<div class="panel-body">
					<ul class="nav nav-tabs">

						<li class="active"><a href="#generalDetails"
							data-toggle="tab">General</a></li>
						<li><a href="#solutionsDetails" data-toggle="tab">Solution</a></li>
						<li><a href="#historyDetails" data-toggle="tab">History</a></li>

					</ul>

					<!-- tab nav -->
					<div class="tab-content">

						<!--general tab-->
						<div class="tab-pane active" id="generalDetails">

							<h4 align="center">General Info</h4>

							<form:form class="well form-horizontal" action="updateTicket"
								modelAttribute="updateTicket" method="post" id="updataTckt">

								<!-- //Ticket Details -->
								<fieldset>
									<legend align="left">Ticket Info</legend>

									<!--First Column-->
									<div class="col-md-6">

										<!-- Text input Ticket Number-->
										<div class="form-group">
											<label class="col-md-3 control-label">Ticket Number</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-barcode"></i></span> <input
														name="ticketNumber" id="ticketNumber" class="form-control"
														type="text" value="${ticketObject.ticketNumber}" readonly>
												</div>
											</div>
										</div>

										<!-- Select type status-->
										<div class="form-group ">
											<label class="col-md-3 control-label">Status</label>
											<div class="col-md-6 selectContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-list"></i></span> <select
														onchange="CheckStatus(this.value);" name="status"
														id="status" class="form-control selectpicker">
														<option value="${ticketObject.status}">${ticketObject.status}</option>
														<option value="Awaiting Spares">Awaiting Spares</option>
														<option value="Escalated">Escalate
															Ticket</option>
														<option value="Resolved">Resolved</option>
													</select>
												</div>
											</div>
										</div>


										<!-- Select type Order No-->
										<div class="order" id="order" style="display: none;">
											<div class="form-group">
												<label class="col-md-3 control-label"> Order No</label>
												<div class="col-md-6 selectContainer">
													<div class="input-group">
														<span class="input-group-addon"><i
															class="glyphicon glyphicon-list"></i></span> <select id="order"
															name="orderNum" class="form-control selectpicker">
															<option value=0>Select Order No</option>
															<c:forEach items="${OrderNumber}" var="orders">
																<option value="${orders.recordID}">${orders.orderNum}
																</option>
															</c:forEach>

														</select>
													</div>
												</div>
											</div>
										</div>

										<!-- Text input Manager-->
										<div class="manager" id="manager" style="display: none;">
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
																<option value="${manager.email}">${manager.firstName}
																	${manager.lastName}</option>
															</c:forEach>

														</select>
													</div>
												</div>
											</div>
										</div>
										
										<!-- Text input Ticket Priority-->
										<div class="form-group">
											<label class="col-md-3 control-label">Priority</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-user"></i></span> <input
														name="priority" id="priority" class="form-control"
														type="text" value="${ticketObject.priority}" readonly>
												</div>
											</div>
										</div>
										<!-- Text area Subject-->
										<div class="form-group">
											<label class="col-md-3 control-label">Subject</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-pencil"></i></span>
													<textarea class="form-control" name="subject"
														required="required" readonly >${ticketObject.subject}</textarea>
												</div>
											</div>
										</div>
										
										
										
									</div>
									<!--/ First Column-->

									<!--Second Column-->
									<div class="col-md-6">

										
										<!-- Text area Description-->
										<div class="form-group">
											<label class="col-md-3 control-label">Description</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-pencil"></i></span>
													<textarea class="form-control" name="description"
														required="required" readonly>${ticketObject.description}</textarea>
												</div>
											</div>
										</div>
										<!-- Text area Comment-->
										<div class="form-group">
											<label class="col-md-3 control-label">Comments</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-pencil"></i></span>
													<textarea class="form-control" name="comments"
														required="required" placeholder="Please enter comments" id="comment"></textarea>
												</div>
											</div>
										</div>
									</div>
									<!--//Second Column-->
								</fieldset>
								<!-- //Ticket Details -->


								<!-- //Device Details -->
								<fieldset>

									<legend align="left">Device Details</legend>
									<!--First Column-->
									<div class="col-md-6">
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
										<!-- Text input Machine Model-->
										<div class="form-group">
											<label class="col-md-3 control-label">Model No</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-barcode"></i></span> <input
														name="productModel" placeholder="Product Model"
														value="${ticketObject.device.modelNumber }"
														class="form-control" type="text" readonly>
												</div>
											</div>
										</div>

										<!-- Text input Machine Brand-->
										<div class="form-group">
											<label class="col-md-3 control-label">Model Brand</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-barcode"></i></span> <input
														name="modelBrand" placeholder="Model Brand"
														value="${ticketObject.device.modelBrand }"
														class="form-control" type="text" readonly="readonly">
												</div>
											</div>
										</div>



										<!-- Text input Device Location-->
										<div class="form-group">
											<label class="col-md-3 control-label">Device Location</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-home"></i></span>
													<textarea class="form-control" readonly>${ ticketObject.getDevice().getStreetNumber()} ${ ticketObject.getDevice().getStreetName()}  ${ ticketObject.getDevice().getCity_town()} ${ ticketObject.getDevice().getAreaCode()}
												</textarea>
												</div>
											</div>
										</div>

									</div>
									<!--/F Column-->

									<!--Second column-->
									<div class="col-sm-6">
										<!-- Text input Contract Start Date-->
										<div class="form-group">
											<label class="col-md-3 control-label">Contract Start
												Date</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-calendar"></i></span> <input
														name="startDate" id="startDate" placeholder="YYYY-MM-DD"
														value="${ticketObject.getDevice().getStartDate()}"
														class="form-control" type="text" readonly="readonly">
												</div>
											</div>
										</div>

										<!-- Text input Contract End Date-->
										<div class="form-group">
											<label class="col-md-3 control-label">Contract End
												Date</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-calendar"></i></span> <input
														name="endDate" id="endDate" placeholder="YYYY-MM-DD"
														value="${ticketObject.getDevice().getEndDate() }"
														class="form-control" type="text" readonly="readonly">
												</div>
											</div>
										</div>
										<!-- Text input Installation Date-->
										<div class="form-group">
											<label class="col-md-3 control-label">Installation
												Date</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-calendar"></i></span> <input
														name="installationDate" id="installationDate"
														placeholder="YYYY-MM-DD"
														value="${ticketObject.getDevice().getInstallationDate() }"
														class="form-control" type="text" readonly="readonly">
												</div>
											</div>
										</div>
									</div>


								</fieldset>
								<!-- //Device Details -->

								<!-- Customer Details -->
								<fieldset>
									<legend align="left">Customer Details</legend>

									<!--First column-->
									<div class="col-md-6">
										<!-- Text input Client Name-->
										<div class="form-group">
											<label class="col-md-3 control-label">Customer Name</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-user"></i></span> <input
														name="customerName" placeholder="Customer Name"
														class="form-control"
														value="${ticketObject.getDevice().getCustomerDevice().getCustomerName()}"
														type="text" readonly="readonly">
												</div>
											</div>
										</div>

										<!-- Text input Contact Person-->
										<div class="form-group">
											<label class="col-md-3 control-label">Contact Person</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-user"></i></span> <input
														name="contactPerson" placeholder="Contact Person"
														class="form-control"
														value="${contactPerson.firstName} ${contactPerson.lastName}"
														type="text" readonly="readonly">
												</div>
											</div>
										</div>
										<!-- Text input Email-->
										<div class="form-group">
											<label class="col-md-3 control-label">Email Address</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-envelope"></i></span> <input
														class="form-control"
														value="${ticketObject.device.contactPerson.email }"
														type="text" readonly="readonly">
												</div>
											</div>
										</div>
										<!-- Text input Cellphone Number-->
										<div class="form-group">
											<label class="col-md-3 control-label">Mobile Number</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-earphone"></i></span> <input
														name="cellNumber" placeholder="Mobile Number"
														class="form-control"
														value="${ticketObject.device.contactPerson.cellphone }"
														type="text" readonly="readonly">
												</div>
											</div>
										</div>

										<!-- Text input Tellphone Number-->
										<div class="form-group">
											<label class="col-md-3 control-label">Telephone No</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-earphone"></i></span> <input
														name="tellphoneNumber" placeholder="Tellphone Number"
														class="form-control"
														value="${ticketObject.device.contactPerson.telephone }"
														type="text" readonly="readonly">
												</div>
											</div>
										</div>

									</div>
									<!-- / F column -->

									<!--Second column-->
									<div class="col-md-6">

										<!-- Text input Floor Number-->
										<div class="form-group">
											<label class="col-md-3 control-label">Street No</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-home"></i></span> <input
														name="floorNumber" placeholder="Street Number"
														class="form-control"
														value="${ticketObject.getDevice().getCustomerDevice().getStreetNumber()} "
														type="text" readonly="readonly">
												</div>
											</div>
										</div>

										<!-- Text input Street Name-->
										<div class="form-group">
											<label class="col-md-3 control-label">Street Name</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-home"></i></span> <input
														name="streetName" placeholder="Street Name"
														class="form-control"
														value="${ticketObject.getDevice().getCustomerDevice().getStreetName()}"
														type="text" readonly="readonly">
												</div>
											</div>
										</div>

										<!-- Text input City or Town-->
										<div class="form-group">
											<label class="col-md-3 control-label">City/Town</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-home"></i></span> <input
														name="city_town" placeholder="City / Town"
														class="form-control"
														value=" ${ticketObject.getDevice().getCustomerDevice().getCity_town()}"
														type="text" readonly="readonly">
												</div>
											</div>
										</div>
										<div class="form-group">
											<label class="col-md-3 control-label">Area Code</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-home"></i></span> <input
														name="zipcode" placeholder="Area Code"
														class="form-control"
														value="${ticketObject.getDevice().getCustomerDevice().getZipcode()}"
														type="text" readonly="readonly">
												</div>
											</div>
										</div>

									</div>
									<!-- /S Column -->

								</fieldset>
								<!-- //Customer Details -->

								<br>
								<div class="form-group row">
									<div class="col-sm-offset-2 col-sm-8">
										<input type="submit" value="Update General"
											class="btn btn-primary btn-block btn-lg" tabindex="9"
											id="updateGen">
									</div>
								</div>
							</form:form>

						</div>
						<!--/general tab-->


						<!--escalationDetails tab-->
						<div class="tab-pane" id="escalationDetails">

							<h4 align="center">Escalate Ticket</h4>

							<form:form class="well form-horizontal" action="updateTicket"
								modelAttribute="updateTicket" method="post">

								<!-- Text input Ticket Number-->
								<div class="form-group">
									<label class="col-md-3 control-label">Ticket Number</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-barcode"></i></span> <input
												name="ticketNumber" id="ticketNumber" class="form-control"
												type="text" value="${ticketObject.ticketNumber}">
										</div>
									</div>
								</div>


								<!-- Text area Escalate-->
								<div class="form-group">
									<label class="col-md-3 control-label">Escalate </label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<input type="checkbox" name="escalate" value="true"
												required="required">
										</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label">Awaiting Spares </label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<input type="checkbox" name="AwaitingSpares" value="true"
												required="required">
										</div>
									</div>
								</div>
								<!-- Select type Assign Technician-->
								<div class="form-group">
									<label class="col-md-3 control-label">Order No</label>
									<div class="col-md-6 selectContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-list"></i></span> <select
												name="orderNumber" class="form-control selectpicker">
												<option>Select Order No</option>
												<c:forEach items="${OrderNumber}" var="orders">
													<option value="${orders.orderNum}">${orders.orderNum}
													</option>
												</c:forEach>
											</select>
										</div>
									</div>
								</div>
								<!-- Text area Escalate Reason-->
								<div class="form-group">
									<label class="col-md-3 control-label">Reason</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-pencil"></i></span>
											<textarea class="form-control" name="escalateReason"
												required="required"></textarea>
										</div>
									</div>
								</div>
								<br>
								<div class="form-group row">
									<div class="col-sm-offset-2 col-md-8">
										<input type="submit" value="Submit"
											class="btn btn-primary btn-block btn-lg" tabindex="9"
											id="escalateTickt">
									</div>
								</div>
							</form:form>
						</div>
						<!--/escalationDetails tab-->


						<!--solution tab-->
						<div class="tab-pane" id="solutionsDetails">
							<h4 align="center">Solution Details</h4>
							<form:form class="well form-horizontal" action="updateTicket"
								modelAttribute="updateTicket" method="post" id="updataTckt">

								<div class="groupsparedetails">
									<legend align="left">Ticket Info</legend>
									<!--First Column-->
									<div class="col-md-12">
										<!-- Text input Ticket Number-->
										<div class="form-group">
											<label class="col-md-3 control-label">Ticket Number</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-barcode"></i></span> <input
														name="ticketNumber" id="ticketNumber" class="form-control"
														type="text" value="${ticketObject.ticketNumber}" readonly="readonly">
												</div>
											</div>
										</div>

										<!-- Text area Action Taken-->
										<div class="form-group">
											<label class="col-md-3 control-label"> Action Taken </label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-pencil"></i></span>
													<textarea class="form-control" id="actionTaken"
														name="comments" required="required"></textarea>
												</div>
											</div>
										</div>

									</div>
								</div>
								<!-- //group details -->

								<!-- group Used Part Numbers -->
								<div class="groupsearchdetails">
									<legend>Used Part Numbers </legend>

									<div class="tableContect">
										<p>
											<input type="button" class="btn btn-success"
												value="Add Part Number">
										</p>

										<table id="usedPartNumbersdataTable" width="300px"
											style="width: 300px"
											class="table table-striped table-bordered table-hover table-condensed">
											<label class="model">Part Number</label>
											<c:forEach var="usedPartNumbers" items="${partNumbers}">
												<tr>

													<td><input type="text" readOnly class="form-control"
														id="usedPartNumbers" name="usedPartNumbers"
														value="${usedPartNumbers}"></td>
													<td><input type="button" class="btn btn-danger"
														value="Remove"></td>

												</tr>
											</c:forEach>

										</table>
									</div>
								</div>
								<!-- //group Used Part Numbers -->

								<br />
								<div class="form-group">
									<div class="col-sm-offset-2 col-md-8">
										<input type="submit" value="Solution"
											class="btn btn-primary btn-block btn-lg" tabindex="9"
											id="solution">
									</div>
								</div>
							</form:form>
						</div>
						<!--/solution tab-->

						<!--history tab-->
						<div class="tab-pane" id="historyDetails">
							<h4 align="center">History Details</h4>
							<form:form class="well form-horizontal">
								<div class="panel-body">
									<!-- Below table will be displayed as Data table -->
									<table id="myDatatable" class="display datatable">
										<thead>
											<tr>
												<th>Ticket No</th>
												<th>Date</th>
												<th>Assigned To</th>
												<th>Comment</th>

											</tr>
										</thead>
										<tbody>
											<!-- Iterating over the list sent from Controller -->
											<c:forEach items="${ticketHistoryList}" var="history">
												<tr>
													<td><c:out value="${history.ticketNumber}" /></td>
													<td><c:out value="${history.escalatedDate}" /></td>
													<td><c:out
															value="${history.employee.firstName} ${history.employee.lastName}" /></td>
													<%-- <th><c:out value="${history.part.modelNumber}" /></td> --%>
													<td><c:out value="${history.escalatedReason}" /></td>


												</tr>
											</c:forEach>
										</tbody>
									</table>

								</div>
							</form:form>

						</div>
						<!--/history tab-->

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

<script>
	$(document).ready(function() {
		$('#myDatatable').DataTable({
			"jQueryUI" : true,
			"pagingType" : "full_numbers",
			"lengthMenu" : [ [ 5, 10, 50, -1 ], [ 5, 10, 50, "All" ] ]
		/* few more options are available to use */
		});
	});
</script>
<script>
	$('.trigger').change(function () {
		$('.tick').hide();
		$('.' + $('.trigger:checked').data('rel')).show();
	}).change(); //Show tick on page load
</script>
<script>

$('#usedPartNumbersdataTable').on('click', 'input[type="button"]', function () {
    $(this).closest('tr').remove();
	})
$('p input[type="button"]').click(function () {
    $('#usedPartNumbersdataTable').append('<tr><td><input type="text" class="form-control" id="usedPartNumbers" name="usedPartNumbers" placeholder="Used Part Numbers" /></td><td><input type="button" class="btn btn-danger" value="Remove" /></td></tr>')
});

</script>

<!--Status Selection-->
<script type="text/javascript">
	
	function CheckStatus(val){
	 var element=document.getElementById('order');
	 if(val=='pick a status' || val== 'Awaiting Spares')
	   element.style.display='block';
	 else  
	   element.style.display='none';
	   
	 var element=document.getElementById('manager');
	 if(val=='pick a status'|| val=='Escalated')
	   element.style.display='block';
	 else  
	   element.style.display='none';
	   
	}

</script>


</html>
