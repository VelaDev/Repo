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
	<a href="ticket.html"><img
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
				<a class="navbar-brand" href='<c:url value="ticket.html"/>' ><span class="glyphicon glyphicon-home"></span></a>
				      
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav">					
				      			        
				        <li class="dropdown">
				        	<a href="#" class="dropdown-toggle"
							 	data-toggle="dropdown" role="button" aria-haspopup="true"
								aria-expanded="false">Orders<span class="caret"></span>
							 </a>
							<ul class="dropdown-menu">
								<li><a href='<c:url value="userPlaceOrder.html"/>'>Place Order</a></li>
								<li><a href='<c:url value="viewAllUserOrders.html"/>'>View Orders</a></li>
							</ul>
						</li>
						
						<li class="dropdown">
							<a href="#" class="dropdown-toggle"
							 	data-toggle="dropdown" role="button" aria-haspopup="true"
							 	aria-expanded="false">Leave<span class="caret"></span>
							 </a>
							 <ul class="dropdown-menu">
								<li><a href='<c:url value="userMakeLeave.html"/>'>Make Leave</a></li>
								<li><a href='<c:url value="viewRequestedUserLeave.html"/>'>View Requested Leave</a></li>
				      		 </ul>
				    	</li>
				    	
				    	<li><a href='<c:url value="userResolvedTickets.html"/>'>Resolved Tickets</a></li> 
				    	
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
