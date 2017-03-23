<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Order History | Velaphanda Trading & Projects</title>
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

<style>
li {
	list-style: none;
}

.shippedOrderContainer {
	padding: 25px;
	margin-bottom: -1em;
	width: auto;
	display: table;
}

p.shippedOrder {
	font-size: 1.1em;
	font-weight: bolder;
	margin-left: 19%;
}

ul.shippedListDetails {
	margin-left: -7%;
}
</style>
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
							<b>Order History</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">

						<div class="col-sm-6">

							<div id="shippedOrderContainer"
								style="width: auto; display: table;">
								<p class="shippedOrder">Ordered To: Patrick Thile</p>
								<ul class="shippedListDetails" style="display: block;">
									<li id="city_town">${customer.city_town}</li>
									<li id="zipcode">${customer.zipcode}</li>
								</ul>

							</div>
						</div>

						<form:form modelAttribute="orderHistory" method="post"
							action="orderHistory" id="orderHistory" name="orderHistory">
							<!-- Below table will be displayed as Data table -->
							<table id="myDatatable" class="display datatable">
								<thead>
									<tr>
										<th>Record ID </th>
										<th>Order No </th>
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
											<td>${list.recordID}</td>
											<td>${list.orderNum}</td>
											<td>${list.status}</td>
											<td>${list.dateOrdered}</td>
											<td>${list.stockType}</td>
											<td><a
												href="orderitemHistory?recordID=<c:out value='${list.recordID}'/>">Details</a></td>

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
