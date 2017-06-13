<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Order History | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">


<link type="text/css" rel="stylesheet" href="<c:url value="/resources/custom/css/vela_custom.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/datepicker.min.css" />">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">

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
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Order History</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">

						<form:form class="form-horizontal" modelAttribute="adminOrderHistory" method="post"
							action="adminOrderHistory" id="adminOrderHistory" name="adminOrderHistory">
							
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
									<input class="btn btn-success" type='submit' value='Submit' />
								</div>
							</form:form>
						
						<form:form modelAttribute="orderHistory" method="post"
							action="orderHistory" id="orderHistory" name="orderHistory">

							<!-- Below table will be displayed as Data table -->
							<table id="myDatatable" class="display datatable">
								<thead>
									<tr>
										<th>Order No</th>
										<th>Order Status</th>
										<th>Approved Date</th>
										<th>Stock Type</th>
										<th>Order Details</th>

									</tr>
								</thead>
								<tbody>
									<!-- Iterating over the list sent from Controller -->
									<c:forEach var="list" items="${orderList}">
										<tr>
											<td>${list.orderNum}</td>
											<td>${list.status}</td>
											<td>${list.dateOrdered}</td>
											<td>${list.stockType}</td>
											<td><a
												href="ordersItemHistory?recordID=<c:out value='${list.recordID}'/>">Details</a></td>

										</tr>
									</c:forEach>
								</tbody>
							</table>
							<!-- table order -->
						</form:form>
						<!-- form order -->

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
	
	
<script type="text/javascript">
		$(document).ready(function() {
			$('#startDatePicker').datepicker({
				format : "yyyy-mm-dd",
				//startDate: 'd0',
		        autoclose: true
			});
		});
</script>

<script type="text/javascript">
	$(document).ready(function() {
		$('#endDatePicker').datepicker({
			format : "yyyy-mm-dd",
			//startDate: 'd0',
	        autoclose: true
		});
	});
</script>
</html>
