<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
.groupclientdetails {
	float: left;
}

.groupproductdetails {
	float: right;
	margin-right: +15%;
}

.content {
	margin-left: -75%;
	width: 180%;
}

<
style type ="text /css">.myrow-container {
	margin: 20px;
}
</style>

<c:import url="templates/navbar.jsp"></c:import>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Device</title>
</head>
<body class=".container-fluid">

	<div class="container" style="width: 90%">

		<br/>
		<c:if test="${not empty retMessage }">
			<div class="alert alert-info" role="alert">
				<c:out value="${ retMessage}">

				</c:out>
			</div>
		</c:if>

		<div class="panel panel-success">
			<div class="panel-heading">
				<h3 class="panel-title">
					<div align="center">
						<b>Machine Details</b>
					</div>
				</h3>
			</div>
			<div class="panel-body">
				<form action="searchDeviceBySerialNo" method="post"
					id="searchDevice">
					<div class="row">
   					  <div class="col-xs-2 form-control-label" align="center">Search
							Device
					  </div>
					  <div class="col-xs-3">
						<input type="text" class="form-control input-sm" name="SerialNo"
								id="SerialNo" placeholder="Serial No">
					   </div>
					   <div class="col-xs-2">
							<input class="btn btn-success" type='submit' value='Search' />
					    </div>
						<div class="col-sm-offset-2 col-sm-8">
								<div id="messages"></div>
						</div>
					</div>

					</div>
					<br>
					<hr>
					<br>
				</form>
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
												<label>Product Model:</label>
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
		</div>
	</div>

</body>	
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$('#searchDevice')
								.bootstrapValidator(
										{
											container : '#messages',
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

<script type="text/javascript" src="<c:url value="/resources/jquery/1.10.2/jquery-1.10.2.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.5/js/bootstrap.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>

<link href="<c:url value="/resources/bootstrap-3.3.5/css/bootstrap.min.css" />"	rel="stylesheet" type="text/css" /> 
<link href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />" rel="stylesheet" type="text/css" /> 

<%-- 
<script type="text/javascript"
	src="<c:url value="/resources/bootstrap-3.3.6/js/jquery-2.1.4.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script>
<link
	href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" /> --%>
</html>