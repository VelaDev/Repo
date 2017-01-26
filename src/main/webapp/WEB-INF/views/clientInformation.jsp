<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Client Information | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
.groupclientdetails {
	float: left;
}

.groupproductdetails {
	float: right;
	margin-right: +10%;
}

.content {
	margin-left: -61%;
	width: 180%;
}
</style>
</head>
<body>
	<div class="velaphanda_containter">
		<c:import url="templates/navbar.jsp"></c:import>
		<div class="container">
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="left">
							<b>Machine Details</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">
						<form action="clientInformation" method="post" id="clientInformation">
							<div class="row">
								<!-- Text input Search-->
								<div class="form-group">
									<label class="col-md-3 control-label">Search Client </label>
									<div class="col-md-4 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-user"></i></span> <input
												name="clientName" id="clientName" class="form-control"
												type="text" placeholder='Search By Client Name'>
										</div>
									</div>
									<div class="col-md-2">
										<input class="btn btn-success" type='submit' value='Search' />
									</div>
								</div>
							</div>
							<hr>
						</form><!--Search-->

						<div class="col-lg-12">
							<form:form method="get">
								<div class="groupdetails-row-padding">
									<div class="groupproductdetails">
										<div class="content">
											<legend>Devices</legend>
											<table class="table table-hover ">
												<thead style="background-color: #D6F1F6;">
													<tr class='clickable-row'>
													   <th>#</th>
														<th>Serial No</th>
														<th>Product Name</th>
														<th>Option</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${clientInformation}" var="device" varStatus="itr">
														<tr>
														     <th><c:out value="${offset + itr.index +1 }"></c:out>
															<th><c:out value="${device.serialNumber}" /></th>
															<th><c:out value="${device.modelNumber}" /></th>
															<th><a
																href="detailedProduct?serialNumber=<c:out value='${device.serialNumber}'/>">Detail</a></th>

														</tr>
													</c:forEach>
												</tbody>
											</table>
											<tag:paginate max="10" offset="${offset}" count="${count}" 
						                     uri="clientInformation" next="&raquo;" previous="&laquo;" />
											
										</div>
									</div>
									<div class="groupclientdetails">
										<legend>Customer Details</legend>
										<form action="">
											<div class="form-group row">
												<label for="companyname" class="col-sm-6 form-control-label">Company
													Name</label>
												<div class="col-sm-10">
													<input type="text" class="form-control" name="client"
														value="${client.clientName}" disabled="disabled">
												</div>
											</div>
											<div class="form-group row">
												<label for="telphone" class="col-sm-6 form-control-label">Tellphone
													Number</label>
												<div class="col-sm-10">
													<input type="text" class="form-control" name="client"
														value="${client.tellphoneNumber}" disabled="disabled">
												</div>
											</div>

											<div class="form-group row">
												<label for="Email" class="col-sm-6 form-control-label">Email
													Address</label>
												<div class="col-sm-10">
													<input type="text" class="form-control" name="client"
														value="${client.email}" disabled="disabled">
												</div>
											</div>
											<div class="form-group row">
												<label for="Address" class="col-sm-4 form-control-label">Address</label>
												<div class="col-sm-10">
													<textarea rows="3" cols="50" disabled="disabled">${client.streetName}, ${client.city_town},${client.province}</textarea>
												</div>
											</div>
										</form>
									</div>
								</div>
							</form:form>
						</div>
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

	<!-- Script -->
	<script type="text/javascript"
		src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
	<!-- /Script -->

	<script>
		$(document)
				.ready(
						function() {
							$('#searchCustomer')
									.bootstrapValidator(
											{
												feedbackIcons : {
													valid : 'glyphicon glyphicon-ok'

												},
												fields : {
													clientName : {
														validators : {
															stringLength : {
																min : 3,
															},

															notEmpty : {
																message : 'Client name is required to search and cannot be empty'
															}
														}
													},
												}
											});
						});
	</script>

</body>
</html>
