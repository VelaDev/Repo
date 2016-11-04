<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Login | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/custom/css/login.css" />" />
<link href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" rel="stylesheet" type="text/css" />
<link href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />" rel="stylesheet" type="text/css" /> 

</head>
<body>
	<div class="velaphanda_containter">
		<div class="container">
			<br />
				<div class="panel panel-success">    
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
						<b>Login | Velaphanda Trading & Projects</b>
					</div>
					</h3>
				</div>
				<div class="panel-body">
				<div class="tabContent">					
							
				<div class="login-page">
				<div class="form">
				<form:form method="post" action="authenticate" role="login"
						modelAttribute="authenticate" id="loginVali">
						<!--First column-->
						<div class="col-sm-15">											
								<img src="resources/bootstrap-3.3.6/images/logo.jpg"
							class="img-responsive" alt="" />
								<br>
							<!-- Text input Username-->	
							<div class="form-group">
								<div class="col-md-40 inputGroupContainer">
									<div class="input-group">
										<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span> 
										<input id="username" name="username" placeholder="Username" class="form-control input-lg" type="text" >
									</div>
								</div>
							</div>		
							<!-- Text input Password-->
							<div class="form-group">
								<div class="col-md-40 inputGroupContainer">
									<div class="input-group">
										<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
										<input name="password" id="password" placeholder="Password" class="form-control input-lg" type="password" >
									</div>
								</div>
							</div>					
							<button type="submit" name="go" class="btn btn-lg btn-primary btn-block">Sign in</button>
											
						</div>
						<!-- /F Column -->
				</form:form>
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
	
<script type="text/javascript" src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js" />"></script>
<script type="text/javascript"	src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>

<!-- Validate Login -->
	<script>
		$(document)
				.ready(
						function() {
							$('#loginVali')
									.bootstrapValidator(
											{
												feedbackIcons : {
													valid : 'glyphicon glyphicon-ok',
													invalid : 'glyphicon glyphicon-remove',
													validating : 'glyphicon glyphicon-refresh'
												},
												fields : {
													username : {
														validators : {
															stringLength : {
																min : 2,
															},
															notEmpty : {
																message : 'Username is required to login and cannot be empty'
															}
														}
													},
													password : {
														validators : {
															stringLength : {
																min : 3,
															},
															notEmpty : {
																message : 'Password is required to login and cannot be empty'
															}
														}
													}
													
												}
											});
						});
</script>
</body>
</html>