<%@include file="templates/taglibs.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ticket Details</title>
</head>
<body>
	<c:import url="templates/techniciannavbar.jsp"></c:import>
<body class=".container-fluid">
	<div class="container myrow-container" style="width: 90%">
		<div class="panel panel-success">
			<div class="panel-heading">
				<h3 class="panel-title">
					<div align="left">
						<b>Ticket Details</b>
					</div>
					<!-- <div align="right"><a href="">Think of something</a></div> -->
				</h3>
			</div>
			<div class="panel-body">
				<div class="col-lg-10">
					<div class="panel-body">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#generalDetails"
								data-toggle="tab">General</a></li>
							<li><a href="#clientDetails" data-toggle="tab">Client</a></li>
							<li><a href="#productDetails" data-toggle="tab">Product</a></li>
							<li><a href="#solutionsDetails" data-toggle="tab">Solution</a></li>
							<li><a href="#historyDetails" data-toggle="tab">History</a></li>
						</ul>
						<div class="tab-content">

							<!--general tab-->
							<div class="tab-pane active" id="generalDetails">
								Sheba General

								<h4 align="center">General Info</h4>

								<form:form action="updateTicket" modelAttribute="updateTicket"
									method="post">
									<div class="form-group row">
										<label for="inputEmail3" class="col-sm-2 form-control-label">Ticket
											Number</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" name="ticketNumber"
												value="${ticketObject.ticketNumber}">
										</div>
									</div>
									<div class="form-group row">
										<label for="inputPassword3"
											class="col-sm-2 form-control-label">Status</label>
										<div class="col-sm-10">
											<input type="text" class="form-control"
												value="${ticketObject.status}" name="status">
										</div>
									</div>
									<div class="form-group row">
										<label for="inputPassword3"
											class="col-sm-2 form-control-label">Description</label>
										<div class="col-sm-10">
											<textarea rows="5" cols="111" name="description">${ticketObject.description }</textarea>
											<%-- <input type="text" class="form-control" value="${ticketObject.status}" name="status"> --%>
										</div>
									</div>
									<div class="form-group row">
										<label for="inputPassword3"
											class="col-sm-2 form-control-label">Priority</label>
										<div class="col-sm-10">
											<input type="text" class="form-control"
												value="${ticketObject.priority}" name="priority">
										</div>
									</div>
									<div class="form-group row">
										<label for="inputPassword3"
											class="col-sm-2 form-control-label">DateTime
											Acknowledged</label>
										<div class="col-sm-10">
											<input type="text" class="form-control"
												value="${ticketObject.getSlaAcknowledgeDateTime().getTime().toLocaleString()}">
										</div>
									</div>
									<div class="form-group row">
										<label for="inputPassword3"
											class="col-sm-2 form-control-label">SLA</label>
										<div class="col-sm-10">
											<input type="text" class="form-control"
												value="${ticketObject.slaStart}">
										</div>
									</div>
									<div class="form-group row">
										<label class="col-sm-2">Acknowledge Ticket</label>
										<div class="col-sm-10">
											<div class="checkbox">
												<label> <input type="checkbox"
													name="technicianAcknowledged" value="true">
												</label>
											</div>
										</div>
									</div>

									<div class="form-group row">
										<div class="col-sm-offset-2 col-sm-10">
											<input type="submit" value="Submit"
												class="btn btn-primary btn-block btn-lg" tabindex="9"
												id="submit">
										</div>
									</div>
								</form:form>
							</div>
						</div>
						<!--Clients tab-->
						<div class="tab-pane" id="clientDetails">
							Sheba Client

							<h4 align="center">Client Details</h4>
							
							<form:form>
								<div class="form-group row">
									<label for="inputEmail3" class="col-sm-2 form-control-label">Client
										Name</label>
									<div class="col-sm-10">
										<input type="text" class="form-control"
											value="${ticketObject.product.client.clientName}">
									</div>
								</div>
								<div class="form-group row">
									<label for="inputPassword3" class="col-sm-2 form-control-label">Telephone
										No</label>
									<div class="col-sm-10">
										<input type="text" class="form-control"
											value="${ticketObject.product.client.getTellphoneNumber()}">
									</div>
								</div>
								<div class="form-group row">
									<label for="inputPassword3" class="col-sm-2 form-control-label">Email</label>
									<div class="col-sm-10">
										<input type="text" class="form-control"
											value="${ticketObject.product.client.getEmail()}">
									</div>
								</div>
								<div class="form-group row">
									<label for="inputPassword3" class="col-sm-2 form-control-label">Street
										Name</label>
									<div class="col-sm-10">
										<input type="text" class="form-control"
											value="${ticketObject.product.client.getStreetName()}">
									</div>
								</div>
								<div class="form-group row">
									<label for="inputPassword3" class="col-sm-2 form-control-label">City/Towm</label>
									<div class="col-sm-10">
										<input type="text" class="form-control"
											value="${ticketObject.product.client.city_town}">
									</div>
								</div>
								<div class="form-group row">
									<label for="inputPassword3" class="col-sm-2 form-control-label">Province</label>
									<div class="col-sm-10">
										<input type="text" class="form-control"
											value="${ticketObject.product.client.getProvince()}">
									</div>
								</div>
								<div class="form-group row">
									<label for="inputPassword3" class="col-sm-2 form-control-label">Area
										Code</label>
									<div class="col-sm-10">
										<input type="text" class="form-control"
											value="${ticketObject.product.client.zipcode}">
									</div>
								</div>
							</form:form>
						</div>
						<!--products tab-->
						<div class="tab-pane" id="productDetails">
							Shepa Product
							<h4 align="center">Product Details</h4>
							
							<form:form>
								<div class="form-group row">
									<label for="inputEmail3" class="col-sm-2 form-control-label">Serial
										No</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" name="product"
											value="${ticketObject.getProduct().getSerialNumber()}">
									</div>
								</div>
								<div class="form-group row">
									<label for="inputPassword3" class="col-sm-2 form-control-label">Product
										Name</label>
									<div class="col-sm-10">
										<input type="text" class="form-control"
											value="${ticketObject.getProduct().getProductName()}">
									</div>
								</div>
								<div class="form-group row">
									<label for="inputPassword3" class="col-sm-2 form-control-label">Product
										Type</label>
									<div class="col-sm-10">
										<input type="text" class="form-control"
											value="${ticketObject.getProduct().getProductType()}">
									</div>
								</div>

								<div class="form-group row">
									<label for="inputPassword3" class="col-sm-2 form-control-label">Model</label>
									<div class="col-sm-10">
										<input type="text" class="form-control"
											value="${ticketObject.getProduct().getProductModel()}">
									</div>
								</div>
							</form:form>
						</div>
						<!--solution tab-->
						<div class="tab-pane" id="solutionsDetails">
							Sheba Solution

							<h4 align="center">Solution Details</h4>
							
							<form:form>
								<div class="form-group row">
									<label for="inputPassword3" class="col-sm-2 form-control-label">Resolution</label>
									<div class="col-sm-10">
										<textarea rows="4" cols="111"></textarea>
										<%-- <input type="text" class="form-control" value="${ticketObject.status}" name="status"> --%>
									</div>
								</div>

								<div class="form-group row">
									<label for="inputPassword3" class="col-sm-2 form-control-label">Solution</label>
									<div class="col-sm-10">
										<textarea rows="4" cols="111"></textarea>
										<%-- <input type="text" class="form-control" value="${ticketObject.status}" name="status"> --%>
									</div>
								</div>
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
										<textarea rows="4" cols="111" name="escalateReason"></textarea>
										<%-- <input type="text" class="form-control" value="${ticketObject.status}" name="status"> --%>
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-offset-2 col-sm-10">
										<input type="submit" value="Submit"
											class="btn btn-primary btn-block btn-lg" tabindex="9"
											id="submit">
									</div>
								</div>
							</form:form>

						</div>
						<!--history tab-->
						<div class="tab-pane" id="historyDetails">
							Sheba History
							<h4>History Details</h4>

							<div class="row">
								<form class="form-horizontal"></form>
							</div>
						</div>
					</div>
					<!--/close tab-content -->
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript"
	src="<c:url value="/resources/bootstrap-3.3.6/js/jquery-2.1.4.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script>
<link href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
</html>
