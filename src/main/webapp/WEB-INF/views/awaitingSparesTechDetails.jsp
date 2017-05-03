<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Awaiting Spares Ticket Details | Velaphanda Trading & Projects</title>
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
<style id="velas-css">
@media ( min-width : 768px) {
	.modal-xl {
		width: 90%;
		max-width: 1200px;
	}
}

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
		<c:import url="templates/navbar.jsp"></c:import>
		<div class="container">
		
			<div class="panel panel-success">
				<div class="panel-heading">
					<div align="center">
						<b>Awaiting Spares Ticket Details</b>
					</div>
				</div>

				<div class="panel-body">
					<ul class="nav nav-tabs">

						<li class="active"><a href="#generalDetails"
							data-toggle="tab">General</a></li>
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
														onchange="CheckStatus(this.value);" readonly name="status"
														id="status" class="form-control selectpicker">
														<option value="${ticketObject.status}">${ticketObject.status}</option>
														<option value="Awaiting Spares">Awaiting Spares</option>
														<option value="Escalated">Escalate Ticket</option>
														<option value="Resolved">Resolved</option>
													</select>
												</div>
											</div>
										</div>


										<div class="modal fade" id="solutionDetails"
											aria-hidden="true" style="display: none;">
											<div class="modal-dialog modal-lg">
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal"
															aria-hidden="true">×</button>
														<h3 class="modal-title">Solution Details</h3>
													</div>
													<div class="modal-body">

														<!--solution tab-->
														<div class="well form-horizontal">

															<div class="groupsparedetails">
																<legend align="left">Ticket Info</legend>
																<!--First Column-->
																<div class="col-md-12">
																	<!-- Text input Ticket Number-->
																	<div class="form-group">
																		<label class="col-md-3 control-label">Ticket
																			Number</label>
																		<div class="col-md-8 inputGroupContainer">
																			<div class="input-group">
																				<span class="input-group-addon"><i
																					class="glyphicon glyphicon-barcode"></i></span> <input
																					name="ticketNumber" id="ticketNumber"
																					class="form-control" type="text"
																					value="${ticketObject.ticketNumber}"
																					readonly="readonly">
																			</div>
																		</div>
																	</div>
																	<!-- Text area Action Taken-->
																	<div class="form-group ">
																		<label class="col-md-3 control-label">Action
																			Taken</label>
																		<div class="col-md-8 selectContainer">
																			<div class="input-group">
																				<span class="input-group-addon"><i
																					class="glyphicon glyphicon-list"></i></span> <select
																					name="actionTaken" id="actionTaken"
																					class="form-control selectpicker">
																					<option value="">Please select Action
																						Taken</option>
																					<option value="Replaced Part">Replaced
																						Part</option>
																					<option value="Replaced Part">Replaced
																						toner</option>
																					<option value="Cleared Paper Jam">Cleared
																						Paper Jam</option>
																					<option value="Installed Drivers">Installed
																						Drivers</option>
																					<option value="Configured Drivers">Configured
																						Drivers</option>
																					<option value="Configured Printer">Configured
																						Printer</option>
																					<option value="User Error">User Error</option>
																					<option value="No fault Found">No fault
																						Found</option>
																				</select>
																			</div>
																		</div>
																	</div>

																	<!-- Text checkbox Colour Reading-->
																	<div class="form-group">
																		<label class="col-md-3 control-label">Colour
																			Reading</label>
																		<div class="col-md-8 inputGroupContainer">
																			<div class="input-group">
																				<span class="input-group-addon"><i
																					class="glyphicon glyphicon-barcode"></i></span> <input
																					type="text" class="form-control"
																					onkeypress="return isNumber(event)"
																					placeholder="Enter Colour Reading" id="colour"
																					name="colourReading"
																					value="${ticketObject.getDevice().getColourReading() }"
																					name="colourReading">
																			</div>
																		</div>
																	</div>
																	<div class="form-group">
																		<label class="col-md-3 control-label">Mono
																			Reading</label>
																		<div class="col-md-8 inputGroupContainer">
																			<div class="input-group">
																				<span class="input-group-addon"><i
																					class="glyphicon glyphicon-barcode"></i></span> <input
																					type="text" class="form-control"
																					onkeypress="return isNumber(event)" id="mono"
																					name="monoReading" placeholder="Enter Mono Reading"
																					name="monoReading"
																					value="${ticketObject.getDevice().getMonoReading() }">
																			</div>
																		</div>
																	</div>

																</div>
															</div>
															<!-- //group details -->

															<!-- group Used Part Numbers -->
															<div class="groupsearchdetails">
																<legend>Used Part Numbers </legend>
																<!-- Radio for Boot Stock-->
																<div class="form-group">
																	<label class="col-md-2 control-label">Boot
																		Stock</label>
																	<div class="col-md-6 inputGroupContainer">
																		<div class="input-group">
																			<input type="radio" name="groupstock" class="trigger"
																				data-rel="boot-stock">
																		</div>
																	</div>
																</div>
																<div class="form-group">
																	<div class="boot-stock tick">
																		<div class="tableContect">
																			<p>
																				<input type="button" class="btn btn-success"
																					value="Add Part Number">
																			</p>
																			<table id="usedPartNumbersdataTable" width="300px"
																				style="width: 300px"
																				class="table table-striped table-bordered table-hover table-condensed">
																				<label class="model">Part Number</label>
																				<c:forEach var="usedPartNumbers"
																					items="${partNumbers}">
																					<tr>

																						<td><input type="text" readOnly
																							class="form-control" id="usedPartNumbers"
																							list="spareParts" onkeydown="upperCaseF(this)"
																							name="usedPartNumbers" value="${usedPartNumbers}"/><datalist id="spareParts"> 
																								<c:forEach var="list"
																									items="${spareParts}">
																									<option value="${list}">
																								</c:forEach> 
																							</datalist></td>
																						<td><input type="button"
																							class="btn btn-danger" value="Remove"></td>
																					</tr>
																				</c:forEach>
																			</table>
																		</div>
																	</div>
																</div>
																<!-- Radio for Site Stock-->
																<div class="form-group">
																	<label class="col-md-2 control-label">Site
																		Stock </label>
																	<div class="col-md-6 inputGroupContainer">
																		<div class="input-group">
																			<input type="radio" name="groupstock" class="trigger"
																				data-rel="site-stock">
																		</div>
																	</div>
																</div>
																<div class="form-group">
																	<div class="site-stock tick">

																		<!-- Text input Customer Name-->
																		<div class="form-group">

																			<div class="col-md-6 inputGroupContainer">
																				<div class="input-group">
																					<span class="input-group-addon"><i
																						class="glyphicon glyphicon-user"></i></span><select
																						id="Site" name="customer"
																						class="form-control selectpicker">
																						<option value="">Select Customer Name</option>
																						<c:forEach items="${customerList}" var="customer">
																							<option value="${customer.customerName}">${customer.customerName}</option>
																						</c:forEach>
																					</select>
																				</div>
																			</div>
																		</div>

																		<div class="tableContect">
																			<p>
																				<input type="button" class="btn btn-success"
																					value="Add Part Number">
																			</p>
																			<table id="usedPartNumbersdataTableSiteStock"
																				width="300px" style="width: 300px"
																				class="table table-striped table-bordered table-hover table-condensed">
																				<label class="model">Part Number</label>
																				<c:forEach var="usedPartNumbers"
																					items="${partNumbers}">
																					<tr>

																						<td><input type="text" readOnly
																							class="form-control" list="spareParts" onkeydown="upperCaseF(this)" id="usedPartNumbers"
																							onkeydown="upperCaseF(this)" name="usedPartNumbers" value="${usedPartNumbers}"/><!-- Iterating over the list sent from Controller -->
																							<datalist id="spareParts"> 
																								<c:forEach var="list"
																									items="${spareParts}">
																									<option value="${list}">
																								</c:forEach> 
																							</datalist></td>
																						<td><input type="button"
																							class="btn btn-danger" value="Remove"></td>

																					</tr>
																				</c:forEach>
																			</table>
																		</div>
																	</div>
																</div>
															</div>
															<!-- //group Used Part Numbers -->
														
														
														
														</div>
														<!--/solution tab-->

													</div>
													<div class="modal-footer">
														<button type="button" class="btn btn-default"
															data-dismiss="modal">Close</button>
														<button id="save" type="button" class="btn btn-primary"
															data-dismiss="modal">Save</button>
													</div>

												</div>
												<!-- /.modal-content -->
											</div>
											<!-- /.modal-dialog -->
										</div>
										<!-- /.modal -->


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
														required="required" readonly>${ticketObject.subject}</textarea>
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
													<textarea class="form-control" onkeydown="upperCaseF(this)" name="description"
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
														required="required" placeholder="Please enter comments"
														id="comment" readonly></textarea>
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
									<a href="viewCustomerDetails?customerName=<c:out value='${ticketObject.device.customerDevice.customerName}'/>">${ticketObject.device.customerDevice.customerName}</a>
								</fieldset>
								<!-- //Customer Details -->

								<br>
								
							</form:form>

						</div>
						<!--/general tab-->




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
	src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
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
$('#status').change(function() {
    var opval = $(this).val();
    if(opval=="Resolved"){
        $('#solutionDetails').modal("show");
    }
});
</script>

