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

							<form:form action="updateTicket" modelAttribute="updateTicket"
								method="post">
								<div class="row">
									<div class="col-xs-12">
										<div class="col-xs-2 form-control-label">
											<label>Ticket Number:</label>

										</div>
										<div class="col-xs-3">
											<input type="text" class="form-control" name="ticketNumber"
												value="${ticketObject.ticketNumber}">
										</div>

										<div class="col-xs-2 form-control-label">
											<label>Status:</label>

										</div>
										<div class="col-xs-3">
											<input type="text" class="form-control"
												value="${ticketObject.status}" name="status">
										</div>
									</div>
								</div>
								<br>

								<div class="row">
									<div class="col-xs-12">
										<div class="col-xs-2 form-control-label">
											<label>SLA:</label>

										</div>
										<div class="col-xs-3">
											<input type="text" class="form-control"
												value="${ticketObject.slaStart}">
										</div>

										<div class="col-xs-2 form-control-label">
											<label>Priority:</label>

										</div>
										<div class="col-xs-3">
											<input type="text" class="form-control"
												value="${ticketObject.priority}" name="priority">
										</div>
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-xs-12">
										<div class="col-xs-2 form-control-label">
											<label>Acknowledge Ticket:</label>

										</div>
										<div class="col-xs-3">
											<input type="checkbox" name="technicianAcknowledged"
												value="true">
										</div>

										<div class="col-xs-2 form-control-label">
											<label>DateTime Acknowledged:</label>

										</div>
										<div class="col-xs-3">
											<input type="text" class="form-control"
												value="${ticketObject.getSlaAcknowledgeDateTime().getTime().toLocaleString()}">
										</div>
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-xs-12">
										<div class="col-xs-2 form-control-label">
											<label>Description:</label>

										</div>
										<div class="col-xs-3">
											<textarea rows="3" cols="98" name="description">${ticketObject.description }</textarea>
										</div>
									</div>
								</div>
								<br>
								<div class="form-group row">
									<div class="col-sm-offset-2 col-sm-8">
										<input type="submit" value="Submit"
											class="btn btn-primary btn-block btn-lg" tabindex="9"
											id="submit">
									</div>
								</div>
							</form:form>
						</div><!--/general tab-->

						<!--Clients tab-->
						<div class="tab-pane" id="clientDetails">
							<h4 align="center">Client Details</h4>

							<form:form>

								<div class="row">
									<div class="col-xs-12">
										<div class="col-xs-2 form-control-label">
											<label>Client Name:</label>

										</div>
										<div class="col-xs-3">
											<input type="text" class="form-control"
												value="${ticketObject.device.client.clientName}">
										</div>

										<div class="col-xs-2 form-control-label">
											<label>Contact Person:</label>

										</div>
										<div class="col-xs-3">
											<input type="text" class="form-control"
												value="${ticketObject.device.client.getContactPerson()}">
										</div>
									</div>
								</div>
								<br>

								<div class="row">
									<div class="col-xs-12">
										<div class="col-xs-2 form-control-label">
											<label>Telephone No:</label>

										</div>
										<div class="col-xs-3">
											<input type="text" class="form-control"
												value="${ticketObject.device.client.getTellphoneNumber()}">
										</div>
										<div class="col-xs-2 form-control-label">
											<label>Email:</label>

										</div>
										<div class="col-xs-3">
											<input type="text" class="form-control"
												value="${ticketObject.device.client.getEmail()}">
										</div>


									</div>
								</div>
								<br>

								<div class="row">
									<div class="col-xs-12">
										<div class="col-xs-2 form-control-label">
											<label>Street Name:</label>

										</div>
										<div class="col-xs-3">
											<input type="text" class="form-control"
												value="${ticketObject.device.client.getStreetName()}">
										</div>
										<div class="col-xs-2 form-control-label">
											<label>City/Towm:</label>

										</div>
										<div class="col-xs-3">
											<input type="text" class="form-control"
												value="${ticketObject.device.client.city_town}">
										</div>
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-xs-12">

										<div class="col-xs-2 form-control-label">
											<label>Province:</label>

										</div>
										<div class="col-xs-3">
											<input type="text" class="form-control"
												value="${ticketObject.device.client.getProvince()}">
										</div>
										<div class="col-xs-2 form-control-label">
											<label>Area Code:</label>

										</div>
										<div class="col-xs-3">
											<input type="text" class="form-control"
												value="${ticketObject.device.client.zipcode}">
										</div>
									</div>
								</div>
								<br>
							</form:form>
						</div><!--/Clients tab-->
						
						<!--products tab-->
						<div class="tab-pane" id="productDetails">

							<h4 align="center">Product Details</h4>
							<br>

							<form:form>

								<div class="row">
									<div class="col-xs-12">
										<div class="col-xs-2 form-control-label">
											<label>Serial No:</label>

										</div>
										<div class="col-xs-3">
											<input type="text" class="form-control" name="product"
												value="${ticketObject.getDevice().getSerialNumber()}">
										</div>

										<div class="col-xs-2 form-control-label">
											<label>Device Model:</label>

										</div>
										<div class="col-xs-3">
											<input type="text" class="form-control"
												value="${ticketObject.getDevice().getProductModel()}">
										</div>
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-xs-12">
										<div class="col-xs-2 form-control-label">
											<label>Contract Start Date:</label>

										</div>
										<div class="col-xs-3">
											<input type="text" class="form-control" name="product"
												value="${ticketObject.getDevice().getStartDate()}">
										</div>

										<div class="col-xs-2 form-control-label">
											<label>Contract Start Date:</label>

										</div>
										<div class="col-xs-3">
											<input type="text" class="form-control"
												value="${ticketObject.getDevice().getEndDate()}">
										</div>
									</div>
								</div>
								<br>

							</form:form>
						</div><!--/products tab-->

						<!--escalationDetails tab-->
						<div class="tab-pane" id="escalationDetails">

							<h4 align="center">Escalate Ticket</h4>
							<br>

							<form:form>

								<div class="form-group row">
									<label class="col-sm-2">Escalate</label>
									<div class="col-sm-10">
										<div class="checkbox">
											<label> <input type="checkbox" name="escalate"
												value="true">
											</label>
										</div>
									</div>
								</div>
								<div class="form-group row">
									<label for="inputPassword3" class="col-sm-2 form-control-label">Escalate
										Reason</label>
									<div class="col-sm-10">
										<textarea rows="3" cols="82" name="escalateReason"
											class="required" required="required"></textarea>
									</div>
								</div>
								<br>
								<div class="form-group row">
									<div class="col-sm-offset-2 col-sm-6">
										<input type="submit" value="Submit"
											class="btn btn-primary btn-block btn-lg" tabindex="9"
											id="submit">
									</div>
								</div>
							</form:form>

						</div><!--/escalationDetails tab-->

						<!--solution tab-->
						<div class="tab-pane" id="solutionsDetails">

							<h4 align="center">Solution Details</h4>
							<br>

							<form:form>
								<div class="form-group row">
									<label for="inputPassword3" class="col-sm-2 form-control-label">Resolution</label>
									<div class="col-sm-10">
										<textarea rows="3" cols="82" class="required"
											required="required"></textarea>
									</div>
								</div>

								<div class="form-group row">
									<label for="inputPassword3" class="col-sm-2 form-control-label">Solution</label>
									<div class="col-sm-10">
										<textarea rows="3" cols="82" class="required"
											required="required"></textarea>
									</div>
								</div>
								<br />
								<div class="form-group row">
									<div class="col-sm-offset-2 col-sm-6">
										<input type="submit" value="Submit"
											class="btn btn-primary btn-block btn-lg" tabindex="9"
											id="submit">
									</div>
								</div>
							</form:form>

						</div><!--/solution tab-->

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
						</div><!--/history tab-->

					</div><!-- /tab-content -->

				</div><!-- /panel body -->
			</div>
			<!--/panel success class-->
		</div><!-- /Container -->
		<!-- Footer -->
		<c:import url="templates/footer.jsp"></c:import>
		<!--/ Footer -->
	</div><!-- / velaphanda_containter -->
</body>
</html>
