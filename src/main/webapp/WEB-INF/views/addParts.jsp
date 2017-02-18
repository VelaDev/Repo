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
.groupsparedetails {
	float: left;
}

.groupsearchdetails {
	float: right;
	margin-right: -20%;
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

						<form action="searchpartNumber" method="post"
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
						</form>
						<!--Search-->

						<div class="col-xs-10">
							<form action="">
								<div class="groupdetails-row-padding">
									<div class="groupsearchdetails">

										<div class="content">
											<!-- Below table will be displayed as Data table -->
											<table id="myDatatable" class="display datatable">
												<thead>
													<legend>Compatible Devices </legend>
												</thead>
												<tbody>
													<!-- Iterating over the list sent from Controller -->

													<c:forEach items="sparePart" var="device">
														<tr>
															<td><h6>
																	<c:out value="${device.compitableDevice }" />
																</h6></td>
															

														</tr>
													</c:forEach>

												</tbody>
											</table>
										</div>

									</div>
								</div>
								<div class="groupsparedetails">
									<legend>Spares</legend>
									<form:form>
										<div class="row">
											<div class="col-xs-12">
												<div class="col-xs-4 form-control-label">
													<h6>
														<label>Part Number</label>
													</h6>

												</div>
												<div class="col-xs-8">
													<input type="text" id="partNumber" name="partNumber"
														class="form-control input-sm" value="${sparePart.partNumber}" readonly="readonly">
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
													<input type="text" id="itemType" name="itemType"
														class="form-control input-sm" value="${sparePart.itemType}" readonly="readonly">
													</select>
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
													<input type="text" id="description" name="description"
														class="form-control input-sm" value="${sparePart.description}" readonly="readonly">
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
													<input type="text" id="quantity" name="quantity"
														class="form-control input-sm"  >
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
													<input type="text" id="receivedBy" name="receivedBy"
														class="form-control input-sm" value="${loggedInUser.firstName} ${loggedInUser.lastName}" readonly="readonly">
												</div>
											</div>
										</div>
										
										<br>
							<br>
							<div class="form-group row">
								<div class="col-sm-offset-2 col-sm-8">
									<input type="submit" value="Add Spares"
										class="btn btn-primary btn-block btn-lg" tabindex="9"
										id="addSpares">
								</div>
							</div>
									</form:form>
								</div>
						</div>
						</form>
					</div>


					<!-- /spare  -->

					<%-- <div class="groupSpare"> 
						
									<form:form class="well form-horizontal" method="post"
								action="saveSpareParts" modelAttribute="saveSpareParts"
								id="saveSpareParts">

								<!--First column-->
								<div class="col-sm-6">

									<!-- Select type Part Number-->
									<div class="form-group">
										<label class="col-md-3 control-label">Part Number</label>
										<div class="col-md-6 selectContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-list"></i></span> <input
													name="partNumber" type="text"
													class="form-control"  placeholder="Part Number"
													id="partNumber">
											</div>
										</div>
									</div>
									
									<!-- Select type Item Type-->
									<div class="form-group">
										<label class="col-md-3 control-label">Item Type</label>
										<div class="col-md-6 selectContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-list"></i></span> <select
													name="type" class="form-control selectpicker" >
													<option value="">Select Item Type</option>
													<option value="Toner">Toner</option>
													<option value="Spares">Spares</option>
												</select>
											</div>
										</div>
									</div>
									
									
								</div>
								<!-- / F column -->

								

								<br>
								<br>
								<div class="form-group row">
									<div class="col-sm-offset-2 col-sm-8">
										<input type="submit" value="Add Spares"
											class="btn btn-primary btn-block btn-lg" tabindex="9"
											id="addSpares">
									</div>
								</div>
							</form:form>
						
						
						</div>
						 --%>

					<!-- /parts  -->
					<%-- <div class="tab-pane" id="compatibility">
							<h4 align="center">Compatibility</h4>
							<br>
							<form:form class="well form-horizontal" method="post"
								action="saveCompatibility" modelAttribute="saveCompatibility"
								id="saveCompatibility">

								<!--First column-->
								<div class="col-sm-6">
									<!-- Select type Part Number-->
									<div class="form-group">
										<label class="col-md-3 control-label">Part Number</label>
										<div class="col-md-6 selectContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-list"></i></span> <input
													name="partNumber" id="partNumber" placeholder="Part Number"
													class="form-control" type="text">

											</div>
										</div>
									</div>

								</div>
								<!-- / F column -->

								<!--Second column-->
								<div class="col-sm-6">


									<!-- Select type Model Number-->
									<div class="form-group">
										<label class="col-md-3 control-label">Model Number</label>
										<div class="col-md-6 selectContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-list"></i></span> <input
													name="modelNumber" id="modelNumber"
													placeholder="Model Number" class="form-control" type="text">
											</div>
										</div>
									</div>
								</div>
								<!-- /S column  -->

								<br>
								<br>
								<br>
								<div class="form-group row">
									<div class="col-sm-offset-2 col-sm-8">
										<input type="submit" value="Add Compatibility"
											class="btn btn-primary btn-block btn-lg" tabindex="9"
											id="addSpares">
									</div>
								</div>
							</form:form> --%>

				</div>


				<%-- 	<div class="tab-pane" id="tonner">
					<h4 align="center">Tonner</h4>
				<form:form class="well form-horizontal" method="post" action="saveSpareParts"
					modelAttribute="saveSpareParts" id="saveSpareParts">
							
					<!--First column-->
					<div class="col-sm-6">					
						<!-- Select type Tonner Code-->						
						<div class="form-group">
							<label class="col-md-3 control-label">Tonner Code</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-list"></i></span>
										<input type="text" class="form-control" placeholder="Tonner Code" name="tonnerCode" id="tonnerCode">
								</div>
							</div>
						</div>
						
						<!-- Select type Description-->						
						<div class="form-group">
							<label class="col-md-3 control-label">Description</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-list"></i></span>
									<select name="description"
										class="form-control selectpicker">
										<option value="">Select Description<option>
									<option value="Black Imaging Unit">Black Imaging Unit</option>
									<option value="Color Imaging Unit">Color Imaging Unit</option>
									<option value="Waste Toner Bottle">Waste Toner Bottle</option>
									</select>
								</div>
							</div>
						</div>
						
						
						<!-- Select type Quantity-->						
						<div class="form-group">
							<label class="col-md-3 control-label">Quantity</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-edit"></i></span>
									<input class="form-control" Placeholder="Quantity" id="quantity" type="text">
								</div>
							</div>
						</div>
						
					</div><!-- / F column -->	
					
					<!--Second column-->		
					<div class="col-sm-6">
					
					
						<!-- Select type Supplier Name-->						
						<div class="form-group">
							<label class="col-md-3 control-label">Supplier Name</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-list"></i></span>
									<input type="text" class="form-control" placeholder="Supplier Name" id="supplierName" name="supplierName">
								</div>
							</div>
						</div>
						
						<!-- Select type Received By-->						
						<div class="form-group">
							<label class="col-md-3 control-label">Recieved By</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-edit"></i></span>
									<input class="form-control" id="receivedBy" placeholder="Recieved By" type="text">
								</div>
							</div>
						</div>
						
						
						
					</div><!-- /S column  -->
					
						<br><br>
						<div class="form-group row">
							<div class="col-sm-offset-2 col-sm-8">
								<input type="submit" value="Add Tonner"
									class="btn btn-primary btn-block btn-lg" tabindex="9"
									id="addTonner">
							</div>
						</div>
					</form:form>
					
					</div><!-- /tonner  --> --%>

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
													modelNumber : {
														validators : {
															notEmpty : {
																message : 'Model mumber is required and cannot be empty'
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
