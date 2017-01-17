<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Display Employees | Velaphanda Trading & Projects</title>
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
		<c:import url="templates/navbar.jsp"></c:import>
		<div class="container">
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Employees List</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">
						<!-- Below table will be displayed as Data table -->
						<table id="myDatatable" class="display datatable">
							<thead>
								<tr>
									<th>First Name<img
										src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
									<th>Last Name<img
										src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
									<th>Email<img
										src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
									<th>Status<img
										src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
									<th>Role<img
										src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
									<th>Edit</th>
									<th>Deactivate</th>
								</tr>
							</thead>
							<tbody>
								<!-- Iterating over the list sent from Controller -->
								<c:forEach var="list" items="${displayEmployees}">
									<tr>
										<td>${list.firstName}</td>
										<td>${list.lastName}</td>
										<td>${list.email}</td>
										<td>${list.status}</td>
										<td>${list.role}</td>
										<th><a href="updateEmployee?email=<c:out value='${list.email}'/>"><button type="button" class="btn btn-success">edit</button></a></th>
										
										<th><button type="button" class="btn btn-danger"
												onClick="location.href='deactivateEmp?email=<c:out value='${list.email}'/>'" id="deactivateEmp" name="deactivateEmp" data-confirm="Are are sure you want to deactivate this employee?">deactivate</button></th>
											
											<%-- <a href="updateEmployee?email=<c:out value='${list.email}'/>">edit</a> --%>
											
											<%-- <button type="button" class="btn btn-success"
												onClick="location.href='updateEmployee?email=<c:out value='${list.email}'/>'">edit</button> --%>
											
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

<!-- Deactive script -->
<script>
$(document).on('click', ':not(form)[data-confirm]', function(e){
    if(!confirm($(this).data('confirm'))){
      e.stopImmediatePropagation();
      e.preventDefault();
		}
});
</script>

</html>
