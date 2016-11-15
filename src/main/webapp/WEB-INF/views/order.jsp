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
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css"
	rel="stylesheet">
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

						<form:form class="well form-horizontal" method="post"
							action="makeOrder" modelAttribute="makeOrder" id="order">

							<div class="row">
							
								<!-- /First group form for original fields -->
								<div class="form-group">
									<!--First Column-->
									<div class="col-md-6">

										<!-- Text input Serial No-->
										<div class="form-group">
											<label class="col-md-3 control-label">Serial No</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-barcode"></i></span> <input
														name="device" class="form-control" type="text">
												</div>
											</div>
										</div>

										<!-- Select type Part Number:-->
										<div class="form-group">
											<label class="col-md-3 control-label">Part Number</label>
											<div class="col-md-6 selectContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-list"></i></span> <select name="part"
														class="form-control selectpicker">
														<option value="">Select Part Number</option>
														<option value="CLT-R806K">CLT-R806K</option>
														<option value="CLT-R806X">CLT-R806X</option>
														<option value="CLT-W806">CLT-W806</option>
													</select>
												</div>
											</div>
										</div>
									</div>
									<!--/F Column-->

									<!--Second column-->
									<div class="col-sm-6">

										<!-- Text input Quantity-->
										<div class="form-group">
											<label class="col-md-3 control-label">Quantity</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-barcode"></i></span> <input
														name="quantity" class="form-control" type="text">
												</div>
											</div>
										</div>

										<!-- Select type Delivery-->
										<div class="form-group">
											<label class="col-md-3 control-label">Delivery</label>
											<div class="col-md-6 selectContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-list"></i></span> <select
														name="delivery" class="form-control selectpicker">
														<option value="">Select Delivery</option>
														<option value="1">Yes</option>
														<option value="0">No</option>
													</select>
												</div>
											</div>
										</div>
									</div>
									<!--/S Column-->
									<!-- Third column -->
									<div class="col-sm-12">
										<!-- Text area Description-->
										<div class="form-group">
											<br /> <label class="col-md-3 control-label">Description</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-pencil"></i></span>
													<textarea class="form-control" rows="5" cols="102"
														name="description" placeholder="Description"></textarea>
												</div>
											</div>
										</div>
									</div>
									
									<!-- Add More options -->
									<div class="col-xs-1">
										<button type="button" class="btn btn-default addButton">
											Add<i class="fa fa-plus"></i>
										</button>
									</div><!-- /Add more options -->									

								</div><!-- /First group form for original fields -->

								<!-- For adding new field -->
								<div class="form-group hide" id="newOrder">

									<!--First Column-->
									<div class="col-md-6">

										<!-- Text input Serial No-->
										<div class="form-group">
											<label class="col-md-3 control-label">Serial No</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-barcode"></i></span> <input
														name="device" class="form-control" type="text" placeholder="Serial No">
												</div>
											</div>
										</div>

										<!-- Select type Part Number:-->
										<div class="form-group">
											<label class="col-md-3 control-label">Part Number</label>
											<div class="col-md-6 selectContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-list"></i></span> <select name="part"
														class="form-control selectpicker">
														<option value="">Select Part Number</option>
														<option value="CLT-R806K">CLT-R806K</option>
														<option value="CLT-R806X">CLT-R806X</option>
														<option value="CLT-W806">CLT-W806</option>
													</select>
												</div>
											</div>
										</div>
									</div>
									<!--/F Column-->

									<!--Second column-->
									<div class="col-sm-6">

										<!-- Text input Quantity-->
										<div class="form-group">
											<label class="col-md-3 control-label">Quantity</label>
											<div class="col-md-6 inputGroupContainer">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon-barcode"></i></span> <input
														name="quantity" class="form-control" type="text" placeholder="Quantity">
												</div>
											</div>
										</div>
										
									</div>
									<!--/S Column-->
								
									
									<!-- remove more options -->
									<div class="col-xs-1">
										<button type="button" class="btn btn-default removeButton">
											<i class="fa fa-minus"></i>
										</button>
									</div><!-- //remove more options -->
									
								</div><!-- /First group form for original fields -->
								
								<!-- Submit -->
								<div class="form-group row">
									<div class="col-sm-offset-2 col-sm-8">
										<br>
										<br> <input type="submit" value="Make Order"
											class="btn btn-primary btn-block btn-lg" tabindex="9"
											id="makeOdr">
									</div>
								</div><!-- /Submit -->
								
							</div><!--row-->
							
						</form:form>
						
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
