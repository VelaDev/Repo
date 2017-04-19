<%@include file="taglibs.jsp"%>



<link
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
<link href="<c:url value="/resources/custom/css/navbar.css" />"
	rel="stylesheet" type="text/css" />
<link href="<c:url value="/resources/custom/css/vela_custom.css"/>"
	rel="stylesheet" type="text/css" />

<style>

.ourbadge {

	display: inline-block;
    min-width: 1px;
    padding: 4px 6px;
    font-size: 12px;
    font-weight: 700;
    line-height: 1;
    color: #fff;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    background-color: #f11212;
    border-radius: 12px;
    margin-bottom: 4px;
    margin-top: -8px;
	
}

</style>

<div class="vela_motto">
	<p>
		<span class="motto">Velaphanda</span> <span class="techsystem">Technical
			System</span>
	</p>
</div>
<div class="velatp_logo">
	<a href="home.html"><img
		src="resources/bootstrap-3.3.6/images/mainlogoo.jpg"></a>
	<div class="userloggedin">
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown"><a href="" class="dropdown-toggle"
				data-toggle="dropdown"><span
					class="glyphicon glyphicon-user btn-lg "> ${user}</span><span
					class="caret"></span></a>
				<ul class="dropdown-menu" role="menu">
					<li><a href='<c:url value="login.html"/>'><span
							class="glyphicon glyphicon-off"></span> Log Out</a></li>
				</ul></li>
		</ul>
	</div>
</div>

<div id="navbar">
	<nav class="navbar navbar-default navbar-static-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand glyphicon glyphicon-home"
					href='<c:url value="home.html"/>'></a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav">

					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Employees<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href='<c:url value="registerEmployee.html"/>'>Add
									Employee</a></li>
							<li><a href='<c:url value="displayEmployees.html"/>'>View
									Employee</a></li>
							<%-- <li><a href='<c:url value="testReports.html"/>'>Checking Reports</a></li> --%>
						</ul></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown">Customers <b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li class="dropdown dropdown-submenu"><a href="#"
								class="dropdown-toggle" data-toggle="dropdown">Customer
									Management</a>
								<ul class="dropdown-menu">
									<li><a href='<c:url value="addClient.html"/>'>Add
											Customer</a></li>
									<li><a href='<c:url value="displayCustomers.html"/>'>View
											Customers</a></li>
								</ul></li>
							<li class="dropdown dropdown-submenu"><a href="#"
								class="dropdown-toggle" data-toggle="dropdown">Device
									Management</a>
								<ul class="dropdown-menu">
									<%-- <li><a href='<c:url value="addProduct.html"/>'>Add
											Device</a></li> --%>
									<%-- <li><a href='<c:url value="updateDevice.html"/>'>Update
											Device</a></li> --%>
									<li><a href='<c:url value="searchDevice.html"/>'>View
											Devices</a></li>
									<!-- <li><a href="#">Delete Device</a></li> -->

								</ul></li>
						</ul></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Spare Parts<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href='<c:url value="receiveParts.html"/>'>Receive
									Spares</a></li>
							<li class="dropdown dropdown-submenu"><a href="#"
								class="dropdown-toggle" data-toggle="dropdown">Available
									Sapres</a>
								<ul class="dropdown-menu">
									<li><a href='<c:url value="availableSpareParts.html"/>'>Head
											Office</a></li>
									<li><a href='<c:url value="bootSite.html"/>'>Boot Stock</a></li>
									<li><a href='<c:url value="stockSite.html"/>'>Site Stock</a></li>
									<!-- <li><a href='<c:url value="order.html"/>'>Make Order</a></li> -->

								</ul></li>
						</ul></li>

					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Orders<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href='<c:url value="placeOrderForTechnician.html"/>'>Place
									Order</a></li>
							<li><a href='<c:url value="viewAllOrders.html"/>'>View
									Orders</a></li><%-- 
							<li><a href='<c:url value="pendingOrders.html"/>'>Pending
									Orders</a></li> --%>
							<li><a href='<c:url value="approvedOrders.html"/>'>Approved
									Orders</a></li>
							<li><a href='<c:url value="shippedOrders.html"/>'>Shipped
									Orders</a></li>
						</ul>
					</li>
						
					<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">Tickets<span class="caret"></span></a>
							<ul class="dropdown-menu">							
								<li><a href='<c:url value="logTicket.html"/>'>Log Ticket</a></li>
								<li><a href='<c:url value="monitoringTickets.html"/>'>Open Tickets</a></li>
							</ul>
					</li> 
						
					<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">Leave<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href='<c:url value="requestLeave.html"/>'>Request Leave</a></li>
								<%-- <li><a href='<c:url value="updateMakeLeave.html"/>'>Update Leave</a></li> --%>
								<li><a href='<c:url value="viewRequestedLeave.html"/>'>View Requested Leave</a></li>
							</ul>
					</li>					
					<li>
					    <a href='<c:url value="pendingOrders.html"/>' role="button" aria-haspopup="true"
								aria-expanded="false">Order Inbox <span class="ourbadge" class="btn-btn-danger">${inboxCount}</span></a>
					</li>
					

				</ul>

			</div>
		</div>
	</nav>
</div>
<div class="nav navbar-nav navbar-right">
	<a href="#" onclick="history.go(-1);"><span
		class="glyphicon glyphicon-circle-arrow-left btn-lg"
		title="Previous Page"></span></a> <a href="#" onclick="history.go(1);"><span
		class="glyphicon glyphicon-circle-arrow-right btn-lg"
		title="Go Forward"></span></a>
</div>
<br />
<br />