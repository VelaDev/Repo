<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Add Spares | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
<link
	href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />"
	rel="stylesheet" type="text/css" />

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">

<style>

.buttonsCompitableDevice{
	margin-left:40%;
}
.groupsparedetails {
	float: left;
}

.groupsearchdetails {
	float: right;
	margin-right: -12%;
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
							<b>Receive Spares</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">

					<div class="tab-content">

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
												name="partNumber" id="partNumber" class="form-control"
												type="text" placeholder='Search By Part Number'>
										</div>
									</div>
									<div class="col-md-2">
										<input class="btn btn-success" type='submit' value='Search' />
									</div>
								</div>
							</div>
							<hr>
						</form:form>
						<!--Search-->

						<div class="col-xs-10">
							<form:form>
								<div class="groupdetails-row-padding">
								
									
									
									<div class="groupsearchdetails">
										
										<legend>Compatible Devices </legend>
										
										<div class="content">
											<%-- <!-- Below table will be displayed as Data table -->
											<table id="myDatatable" class="display datatable">
												<thead>
													<legend>Compatible Devices </legend>
												</thead>
												<tbody>
													<!-- Iterating over the list sent from Controller -->
													<c:forEach items="${models}" var="device">
														<tr>
															<td><h6>${ device}</h6></td>
														</tr>
													</c:forEach>

												</tbody>
											</table> --%>
										</div> 
										
										<div class="buttonsCompitableDevice">										
										
											<!-- Text input Machine Model-->
											<div class="form-group">
												<label>Model No</label>	
												<input name="modelNumber" id="modelNumber" placeholder="Model Number" class="form-control" type="text" ><br/>
											</div>
											<br/><br/>
											<a href="#"><button class="btn btn-info">Add </button></a><br/>
											<a href="#"><button class="btn btn-danger">Remove</button></a>
										
											<div class="listfromPopulatedModelNumber" id="listfromPopulatedModelNumber">
												<select id="listfromPopulatedModelNo" multiple="multiple" rows=10>
	        
	    										</select>
											</div>
										
										</div>
										
										</div>
										
									</div><!-- //group search details -->
								
							</form:form>

							

							<form:form action="saveSpareParts"
								modelAttribute="saveSpareParts" method="post" id="saveSpareParts">

								<div class="groupsparedetails">
									<legend>Spares</legend>

									<div class="row">
										<div class="col-xs-12">
											<div class="col-xs-4 form-control-label">
												<h6>
													<label>Part Number</label>
												</h6>

											</div>
											<div class="col-xs-8">
												<div class="form-group">
													<div class="input-group">
														<input type="text" id="partNumber" name="partNumber"
															class="form-control" value="${sparePart.partNumber}">
													</div>
												</div>
											</div>
										</div>
									</div>

									<div class="row">
										<div class="col-xs-12">
											<div class="col-xs-4 form-control-label">
												<h6>
													<label>Item Type</label>
												</h6>

											</div>
											<div class="col-xs-8">

												<div class="form-group">
													<div class="input-group">
														<input type="text" id="itemType" name="itemType"
															class="form-control" value="${sparePart.itemType}">
													</div>
												</div>
											</div>
										</div>
									</div>

									<div class="row">
										<div class="col-xs-12">
											<div class="col-xs-4 form-control-label">
												<h6>
													<label>Description</label>
												</h6>

											</div>
											<div class="col-xs-8">
												<div class="form-group">
													<div class="input-group">
														<input type="text" id="description" name="description"
															class="form-control" value="${sparePart.description}">
													</div>
												</div>
											</div>
										</div>
									</div>

									<div class="row">
										<div class="col-xs-12">
											<div class="col-xs-4 form-control-label">
												<h6>
													<label>Quantity</label>
												</h6>

											</div>
											<div class="col-xs-8">
												<div class="form-group">
													<div class="input-group">
														<input type="text" id="quantity" name="quantity"
															class="form-control"
															onkeypress="return isNumber(event)">
													</div>
												</div>
											</div>
										</div>
									</div>

									<div class="row">
										<div class="col-xs-12">
											<div class="col-xs-4 form-control-label">
												<h6>
													<label>Received By</label>
												</h6>

											</div>
											<div class="col-xs-8">
												<div class="form-group">
													<div class="input-group">
														<input type="text" id="receivedBy" name="receivedBy"
															class="form-control"
															value="${loggedInUser.firstName} ${loggedInUser.lastName}"
															readonly="readonly">
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- //group spare details -->


								<div class="form-group row">
									<div class="col-sm-offset-2 col-sm-8">
										<br> <br> <input type="submit" value="Add Spare"
											class="btn btn-primary btn-block btn-lg" tabindex="9"
											id="addSpare">
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

	<!-- Scripts -->
	<script type="text/javascript"
		src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
	<!-- /Scripts -->

	<script type="text/javascript">
function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}
</script>

	<script>
		$(document)
				.ready(
						function() {
							$('#searchpartNumber')
									.bootstrapValidator(
											{
												feedbackIcons : {
													valid : 'glyphicon glyphicon-ok',
													invalid : 'glyphicon glyphicon-remove',
													validating : 'glyphicon glyphicon-refresh'
												},
												fields : {
													partNumber : {
														validators : {
															stringLength : {
																min : 3,
															},
															notEmpty : {
																message : 'Part number is required to search and cannot be empty'
															}
														}
													},
												}
											});
						});
	</script>

	<!-- Validate add part -->
	<script>
		$(document)
				.ready(
						function() {
							$('#saveSpareParts')
									.bootstrapValidator(
											{
												feedbackIcons : {
													valid : 'glyphicon glyphicon-ok',
													invalid : 'glyphicon glyphicon-remove',
													validating : 'glyphicon glyphicon-refresh'
												},
												fields : {
													partNumber : {
														validators : {
															notEmpty : {
																message : 'Part number is required and cannot be empty'
															}
														}
													},
													itemType : {
														validators : {
															notEmpty : {
																message : 'Item type is required and cannot be empty'
															}
														}
													},
													quantity : {
														validators : {
															notEmpty : {
																message : 'Quantity is required and cannot be empty'
															}
														}
													},
													description : {
														validators : {
															notEmpty : {
																message : 'Description is required and cannot be empty'
															}
														}
													},
												}
											});
						});
	</script>

</body>

</html>
