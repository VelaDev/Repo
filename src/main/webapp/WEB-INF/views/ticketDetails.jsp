<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Ticket Details | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

  <link type="text/css" rel="stylesheet" href="<c:url value="/resources/custom/css/vela_custom.css" />">
  <link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
  <link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">	
  <link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">
  
</head>
<body>
	<div class="velaphanda_containter">
		<c:import url="templates/techniciannavbar.jsp"></c:import>
		<div class="container">
			<br />
			<div class="panel panel-success">
				<div class="panel-heading">
					<div align="center">
						<b>Ticket Details</b>
					</div>
				</div>
				<div class="panel-body">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#generalDetails"data-toggle="tab">General</a></li>
						<li><a href="#clientDetails" data-toggle="tab">Customer</a></li>
						<li><a href="#productDetails" data-toggle="tab">Device</a></li>
						<li><a href="#escalationDetails" data-toggle="tab">Escalate</a></li>
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
									<!-- Text input Ticket Status-->
									<div class="form-group">
										<label class="col-md-3 control-label">Status</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-user"></i></span> <input name="status"
													id="status" class="form-control" type="text"
													value="${ticketObject.status}" readonly>
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
												required="required" readonly></textarea>
										</div>
									</div>
								</div>

								</div>
								<!--/ First Column-->

								<!--Second Column-->
								<div class="col-md-6">

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
									
									
								</div>
								
								
								<br>
								<div class="form-group row">
									<!-- <div class="col-sm-offset-2 col-sm-8">
										<input type="submit" value="Update General"
											class="btn btn-primary btn-block btn-lg" tabindex="9"
											id="updateGen">
									</div> -->
								</div>
							</form:form>

						</div>
						<!--/general tab-->

						<!--Customers tab-->
						<div class="tab-pane" id="clientDetails">
							<h4 align="center">Customer Details</h4>
							
							
							   <form:form class="well form-horizontal">
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
													type="text" disabled="disabled">
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
													type="text" disabled="disabled">
											</div>
										</div>
									</div>
 
									<!-- Select type Province-->
								 <div class="form-group">
										<label class="col-md-3 control-label">Province</label>
										<div class="col-md-6 selectContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-list"></i></span> <input
													name="province" class="form-control"
													value="${ticketObject.getDevice().getCustomerDevice().getProvince()}"
													type="text" disabled="disabled">
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
													value="${ticketObject.getDevice().getCustomerDevice().getCity_town()}" type="text" disabled="disabled">
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
													type="text" disabled="disabled">
											</div>
										</div>
									</div>
									<!-- Text input Area Code-->
									<div class="form-group">
										<label class="col-md-3 control-label">Area Code</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-home"></i></span> <input name="zipcode"
													placeholder="Area Code" class="form-control"
													value="${ticketObject.getDevice().getCustomerDevice().getZipcode()}" type="text" disabled="disabled">
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
													value="${ticketObject.getDevice().getCustomerDevice().getStreetNumber()}"
													type="text" disabled="disabled">
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
													value="${ticketObject.getDevice().getCustomerDevice().getTelephoneNumber()}"
													type="text" disabled="disabled">
											</div>
										</div>
									</div> 

									<!-- Text input Fax Number-->
									<div class="form-group">
										<label class="col-md-3 control-label">Fax Number</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-earphone"></i></span> <input
													name="faxNumber" placeholder="Fax Number"
													class="form-control"
													value="${ticketObject.getDevice().getCustomerDevice().getFaxNumber()}" type="text" disabled="disabled">
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
													 value="${contactPerson.contactCellNumber}"
													type="text" disabled="disabled">
											</div>
										</div>
									</div> 

								 <!-- Text input Email-->
									<div class="form-group">
										<label class="col-md-3 control-label">E-Mail</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-envelope"></i></span> <input
													class="form-control"
													value="${ticketObject.getDevice().getCustomerDevice().getEmail()}"
													type="text" disabled="disabled">
											</div>
										</div>
									</div> 


								</div> 
								<!-- /S Column -->
								 <div class="form-group">
									<div class="col-sm-offset-2 col-sm-8"></div>
								</div> 
							</form:form>
						</div>
						<!--/Clients tab-->

						<!--products tab-->
						<div class="tab-pane" id="productDetails">
							<h4 align="center">Device Details</h4>
							<form:form class="well form-horizontal">

								 <!--First Column-->
						       <div class="col-md-6">
								<!-- Text input Serial No-->
								<div class="form-group">
									<label class="col-md-3 control-label">Serial No</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-barcode"></i></span> <input
												name="serialNumber" placeholder="Serial Number" value="${ticketObject.getDevice().getSerialNumber() }"
												class="form-control" type="text" disabled="disabled">
										</div>
									</div>
								</div>
								
								<!-- Text input Contract Start Date-->
								<div class="form-group">
									<label class="col-md-3 control-label">Contract Start Date</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-calendar"></i></span> <input
												name="startDate" id="startDate" placeholder="YYYY-MM-DD"
												value="${ticketObject.getDevice().getStartDate()}"
												class="form-control" type="text" disabled="disabled">
										</div>
									</div>
								</div>
								
								<!-- Text checkbox Mono Reading-->
								<div class="form-group">
									<label class="col-md-3 control-label">Mono Reading</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-barcode"></i></span> <input
												name="monoReading" placeholder="Mono Reading"
												value="${ticketObject.getDevice().getMonoReading()}"
												class="form-control" type="text" disabled="disabled">
										</div>
									</div>
								</div>
								
								<!-- Text input Device Location-->
								<div class="form-group">
									<label class="col-md-3 control-label">Device Location</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-home"></i></span> <%-- <input
												name="deviceLocation" id="deviceLocation" placeholder="Device Location"
												value="${ticketObject.getDevice().getDeviceLocation() }"
												class="form-control" type="text" disabled="disabled"> --%>
												<textarea rows="3" cols="30" disabled>${ ticketObject.getDevice().getStreetNumber()} ${ ticketObject.getDevice().getStreetName()}  ${ ticketObject.getDevice().getCity_town()} ${ ticketObject.getDevice().getAreaCode()}
												</textarea>
										</div>
									</div>
								</div>
							
						</div><!--/F Column-->
												
						<!--Second column-->
							<div class="col-sm-6">
								<!-- Text input Machine Model-->
								<div class="form-group">
									<label class="col-md-3 control-label">Model No</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-barcode"></i></span> <input
												name="productModel" placeholder="Product Model"
												value="${ticketObject.device.modelNumber }"
												class="form-control" type="text" disabled="disabled">
										</div>
									</div>
								</div>

								<!-- Text input Contract End Date-->
								<div class="form-group">
									<label class="col-md-3 control-label">Contract End Date</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-calendar"></i></span> <input
												name="endDate" id="endDate" placeholder="YYYY-MM-DD"
												value="${ticketObject.getDevice().getEndDate() }"
												class="form-control" type="text" disabled="disabled">
										</div>
									</div>
								</div>
								<!-- Text input Installation Date-->
								<div class="form-group">
									<label class="col-md-3 control-label">Installation Date</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-calendar"></i></span> <input
												name="installationDate" id="installationDate" placeholder="YYYY-MM-DD"
												value="${ticketObject.getDevice().getInstallationDate() }"
												class="form-control" type="text" disabled="disabled" >
										</div>
									</div>
								</div>
								
								<!-- Select type Mono Colour-->						
								<div class="form-group">
									<label class="col-md-3 control-label">Mono Colour</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-calendar"></i></span> <input
												name="colour" id="colour" placeholder="Colour"
												value="${ticketObject.getDevice().getColourReading() }"
												class="form-control" type="text" disabled="disabled" >
										</div>
									</div>
								</div>
						
						     </div>
								<div class="form-group row">
									<div class="col-sm-offset-2 col-sm-8"></div>
								</div>

							</form:form>
						</div>
						<!--/products tab-->

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
													class="glyphicon glyphicon-list"></i></span> <select name="orderNumber"
													class="form-control selectpicker">
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
							<form:form class="well form-horizontal">
								
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
									
									<!-- Text input Part Number Used-->
									<div class="form-group">
										<label class="col-md-3 control-label">Part Number Used</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-barcode"></i></span> <input
													name="ticketNumber" id="partNumberUsed" class="form-control"
													type="text" value="">
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
											<textarea class="form-control" id="actionTaken" name="actionTaken"
												required="required"></textarea>
										</div>
									</div>
								</div>
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
												<th>Ticket No <img src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
												<th>Date <img src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
												<th>Assigned To <img src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
												<th>Comment <img src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
												
											</tr>
										</thead>
										<tbody>
											<!-- Iterating over the list sent from Controller -->
											<c:forEach items="${ticketHistoryList}" var="history">
															<tr>
																<td><c:out value="${history.ticketNumber}" /></td>
																<td><c:out value="${history.escalatedDate}" /></td>
																<td><c:out value="${history.employee.firstName} ${history.employee.lastName}" /></td>
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

<script type="text/javascript"	src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
<script type="text/javascript"	src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>

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

</html>
