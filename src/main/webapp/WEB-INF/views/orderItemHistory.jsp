<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Approved Orders | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/custom/css/orderhistory.css"/>">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/custom/css/vela_custom.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/fonts/font-awesome.min.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" />

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">

</head>
<body>
	<div class="velaphanda_containter">
		<c:import url="templates/navbar.jsp"></c:import>
		<div class="container">
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Order Item History</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">
							
						<div class="groupdetails-row-padding">
							
								
							
							<div id="pagewrap">

								<section id="content">
									<div class="groupclientdetails">
										<legend>Order Details</legend>
										<table id="orderInfo" class="display datatable">
											<thead>
												<tr>												
													<th>Order No</th>													
													<th>Part No</th>
													<th>Compatible Devices</th>
													<th>Description</th>
													<th>Quantity</th>
													<!-- <th>Placed By</th>
													<th>Approver</th> -->
													
												</tr>
											</thead>
											<tbody>
												<!-- Iterating over the list sent from Controller -->
												<c:forEach var="list" items="${pendingOrderList}">
													<tr>
														<td>${list.orderHeader.orderNum}</td>
														<td>${list.partNumber}</td>
														<td>${list.model}</td>
														<td>${list.itemDescription}</td>
														<td>${list.quantity}</td>	
														<!-- <td></td>	
														<td></td> -->											
													</tr>
												</c:forEach>
											</tbody>
										</table>
	
									</div>
								<!-- group client details --> 
								</section>
								<!-- section content -->

								<aside id="sidebar">
								<div class="groupproductdetails">
									<legend>Order Statuses</legend>
									<form:form modelAttribute="orderHistory" method="post"
										action="orderHistory" id="orderHistory" name="orderHistory">

										<!-- Below table will be displayed as Data table -->
										<table id="orderDetails" class="display datatable">
											<thead>
												<tr>
													<th>Order Status</th>
													<th>Date/Time</th>
													
												</tr>
											</thead>
											<tbody>
												<!-- Iterating over the list sent from Controller -->
												<c:forEach var="list" items="< ${orderStatus}>">
													<tr>

														<td>${list.orderStatus}</td>
														<td>${list.statusDateTime}</td>
														
													</tr>
												</c:forEach>
											</tbody>
										</table>
										<!-- table order History -->

									</form:form>
									<!-- form order History -->
								</div>
								<!-- group product details --> </aside>
								<!-- aside sidebar -->
							</div>
							<!-- page wrap -->
						</div>
						<!-- group details-row-padding -->

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

</body>
<script type="text/javascript"
	src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>
<!-- Paging the table -->
<script type="text/javascript">
	$(document).ready(function() {
		$('#orderDetails').DataTable({
			"jQueryUI" : true,
			"pagingType" : "full_numbers",
			"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ]
		/* few more options are available to use */
		});
	});
</script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#orderInfo').DataTable({
			"jQueryUI" : true,
			"pagingType" : "full_numbers",
			"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ]
		/* few more options are available to use */
		});
	});
</script>
</html>
