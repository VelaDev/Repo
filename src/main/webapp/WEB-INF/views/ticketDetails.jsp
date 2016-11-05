<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Ticket Details | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
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
						<li class="active"><a href="#generalDetails"
							data-toggle="tab">General</a></li>
						<li><a href="#clientDetails" data-toggle="tab">Client</a></li>
						<li><a href="#productDetails" data-toggle="tab">Product</a></li>
						<li><a href="#escalationDetails" data-toggle="tab">Escalate</a></li>
						<li><a href="#solutionsDetails" data-toggle="tab">Solution</a></li>
						<li><a href="#historyDetails" data-toggle="tab">History</a></li>

					</ul>
					<!-- tab nav -->

					<div class="tab-content">

						<!--general tab-->
						<div class="tab-pane active" id="generalDetails">
							<h4 align="center">General Info</h4>
							<br>

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
													class="glyphicon glyphicon-barcaode"></i></span> <input
													name="ticketNumber" id="ticketNumber" class="form-control"
													type="text" value="${ticketObject.ticketNumber}">
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
													value="${ticketObject.status}">
											</div>
										</div>
									</div>

									<!-- Text input Ticket SLA-->
									<div class="form-group">
										<label class="col-md-3 control-label">SLA</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-user"></i></span> <input
													name="slaStart" id="slaStart" class="form-control"
													type="text" value="${ticketObject.slaStart}">
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
													type="text" value="${ticketObject.priority}">
											</div>
										</div>
									</div>

									<!-- Text input Ticket Acknowledged-->
									<div class="form-group">
										<label class="col-md-3 control-label">Acknowledged
											Ticket</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<input name="priority" id="priority" class="form-control"
													type="checkbox" value="true" name="technicianAcknowledged">
											</div>
										</div>
									</div>
									<!-- Text input Ticket DateTime Acknowledged-->
									<div class="form-group">
										<label class="col-md-3 control-label">DateTime
											Acknowledged</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-calendar"></i></span> <input
													name="priority" id="priority" class="form-control"
													type="text"
													value="${ticketObject.getSlaAcknowledgeDateTime().getTime().toLocaleString()}">
											</div>
										</div>
									</div>


								</div>
								<!--/S Column-->

								<!-- Text area Description-->
								<div class="form-group">
									<label class="col-md-3 control-label">Description</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-pencil"></i></span>
											<textarea class="form-control" name="description">${ticketObject.description }</textarea>
										</div>
									</div>
								</div>


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

						<!--Clients tab-->
						<div class="tab-pane" id="clientDetails">
							<h4 align="center">Client Details</h4>

							<form:form class="well form-horizontal">

								<!--First column-->
								<div class="col-sm-6">

									<!-- Text input Client Name-->
									<div class="form-group">
										<label class="col-md-3 control-label">Client Name</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-user"></i></span> <input
													name="clientName" placeholder="Client Name"
													class="form-control"
													value="${ticketObject.device.client.clientName}"
													type="text">
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
													value="${ticketObject.device.client.getContactPerson()}"
													type="text">
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
													value="${ticketObject.device.client.getProvince()}"
													type="text">


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
													value="${ticketObject.device.client.city_town}" type="text">
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
													value="${ticketObject.device.client.getStreetName()}"
													type="text">
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
													value="${ticketObject.device.client.zipcode}" type="text">
											</div>
										</div>
									</div>

								</div>
								<!-- / F column -->

								<!--Second column-->
								<div class="col-sm-6">


									<!-- Text input Floor Number-->
									<div class="form-group">
										<label class="col-md-3 control-label">Floor No</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-home"></i></span> <input
													name="floorNumber" placeholder="Floor Number"
													class="form-control"
													value="${ticketObject.device.client.floorNumber}"
													type="text">
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
													value="${ticketObject.device.client.getTellphoneNumber()}"
													type="text">
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
													value="${ticketObject.device.client.faxNumber}" type="text">
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
													value="${ticketObject.device.client.cellNumber}"
													type="text">
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
													value="${ticketObject.device.client.getEmail()}"
													type="text">
											</div>
										</div>
									</div>


								</div>
								<!-- /S Column -->
							</form:form>
						</div>
						<!--/Clients tab-->

						<!--products tab-->
						<div class="tab-pane" id="productDetails">

							<h4 align="center">Product Details</h4>
							<br>

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
													name="serialNumber"
													value="${ticketObject.getDevice().getSerialNumber()}"
													class="form-control" type="text">
											</div>
										</div>
									</div>

									<!-- Text input Contract Start Date-->
									<div class="form-group">
										<label class="col-md-3 control-label">Contract Start
											Date</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-calendar"></i></span> <input
													name="startDate" id="startDate"
													value="${ticketObject.getDevice().getStartDate()}"
													class="form-control" type="text">
											</div>
										</div>
									</div>

								</div>
								<!--/F Column-->

								<!--Second column-->
								<div class="col-sm-6">
									<!-- Text input Machine Model-->
									<div class="form-group">
										<label class="col-md-3 control-label">Machine Model</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-barcode"></i></span> <input
													name="productModel"
													value="${ticketObject.getDevice().getProductModel()}"
													class="form-control" type="text">
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
													name="endDate" id="endDate"
													value="${ticketObject.getDevice().getEndDate()}"
													class="form-control" type="text">
											</div>
										</div>
									</div>
								</div>
								<!--/S Column-->
								<br>

							</form:form>
						</div>
						<!--/products tab-->

						<!--escalationDetails tab-->
						<div class="tab-pane" id="escalationDetails">

							<h4 align="center">Escalate Ticket</h4>
							<br>

							<form:form class="well form-horizontal">


								<!-- Text area Escalate-->
								<div class="form-group">
									<label class="col-md-3 control-label">Escalate </label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<input class="form-control" type="checkbox" name="escalate"
												value="true" required="required">
										</div>
									</div>
								</div>

								<!-- Text area Escalate Reason-->
								<div class="form-group">
									<label class="col-md-3 control-label">Escalate Reason</label>
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
										<input type="submit" value="Escalate Ticket"
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
							<br>

							<form:form class="well form-horizontal">


								<!-- Text area Resolution-->
								<div class="form-group">
									<label class="col-md-3 control-label">Resolution </label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-pencil"></i></span>
											<textarea class="form-control" name="resolution"
												required="required"></textarea>
										</div>
									</div>
								</div>

								<!-- Text area Solution-->
								<div class="form-group">
									<label class="col-md-3 control-label">Solution </label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-pencil"></i></span>
											<textarea class="form-control" name="solution"
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

							<h4>History Details</h4>

							<div class="row">
								<form class="form-horizontal">
									<div class="panel-body">
										<div class="row">
											<div class="content">
												<table class="table table-hover ">
													<thead style="background-color: #bce8f1;">
														<tr class='clickable-row'>
															<th>Ticket No</th>
															<th>Date</th>
															<th>Assigned To</th>
															<th>Comment</th>

														</tr>
													</thead>
													<tbody>
														<c:forEach items="${ticketHistoryList}" var="history">
															<tr>
																<th><c:out value="${history.ticketNumber}" /></th>
																<th><c:out value="${history.escalatedDate}" /></th>
																<%-- <th><c:out value="${history.part.modelNumber}" /></th> --%>
																<th><c:out value="${history.comment}" /></th>


															</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</form>
							</div>
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
</html>
