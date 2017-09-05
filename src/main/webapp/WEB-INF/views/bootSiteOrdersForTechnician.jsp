<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Boot Stock | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/custom/css/vela_custom.css" />">

<!-- Little Dash-board -->
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/ticketoverview.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/common-9a01e5a5a5a2f97d04552fa65cc3846b.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/fonts/sprites-b23bb97cb281c684a70d957ed91664df.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/app-310c175202e0f34694cea021357db448.css" />" />
<!-- //Little Dash-board -->

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">
<!--/style-->


<style>
.db-summary li:first-child:nth-last-child(2), .db-summary li:first-child:nth-last-child(2) 
	 ~ li {
	width: 10%;
}

.db-summary li a {
	padding-top: 15px;
	padding-left: 59px;
	display: block;
}

.db-summary li:first-child {
	border-right: 1px #dfdfdf solid;
}

.db-summary li {
	float: left;
	box-sizing: border-box;
	border-right: 1px #dfdfdf solid;
}
</style>
</head>
<body>
	<div class="velaphanda_containter">
		<c:import url="templates/techniciannavbar.jsp"></c:import>
		<div class="container">
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>
								<!-- Available Spares on  -->Boot Stock
							</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">

					<div class="tab-content">


						<div class="ticket-summary row-fluid">

							<ul class="db-summary clearfix pb20 pt20 clear"
								id="ticket-summary" class="nav nav-tabs">

								<li><a href='numberOfParts'
									data-parallel-url="'numberOfPartsForTech'"
									data-parallel-placeholder="#ticket-leftFilter"
									class="summery-filter clearfix" data-pjax="#body-container">

										<div class="summary-count pull-left ml20"
											style="margin-left: 28%">
											<h4 align="center">${countPartForTech}</h4>
											<p align="center">Parts</p>
										</div>
								</a></li>

								<li><a href='numberOfToners' 
									class="summery-filter clearfix"
									data-parallel-url="numberOfTonersForTech"
									data-parallel-placeholder="#ticket-leftFilter"
									data-pjax="#body-container">

										<div class="summary-count pull-left ml20"
											style="margin-left: 4%">
											<h4 align="center">${countTonerForTech}</h4>
											<p align="center">Toners</p>
										</div>
								</a></li>
							</ul>
						</div>


						<!-- tab nav -->
						<div class="tab-content">

							<div class="tab-pane active" id="numberOfTonersForTech">

								<form action="">
									
									<!-- Below table will be displayed as Data table -->
									<table id="myDatatable" class="display datatable">
										<thead>
											<tr>
												<th>Part No</th>
												<th>Compatible Devices</th>
													<th>Model Brand</th>
												<th>Description</th>
												<th>Quantity</th>
												<th>Item type</th>
											</tr>
										</thead>
										<tbody>
											<!-- Iterating over the list sent from Controller -->
											<c:forEach var="list" items="${orders}">
												<tr>
													<td>${list.partNumber}</td>
													<td>${list.compatibleDevice}</td>
													<td>${list.modelBrand}</td>
													<td>${list.itemDescription}</td>
													<td>${list.quantity}</td>
													<td>${list.itemType}</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</form>

							</div>

						</div>

						<!-- /tab-content -->
					</div>
				</div>
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
