<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Awaiting Spares | Velaphanda Trading & Projects</title>
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
							<b>Awaiting Spares</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">

						<c:if test="${empty ticketList}">
							There are no awaiting spares at the moment
						</c:if>
						<c:if test="${not empty ticketList}">

							<table id="myDatatable" class="display datatable">
								<thead>
									<tr>
										<th>Ticket No</th>
										<th>Assigned Technician</th>
										<th>Description</th>
										<th>Date</th>										
										<th>Details</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${ticketList}" var="tickets">
										<tr>
											<td><c:out value="${tickets.ticketNumber}" /></td>
											<td><c:out
													value="${tickets.employee.firstName}  ${tickets.employee.lastName}" /></td>
											<td><c:out value="${tickets.description}" /></td>
											<td><c:out value="${tickets.dateTime}" /></td>
											<%-- <td><a href="AssignTicketToOtherTechnician?ticketNumber=<c:out value='${tickets.ticketNumber}'/>">Update</a></td>
 											 --%>
 											<td><a href="awaitingSparesDetails?id=<c:out value='${tickets.recordID}'/>">Ticket Details</a></td>
									
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</c:if>

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
