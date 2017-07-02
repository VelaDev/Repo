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
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/daterangepicker.css" />" />

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
.selectDate {
    position: relative;
    display: inline-block;
    height: 28px;
    width: 48%;
    margin-left: 25%; 
}

.selectDate input {
	width: 100%; /* Arbitrary number */
	height: 100%;
	padding-right: 40px;
	box-sizing: border-box;
}

#calendar {
	height: 100%;
	width: 40px;
	background-image: url(resources/images/calendar.png),url(resources/images/down_arrow.png);
	background-repeat: no-repeat;
	background-position: 50% 50%;
	border: none;
	background-color: transparent;
	position: absolute;
	top: 50%;
	right: 0;
	transform: translateY(-50%);
}

i.glyphicon.glyphicon-calendar.col-sm-pull-2 {
	right: -29%;
}

input#selectDateRange {
	cursor: pointer;
}

.db-summary li:first-child:nth-last-child(5), .db-summary li:first-child:nth-last-child(5) 
	~ li {
	width: 12%;
}

.db-summary li:first-child:nth-last-child(4), .db-summary li:first-child:nth-last-child(4) 
	 ~ li {
	width: 10%;
}

.input-group-btn:last-child>.btn, .input-group-btn:last-child>.btn-group
	{
	z-index: 2;
	height: 26px;
	margin-left: -1px;
	padding-bottom: 17px;
}

.db-summary li:first-child {
	border-right: 1px #dfdfdf solid;
}

