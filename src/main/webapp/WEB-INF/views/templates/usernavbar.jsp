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

#navbar {
	margin-left: 4%;
}

.velatp_logo {
	margin-left: 5.5%;
}

.userloggedin {
	margin-right: 6%;
	margin-bottom: 5%;
	margin-top: -4%;
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

.dropdown-submenu:hover>a:after {
	border-left-color: #555;
}

.dropdown-menu>li>a:hover,.dropdown-menu>.active>a:hover {
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
	.navbar-default .navbar-nav .open .dropdown-menu>li>a:hover,.navbar-default .navbar-nav .open .dropdown-menu>li>a:focus
		{
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
	<a href="ticket.html"><img
		src="resources/bootstrap-3.3.6/images/velatp.jpg"></a>
	<div class="userloggedin">
		<ul class="nav navbar-nav navbar-right">
			<li><span class="glyphicon glyphicon-user btn-lg ">${loggedInUser}</span></li>
			<li><a href='<c:url value="login.html" ></c:url>'><span
					class="glyphicon glyphicon-off"></span> Log Out</a></li>
		</ul>
	</div>
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
				
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav">
					
				      <a class="navbar-brand" href='<c:url value="ticket.html"/>' ><span class="glyphicon glyphicon-home"></span></a>
				        <li class="dropdown">
				          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Tickets<span class="caret"></span></a>
				          <ul class="dropdown-menu">
				          <li><a href='<c:url value="ticket.html"/>'>Log Tickets</a></li>
				          </ul>
				        </li>
				        
				        <li class="dropdown">
				          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Technicians<span class="caret"></span></a>
				          <ul class="dropdown-menu">
				            <li><a href='<c:url value=""/>'>Available Technicians</a></li>
				          </ul>
				        </li>
				      </ul>
      		
			</div>
		</div>
	</nav>
</div>