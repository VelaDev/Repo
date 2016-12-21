<%@ include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Order | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--style-->
<link
	href="<c:url value="/resources/dynamicfields/css/extented_fields.css" />"
	rel="stylesheet" type="text/css" />
<link href="<c:url value="/resources/custom/css/vela_custom.css" />"
	rel="stylesheet" type="text/css" />
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css"
	rel="stylesheet">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">

<!--/style-->
</head>
<body>
	<div class="velaphanda_containter">
		<c:import url="templates/techniciannavbar.jsp"></c:import>
		<div class="container">
			<br>
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
							<b>Make Order</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">
						<!-- Below table will be displayed as Data table -->
						<!--First column-->
						<div class="col-md-4">
							<!-- Text input Email-->
							<div class="form-group">
								<div class="col-md-6 inputGroupContainer">
									<div class="input-group">
										<span class="input-group-addon"><i
											class="glyphicon glyphicon-list"></i></span> <select
											name="stockType" class="form-control selectpicker">
											<option value="">Stock Type</option>
											<option value="boot">Boot</option>
											<option value="site">Site</option>
										</select>
									</div>
								</div>
							</div>
						</div>
						<!-- /F Column -->
						<!--First column-->
						<div class="col-md-4">
							<div class="form-group">
								<div class="col-md-6 selectContainer">
									<div class="input-group">
										<span class="input-group-addon"><i
											class="glyphicon glyphicon-user"></i></span> <input id="technicain"
											name="technicain" placeholder="Technicain"
											class="form-control" type="text" value="">
									</div>
								</div>
							</div>
						</div>
						<!-- /F Column -->
						<!--First column-->
						<div class="col-md-4">
							<!-- Text input Location-->
							<div class="form-group">
								<div class="col-md-6 inputGroupContainer">
									<div class="input-group">
										<span class="input-group-addon"><i
											class="	glyphicon glyphicon-map-marker"></i></span> <input
											id="location" name="location" placeholder="Location"
											class="form-control" type="text"">
									</div>
								</div>
							</div>
						</div>
						<!-- /F Column -->
						<br />
						<br />

						<table id="myDatatable" class="display datatable">
							<thead>
								<tr>
									<th>Part N0 <img
										src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
									<th>Description <img
										src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
									<th>Model No <img
										src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
									<th>Tick To Order<img
										src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
									<th>Quantity<img
										src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
									<!-- <th>Edit<img
										src="resources/bootstrap-3.3.6/images/sort_both.png"></th> -->
								</tr>
							</thead>
							<tbody>
								<!-- Iterating over the list sent from Controller -->
								<c:forEach var="list" items="${compatibility}">
									<tr>
										<td>${list.spare.partNumber}</td>
										<td>${list.spare.description}</td>
										<td>${list.modelNumber}</td>
										<td><input type="checkbox" class="form-group"
											id="checked" name="checked"></td>
										<td><input type="text" class="form-group" id="quantity"
											name="quantity"></td>

										<%-- 	<th>
										<a href="detailedProduct?serialNumber=<c:out value='${list.partNumber}'/>">details</a></th>
										</tr> --%>
								</c:forEach>
							</tbody>
						</table>
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
		src="<c:url value="/resources/dynamicfields/js/extented_fields.js" />"></script>

	<script type="text/javascript"
		src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap-datepicker.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>

	<script>
		$(document).ready(function() {
			$('#myDatatable').DataTable({
				"jQueryUI" : true,
				"pagingType" : "full_numbers",
				"lengthMenu" : [ [ 5, 10, 50, -1 ], [ 5, 10, 50, "All" ] ]
			/* few more options are available to use */
			});
		});
	</script>

	<!-- /Script -->

	<!-- Validate Make Order -->
	<script>
		$(document)
				.ready(
						function() {
							$('#order')
									.bootstrapValidator(
											{
												//framework : 'bootstrap',
												icon : {
													valid : 'glyphicon glyphicon-ok',
													invalid : 'glyphicon glyphicon-remove',
													validating : 'glyphicon glyphicon-refresh'
												},
												fields : {
													device : {
														validators : {
															stringLength : {
																min : 3,
															},
															notEmpty : {
																message : 'Serial number is required and cannot be empty'
															}
														}
													},
													part : {
														validators : {
															notEmpty : {
																message : 'Part Number is required and cannot be empty'
															}
														}
													},
													description : {
														validators : {
															stringLength : {
																min : 10,
																max : 200,
																message : 'Please enter at least 10 characters and no more than 200'
															},
															notEmpty : {
																message : 'Descritipn is required and cannot be empty'
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
													delivery : {
														validators : {
															notEmpty : {
																message : 'Delivery is required and cannot be empty'
															}
														}
													}
												}
											})
											

									// Add button click handler
									.on(
											'click',
											'.addButton',
											function() {
												var $template = $('#newOrder'), $clone = $template
														.clone()
														.removeClass('hide')
														.removeAttr('id')
														.insertBefore($template);

												// Add new fields
												// Note that we DO NOT need to pass the set of validators
												// because the new field has the same name with the original one
												// which its validators are already set
												$('#order')
														.bootstrapValidator(
																'addField',
																$clone
																		.find('[name="device"]'))
														.bootstrapValidator(
																'addField',
																$clone
																		.find('[name="part"]'))
														.bootstrapValidator(
																'addField',
																$clone
																		.find('[name="description"]'))
														.bootstrapValidator(
																'addField',
																$clone
																		.find('[name="quantity"]'))
														.bootstrapValidator(
																'addField',
																$clone
																		.find('[name="delivery"]'))
											})
									// Remove button click handler
									.on(
											'click',
											'.removeButton',
											function() {
												var $row = $(this).closest(
														'.form-group');

												// Remove fields
												$('#order')
														.bootstrapValidator(
																'removeField',
																$row
																		.find('[name="device"]'))
														.bootstrapValidator(
																'removeField',
																$row
																		.find('[name="part"]'))
														.bootstrapValidator(
																'removeField',
																$row
																		.find('[name="description"]'))
														.bootstrapValidator(
																'removeField',
																$row
																		.find('[name="quantity"]'))
														.bootstrapValidator(
																'removeField',
																$row
																		.find('[name="delivery"]'));

												// Remove element containing the fields
												$row.remove();
											});
						});
	</script>

</body>
</html>