.db-summary li {
	float: left;
	box-sizing: border-box;
	border-right: 1px #dfdfdf solid;
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
				id="searchOrderNumber" modelAttribute="searchOrderNumber">

				<div style="margin-bottom: -3px; margin-left: -1px;" align=left>

					<!-- Select type customers-->
					<div class="form-group ">
						<div class="col-md-4 selectContainer">
							<div class="input-group">
								<span class="input-group-addon"><i
									class="glyphicon glyphicon-list"></i></span> <select
									name="customerName" id="customers"
									class="form-control selectpicker">
									<option value="">All Customers</option>
									<c:forEach items="${customers}" var="customer">

										<option value="${customer.customerName}">${customer.customerName}</option>

									</c:forEach>
								</select>

							</div>
						</div>
					</div>

					<div class="col-sm-4">
						<div class='selectDate'>
							<input type="textbox" id="selectDateRange" name="selectDateRange"
								class="form-control" />
							<span id="calendar"></span>
						</div>
					</div>


					<div align=right>
						<!-- Text input Search-->
						<div class="form-group">
							<div class="col-md-4 inputGroupContainer">
								<div class="input-group">
									<input type="text" placeholder="Search By Order Number"
										class="form-control" name="orderNum" id="orderNum" /> <span
										class="input-group-btn">
										<button class="btn btn-success" type="submit">
											<div class="up" style="margin-top: -8%; color: white;">Search</div>
										</button>
									</span>
								</div>
								<!-- /input-group -->
							</div>

							<!-- Iterating over the list sent from Controller -->
							<datalist id=""> <c:forEach var="list" items="">
								<option value="">
							</c:forEach> </datalist>

						</div>
					</div>


				</div>

			</form:form>

			<div class="panel panel-success">
				<!--Search-->
				<div class="panel-heading">
					<h3 class="panel-title">
						<br /> <br />
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

								<li><a href='placeOrderForTechnician.html'
									data-parallel-url=""
									data-parallel-placeholder="#ticket-leftFilter"
									class="summery-filter clearfix" data-pjax="#body-container">

										<div class="summary-count pull-left ml20"
											style="margin-left: 28%">
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
											<br /> <br />
											<p align="center">Create Order</p>
										</div>
								</a></li>

								<li><a href='<c:url value="ordersToApprove"/>'
									class="summery-filter clearfix"
									data-parallel-url="OrderToApprove"
									data-parallel-placeholder="#ticket-leftFilter"
									data-pjax="#body-container">

										<div class="summary-count pull-left ml20"
											style="margin-left: 4%">
											<h4 align="center">${countNewOrders}</h4>
											<p align="center">Orders to Approve</p>
										</div>
								</a></li>

								<li><a href='<c:url value="ordersToShip"/>'
									data-parallel-url="OrderToShip"
									data-parallel-placeholder="#ticket-leftFilter"
									class="summery-filter clearfix" data-pjax="#body-container">

										<div class="summary-count pull-left ml20"
											style="margin-left: 5%">
											<h4 align="center">${countApprovedOrder}</h4>
											<p align="center">Orders to Ship</p>
										</div>
								</a></li>

								<li><a href='<c:url value="ShippedOrders"/>'
									class="summery-filter clearfix"
									data-parallel-url="OrderToApprove"
									data-parallel-placeholder="#ticket-leftFilter"
									data-pjax="#body-container">

										<div class="summary-count pull-left ml20"
											style="margin-left: 4%">
											<h4 align="center">${countShippedOrder}</h4>
											<p align="center">Shipped Orders</p>
										</div>
								</a></li>

								<li><a href='<c:url value="closedOrders"/>'
									class="summery-filter clearfix"
									data-parallel-url="OrderToApprove"
									data-parallel-placeholder="#ticket-leftFilter"
									data-pjax="#body-container">

										<div class="summary-count pull-left ml20"
											style="margin-left: 4%">
											<h4 align="center">${countClosedOrder}</h4>
											<p align="center">Closed Orders</p>
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

									<form:form modelAttribute="orderHistory" method="post"
										action="orderHistory" id="orderHistory" name="orderHistory">

										<!-- Below table will be displayed as Data table -->
										<table id="createOrderDatatable" class="display datatable">
											<thead>
												<tr>
													<th>Order No</th>
													<th>Date Ordered</th>
													<th>Order Status</th>
													<th>Customer</th>
													<th>Stock Type</th>
													<th>Ordered By</th>
													<!-- <th>Order Details</th> -->
												</tr>
											</thead>
											<tbody>
												<!-- Iterating over the list sent from Controller -->
												<c:forEach var="list" items="${orderList}">
													<tr>
														<td><a
															href="orderItemHistory?recordID=<c:out value='${list.recordID}'/>">${list.orderNum}</a></td>
														<td>${list.dateOrdered}</td>
														<td>${list.status}</td>
														<c:if test="${empty list.customer.customerName }">
															<td>N/A</td>
														</c:if>
														<c:if test="${not empty list.customer.customerName }">
															<td>${list.customer.customerName }</td>
														</c:if>
														<td>${list.stockType}</td>
														<td>${list.employee.firstName}
															${list.employee.lastName}</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
										<!-- table order -->
									</form:form>
									<!-- form order -->

								</div>

								<div class="tab-pane" id="shippedOrders">
									<legend align=center>Shipped Orders</legend>
									<form:form modelAttribute="orderHistory" method="post"
										action="orderHistory" id="orderHistory" name="orderHistory">

										<!-- Below table will be displayed as Data table -->
										<table id="shippedOrdersDatatable" class="display datatable">
											<thead>
												<tr>
													<th>Order No</th>
													<th>Order Status</th>
													<th>Customer</th>
													<th>Approved Date</th>
													<th>Stock Type</th>
													<th>Ordered By</th>
													<th>Order Details</th>
												</tr>
											</thead>
											<tbody>
												<!-- Iterating over the list sent from Controller -->
												<c:forEach var="list" items="${orderList}">
													<tr>
														<td><a href="=<c:out value='${list.recordID}'/>">${list.orderNum}</a></td>
														<td>${list.status}</td>
														<td></td>
														<td>${list.dateOrdered}</td>
														<td>${list.stockType}</td>
														<td>Ordered By</td>
														<td><a
															href="orderItemHistory?recordID=<c:out value='${list.recordID}'/>">Details</a></td>

													</tr>
												</c:forEach>
											</tbody>
										</table>
										<!-- table order -->
									</form:form>
									<!-- form order -->

								</div>

								<div class="tab-pane" id="closedOrder">
									<legend align=center>Closed Order</legend>
									<form:form modelAttribute="orderHistory" method="post"
										action="orderHistory" id="orderHistory" name="orderHistory">

										<!-- Below table will be displayed as Data table -->
										<table id="closedOrderDatatable" class="display datatable">
											<thead>
												<tr>
													<th>Order No</th>
													<th>Order Status</th>
													<th>Customer</th>
													<th>Approved Date</th>
													<th>Stock Type</th>
													<th>Ordered By</th>
													<th>Order Details</th>
												</tr>
											</thead>
											<tbody>
												<!-- Iterating over the list sent from Controller -->
												<c:forEach var="list" items="${orderList}">
													<tr>
														<td><a href="=<c:out value='${list.recordID}'/>">${list.orderNum}</a></td>
														<td>${list.status}</td>
														<td></td>
														<td>${list.dateOrdered}</td>
														<td>${list.stockType}</td>
														<td>Ordered By</td>
														<td><a
															href="orderItemHistory?recordID=<c:out value='${list.recordID}'/>">Details</a></td>

													</tr>
												</c:forEach>
											</tbody>
										</table>
										<!-- table order -->
									</form:form>
									<!-- form order -->


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
			src="<c:url value="/resources/jquery/moment/moment.min.js"/>"></script>
		<script type="text/javascript"
			src="<c:url value="/resources/bootstrap-3.3.7/js/daterangepicker.js"/>"></script>

		<script type="text/javascript"
			src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>


		<!-- Datatables -->
		<script type="text/javascript"
			src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>
		<!-- /Scripts -->

		<!-- Paging the table -->
		<script type="text/javascript">
			$(document).ready(function() {
				$('#createOrderDatatable').DataTable({
					"jQueryUI" : true,
					"pagingType" : "full_numbers",
					"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ]
				/* few more options are available to use */
				});
			});
		</script>

		<script type="text/javascript">
			$(document).ready(function() {
				$('#OrderToApproveDatatable').DataTable({
					"jQueryUI" : true,
					"pagingType" : "full_numbers",
					"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ]
				/* few more options are available to use */
				});
			});
		</script>

		<script type="text/javascript">
			$(document).ready(function() {
				$('#closedOrderDatatable').DataTable({
					"jQueryUI" : true,
					"pagingType" : "full_numbers",
					"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ]
				/* few more options are available to use */
				});
			});
		</script>

		<script type="text/javascript">
			$(document).ready(function() {
				$('#OrderToShipDatatable').DataTable({
					"jQueryUI" : true,
					"pagingType" : "full_numbers",
					"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ]
				/* few more options are available to use */
				});
			});
		</script>


		<script type="text/javascript">
			$(document).ready(function() {
				$('#shippedOrdersDatatable').DataTable({
					"jQueryUI" : true,
					"pagingType" : "full_numbers",
					"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ]
				/* few more options are available to use */
				});
			});
		</script>

		<!-- Get the date from  -->
		<script type="text/javascript">
			$(function() {

				var start = moment().subtract(29, 'days');
				var end = moment();

				function cb(start, end) {
					$('#selectDateRange input').html(start.format('YYYY/DD/MM'));
					var selectDateRange = start.format('YYYY/DD/MM');
					document.getElementById('selectDateRange').value = selectDateRange;
					console.log("Selected Date : ",selectDateRange);
				}

				$('#selectDateRange')
						.daterangepicker(
								{
									startDate : start,
									endDate : end,
									ranges : {
										'24 Hours' : [
												moment().subtract(1, 'days'),
												moment().subtract(1, 'days') ],
										'Last 7 Days' : [
												moment().subtract(6, 'days'),
												moment() ],
										'Last 14 Days' : [
												moment().subtract(14, 'days'),
												moment() ],
										'Last 30 Days' : [
												moment().subtract(29, 'days'),
												moment() ],
										'This Month' : [
												moment().startOf('month'),
												moment().endOf('month') ],
										'Last Month' : [
												moment().subtract(1, 'month')
														.startOf('month'),
												moment().subtract(1, 'month')
														.endOf('month') ]
									}
								}, cb);

				cb(start, end);

			});
		</script>
</body>
</html>
