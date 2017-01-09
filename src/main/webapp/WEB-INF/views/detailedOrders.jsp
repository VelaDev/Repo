<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title> Orders | Velaphanda Trading & Projects</title>
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
		<c:import url="templates/techniciannavbar.jsp"></c:import>
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
							<b>Approve order</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">
					<form:form modelAttribute="approveOrderItems" method="post"
							action="approveOrderItems" id="approveOrderItems" name="approveOrderItems">
						<!-- Below table will be displayed as Data table -->
						<table id="myDatatable" class="display datatable">
							<thead>
								<tr>
								    <th>Order No</th>
									<th>Part No<img
										src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
										<th>Model No<img
										src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
										<th>Desc<img
										src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
									<th>Quantity<img
										src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
									<th>Date<img
										src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
										<th>Stock Type</th>
								</tr>
							</thead>
							<tbody>
								<!-- Iterating over the list sent from Controller -->
								<c:forEach var="list" items="${pendingOrderList}">
									<tr>
									    <td>${list.order.orderNum}</td>
										<td>${list.partNumber}</td>
										<td>${list.model}</td>
										<td>${list.description}</td>
										<td>${list.quantity}</td> 
										<td>${list.dateTime}</td> 
										<td>${list.order.stockType}</td> 
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
