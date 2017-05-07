<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Home | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="shortcut icon" href="<c:url value="/images/favicon.ico" />" type="image/x-icon"/>
  
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
					
						
						<li><a href='<c:url value="openTickets.html"/>' data-parallel-url="#"
							data-parallel-placeholder="#ticket-leftFilter"
							class="summery-filter clearfix" data-pjax="#body-container">
								<div class="db-icon-wrap center pull-left">
									<i class="ficon-db-calendar dbicon-red"></i>
								</div>
								<div class="summary-count pull-left ml20">
									<h4>${openTickets}</h4>
									<p>Open Tickets</p>
								</div>
						</a></li>

						<li><a href='<c:url value="awaitingSpares.html"/>' class="summery-filter clearfix"
							data-parallel-url="#"
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

						<li><a href='<c:url value="bridgedTickets.html"/>' data-parallel-url="#"
							data-parallel-placeholder="#ticket-leftFilter"
							class="summery-filter clearfix" data-pjax="#body-container">
								<div class="db-icon-wrap center pull-left">
									<i class="ficon-ticket dbicon-red"></i>
								</div>
								<div class="summary-count pull-left ml20">
									<h4>${bridgedTickets}</h4>
									<p>SLA Bridged</p>
								</div>

						</a></li>

						<li><a href='<c:url value="escalatedTickes.html"/>' data-parallel-url="#"
							data-parallel-placeholder="#ticket-leftFilter"
							class="summery-filter clearfix" data-pjax="#body-container">
								<div class="db-icon-wrap center pull-left">
									<i class="fa fa-line-chart dbicon-red"></i>
								</div>
								<div class="summary-count pull-left">
									<h4>${escalatedTickets}</h4>
									<p>Escalated Tickets</p>
								</div>
						</a></li>
						
						<li><a href='<c:url value="resolvedTickets.html"/>'
							data-parallel-url="#"
							data-parallel-placeholder="#ticket-leftFilter"
							class="summery-filter clearfix" data-orig-name="new"
							data-pjax="#body-container">
								<div class="db-icon-wrap center pull-left">
									<i class="fa fa-gavel dbicon-green"></i>
								</div>
								<div class="summary-count pull-left ml20">
									<h4>${resolvedTickets}</h4>
									<p>Resolved Tickets</p>
								</div>
						</a></li>
						
						<li><a href='<c:url value="closedTickets.html"/>'
							data-parallel-url="#"
							data-parallel-placeholder="#ticket-leftFilter"
							class="summery-filter clearfix" data-orig-name="new"
							data-pjax="#body-container">
								<div class="db-icon-wrap center pull-left">
									<i class="fa fa-gavel dbicon-green"></i>
								</div>
								<div class="summary-count pull-left ml20">
									<h4>${closedTickets}</h4>
									<p>Closed Tickets</p>
								</div>
						</a></li>
						
					</ul>
				</div>

				<div class="panel-body">
					
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
	
	<script type="text/javascript" src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
	
</body>
</html>
