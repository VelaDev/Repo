<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Home | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/custom/css/vela_custom.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/fonts/font-awesome.min.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" />

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
<style type="text/css">
	
	.db-summary li:first-child:nth-last-child(8), .db-summary li:first-child:nth-last-child(8) ~ li {
    width: 12%;
}

</style>
</head>

<body>
	<div class="velaphanda_containter" id="velaphanda_containter">
		<c:import url="templates/navbar.jsp"></c:import>
		<div class="container">

			<div class="panel panel-success">

				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Tickets</b>
						</div>
					</h3>
				</div>

				<div class="ticket-summary row-fluid">

					<ul class="db-summary clearfix pb20 pt20 clear" id="ticket-summary">


						<li><a href='<c:url value="openTickets"/>'
							data-parallel-url="#"
							data-parallel-placeholder="#ticket-leftFilter"
							class="summery-filter clearfix" data-pjax="#body-container">
								<div class="db-icon-wrap center pull-left">
									<i class="ficon-db-calendar dbicon-red"></i>
								</div>
								<div class="summary-count pull-left">
									<h4 style="color: #01960C;">${openTickets}</h4>
									<p>Open</p>
								</div>
						</a></li>

						<li><a href='<c:url value="acknowledgedTickets"/>'
							data-parallel-url="AcknowledgedTickets"
							data-parallel-placeholder="#ticket-leftFilter"
							class="summery-filter clearfix" data-pjax="#body-container">
								<div class="db-icon-wrap center pull-left">
									<i class="ficon-db-calendar dbicon-red"></i>
								</div>
								<div class="summary-count pull-left" >
									<h4 align="center">${countAcknowledgedTickets}</h4>
									<p align="center">Acknowledged</p>
								</div>
						</a></li>

						<li><a href='<c:url value="takenTickets"/>'
							class="summery-filter clearfix" data-parallel-url="TakenTickets"
							data-parallel-placeholder="#ticket-leftFilter"
							data-pjax="#body-container">
								<div class="db-icon-wrap center pull-left">
									<i class="ficon-db-calendar dbicon-red"></i>
								</div>
								<div class="summary-count pull-left">
									<h4 align="center">${countTakenTickets}</h4>
									<p align="center">Taken</p>
								</div>
						</a></li>

						<li><a href='<c:url value="ticketsAwaitingSpares"/>'
							class="summery-filter clearfix" data-parallel-url="#"
							data-parallel-placeholder="#ticket-leftFilter"
							data-pjax="#body-container">
								<div class="db-icon-wrap center pull-left">
									<i class="ficon-db-sand-clock dbicon-orange"></i>
								</div>
								<div class="summary-count pull-left ml20">
									<h4>${awaitingSparesTickets}</h4>
									<p>Awaiting Spare</p>
								</div>
						</a></li>

						

						<li><a href='<c:url value="escalatedTickets"/>'
							data-parallel-url="#"
							data-parallel-placeholder="#ticket-leftFilter"
							class="summery-filter clearfix" data-pjax="#body-container">
								<div class="db-icon-wrap center pull-left">
									<i class="fa fa-line-chart dbicon-red"></i>
								</div>
								<div class="summary-count pull-left">
									<h4>${escalatedTickets}</h4>
									<p>Escalated</p>
								</div>
						</a></li>
						
						<li><a href='<c:url value="sLABridgedTickets"/>'
							data-parallel-url="#"
							data-parallel-placeholder="#ticket-leftFilter"
							class="summery-filter clearfix" data-pjax="#body-container">
								<div class="db-icon-wrap center pull-left">
									<i class="ficon-ticket dbicon-red"></i>
								</div>
								<div class="summary-count pull-left ml20">
									<h4 style="color:red">${bridgedTickets}</h4>
									<p>SLA Bridged</p>
								</div>

						</a></li>

						<li><a href='<c:url value="resolvedTickets"/>'
							data-parallel-url="#"
							data-parallel-placeholder="#ticket-leftFilter"
							class="summery-filter clearfix" data-orig-name="new"
							data-pjax="#body-container">
								<div class="db-icon-wrap center pull-left">
									<i class="fa fa-gavel dbicon-green"></i>
								</div>
								<div class="summary-count pull-left ml20">
									<h4>${resolvedTickets}</h4>
									<p>Resolved</p>
								</div>
						</a></li>
						<li><a href='<c:url value="closedTickets"/>'
							data-parallel-url="#"
							data-parallel-placeholder="#ticket-leftFilter"
							class="summery-filter clearfix" data-orig-name="new"
							data-pjax="#body-container">
								<div class="db-icon-wrap center pull-left">
									<i class="fa fa-gavel dbicon-green"></i>
								</div>
								<div class="summary-count pull-left ml20">
									<h4>${closedTickets}</h4>
									<p>Closed</p>
								</div>
						</a></li>

					</ul>
				</div>

				<div class="panel-body"></div>
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

	<script type="text/javascript"
		src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>

</body>
</html>
