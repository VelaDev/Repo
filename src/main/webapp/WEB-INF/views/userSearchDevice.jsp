<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Display Devices | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/custom/css/vela_custom.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">

</head>
<body>
	<div class="velaphanda_containter">
		<c:import url="templates/usernavbar.jsp"></c:import>
		<div class="container">
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Devices</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">
						<!-- Below table will be displayed as Data table -->
						<table id="myDatatable" class="display datatable">
							<thead>
								<tr>
									<th>Customer Name</th>
									<th>Serial No</th>
									<th>Address</th>
									<th>Model No </th>
									<th>Start Date </th>
									<th>End Date </th>
									<th>View Details</th>
								</tr>
							</thead>
							<tbody>
								<!-- Iterating over the list sent from Controller -->
								<c:forEach var="list" items="${deviceList}">
									<tr>
										<td><a href="userViewCustomer?customerName=<c:out value='${list.customerDevice.customerName}'/>">${list.customerDevice.customerName}</a></td>
										<td><a href="userDetailedProduct?serialNumber=<c:out value='${list.serialNumber}'/>">${list.serialNumber}</a></td>
										<td>${list.buildingName } ${list.streetNumber } ${list.streetName }</td>
										<td>${list.modelNumber}</td>
										<td>${list.startDate}</td>
										<td>${list.endDate}</td>
										<td><a href="userDetailedProduct?serialNumber=<c:out value='${list.serialNumber}'/>">Device Details</a></td>
									
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

<script type="text/javascript"
	src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>

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
</html>
