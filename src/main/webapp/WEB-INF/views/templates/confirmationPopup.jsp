<%@include file="taglibs.jsp"%>



<link href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" rel="stylesheet" type="text/css" />
<link href="<c:url value="/resources/custom/css/navbar.css" />" rel="stylesheet" type="text/css" />
<link href="<c:url value="/resources/custom/css/vela_custom.css"/>" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js" />"></script>


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
	<a href="#"><img
		src="resources/images/mainlogoo.jpg"></a>
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

<!-- <div id="navbar">
	<nav class="navbar navbar-default navbar-static-top">
		<div class="container-fluid">
		</div>
	</nav>
</div> -->
<br />
<br />