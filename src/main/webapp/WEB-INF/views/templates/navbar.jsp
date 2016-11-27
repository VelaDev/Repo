<%@include file="taglibs.jsp"%>

<script type="text/javascript" src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js" />"></script>

<link href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" rel="stylesheet" type="text/css" />
<link href="<c:url value="/resources/custom/css/navbar.css" />" rel="stylesheet" type="text/css" />
<link href="<c:url value="/resources/custom/css/vela_custom.css"/>" rel="stylesheet" type="text/css" />

<div class="navigationButton">
	<a href="#" onclick="history.go(-1);"><span class="glyphicon glyphicon-circle-arrow-left btn-lg">Back</span></a>
	<a href="#" onclick="history.go(1);"><span class="glyphicon glyphicon-circle-arrow-right btn-lg">Next</span></a>
</div> 

<div class="vela_motto">
<p><span class="motto">Velaphanda</span> <span class="techsystem">Technical System</span></p>
</div>
<div class="velatp_logo">
 	<a href="home.html"><img src="resources/bootstrap-3.3.6/images/mainlogo.jpg"></a>
 <div class="userloggedin">
	 <ul class="nav navbar-nav navbar-right">        
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-user btn-lg "> ${loggedInUser.firstName} ${loggedInUser.lastName}</span><span class="caret"></span></a>
			<ul class="dropdown-menu" role="menu">
				<li><a href='<c:url value="login.html" ></c:url>'><span	class="glyphicon glyphicon-off"></span> Log Out</a></li>							
	       </ul>
        </li>
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
							<li><a href='<c:url value="displayEmployees.html"/>'>Display
									Employee</a></li>
							<li><a href='<c:url value="updateEmployee.html"/>'>Update Employee</a></li>
							<li><a href='<c:url value="resertPassword.html"/>'>Reset Password</a></li>
							<li><a href='<c:url value="deactivateEmployee.html"/>'>Deactivate
									Employee</a></li>
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
									<li><a href='<c:url value="updateCustomer.html"/>'>Update
											Customer</a></li>
									<li><a href='<c:url value="displayCustomers.html"/>'>Display
											Customers</a></li>
									<li><a href='<c:url value="clientInformation.html"/>'>Search
											Devices for a customer</a></li>
									<li><a href="#">Delete Customer</a></li>
								</ul></li>
							<li class="dropdown dropdown-submenu"><a href="#"
								class="dropdown-toggle" data-toggle="dropdown">Device
									Management</a>
								<ul class="dropdown-menu">
									<li><a href='<c:url value="addProduct.html"/>'>Add
											Device</a></li>
									<li><a href='<c:url value="updateDevice.html"/>'>Update
											Device</a></li>
									<li><a href='<c:url value="searchDevice.html"/>'>Search
											Device</a></li>
									<li><a href="#">Delete Device</a></li>

								</ul></li>
						</ul></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Spare Parts<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href='<c:url value="addParts.html"/>'>Add Spares</a></li>
							<li><a href='<c:url value="displayOrders.html"/>'>Display Orders</a></li>
						</ul></li>

					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Tickets<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href='<c:url value="monitoringTickets.html"/>'>Open
									Tickets</a></li>
							<li><a href='<c:url value="logTicket.html"/>'>Log Ticket</a></li>
						</ul></li>

				</ul>
				
			</div>
		</div>
	</nav>
</div>


