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
					   <form:form modelAttribute="makeOrder" method="post" action="makeOrder" id="makeOrder" name="makeOrder">
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
						<div id="makeOrders">
						<table id="myDatatable" class="display datatable">
							<thead>
								<tr>
									<th>Part No <img
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
										
											<td id="partNumber" name="partNumber"> <input type="text"id="partNumber" name="partNumber" value="${list.spare.partNumber}"></td>
											<td id="description" name="description" ><input type="text"id="description" name="description" value="${list.spare.description}"></td>
											<td id="modelNumber" name="modelNumber"><input type="text"id="modelNumber" name="modelNumber" value="${list.modelNumber}"></td>
											<td><input type="checkbox" class="form-group"
												id="checkedOrder" name="checkedOrder"></td>
											<td><input type="text" class="form-group" id="quantity"
												name="quantity"></td>
	
											<%-- 	<th>
											<a href="detailedProduct?serialNumber=<c:out value='${list.partNumber}'/>">details</a></th>
											--%>
										
										</tr> 
										
								</c:forEach>
							</tbody>
						</table>
										
					</div>
					
						<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-8">
							<br><br>
							<input type="submit" value="Make Order"
								class="btn btn-primary btn-block btn-lg" tabindex="9"
								id="order" name="order">
						</div>
						</div>
					
						
					
					</form:form>
						<div id="makeOrders">Check product to order
						  <input type="checkbox" name="HP-C000" value="HP-C000">HP-C000
						  <input type="checkbox" name="Toshiba22" value="Toshiba22">Toshiba22
						  <input type="checkbox" name="HP12" value="HP12">HP12
 						 <button>Submit</button>
						</div>

						<div id="result"></div>
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
	
	(function (d, w, undefined) {
		 d.querySelector('#makeOrders submit').addEventListener('click', doSubmitMulti);
		 var multiOrderSelectorContainer = d.querySelector('#makeOrders');		  

		  function doSubmitMulti() {
		    var ordersChecked = [].slice.call( 
		                              multiOrderSelectorContainer
		                                .querySelectorAll('[type=checkbox]:checked') )
		                            .map(function (v){
		                              return v.value;
		                             });
		    d.querySelector('#result').innerHTML = 
		                    'You selected these products(s): <b>'+ 
		                     (ordersChecked.length 
		                      ? ordersChecked.join(', ') 
		                      : 'none yet selected') +
		                     '</b>';
		  }
		}(document, window))
		
	</script>
	
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
