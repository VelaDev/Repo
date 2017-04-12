<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>View Requested Leave Information | Velaphanda Trading &
	Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">
</head>
<body>
	<div class="velaphanda_containter" id="velaphanda_containter">
		<c:import url="templates/techniciannavbar.jsp"></c:import>
		<div class="container">
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>View Requested Leave</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">

					<!-- Below table will be displayed as Data table -->
					<table id="myDatatable" class="display datatable">
						<thead>
							<tr>
								<th>Employee Names</th>
								<th>Email</th>
								<th>Type of Leave</th>
								<th>First Date Leave</th>
								<th>Last Date Leave</th>
								<th>Contact Number</th>
								<th>Address</th>
								<th>Update</th>
							</tr>
						</thead>
						<tbody>
							<!-- Iterating over the list sent from Controller -->
							<c:forEach items="${leaveList}" var="leave" varStatus="itr">
								<tr>
									<td><c:out value="${leave.employee.firstName} ${leave.employee.lastName}" /></td>
									<td><c:out value="${leave.employee.email}" /></td>
									<td><c:out value="${leave.leaveType}" /></td>
									<td><c:out value="${leave.startDate}" /></td>
									<td><c:out value="${leave.endDate}" /></td>
									<td><c:out value="${leave.contactNumber}" /></td>
									<td><c:out value="${leave.address}" /></td>
									<td><a 	href="updateLeave?leaveID=<c:out value='${leave.leaveID}'/>">Edit</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

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


	<!-- Scripts -->
	<script type="text/javascript"
		src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>

	<!-- /Scripts -->


	<script type="text/javascript">
		$(document).ready(function() {
			$('#myDatatable').DataTable({
				"jQueryUI" : true,
				"pagingType" : "full_numbers",
				"lengthMenu" : [ [ 5, 10, 50, -1 ], [ 5, 10, 50, "All" ] ]
			/* few more options are available to use */
			});
		});
	</script>
	<!-- / Data tables search -->

</body>
</html>
