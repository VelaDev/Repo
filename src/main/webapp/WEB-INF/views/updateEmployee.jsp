<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Update Employee | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/stylesheet" href="<c:url value="/resources/custom/css/vela_custom.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap-3.3.7/fonts/font-awesome.min.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />"  />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />"  />

</head>
<body>
	<div class="velaphanda_containter">
		<c:import url="templates/navbar.jsp"></c:import>
		<div class="container">
			<c:if test="${not empty retMessage }">
				<div class="alert alert-info" role="alert">
					<c:out value="${ retMessage}">
					</c:out>
				</div>
			</c:if>
			<br />
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Update Employee</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">
						<br>
						<form:form class="well form-horizontal" method="post"
							action="updateEmployee" modelAttribute="updateEmployee"
							id="updateEmployee">

							<!--First column-->
							<div class="col-sm-6">

								<!-- Text input First Name-->
								<div class="form-group">
									<label class="col-md-3 control-label">First Name</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-user"></i></span> <input
												name="firstName" placeholder="First Name"
												class="form-control" type="text"
												value='${employeeObject.firstName }'>
										</div>
									</div>
								</div>

								<!-- Text input Last Name-->
								<div class="form-group">
									<label class="col-md-3 control-label">Last Name</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-user"></i></span> <input name="lastName"
												placeholder="Last Name" class="form-control" type="text"
												value='${employeeObject.lastName }'>
										</div>
									</div>
								</div>

								<!-- Select type Title-->
								<div class="form-group">
									<label class="col-md-3 control-label">Title</label>
									<div class="col-md-6 selectContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-list"></i></span> <select name="title" id="title"
												class="form-control selectpicker" onchange="CheckGender(this.value);">
												<option value="${ employeeObject.title}">${ employeeObject.title}</option>
												<option value="Mr">Mr</option>
												<option value="Miss">Miss</option>
												<option value="Mrs">Mrs</option>
												<option value="Dr">Dr</option>
											</select>
										</div>
									</div>
								</div>
								
								<!-- Select type Gender-->
								<div class="form-group">
									<label class="col-md-3 control-label">Gender</label>
									<div class="col-md-6 selectContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-list"></i></span> <select name="gender" id="gender"
												class="form-control selectpicker" onchange="CheckGender(this.value);">
												<option value="${ employeeObject.gender}">${ employeeObject.gender}</option>
												<option value="Male">Male</option>
												<option value="Female">Female</option>

											</select>
										</div>
									</div>
								</div>

							</div>
							<!-- / F column -->
							
							<!--Second column-->
							<div class="col-sm-6"> 
 								
								<!-- Text input Cellphone Number-->
								<div class="form-group">
									<label class="col-md-3 control-label">Cellphone No</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-earphone"></i></span> <input
												id="cellphoneNumber" name="cellNumber"
												placeholder="Cellphone No" onkeypress="return isNumber(event)" class="form-control" type="text"  
												value='${employeeObject.cellNumber }'>
										</div>
									</div>
								</div>

								<!-- Text input email-->
								<div class="form-group">
									<label class="col-md-3 control-label">Email</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-envelope"></i></span> <input
												name="email" placeholder="Email Address"
												class="form-control" type="text"
												value='${ employeeObject.email}' >
										</div>
									</div>
								</div>

								<!-- Select type Role-->
								<div class="form-group">
									<label class="col-md-3 control-label">Role</label>
									<div class="col-md-6 selectContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-list"></i></span> <select name="role"
												class="form-control selectpicker">
												<option value="${ employeeObject.role}">${ employeeObject.role}</option>
												<option value="Admin">Admin</option>
												<option value="Manager">Manager</option>
												<option value="Technician">Technician</option>
												<option value="User">User</option>

											</select>
										</div>
									</div>
								</div>

							</div>
							<!-- /S column  -->
							<div class="form-group row">
								<div class="col-sm-offset-2 col-sm-8">
									<br>
									<br> <input type="submit" value="Update Employee"
										class="btn btn-primary btn-block btn-lg" tabindex="9"
										id="updateEmp" name="updateEmp">
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

	<!-- Script -->

	<script type="text/javascript"
		src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
	<script type="text/javascript"
	src="<c:url value="/resources/jquery/1.13.1/jquery.validate.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
		
	<script type="text/javascript" src="<c:url value="/resources/custom/js/velas_validations.js"/>"></script>
	
	<!-- /Script -->

</body>
</html>
