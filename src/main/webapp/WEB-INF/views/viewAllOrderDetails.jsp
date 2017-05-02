<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Detailed Order | Velaphanda Trading & Projects</title>
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
<style type="">
	
	.declineButton{
		margin-left:51%;
		margin-right:-59%;
	}
</style>
</head>
<body>
	<div class="velaphanda_containter">
		<c:import url="templates/usernavbar.jsp"></c:import>
		<div class="container">
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Order Items</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">
						<form:form modelAttribute="approveOrderItems" method="post"
							action="approveOrderItems" id="approveOrderItems"
							name="approveOrderItems">
							<!--First column-->
							<div class="col-md-4">
								<div class="form-group">
									<div class="col-md-6 selectContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-list"></i></span> <input id="technician"
												name="recordID" placeholder="Order Number"
												class="form-control" type="text"
												value="${RecordID.recordID}" readonly="readonly">
										</div>
									</div>
								</div>
							</div>
							<br>
							<br>
							<!-- /F Column -->
							<!-- Below table will be displayed as Data table -->
							<table id="myDatatable" class="display datatable">
								<thead>
									<tr>
										<th>Part No</th>
										<th>Model No</th>
										<th>Desc</th>
										<th>Quantity</th>
										<th>Order Date</th>
										<th>Status</th>
									</tr>
								</thead>
								<tbody>
									<!-- Iterating over the list sent from Controller -->
									<c:forEach var="list" items="${pendingOrderList}">
										<tr>
											<td>${list.partNumber}</td>
											<td>${list.model}</td>
											<td>${list.itemDescription}</td>
											<td><input type="text" id="quantity" name="quantity" value="${list.quantity}"></td>
											<td>${list.dateTime}</td>
											<td>${list.orderHeader.status}</td>
											
										</tr>
									</c:forEach>
								</tbody>
							</table>
								
						</form:form>
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
