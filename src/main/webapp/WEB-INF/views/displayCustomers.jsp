<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>View Customers | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

  <link type="text/css" rel="stylesheet" href="<c:url value="/resources/custom/css/vela_custom.css" />">
  <link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
  <link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">	
  <link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">
  
</head>
<body>
	<div class="velaphanda_containter">
		<c:import url="templates/navbar.jsp"></c:import>
		<div class="container">
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Customers</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">
								<!-- Below table will be displayed as Data table -->
									<table id="myDatatable" class="display datatable">
										<thead>
											<tr>
												<th>Customer Name <img src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
												<th>Email <img src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
												<th>Tell <img src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
												<th>Update Customer</th>
												<th>View Device</th>
												<th>Add Device</th>
											</tr>
										</thead>
										<tbody>
											<!-- Iterating over the list sent from Controller -->
											<c:forEach var="list" items="${displayCustomers}">
												<tr>
													
													<%-- <td></td> --%>
													<td><a href="searchCustomerdevices?customerName=<c:out value='${list.customerName}'/>"><button class="btn btn-success">${list.customerName}</button></a></td>
                                                   	<td>${list.email}</td>
													<td>${list.tellphoneNumber}</td>
                                                    <td><a href="searchCustomer?customerName=<c:out value='${list.customerName}'/>"><button class="btn btn-info">Update Customer</button></a></td>
                                                    <td><a href="searchCustomer?customerName=<c:out value='${list.customerName}'/>"><button class="btn btn-info">View Device</button></a></td>
                                                    <td><a href="searchClientforProduct?customerName=<c:out value='${list.customerName}'/>"><button class="btn btn-success">Add Device</button></a></td>
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
		<!-- /Container -->
		<!-- Footer -->
		<c:import url="templates/footer.jsp"></c:import>
		<!--/ Footer -->
	</div>
	<!-- / velaphanda_containter -->

</body>

<script type="text/javascript"	src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
<script type="text/javascript"	src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>
<%-- <script type="text/javascript"src="<c:url value="/resources/datatables/1.10.13/js/datatable.js" />"></script> --%>

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
</html>