<script>
	$('.trigger').change(function () {
		$('.tick').hide();
		$('.' + $('.trigger:checked').data('rel')).show();
	}).change(); //Show content on page load
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
request.open('GET', 'https://s3-us-west-2.amazonaws.com/s.cdpn.io/4621/html-elements.json', true);
request.send();

</script>

<script>

$('#usedPartNumbersdataTable').on('click', 'input[type="button"]', function () {
    $(this).closest('tr').remove();
	})
$('p input[type="button"]').click(function () {
    $('#usedPartNumbersdataTable').append('<tr><td><input type="text" class="form-control" list="spareParts" onkeydown="upperCaseF(this)" id="usedPartNumbers" name="usedPartNumbers" placeholder="Used Part Numbers" /><datalist id="spareParts"><c:forEach var="list"	items="${spareParts}"><option value="${list}"></c:forEach></datalist></td><td><input type="button" class="btn btn-danger" value="Remove" /></td></tr>')
});

</script>
<script>

$('#usedPartNumbersdataTableSiteStock').on('click', 'input[type="button"]', function () {
    $(this).closest('tr').remove();
	})
$('p input[type="button"]').click(function () {
    $('#usedPartNumbersdataTableSiteStock').append('<tr><td><input type="text" class="form-control" list="spareParts" onkeydown="upperCaseF(this)" id="usedPartNumbers" name="usedPartNumbers" placeholder="Used Part Numbers" /><datalist id="spareParts"><c:forEach var="list"	items="${spareParts}"><option value="${list}"></c:forEach></datalist></td><td><input type="button" class="btn btn-danger" value="Remove" /></td></tr>')
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

<!-- Accept alphanumeric characters only -->
<script type="text/javascript">
function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}
</script>

<!-- Make all Serials numbers UpperCase  -->
<script type="text/javascript">
	function upperCaseF(a){
	    setTimeout(function(){
	        a.value = a.value.toUpperCase();
	    }, 1);
	}
</script>

</html>
