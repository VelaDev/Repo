
<%@include file="taglibs.jsp"%>

<script type="text/javascript"
	src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js" />"></script>
<link
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
<link
	href="<c:url value="/resources/custom/css/navbar.css" />"
	rel="stylesheet" type="text/css" />


<div class="velatp_logo">
	<a href="technicianHome.html"><img
		src="resources/bootstrap-3.3.6/images/velatp.jpg"></a>
	<div class="userloggedin">
		<%-- <ul class="nav navbar-nav navbar-right">
			<li><span class="glyphicon glyphicon-user btn-lg ">${loggedInUser}</span></li>
			<li><a href='<c:url value="login.html" ></c:url>'><span	class="glyphicon glyphicon-off"></span> Log Out</a></li>							
	</ul>
	</div> --%>
	
	 <ul class="nav navbar-nav navbar-right">        
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-user btn-lg "> ${loggedInUser}</span><span class="caret"></span></a>
			<ul class="dropdown-menu" role="menu">
				<li><a href='<c:url value="login.html" ></c:url>'><span	class="glyphicon glyphicon-off"></span> Log Out</a></li>							
	
           </ul>
        </li>
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
				<a class="navbar-brand glyphicon glyphicon-home"
					href='<c:url value="technicianHome.html"/>'></a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Tickets<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href='<c:url value="technicianHome.html"/>'>Open
									Tickets</a></li>
							<li><a href='<c:url value="#"/>'>Escalated Tickets</a></li>
							<li><a href='<c:url value="#"/>'>Closed Tickets</a></li>
						</ul>
					</li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Spares<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href='<c:url value="order.html"/>'>Make Order</a></li>
							<li><a href='<c:url value="approvedOrders.html"/>'>Approved Orders</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>
</div>