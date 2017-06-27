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
.db-summary li:first-child:nth-last-child(4), .db-summary li:first-child:nth-last-child(4) 
	 ~ li {
	width: 10%;
}

.searchorder {
	#border: 1px solid #000;
	#display: inline-block;
}

input, button {
	background-color: transparent;
	border: 0;
}

.input-group-btn:last-child>.btn, .input-group-btn:last-child>.btn-group {
    z-index: 2;
    height: 26px;
    margin-left: -1px;
    padding-bottom: 17px;
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

				<div style="margin-bottom: -3px; margin-left: -1px;" align=left>

					<!-- Select type customers-->
					<div class="form-group ">											
					   <div class="col-md-4 selectContainer">
							<div class="input-group">
								<span class="input-group-addon"><i
								  class="glyphicon glyphicon-list"></i></span> <select
									 name="customers" id="customers" class="form-control selectpicker">
										<option value="">All Customers</option>
     								</select>
							</div>
						</div>
					</div>
					
					<!-- Text input Search-->						
					<div class="form-group">
					 	<div class="col-md-4 inputGroupContainer">							
						     <div class="input-group">
						 		 <input type="text" placeholder="Search By Order Number" class="form-control" name="orderNum" id="orderNum">
						  			<span class="input-group-btn">
						    			<button class="btn btn-success" type="button">Search</button>
						  			</span>
							 </div><!-- /input-group -->
						</div>
						
							<!-- Iterating over the list sent from Controller -->
							<datalist id=""> <c:forEach var="list" items="">
								<option value="">
							</c:forEach> </datalist>
						
					 </div>  
					
				</div>
				
				<div align=right>					
					<!-- Select type selectDate-->
					<div class="form-group ">											
					   <div class="col-md-4 selectContainer">
							<div class="input-group">
								<span class="input-group-addon"><i
								  class="glyphicon glyphicon-list"></i></span> <select
									 name="selectDate" id="selectDate" class="form-control selectpicker">
										<option value="Last 7 Days">Last 7 Days</option>
										<option value="Last 14 Days">Last 14 Days</option>
     								</select>
							</div>
						</div>
					</div>
				</div>
				
			</form:form>

			<div class="panel panel-success">
				<!--Search-->
				<div class="panel-heading">
					<h3 class="panel-title">
						<br/><br/>
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

										<div class="summary-count pull-left ml20">
											<h4 align="center">1</h4>
											<p align="center">Place New Order</p>
										</div>
								</a></li>

								<li><a href='#OrderToApprove' data-toggle="tab"
									class="summery-filter clearfix"
									data-parallel-url="OrderToApprove"
									data-parallel-placeholder="#ticket-leftFilter"
									data-pjax="#body-container">

										<div class="summary-count pull-left ml20">
											<h4 align="center">${newOrder}</h4>
											<p align="center">Orders to Approve</p>
										</div>
								</a></li>

								<li><a href='#OrderToShip' data-parallel-url="OrderToShip"
									data-toggle="tab"
									data-parallel-placeholder="#ticket-leftFilter"
									class="summery-filter clearfix" data-pjax="#body-container">

										<div class="summary-count pull-left ml20">
											<h4 align="center">1</h4>
											<p align="center">Orders to Ship</p>
										</div>

								</a></li>

								<li><a href='#closedOrder' data-parallel-url="closedOrder"
									data-toggle="tab"
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
														<td><a href="orderItemHistory?recordID=<c:out value='${list.recordID}'/>">${list.orderNum}</a></td>
														<td>${list.dateOrdered}</td>
														<td>${list.status}</td>
														 <c:if test="${empty list.customer.customerName }">
														 <td>N/A</td>
														 </c:if>
														  <c:if test="${not empty list.customer.customerName }">
														     <td>${list.customer.customerName }</td></c:if>
														<td>${list.stockType}</td>
														<td>${list.employee.firstName} ${list.employee.lastName}</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
										<!-- table order -->
									</form:form>
									<!-- form order -->

								</div>

								<div class="tab-pane" id="OrderToApprove">
									<legend align=center>Orders To Approve</legend>
									<form:form modelAttribute="orderHistory" method="post"
										action="orderHistory" id="orderHistory" name="orderHistory">

										<!-- Below table will be displayed as Data table -->
										<table id="OrderToApproveDatatable" class="display datatable">
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

								<div class="tab-pane" id="OrderToShip">
									<legend align=center>Orders To Ship</legend>
									<form:form modelAttribute="orderHistory" method="post"
										action="orderHistory" id="orderHistory" name="orderHistory">

										<!-- Below table will be displayed as Data table -->
										<table id="OrderToShipDatatable" class="display datatable">
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


		<!--/Paging the table -->
</body>
</html>