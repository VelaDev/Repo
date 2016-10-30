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
					<div align="center">
						<b>Ticket Details</b>
					</div>
					<!-- <div align="right"><a href="">Think of something</a></div> -->
				</h3>
			</div>
			<div class="panel-body">
				<!-- <div class="col-lg-10"> -->
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
								<h4 align="center">General Info</h4><br>

								<form:form action="updateTicket" modelAttribute="updateTicket"
									method="post">
									<div class="row">
							<div class="col-xs-12">
								<div class="col-xs-2 form-control-label">
									<label>Ticket
											Number:</label>

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
									<input type="checkbox"
													name="technicianAcknowledged" value="true">
								</div>

								<div class="col-xs-2 form-control-label">
									<label>DateTime
											Acknowledged:</label>

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
									class="btn btn-primary btn-block btn-lg" tabindex="9" id="submit">
							</div>
						</div>
				</form:form>
			</div>
					
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
									<label>Telephone
										No:</label>

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
									<label>Street
										Name:</label>

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
									<label>Area
										Code:</label>

								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control"
											value="${ticketObject.device.client.zipcode}">
								</div>
							</div>
						</div>
						<br>
							</form:form>
						</div>
						<!--products tab-->
						<div class="tab-pane" id="productDetails">
							
							<h4 align="center">Product Details</h4><br>
							
							<form:form>
								
								<div class="row">
							<div class="col-xs-12">
								<div class="col-xs-2 form-control-label">
									<label>Serial
										No:</label>

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
						</div>
						
						<!--solution tab-->
						<div class="tab-pane" id="solutionsDetails">
							
							<h4 align="center">Solution Details</h4><br>
							
							<form:form>
								<div class="form-group row">
									<label for="inputPassword3" class="col-sm-2 form-control-label">Resolution</label>
									<div class="col-sm-10">
										<textarea rows="3" cols="79" class="required" required="required"></textarea>
									</div>
								</div>

								<div class="form-group row">
									<label for="inputPassword3" class="col-sm-2 form-control-label">Solution</label>
									<div class="col-sm-10">
										<textarea rows="3" cols="79" class="required" required="required"></textarea>
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
										<textarea rows="3" cols="79" name="escalateReason" class="required" required="required"></textarea>
									</div>
								</div><br>
								<div class="form-group row">
							<div class="col-sm-offset-2 col-sm-8">
								<input type="submit" value="Submit"
									class="btn btn-primary btn-block btn-lg" tabindex="9" id="submit">
							</div>
						</div>
							</form:form>

						</div>
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
					</div>
					</div><!--/close tab-content -->
				</div><!--/Close panel body-->
			</div>
		</div>
	<!-- </div> -->
</body>

<!-- Comment 3.3.6 BootStrap -->
<%-- <script type="text/javascript" 	src="<c:url value="/resources/bootstrap-3.3.6/js/jquery-2.1.4.min.js" />"></script>
<script type="text/javascript" 	src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script>
<link href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />" rel="stylesheet" type="text/css" />
 --%>
 
<!-- Add 3.3.7 BootStrap locally -->
<script type="text/javascript" 	src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"> </script>
<script type="text/javascript" 	src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js" />"> </script>
<link href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" rel="stylesheet" type="text/css" />

<!-- Comment the one from the cloud --><!-- 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->


</html>
