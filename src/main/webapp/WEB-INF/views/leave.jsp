<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Leave | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">
</head>
<body>
	<div class="velaphanda_containter" id="velaphanda_containter">
		<c:import url="templates/navbar.jsp"></c:import>
		<div class="container">
			<br />
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="left">
							<b>Leave</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#home" data-toggle="tab">Ticket
								Overall</a></li>
						<li><a href="#ticketDetails" data-toggle="tab">Ticket
								Details</a></li>
					</ul>
					<div class="tab-content">

						<!--home tab-->
						<div class="tab-pane active" id="home">
							<div class="panel panel-success">
								<div class="panel-heading">
									<h3 class="panel-title">
										<div align="center">
											<b>Tickets Overall</b>
										</div>
									</h3>
								</div>
								<div class="panel-body">
									<!-- <div class="col-lg-10"> -->
									<div class="panel-body">
										<div class="pie_content">
											<div id="ticket_details_pie" align='center'></div>
										</div>
									</div>
								</div>
								<!-- /panel body -->
							</div>
							<!-- /panel panel-success -->
						</div>
						<!-- /home tab-->

						<!--Tickets Details tab-->
						<div class="tab-pane" id="ticketDetails">

							<div class="panel panel-success">
								<div class="panel-heading">
									<h3 class="panel-title">
										<div align="center">
											<b>Tickets List</b>
										</div>
									</h3>
								</div>
								<div class="panel-body">
									<!-- <div class="col-lg-10"> -->
									<div class="panel-body">
										
											</div>
								</div>
								<!-- /panel body -->
							</div>
							<!-- /panel panel-success -->

						</div>
						<!-- Ticket Detials -->
							
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
   
    
    
 	
	
	<!-- Data tables search -->
	<script type="text/javascript"
		src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
		
	<script type="text/javascript"
		src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>

	<script type="text/javascript">
		$(document).ready(function() {
			$('#myDatatable').DataTable({
				"jQueryUI" : true,
				"pagingType" : "full_numbers",
				"lengthMenu" : [ [ 5, 10, 50, -1 ], [ 5, 10, 50, "All" ] ]
			/* few more options are available to use */
			});
		});
	</script>
	<!-- / Data tables search -->
	
</body>
</html>
