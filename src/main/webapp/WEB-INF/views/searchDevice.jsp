<%@ include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Device | Velaphanda Trading & Projects</title>
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
						<form action="searchDeviceBySerialNo" method="post"
						id="searchDevice">
								<div class="row">
									<!-- Text input Search-->
									<div class="form-group">
										<label class="col-md-3 control-label">Search Device </label>
										<div class="col-md-4 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-hdd"></i></span> <input
													name="SerialNo" id="SerialNo" class="form-control"
													type="text" placeholder='Search By Serial Number'>
											</div>
										</div>
										<div class="col-md-2">
											<input class="btn btn-success" type='submit' value='Search' />
										</div>
									</div>
								</div>
							<hr>
						</form>
								
						<div class="col-xs-10">
							<form action="">
					<div class="groupdetails-row-padding">

						<div class="groupproductdetails">
							<div class="content">
								<legend>Machine Accessories</legend>
								<table class="table table-hover ">
									<thead style="background-color: #D6F1F6;">
										<tr class='clickable-row'>
											<th>Accessory Type</th>
											<th>Serial No</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${accessories}" var="accessory">
											<tr>
												<th><h6>
														<c:out value="${accessory.accessotyType}" />
													</h6></th>
												<th><h6>
														<c:out value="${accessory.serial}" />
													</h6></th>

											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						<div class="groupclientdetails">
							<legend>Machine Details</legend>
							<form:form>
							<div class="row">
									<div class="col-xs-12">
										<div class="col-xs-4 form-control-label">
											<h6>
												<label>Contact Person:</label>
											</h6>

										</div>
										<div class="col-xs-8">
											<input type="text" class="form-control input-sm"
												value="${productObject.client.contactPerson}" disabled="disabled">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-12">
										<div class="col-xs-4 form-control-label">
											<h6>
												<label>Tell No:</label>
											</h6>

										</div>
										<div class="col-xs-8">
											<input type="text" class="form-control input-sm"
												value="${productObject.client.tellphoneNumber}" disabled="disabled">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-12">
										<div class="col-xs-4 form-control-label">
											<h6>
												<label>Serial Number:</label>
											</h6>

										</div>
										<div class="col-xs-8">
											<input type="text" class="form-control input-sm"
												value="${productObject.serialNumber}" disabled="disabled">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-12">
										<div class="col-xs-4 form-control-label">
											<h6>
												<label>Model Number:</label>
											</h6>

										</div>
										<div class="col-xs-8">
											<input type="text" class="form-control input-sm"
												value="${productObject.productModel}" disabled="disabled">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-12">
										<div class="col-xs-4 form-control-label">
											<h6>
												<label>Contract Start Date:</label>
											</h6>

										</div>
										<div class="col-xs-8">
											<input type="text" class="form-control input-sm"
												value="${productObject.startDate}" disabled="disabled">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-12">
										<div class="col-xs-4 form-control-label">
											<h6>
												<label>Contract End Date</label>
											</h6>

										</div>
										<div class="col-xs-8">
											<input type="text" class="form-control input-sm"
												value="${productObject.endDate}" disabled="disabled">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-12">
										<div class="col-xs-4 form-control-label">
											<h6>
												<label>Company Name</label>
											</h6>

										</div>
										<div class="col-xs-8">
											<input type="text" class="form-control input-sm"
												value="${productObject.client.getClientName()}"
												disabled="disabled">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-12">
										<div class="col-xs-4 form-control-label">
											<h6>
												<label>Customer Address</label>
											</h6>

										</div>
										<div class="col-xs-8">
											<textarea rows="3" cols="29" disabled="disabled">${productObject.client.streetName}, ${productObject.client.city_town},${productObject.client.province}</textarea>
										</div>
									</div>
								</div>

							</form:form>
						</div>

					</div>
				</form>
						</div>
				  </div><!-- /tab-content -->
				</div><!-- /panel body -->
			  </div><!--/panel success class-->
			</div><!-- /Container -->
		
	   <!-- Footer -->
	  <c:import url="templates/footer.jsp"></c:import>
	 <!--/ Footer -->
	 
	</div><!-- / velaphanda_containter -->
	
	<!-- Script -->
	<script type="text/javascript"
		src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
	<!-- /Script -->
	
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$('#searchDevice')
								.bootstrapValidator(
										{
											feedbackIcons : {
												valid : 'glyphicon glyphicon-ok',
												invalid : 'glyphicon glyphicon-remove',
												validating : 'glyphicon glyphicon-refresh'
											},
											fields : {
												SerialNo : {
													validators : {
														notEmpty : {
															message : 'Serial Number is required to search and cannot be empty'
														}
													}
												},
											}
							   });
					});
</script>
</body>
</html>