<%@include file="templates/taglibs.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ticket Details</title>
</head>
<body>
	<c:import url="templates/techniciannavbar.jsp"></c:import>
<body class=".container-fluid">
	<div class="container myrow-container" style="width: 90%">
		<div class="panel panel-success">
			<div class="panel-heading">
				<h3 class="panel-title">
					<div align="left">
						<b>Ticket Details</b>
					</div>
					<!-- <div align="right"><a href="">Think of something</a></div> -->
				</h3>
			</div>
			<div class="panel-body">

				<div class="col-lg-10">

					<div class="panel-body">
						<!-- <ul class="nav nav-pills">
							<li class="active"><a href="#general-pills"
								data-toggle="tab">General</a></li>
							<li><a href="#clientDetails-pills" data-toggle="tab">Client
									Details</a></li>
							<li><a href="#productDetails-pills" data-toggle="tab">Product
									Details</a></li>
							<li><a href="#solutions-pills" data-toggle="tab">Solutions</a></li>
							<li><a href="#history-pills" data-toggle="tab">History</a></li>
						</ul> -->


			<ul class="nav nav-tabs">
				<li class="active"><a href="general.html">General</a></li>
				<li><a href="client.html">Client</a></li>
				<li><a href="product.html">Product</a></li>
				<li><a href="solution.html">Solution</a></li>
				<li><a href="history.html">History</a></li> 
			  </ul> 
			    <div class="tab-content">				
					
					<!--general tab-->
					<div class="tab-pane active" id="general">
						Test Mes
					</div>
					<!--Clients tab-->
					<div class="tab-pane" id="client">
						Ok
					</div>
					<!--products tab-->
					<div class="tab-pane" id="products">
						Hare
					</div>
					<!--solution tab-->
					<div class="tab-pane" id="solution">
					 	Jwale
					</div>
					<!--history tab-->					
					<div class="tab-pane" id="history">
				 	   History
					</div>
			    </div>	<!--/close tab-content -->
						
						
					</div>
					</div>
					
				</div>			
			</div>
				
		</div>

</body>

<script type="text/javascript"
	src="<c:url value="/resources/bootstrap-3.3.6/js/jquery-2.1.4.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script>
<link
	href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
</html>