<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Receive Spares | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/custom/css/vela_custom.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/fonts/font-awesome.min.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap-3.3.7/css/datepicker.min.css" />">



<style>
.model {
	margin-left: 3%
}

.form-group-model {
	margin-left: 10%;
}

.groupsparedetails, .groupsearchdetails {
	padding: 20px;
}

.groupsparedetails {
	float: left;
	width: 50%;
}

.groupsearchdetails {
	overflow: hidden;
}
</style>

</head>
<body>
	<div class="velaphanda_containter">
		<c:import url="templates/usernavbar.jsp"></c:import>
		<div class="container">

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

			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Receive Spares</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<p id="getme"></p>
					<div class="tab-content">

							<c:if test="${empty sparePart.partNumber }">
							
							<form:form action="searchpartNumber" method="post"
							id="searchpartNumber">
							<div class="row">
								<!-- Text input Search-->
								<div class="form-group">
									<label class="col-md-3 control-label">Part Number </label>
									<div class="col-md-4 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-hdd"></i></span> <input
												name="partNumber" list="spareParts"
												onkeydown="upperCaseF(this)" id="partNumber"
												class="form-control" type="text"
												placeholder='Search By Part Number'>
										</div>
									</div>
									<!-- Iterating over the list sent from Controller -->
									<datalist id="spareParts"> <c:forEach var="list"
										items="${spareParts}">
										<option value="${list}">
									</c:forEach> </datalist>

									<div class="col-md-2">
										<input class="btn btn-success" type='submit' value='Search' />
									</div>
								</div>
							</div>
							<hr>
						</form:form>
						<!--Search-->
							
						</c:if>						
						<c:if test="${not empty sparePart.partNumber }">
						
						</c:if>
							
												
						<c:if test="${not empty sparePart.itemDescription }">

						<form:form class="well form-horizontal" action="saveSpareParts"
							modelAttribute="saveSpareParts" method="post" id="saveSpareParts">

							<!-- group spare details -->
							<div class="groupsparedetails">
								<legend>Spares</legend>


								<!--First Column-->
								<div class="col-md-12">
									<!-- Text input Part Number-->
									<div class="form-group">
										<label class="col-md-3 control-label">Part Number</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-barcode"></i></span> <input
													id="partNum" readOnly name="partNumber"
													onkeydown="upperCaseF(this)"
													placeholder="Enter Part Number" class="form-control"
													type="text" value="${sparePart.partNumber}">
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
													class="form-control" readOnly name="itemType"
													class="form-control selectpicker">
													<option value="${sparePart.itemType}">${sparePart.itemType}</option>
													<option value="Toner">Toner</option>
													<option value="Part">Part</option>
												</select>
											</div>
										</div>
									</div>
									
									<!-- Select type Brand-->
									<div class="form-group">
										<label class="col-md-3 control-label">Model Brand</label>
										<div class="col-md-6 selectContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-list"></i></span>
													<input
													id="modelBrand" readOnly name="modelBrand"
													type="text" class="form-control"
													value="${sparePart.modelBrand}">
												
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
													id="description" readOnly name="itemDescription"
													type="text" class="form-control"
													value="${sparePart.itemDescription}">
											</div>
										</div>
									</div>

									<!-- Text input Quantity-->
									<div class="form-group">
										<label class="col-md-3 control-label">Quantity</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-barcode"></i></span> <input
													type="number" placeholder="Enter Quantity" id="quantity"
													name="quantity" class="form-control">
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

								</div>

							</div>
							<!-- //group spare details -->

							<!-- group search details -->
							<div class="groupsearchdetails">
								<legend>Compatible Devices </legend>

								<div class="tableContect">

									<table id="dataTable" width="300px" style="width: 300px"
										class="table table-striped table-bordered table-hover table-condensed">
										<label class="model">Model No</label>
										<c:forEach var="compitableDevice" items="${models}">
											<tr>

												<td><input type="text" readOnly class="form-control"
													id="compitableDevice" name="compitableDevice"
													value="${compitableDevice}"></td>
											</tr>
										</c:forEach>

									</table>
								</div>
							</div>
							<!-- //group search details -->

							<div class="form-group row">
								<div class="col-sm-offset-2 col-sm-8">
									<br> <br> <input type="submit" value="Add Spare"
										class="btn btn-primary btn-block btn-lg" tabindex="9"
										id="addSpare">
								</div>
							</div>

						</form:form>
						
						</c:if>
						
						<c:if test="${empty sparePart.itemDescription }">
						</c:if>

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

	<!-- Scripts -->
	<script type="text/javascript"
		src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
		<script type="text/javascript"
	src="<c:url value="/resources/jquery/1.13.1/jquery.validate.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap-datepicker.min.js" />"></script>
		
	<script type="text/javascript" src="<c:url value="/resources/custom/js/velas_validations.js"/>"></script>
	
	<!-- /Scripts -->


</body>

</html>
