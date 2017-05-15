<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Escalated Tickets | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/custom/css/vela_custom.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/custom/css/vela_custom_ticktes.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">


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
			<c:if test="${not empty retErrorMessage }">
				<div class="alert alert-danger" role="alert">
					<c:out value="${ retErrorMessage}">
					</c:out>
				</div>
			</c:if>
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Escalated Tickets Details</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<ul class="nav nav-tabs">

						<li class="active"><a href="#generalDetails"
							data-toggle="tab">General</a></li>
						<!-- <li><a href="#resolvedDetails" data-toggle="tab">Resolved
								Details</a></li>
						 -->
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



										<!-- Select type Order No-->
										<div class="order" id="order" style="display: none;">
											<div class="form-group">
												<label class="col-md-3 control-label"> Order No</label>
												<div class="col-md-6 selectContainer">
													<div class="input-group">
														<span class="input-group-addon"><i
															class="glyphicon glyphicon-list"></i></span> <select id="order"
															name="orderNum" readonly class="form-control selectpicker">
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
															id="escalatedTo" readonly name="escalatedTo"
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
													<textarea class="form-control" readonly onkeydown="upperCaseF(this)"
														name="description" required="required" readonly>${ticketObject.description}</textarea>
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
													<textarea class="form-control" readonly name="comments"
														required="required" placeholder="Please enter comments"
														id="comment"></textarea>
												</div>
											</div>
										</div>
									</div>
									<!--//Second Column-->
								</fieldset>
								<!-- //Ticket Details -->


								<!-- //Device Details -->
								<div class="well form-horizontal">

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
												<label class="col-md-3 control-label">Device
													Location</label>
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

								</div>
								<!-- //Device Details -->

								<!-- Customer Details -->
								<fieldset>
									<legend align="left">Customer Details</legend>
									<a
										href="viewCustomerDetails?customerName=<c:out value='${ticketObject.device.customerDevice.customerName}'/>">${ticketObject.device.customerDevice.customerName}</a>
								</fieldset>
								<!-- //Customer Details -->

								<br>
								
							</form:form>

						</div>
						<!--/general tab-->

						<!-- Solution Details -->
						<form:form action="updateTicket" modelAttribute="updateTicket" method="post" id="updataTckt" >

							<div id="solutionDetails" class="modal fade" role="dialog"
								aria-labelledby="solutionDetailsLabel" aria-hidden="true">
								<div class="modal-dialog modal-lg">
									<div class="modal-content">
									
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-hidden="true">×</button>
											<h3 class="modal-title">Solution Details</h3>
										</div>
										
										<div class="modal-body">

											<!--wellform form-horizontal-->
											<div class="wellform form-horizontal">

												<div class="groupsparedetails">
													<legend align="left">Ticket Info</legend>
													<!--First Column-->
													<div class="col-md-12">
														<!-- Text input Ticket Number-->
														<div class="form-group">
															<label class="col-md-4 control-label">Ticket
																Number</label>
															<div class="col-md-8 inputGroupContainer">
																<div class="input-group">
																	<span class="input-group-addon"><i
																		class="glyphicon glyphicon-barcode"></i></span> <input
																		id="ticketNumber" class="form-control" type="text"
																		name="ticketNumber"
																		value="${ticketObject.ticketNumber}"
																		readonly="readonly">
																</div>
															</div>
														</div>

														<!-- Text input status-->
														<div class="form-group">
															<label class="col-md-4 control-label">Status</label>
															<div class="col-md-8 inputGroupContainer">
																<div class="input-group">
																	<span class="input-group-addon"><i
																		class="glyphicon glyphicon-barcode"></i></span> <input
																		id="status" class="form-control" type="text"
																		name="status" value="Resolved" readonly="readonly">
																</div>
															</div>
														</div>

														<!-- Text area Action Taken-->
														<div class="form-group ">
															<label class="col-md-4 control-label">Action
																Taken</label>
															<div class="col-md-8 selectContainer">
																<div class="input-group">
																	<span class="input-group-addon"><i
																		class="glyphicon glyphicon-list"></i></span> <select
																		name="actionTaken" id="actionTaken"
																		class="form-control selectpicker"
																		onchange="CheckPartToner(this.value);">
																		<option value="">Please select Action Taken</option>
																		<option value="Replaced Part">Replaced Part</option>
																		<option value="Replaced toner">Replaced Toner</option>
																		<option value="Cleared Paper Jam">Cleared
																			Paper Jam</option>
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

														<!-- Text checkbox Colour Reading-->
														<div class="form-group">
															<label class="col-md-4 control-label">Colour
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
															<label class="col-md-4 control-label">Mono
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



													<div class="diplayNone" id="getPartToner"
														>
														<!-- Radio for Boot Stock-->
														<div class="form-group">
															<label class="col-md-3 control-label">Boot Stock</label>
															<div class="col-md-6 inputGroupContainer">
																<div class="input-group">
																	<input type="radio" data-toggle="modal"
																		data-target="#bootStock" name="groupstock"
																		class="trigger" data-rel="boot-stock" id="BootStocked">
																</div>
															</div>
														</div>

														<!-- Radio for Site Stock-->
														<div class="form-group">
															<label class="col-md-3 control-label">Site Stock
															</label>
															<div class="col-md-6 inputGroupContainer">
																<div class="input-group">
																	<input type="radio" name="groupstock" class="trigger"
																		data-rel="site-stock" data-toggle="modal"
																		data-target="#siteStock" id="SiteStocked">
																</div>
															</div>
														</div>


														<!-- display ticked Used Part Numbers-->
														<div class="shitRight">
															<div class="form-group">
																<label class="col-md-5 control-label">Used Part
																	Numbers</label>
																<div class="col-md-8 inputGroupContainer">
																	<div class="input-group">
																		<span class="input-group-addon"><i
																			class="glyphicon glyphicon-barcode"></i></span>
																		<textarea id="tickedUsedPartNumbers"
																			class="form-control" readonly="readonly"
																			style="width: 200px; height: 90px; font-size: 11px;"
																			rows="3" name="usedPartNumbers"></textarea>
																	</div>
																</div>
															</div>
														</div>
														<!--// display ticked Used Part Numbers-->

													</div>
													<!-- displayNone for getPartToner -->

												</div>
												<!-- //group Used Part Numbers -->

												<div class="modal-footer">

													<button type="button" class="btn btn-default"
														data-dismiss="modal">Close</button>
													<button type="submit" value="Submit"
														class="btn btn-primary" id="send_btn">Submit</button>

												</div>

											</div>
											<!--/wellform form-horizontal-->

										</div>
										<!-- modal-body -->
									</div>
									<!-- /.modal-content -->
								</div>
								<!-- /.modal-dialog -->
							</div>
							<!-- /.modal solutionDetails-->

							<!--Boot Stock-->
							<div id="bootStock" class="modal fade" role="dialog"
								style="z-index: 1400; padding-top: 5%; padding-left: 17px;">
								<div class="modal-dialog">
									<!-- Modal content-->
									<div class="modal-content" id="botStock">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-hidden="true">×</button>
											<h3 class="modal-title">Boot Stock</h3>
										</div>
										<div class="modal-body">
											<table id="bStock" class="display datatable">
												<thead>
													<tr>
														<th>Part No</th>
														<th>Description</th>
														<!-- <th>Model No</th> -->
														<th>Quantity</th>
														<th>Tick</th>

													</tr>
												</thead>
												<tbody>
													<!-- Iterating over the list sent from Controller -->
													<c:forEach var="list" items="${bootStock}">

														<tr>
															<td>${list.partNumber}</td>
															<td>${list.itemDescription}</td>
															<%-- <td>${list.compatibleDevice}</td> --%>
															<td>${list.quantity}</td>
															<td><input type="checkbox"
																id="${list.partNumber}_selectedItem" name="selectedItem"
																class="form-group" onClick="checkUsedPartNumbers();"
																value="${list.partNumber}"></td>
														</tr>

													</c:forEach>
												</tbody>
											</table>

										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default"
												data-dismiss="modal">Close</button>
											<button id="save" type="button" class="btn btn-primary"
												data-dismiss="modal">Save</button>
										</div>
									</div>
								</div>
							</div>
							<!--/site stock-->


							<!--Site Stock-->
							<div id="siteStock" class="modal fade" role="dialog"
								style="z-index: 1400; padding-top: 5%; padding-left: 17px;">
								<div class="modal-dialog">
									<!-- Modal content-->
									<div class="modal-content" id="siStock">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-hidden="true">×</button>
											<h3 class="modal-title">Site Stock</h3>
										</div>
										<div class="modal-body">
											<table id="sStock" class="display datatable">
												<thead>
													<tr>
														<th>Part No</th>
														<th>Description</th>
														<!-- <th>Model No</th> -->
														<th>Quantity</th>
														<th>Tick</th>

													</tr>
												</thead>
												<tbody>
													<!-- Iterating over the list sent from Controller -->
													<c:forEach var="list" items="${siteStock}">

														<tr>
															<td>${list.partNumber}</td>
															<td>${list.itemDescription}</td>
															<td>${list.quantity}</td>
															<td><input type="checkbox"
																id="${list.partNumber}_selectedItem" name="selectedItem"
																class="form-group" onClick="checkUsedPartNumbers();"
																value="${list.partNumber}"></td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
											<div class="modal-footer">

												<button type="button" class="btn btn-default"
													data-dismiss="modal">Close</button>
												<button id="save" type="button" class="btn btn-primary"
													data-dismiss="modal">Save</button>

											</div>
										</div>
									</div>
								</div>
							</div>
							<!--/site stock-->

						</form:form>
						<!-- /Solution Details -->


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
													<td><c:out value="${history.actionTaken}" /></td>
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
	src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
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
	$(document).ready(function() {
		$('#resolvededDetails').DataTable({
			"jQueryUI" : true,
			"pagingType" : "full_numbers",
			"lengthMenu" : [ [ 5, 10, 50, -1 ], [ 5, 10, 50, "All" ] ]
		/* few more options are available to use */
		});
	});
