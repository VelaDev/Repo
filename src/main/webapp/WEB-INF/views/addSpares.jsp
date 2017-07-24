<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Add Spare Parts | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/custom/css/vela_custom.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/datepicker.min.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/fonts/font-awesome.min.css" />" />

</head>
<body>
	<div class="velaphanda_containter" id="velaphanda_containter">
		<c:import url="templates/navbar.jsp"></c:import>
		<div class="container">
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Add Spares</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">

					<c:if test="${not empty retMessage }">
						<div class="alert alert-info" role="alert">
							<c:out value="${ retMessage}">
							</c:out>
						</div>
					</c:if>

					<c:if test="${not empty errorRetMessage }">
						<div class="alert alert-danger" role="alert">
							<c:out value="${ errorRetMessage}">
							</c:out>

						</div>
					</c:if>
					<form:form class="well form-horizontal" method="POST"
						action="spareToMasterData" modelAttribute="spareToMasterData"
						id="spareParts">

						<!-- Text input Part Number-->
						<div class="form-group">
							<label class="col-md-3 control-label">Part Number</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-barcode"></i></span> <input id="partNum"
										name="partNumber" onkeydown="upperCaseF(this)"
										placeholder="Enter Part Number" class="form-control"
										type="text" value="">
								</div>
							</div>
						</div>

						<!-- Text input Machine Model-->
						<div class="form-group">
							<label class="col-md-3 control-label">Compatible Devices</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-barcode"></i></span> <input
										name="compitableDevice" onkeydown="upperCaseF(this)"
										id="modelNumber" placeholder="Compatible Devices"
										class="form-control" type="text">
								</div>
							</div>
						</div>

						<!-- Select type Item Type-->
						<div class="form-group">
							<label class="col-md-3 control-label">Item Type</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-list"></i></span><select id="itemType"
										class="form-control" name="itemType"
										class="form-control selectpicker">
										<option value="">Select Item Type</option>
										<option value="Toner">Toner</option>
										<option value="Part">Part</option>
									</select>
								</div>
							</div>
						</div>
						<!-- Select type Brand-->
						<div class="form-group">
							<label class="col-md-3 control-label">Brand</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-list"></i></span> <select id="modelBrand"
										name="modelBrand" class="form-control">
										<option value="">Select Brand</option>
										<option value="Samsung">Samsung</option>
										<option value="Canon">Canon</option>
										<option value="Oce">Oce</option>
										<option value="HP">HP</option>
										<option value="Kyocera">Kyocera</option>
										<option value="Nasua">Nasua</option>
										<option value="Ricoh">Ricoh</option>
										<option value="Toshiba">Toshiba</option>

									</select>
								</div>
							</div>
						</div>
						<!-- Text input Description-->
						<div class="form-group">
							<label class="col-md-3 control-label">Description</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-barcode"></i></span> <input
										id="description" name="itemDescription" type="text"
										class="form-control" value="">
								</div>
							</div>
						</div>
						<!-- Text input Received By-->
						<div class="form-group">
							<label class="col-md-3 control-label">Received By</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-user"></i></span> <input type="text"
										id="receivedBy" name="receivedBy" class="form-control"
										value="${loggedInUser.firstName} ${loggedInUser.lastName}"
										readonly="readonly">
								</div>
							</div>
						</div>
						<br>
						<div class="form-group row">
							<div class="col-sm-offset-3 col-sm-6">
								<input type="submit" value="Add Spare Parts"
									class="btn btn-primary btn-block btn-lg" tabindex="9"
									id="addSpareP">
							</div>
						</div>
					</form:form>

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
		src="<c:url value="/resources/jquery/1.13.1/jquery.validate.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>

	<script type="text/javascript"
		src="<c:url value="/resources/custom/js/velas_validations.js"/>"></script>

	<!-- /Script -->

</body>
</html>
