<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html lang="en">
<head>
<title>Change Password | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
<link
	href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />"
	rel="stylesheet" type="text/css" />

</head>
<body>
	<div class="velaphanda_containter">
		<div class="container">
			<br />
				<div class="panel panel-success">    
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
						<b>Change Password | Velaphanda Trading & Projects</b>
					</div>
					</h3>
				</div>
				<div class="panel-body">
				<div class="tabContent">					
							
			<div class="velaphanda_containter">
		<div class="container">
			<c:if test="${not empty retMessage }">
				<div class="alert alert-info" role="alert">
					<c:out value="${ retMessage}">
					</c:out>
				</div>
			</c:if>
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Change Password</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">
						<form:form method="post" class="well form-horizontal"
							action="changePassword" modelAttribute="changePassword"
							id="resetPass" >

							<!--First column-->
							<div class="col-md-8">

								<!-- Text input Email-->
								<div class="form-group">
									<label class="col-md-3 control-label">Email</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-envelope"></i></span> <input id="email"
												name="email" placeholder="Email" class="form-control"
												type="email" value="${employee.email}">
										</div>
									</div>
								</div>
								
							</div>
							<!-- /F Column -->
							
							<div class="col-md-6">
									<!-- Text input New Password-->
								<div class="form-group">
									<label class="col-md-3 control-label">New Password</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-lock"></i></span> <input
												name="newpassword" id="newpassword"
												placeholder="New Password" class="form-control"
												type="password">
										</div>
									</div>
								</div>
								<!-- Text input Confirm Password-->
								<div class="form-group">
									<label class="col-md-3 control-label">Confirm Password</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-lock"></i></span> <input
												name="confirmpassword" id="confirmpassword"
												placeholder="Confirm Password" class="form-control"
												type="password">
										</div>
									</div>
								</div>
							</div>
							<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-8">
							<br><br>
							<button type="submit" name="resetpassword" id="resetpassword"
								class="btn btn-lg btn-primary btn-block">Reset Password</button>
							
							</div>
					</div>
					
							
						</form:form>



					</div>
					<!-- /tab-content -->
				</div>
				<!-- /panel body -->
			</div>
			<!--/panel success class-->
		</div>
		<!-- /Container -->
		<!-- Footer -->
		<c:import url="templates/footer.jsp"></c:import>
		<!--/ Footer -->
	</div>
	<!-- / velaphanda_containter -->

	<!-- Validator -->
	<script type="text/javascript"
		src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>

	<!-- Validate Reset Password -->
	<script>
		$(document)
				.ready(
						function() {
							$('#resetPass')
									.bootstrapValidator(
											{
												feedbackIcons : {
													valid : 'glyphicon glyphicon-ok',
													invalid : 'glyphicon glyphicon-remove',
													validating : 'glyphicon glyphicon-refresh'
												},
												fields : {
													newpassword : {
														validators : {
															identical : {
																field : 'newpassword',
																message : 'The password and its confirm are not the same'
															}
														}
													},
													confirmpassword : {
														validators : {
															identical : {
																field : 'password',
																message : 'The password and its confirm are not the same'
															}
														}
													}

												}
											});
						});
	</script>		
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

</body>
</html>