</script>
<script>
	$(document).ready(function() {
		$('#bStock').DataTable({
			"jQueryUI" : true,
			"pagingType" : "full_numbers",
			"lengthMenu" : [ [ 5, 10, 50, -1 ], [ 5, 10, 50, "All" ] ]
		/* few more options are available to use */
		});
	});
</script>
<script>
	$(document).ready(function() {
		$('#sStock').DataTable({
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
		function checkUsedPartNumbers(){
  
			  var checkboxes = document.getElementsByName('selectedItem');
			  var checkboxesChecked = [];
			  // loop over them all
			  for (var i=0; i<checkboxes.length; i++) {
				 // And stick the checked ones onto an array...
				 if (checkboxes[i].checked) {
					checkboxesChecked.push(checkboxes[i].value);
				 }
			  }
			  document.getElementById("tickedUsedPartNumbers").value = checkboxesChecked;

			}
	</script>

<script>
	$('.trigger').change(function () {
		$('.tick').hide();
		$('.' + $('.trigger:checked').data('rel')).show();
	}).change(); //Show content on page load
</script>




<!--Status Selection-->
<script type="text/javascript">
	
	function CheckStatus(val){
	 var element=document.getElementById('order');
	 if(val=='pick a status' || val== 'Replaced Part')
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




<script>
$("#actionTaken").on('change', function() {
    if( $(this).val() == "Replaced Part" || $(this).val() == "Replaced toner" ) {
        $('input[type="radio"]:enabled').attr('disabled', true);
        $('#BootStocked, #SiteStocked').attr('disabled', false);       
    } else if($(this).val() == "" || $(this).val() == "Cleared Paper Jam" || $(this).val() == "Installed Drivers" || $(this).val() == "Configured Drivers" || $(this).val() =="Configured Printer" || $(this).val() == "User Error" || $(this).val() ==  "No fault Found") {
        $('input[type="radio"]:enabled').attr('disabled', true);
        $('#BootStocked, #SiteStocked').attr('disabled', true);
    }
});

</script>


<!--Select customer before showing add button-->
<script type="text/javascript">
	
	function ShowCustomer(val){
	 var element=document.getElementById('siteAdd');
	 if(val=='pick a customer' ||val=='customer')
	   element.style.display='block';
	 else  
	   element.style.display='none';
	}

</script>
<script>
	$(document)
			.ready(
					function() {
						$('#updataTckt')
								.bootstrapValidator(
										{
											feedbackIcons : {
												valid : 'glyphicon glyphicon-ok',
												invalid : 'glyphicon glyphicon-remove',
												validating : 'glyphicon glyphicon-refresh'
											},
											fields : {
												actionTaken : {
													validators : {
														stringLength : {
															min : 3,
														},
														notEmpty : {
															message : 'Action taken is required and cannot be empty'
														}
													}
												}
											}
										});
					});
</script>

<script>
$('#check_site_stock_customer').bootstrapValidator();
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
