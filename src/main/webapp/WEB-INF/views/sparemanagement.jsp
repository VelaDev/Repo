<%@include file="templates/taglibs.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Spares Management</title>

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

/* Style the buttons that are used to open and close the accordion panel */
button.accordion {
	background-color: #f2f2f2;
	color: #444;
	cursor: pointer;
	/* padding: 18px; */
	width: 100%;
	text-align: left;
	border: none;
	outline: none;
	transition: 0.4s;
}

/* Add a background color to the button if it is clicked on (add the .active class with JS), and when you move the mouse over it (hover) */
button.accordion.active, button.accordion:hover {
	background-color: #ddd;
}

/* Style the accordion panel. Note: hidden by default */
div.bootPanel {
	padding: 0 18px;
	background-color: white;
	display: none;
}

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
	background-image: url(resources/images/calendar.png),
		url(resources/images/down_arrow.png);
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

.db-summary li:first-child:nth-last-child(6), .db-summary li:first-child:nth-last-child(6) 
	 ~ li {
	width: 11%;
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

			<div class="panel panel-success">
				<!--Search-->
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="left">
							<b>Spares Management</b>
						</div>
					</h3>
				</div>

				<div class="panel-body">
					<div class="tab-content">

						<div class="ticket-summary row-fluid">

							<ul class="db-summary clearfix pb20 pt20 clear"
								id="ticket-summary" class="nav nav-tabs">

								<li><a href='receiveParts.html'
									data-parallel-url="receiveParts.html"
									data-parallel-placeholder="#ticket-leftFilter"
									class="summery-filter clearfix" data-pjax="#body-container">

										<div class="summary-count pull-left ml20"
											style="margin-left: 28%">
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
											<br /> <br />
											<p align="center">Recieve Parts</p>
										</div>
								</a></li>

								<li><a href='#hoSpareParts' data-toggle="tab"
									class="summery-filter clearfix"
									data-parallel-url="hoSpareParts"
									data-parallel-placeholder="#ticket-leftFilter"
									data-pjax="#body-container">

										<div class="summary-count pull-left ml20"
											style="margin-left: 4%">
											<h4 align="center">${hoCount}</h4>
											<p align="center">Head Office</p>
										</div>
								</a></li>

								<li><a href='#siteStock' data-toggle="tab"
									class="summery-filter clearfix" data-parallel-url="#siteStock"
									data-parallel-placeholder="#ticket-leftFilter"
									data-pjax="#body-container">

										<div class="summary-count pull-left ml20"
											style="margin-left: 4%">
											<h4 align="center">${siteCount}</h4>
											<p align="center">Site Stock</p>
										</div>
								</a></li>

								<li><a href='#bootStock' data-toggle="tab"
									data-parallel-url="#bootStock"
									data-parallel-placeholder="#ticket-leftFilter"
									class="summery-filter clearfix" data-pjax="#body-container">

										<div class="summary-count pull-left ml20"
											style="margin-left: 28%">

											<h4 align="center">${bootCount}</h4>
											<p align="center">Boot Stock</p>
										</div>
								</a></li>

							</ul>
						</div>


						<!-- tab nav -->
						<div class="tab-content">

							<div class="tab-pane active" id="receiveParts"></div>

							<div class="tab-pane" id="hoSpareParts">
								<legend align=center>Head Office Stock</legend>
								<form:form modelAttribute="hoSpareParts" method="post"
									action="hoSpareParts" id="hoSpareParts" name="hoSpareParts">

									<!-- Below table will be displayed as Data table -->
									<table id="HODatatable" class="display datatable">
										<thead>
											<tr>
												<th>Part No</th>
												<th>Compatible Devices</th>
												<th>Description</th>
												<th>Item Type</th>
												<th>QTY</th>
											</tr>
										</thead>
										<tbody>
											<!-- Iterating over the list sent from Controller -->
											<c:forEach var="list" items="${spareParts}">
												<tr>

													<td>${list.partNumber}</td>
													<td>${list.compitableDevice}</td>
													<td>${list.itemDescription}</td>
													<td>${list.itemType}</td>
													<td>${list.quantity}</td>

												</tr>
											</c:forEach>
										</tbody>
									</table>
									<!-- table order -->
								</form:form>
								<!-- form order -->

							</div>

							<div class="tab-pane" id="siteStock">
								<legend align=center>Site Stock</legend>


								<table id="loadStockSite" class="display datatable">
									<thead>
										<tr>
											<th>Customer Nane</th>
										</tr>
									</thead>
									<tbody>
										<!-- Iterating over the list sent from Controller -->
										<c:forEach var="list" items="${customer}">
											<tr>
												<td><a
													href="loadStockSite?customerName=<c:out value='${list.customerName}'/>">${list.customerName}</a></td>

											</tr>
										</c:forEach>
									</tbody>
								</table>

							</div>

							<div class="tab-pane" id="bootStock">
								<legend align=center>Boot Stock</legend>
								<!-- Below table will be displayed as Data table -->
								<table id="loadBootStock" class="display datatable">
									<thead>
										<tr>
											<th>Technician Nane</th>
										</tr>
									</thead>
									<tbody>
										<!-- Iterating over the list sent from Controller -->
										<c:forEach var="list" items="${employees}">
											<tr>

												<td><a
													href="loadBootStock?technician=<c:out value='${list.firstName} ${list.lastName}'/>">${list.firstName}
														${list.lastName}</a></td>
											</tr>
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
				$('#createLeaveDatatable').DataTable({
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
				$('#pendingLeaveDatatable').DataTable({
					"jQueryUI" : true,
					"pagingType" : "full_numbers",
					"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ]
				/* few more options are available to use */
				});
			});
		</script>

		<script type="text/javascript">
			$(document).ready(function() {
				$('#HODatatable').DataTable({
					"jQueryUI" : true,
					"pagingType" : "full_numbers",
					"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ]
				/* few more options are available to use */
				});
			});
		</script>

		<script type="text/javascript">
			$(document).ready(function() {
				$('#loadBootStock').DataTable({
					"jQueryUI" : true,
					"pagingType" : "full_numbers",
					"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ]
				/* few more options are available to use */
				});
			});
		</script>

		<script type="text/javascript">
			$(document).ready(function() {
				$('#loadStockSite').DataTable({
					"jQueryUI" : true,
					"pagingType" : "full_numbers",
					"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ]
				/* few more options are available to use */
				});
			});
		</script>
</body>
</html>
