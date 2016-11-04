<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Error Login | Velaphanda Trading & Projects</title>

<script src="/resources/bootstrap-3.3.6/js/jquery-3.0.0.min.js"></script>
<script type="text/javascript"
	src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/custom/css/login.css" />" />
<body>
		
		<div class="velaphanda_containter">
		<div class="container">
			<br />
				<div class="panel panel-success">    
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
						<b>Error Login | Velaphanda Trading & Projectsr</b>
					</div>
					</h3>
				</div>
				<div class="panel-body">
				<div class="tabContent">					
							
				<div class="login-page">
				<div class="form">
				<form method="post" action="error" role="login">
						<img src="resources/bootstrap-3.3.6/images/logo.jpg"
							class="img-responsive" alt="" />
						<div class="errorLogin">
							<h2>You are not registered 
								to use the system. 
								Consults Administrator</h2>
							or <a href="login.html">Login</a> with correct credentials
						</div>
					</form>
			</div>
		</div>		
			<!-- Footer -->
		<c:import url="templates/footer.jsp"></c:import>
		<!--/ Footer -->					
		</div><!-- /tab-content -->									
				</div><!-- /panel body -->
			</div><!--/panel success class-->
			
		</div><!-- /Container -->
		
	</div><!-- velaphanda_containter -->
		
</body>
</html>