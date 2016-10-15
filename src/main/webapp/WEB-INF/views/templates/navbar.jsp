
<%@include file="taglibs.jsp"%>

<script type="text/javascript"
	src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js" />"></script>
<link
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />


<style>
.container {
	width: 100%;
}

.dropdown-menu>li.kopie>a {
	padding-left: 5px;
}

.dropdown-submenu {
	position: relative;
}

.dropdown-submenu>.dropdown-menu {
	top: 0;
	left: 100%;
	margin-top: -6px;
	margin-left: -1px;
	-webkit-border-radius: 0 6px 6px 6px;
	-moz-border-radius: 0 6px 6px 6px;
	border-radius: 0 6px 6px 6px;
}

.dropdown-submenu>a:after {
	border-color: transparent transparent transparent #333;
	border-style: solid;
	border-width: 5px 0 5px 5px;
	content: " ";
	display: block;
	float: right;
	height: 0;
	margin-right: -10px;
	margin-top: 5px;
	width: 0;
}

.loggedin {
	float: right;
}

#userloggein {
	float: right;
}

.dropdown-submenu:hover>a:after {
	border-left-color: #555;
}

.dropdown-menu>li>a:hover, .dropdown-menu>.active>a:hover {
	text-decoration: underline;
}

@media ( max-width : 767px) {
	.navbar-nav {
		display: inline;
	}
	.navbar-default .navbar-brand {
		display: inline;
	}
	.navbar-default .navbar-toggle .icon-bar {
		background-color: #fff;
	}
	.navbar-default .navbar-nav .dropdown-menu>li>a {
		color: red;
		background-color: #ccc;
		border-radius: 4px;
		margin-top: 2px;
	}
	.navbar-default .navbar-nav .open .dropdown-menu>li>a {
		color: #333;
	}
	.navbar-default .navbar-nav .open .dropdown-menu>li>a:hover,
		.navbar-default .navbar-nav .open .dropdown-menu>li>a:focus {
		background-color: #ccc;
	}
	.navbar-nav .open .dropdown-menu {
		border-bottom: 1px solid white;
		border-radius: 0;
	}
	.dropdown-menu {
		padding-left: 10px;
	}
	.dropdown-menu .dropdown-menu {
		padding-left: 20px;
	}
	.dropdown-menu .dropdown-menu .dropdown-menu {
		padding-left: 30px;
	}
	li.dropdown.open {
		border: 0px solid red;
	}
}

@media ( min-width : 768px) {
	ul.nav li:hover>ul.dropdown-menu {
		display: block;
	}
	#navbar {
		text-align: center;
	}
}
</style>
<div class="velatp_logo">
	<img src="resources/bootstrap-3.3.6/images/velatp.jpg">
</div>
<div id="navbar">
	<nav class="avbar navbar-default navbar-static-top">
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
							<li><a href='<c:url value="#html"/>'>Update Employee</a></li>
							<li><a href='<c:url value="#.html"/>'>Password Reset </a></li>
							<li><a href='<c:url value="#.html"/>'>Deactivate
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
							<li><a href="#">Approved Orders</a></li>
						</ul></li>

					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Tickets<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href='<c:url value="monitoringTickets.html"/>'>Open
									Tickets</a></li>
							<li><a href='<c:url value="#"/>'>Log Ticket</a></li>
						</ul></li>

				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><span class="glyphicon glyphicon-user btn-lg ">${loggedInUser}</span></li>
					<li><a href='<c:url value="login.html" ></c:url>'><span
							class="glyphicon glyphicon-off"></span> Log Out</a></li>
				</ul>
			</div>
		</div>
	</nav>
</div>


