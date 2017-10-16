<%@include file="taglibs.jsp"%>

<script type="text/javascript" src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js" />"></script>
	
<link href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" rel="stylesheet" type="text/css" />	
<link href="<c:url value="/resources/custom/css/navbar.css" />" rel="stylesheet" type="text/css" />	
<link href="<c:url value="/resources/custom/css/vela_custom.css"/>" rel="stylesheet" type="text/css" />



<div class="vela_motto">
<p><span class="motto">Velaphanda</span> <span class="techsystem">Technical System</span></p>
</div>
<div class="velatp_logo">
	<a href="userdashboard.html"><img
		src="resources/images/mainlogoo.jpg"></a>
	<div class="userloggedin">
	 <ul class="nav navbar-nav navbar-right">        
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-user btn-lg ">  ${user}</span><span class="caret"></span></a>
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
				<a class="navbar-brand" href='<c:url value="userdashboard.html"/>' ><span class="glyphicon glyphicon-home"></span></a>
				      
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav">
				
						<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown">Customers <b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li class="dropdown dropdown-submenu"><a href="#"
								class="dropdown-toggle" data-toggle="dropdown">Customer
									Management</a>
								<ul class="dropdown-menu">									
									<li><a href='<c:url value="userDisplayCustomers.html"/>'>View
											Customers</a></li>
								</ul></li>
								
								<li class="dropdown dropdown-submenu"><a href="#"
									class="dropdown-toggle" data-toggle="dropdown">Device
										Management</a>
									<ul class="dropdown-menu">
										<li><a href='<c:url value="searchDevice.html"/>'>View
												Devices</a></li>
									</ul>
								</li>
								
							</ul>
						</li>
						<li>
					    <a href='<c:url value="userticketmanagement.html"/>' role="button" aria-haspopup="true"
								aria-expanded="false">Ticket Management</a>
						</li>
						
						<li>
					    <a href='<c:url value="usersparemanagement.html"/>' role="button" aria-haspopup="true"
								aria-expanded="false">Spares Management</a>
						</li>   
				       						
					   	<li>
						    <a href='<c:url value="userordermanagement.html"/>' role="button" aria-haspopup="true"
									aria-expanded="false">Order Management</a>
						</li> 
						<li>
						    <a href='<c:url value="userleavemanagement.html"/>' role="button" aria-haspopup="true"
									aria-expanded="false">Leave Management</a>
						</li>
				    	
					</ul>
			</div>
		</div>
	</nav>
</div>
<div class="nav navbar-nav navbar-right">
	<a href="#" onclick="history.go(-1);"><span class="glyphicon glyphicon-circle-arrow-left btn-lg" title="Previous Page"></span></a>
	<a href="#" onclick="history.go(1);"><span class="glyphicon glyphicon-circle-arrow-right btn-lg" title="Go Forward"></span></a>
</div>
<br/><br/>
