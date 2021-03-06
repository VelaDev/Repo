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
	href="<c:url value="/resources/custom/css/vela_custom.css" />"
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
					<!-- tab nav -->
					<ul class="nav nav-tabs">
						<li class="active"><a href="#orderTonner" data-toggle="tab">Order Tonner</a></li>
						<li><a href="#orderParts" data-toggle="tab">Order Parts</a></li>
					</ul>
					
					<div class="tab-content">
					
						<!--order Order Tonner-->
						<div class="tab-pane" id="orderTonner">
							<h4 align="center">Order Tonner</h4>
							<form:form class="well form-horizontal">								
							
							<!-- Fields goes here -->
							<p>Fields goes here</p>
								<br>
								<div class="form-group">
									<div class="col-sm-offset-2 col-md-8">
										<input type="submit" value="Order Tonner"
											class="btn btn-primary btn-block btn-lg" tabindex="9"
											id="orderT">
									</div>
								</div>
							</form:form>
						</div>
						<!--/order tonner-->
						
						<!--order parts tab-->
						<div class="tab-pane" id="orderParts">
							<h4 align="center">Order Parts</h4>
							<form:form class="well form-horizontal">
							
							<!-- Fields goes here -->
							<p>Fields goes here</p>	
							
								<br>
								<div class="form-group">
									<div class="col-sm-offset-2 col-md-8">
										<input type="submit" value="Order Parts"
											class="btn btn-primary btn-block btn-lg" tabindex="9"
											id="orderP">
									</div>
								</div>
							</form:form>
						</div>
						<!--/order parts tab-->
						
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
