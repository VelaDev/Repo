<%@include file="templates/taglibs.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Order Management</title>

<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/custom/css/vela_custom.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/fonts/font-awesome.min.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" />

<!-- Little Dash-board -->
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/ticketoverview.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/common-9a01e5a5a5a2f97d04552fa65cc3846b.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/fonts/sprites-b23bb97cb281c684a70d957ed91664df.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/app-310c175202e0f34694cea021357db448.css" />" />
<!-- //Little Dash-board -->

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">
<!--/style-->

<style type="text/css">
.db-summary li:first-child:nth-last-child(4), .db-summary li:first-child:nth-last-child(4) ~ li {
    width: 10%;
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
			<form:form action="searchOrderNumber" method="post"
				id="searchOrderNumber">

				<div style="margin-bottom: -13px;" align=left>

					<select id="customers" name="customers">
						<option value="">All Customers</option>
					</select>

					<!-- Text input Search-->

					<input name="orderNum" list="" id="orderNum" type="text"
						placeholder='Order Number'>


					<!-- Iterating over the list sent from Controller -->
					<datalist id=""> <c:forEach var="list" items="">
						<option value="">
					</c:forEach> </datalist>


					<input type='submit' value='Search' />
				</div>
				<div align=right>
					<select id="customers" name="customers">
						<option value="">All Customers</option>
					</select>
				</div>


			</form:form>

			<div class="panel panel-success">
				<!--Search-->
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="left">
							<b>Orders</b>
						</div>
					</h3>
				</div>

				<div class="panel-body">
					<div class="tab-content">
						
						<div class="ticket-summary row-fluid">

								<ul class="db-summary clearfix pb20 pt20 clear"
									id="ticket-summary" class="nav nav-tabs">


									<li><a href='#createOrder'
										data-parallel-url="createOrder" data-toggle="tab"
										data-parallel-placeholder="#ticket-leftFilter"
										class="summery-filter clearfix" data-pjax="#body-container">

											<div class="summary-count pull-left ml20">
												<h4 align="center">2</h4>
												<p align="center">Create Order</p>
											</div>
									</a></li>

									<li><a href='#OrderToApprove' data-toggle="tab"
										class="summery-filter clearfix" data-parallel-url="OrderToApprove"
										data-parallel-placeholder="#ticket-leftFilter"
										data-pjax="#body-container">

											<div class="summary-count pull-left ml20">
												<h4 align="center">1</h4>
												<p align="center">Order to Approve</p>
											</div>
									</a></li>

									<li><a href='#OrderToShip'
										data-parallel-url="OrderToShip" data-toggle="tab"
										data-parallel-placeholder="#ticket-leftFilter"
										class="summery-filter clearfix" data-pjax="#body-container">

											<div class="summary-count pull-left ml20">
												<h4 align="center">1</h4>
												<p align="center">Order to Ship</p>
											</div>

									</a></li>

									<li><a href='#closedOrder'
										data-parallel-url="closedOrder" data-toggle="tab"
										data-parallel-placeholder="#ticket-leftFilter"
										class="summery-filter clearfix" data-pjax="#body-container">

											<div class="summary-count pull-left">
												<h4 align="center">2</h4>
												<p align="center">Closed Order</p>
											</div>
									</a></li>


								</ul>
							</div>
						
						<form:form class="well form-horizontal" method="post"
							action="orderManage" id="orderManage"
							modelAttribute="orderManage">							
							<!-- tab nav -->
						<div class="tab-content">
						
								<div class="tab-pane active" id="createOrder">
									createOrder
									
									<form:form class="well form-horizontal" modelAttribute="makeOrder"
							method="post" action="makeOrder" id="putInOrder"
							onsubmit="return checkChecked('putInOrder');">


							<!-- Select type Stock Type-->
							<div class="form-group">
								<label class="col-md-3 control-label">Stock Type</label>
								<div class="col-md-6 selectContainer">
									<div class="input-group">
										<span class="input-group-addon"><i
											class="glyphicon glyphicon-list"></i></span><select id="stockType"
											name="stockType" class="form-control"
											onchange='CheckStockType(this.value);'
											class="form-control selectpicker">
											<option value="">Select Stock Type</option>
											<option value="Boot">Boot</option>
											<option value="Site">Site</option>
										</select>
									</div>
								</div>
							</div>

							<div id="Site" style='display: none;'>

								<!-- Text input Customer Name-->
								<div class="form-group">
									<label class="col-md-3 control-label">Customer Name</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-user"></i></span><select id="Site"
												name="customer" class="form-control selectpicker">
												<option value="">Customer Name</option>
												<c:forEach items="${customerList}" var="customer">
													<option value="${customer.customerName}">${customer.customerName}</option>
												</c:forEach>
											</select>
										</div>
									</div>
								</div>
							</div>

							<!-- Text input Technician name-->
							<div class="form-group">
									<label class="col-md-3 control-label">Technician</label>
									<div class="col-md-6 selectContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-list"></i></span> <select
												name="technicianUserName" id="technicianUserName" class="form-control selectpicker">
												<option value="">Select Technician</option>
												<c:forEach items="${technicianList}" var="technician">
													<option value="${technician.email}">${technician.firstName} ${technician.lastName}</option>
												</c:forEach>
											</select>
										</div>
									</div>
								</div>


							<!-- Text input Approver-->
							<div class="form-group">
								<label class="col-md-3 control-label">Approver</label>
								<div class="col-md-6 inputGroupContainer">
									<div class="input-group">
										<span class="input-group-addon"><i
											class="glyphicon glyphicon-user"></i></span> <select id="approver"
											name="approver" class="form-control selectpicker">
											<option value="">Select Approver</option>
											<c:forEach items="${managersList}" var="manager">
												<option value="${manager.email}">${manager.firstName}
													${manager.lastName}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>

							<br />
							<div id="makeOrders">
								<table id="myDatatable" class="display datatable">
									<thead>
										<tr>
											<th>Part No</th>
											<th>Description</th>
											<th>Model No</th>
											<th>Available QTY</th>
											<th>Tick To Order</th>
											<th>Quantity</th>
											<!-- <th>Edit</th> -->
										</tr>
									</thead>
									<tbody>
										<!-- Iterating over the list sent from Controller -->
										<c:forEach var="list" items="${compatibility}">

											<tr>
												<td>${list.partNumber}</td>
												<td>${list.itemDescription}</td>
												<td>${list.compitableDevice}</td>
												<td><input type="text"
													id="${list.partNumber}_avaliableQuantity"
													name="avaliableQuantity" class="form-control"
													readonly="readonly" value="${list.quantity}"></td>
												<td><input type="checkbox" id="checkedOrder"
													name="selectedItem" class="form-group"
													value="${list.partNumber},${list.compitableDevice},${list.itemDescription}"></td>
												<td><input type="text" id="${list.partNumber}_quantity"
													name="quantity" class="form-control"
													onblur="compareQuantity(this, ${list.quantity})" value="" /></td>
											</tr>

										</c:forEach>
									</tbody>
								</table>

							</div>

							<div class="form-group row">
								<div class="col-sm-offset-2 col-sm-8">
									<br> <br> <input type="submit" value="Place Order"
										class="btn btn-primary btn-block btn-lg" tabindex="9"
										id="putorder" name="putorder">
								</div>
							</div>

						</form:form>
									
								</div>
								
								<div class="tab-pane" id="OrderToApprove">
									OrderToApprove
								</div>
								
								<div class="tab-pane" id="OrderToShip">
									OrderToShip
								</div>
								
								<div class="tab-pane" id="closedOrder">
									closedOrder
								</div>
								
						</div>
						<!-- /tab-content -->

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
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>

		<!-- Datatables -->
	<script type="text/javascript"
		src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>
	<!-- /Scripts -->

	<!-- Paging the table -->
	<script type="text/javascript">
		$(document).ready(function() {
			$('#myDatatable').DataTable({
				"jQueryUI" : true,
				"pagingType" : "full_numbers",
				"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ]
			/* few more options are available to use */
			});
		});
</script>

</body>
</html>