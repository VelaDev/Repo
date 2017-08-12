atit<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Awaiting Spares | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/custom/css/vela_custom.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/datepicker.min.css" />">
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
							
							<form:form class="form-horizontal" modelAttribute="awaitingAdminDetails" action="awaitingAdminDetails" method="post">
								<div class="col-sm-4">
									<!-- Text input First Date Leave-->
									<div class="form-group">
										<label class="col-xs-3 control-label">From Date</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group input-append date" id="startDatePicker">
												<input type='text' class="form-control" name="startDate"
													id="startDate" placeholder="YYYY-MM-DD" /> <span
													class="input-group-addon"> <span
													class="glyphicon glyphicon-calendar"></span>
												</span>
											</div>
										</div>
									</div>
								</div>
								
								<div class="col-sm-4">						
									<!-- Text input Last Date Leave-->
									<div class="form-group">
										<label class="col-md-3 control-label">To This Date</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group input-append date" id="endDatePicker">
												<input type='text' class="form-control" name="endDate"
													id="endDate" placeholder="YYYY-MM-DD" /> <span
													class="input-group-addon"> <span
													class="glyphicon glyphicon-calendar"></span>
												</span>
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-2">
									<input class="btn btn-success" type='submit' value='Search' />
								</div>
							</form:form>
							
							<table id="myDatatable" class="display datatable">
								<thead>
									<tr>
										<th>Ticket No</th>
										<th>Date</th>
										<th>Device Serial</th>
										<th>Description</th>
										<th>Assigned Technician</th>							
										
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${ticketList}" var="tickets">
										<tr>
											<td><a href="awaitingSparesDetails?id=<c:out value='${tickets.recordID}'/>"><c:out value="${tickets.ticketNumber}" /></a></td>
											<td><c:out value="${tickets.dateTime}" /></td>
											<td><c:out value="${tickets.device.serialNumber}" /></td>
											<td><c:out value="${tickets.description}" /></td>
											<td><c:out
													value="${tickets.employee.firstName}  ${tickets.employee.lastName}" /></td>
 											
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
<!-- Scripts -->
	<script type="text/javascript"
		src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap-datepicker.min.js" />"></script>
	<!-- /Scripts -->
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
	
	
<script>
$(document).ready(function() {
  var date = new Date();
  var sevendaysago = new Date(date.getFullYear(), date.getMonth(), date.getDate() - 7);
  var today = new Date(date.getFullYear(), date.getMonth(), date.getDate());
  //var end = new Date(date.getFullYear(), date.getMonth(), date.getDate());

  $('#startDatePicker').datepicker({
  
		format : "yyyy-mm-dd",
		todayHighlight: true,
		//startDate: sevendaysago,
		//endDate: end,
		autoclose: true
  });
  $('#endDatePicker').datepicker({
  
		format : "yyyy-mm-dd",
		todayHighlight: true,
		//startDate: today,
		//endDate: end,
		autoclose: true
  });

  $('#startDatePicker').datepicker('setDate', sevendaysago);
  $('#endDatePicker').datepicker('setDate', today);
});
</script>
</html>
