<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
		<c:import url="templates/navbar.jsp"></c:import>
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
							<b>Password Reset</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">

						<form action="searchEmployeeForPasswordReset" method="post"
							id="searchEmployeeForPasswordReset">
							<div class="row">



								<!-- Text input Search-->
								<!-- 		<div class="form-group">
							<label class="col-md-3 control-label">Search Employee</label>
							<div class="col-md-4 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-user"></i></span> <input name="empName" id="empName"
										 class="form-control" type="text" placeholder='Search By Email Address'>									
								</div>								
							</div>
							<div class="col-md-2">
									<input class="btn btn-success" type='submit' name="search" value='Search' />
							</div>
							</div> -->
							</div>

							<hr>
						</form>
						<br>
						<form:form class="well form-horizontal" method="post"
							action="resetPassword" modelAttribute="resetPassword"
							id="resetPassword">

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
												value='${employeeObject.firstName }' readonly="readonly">
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
												value='${employeeObject.lastName }' readonly="readonly">
										</div>
									</div>
								</div>

								<!-- Text input type Title-->
								<div class="form-group">
									<label class="col-md-3 control-label">Title</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-user"></i></span> <input name="title"
												id="title" class="form-control" type="text"
												value='${ employeeObject.title}' readonly="readonly">
										</div>
									</div>
								</div>

							</div>
							<!-- / F column -->

							<!--Second column-->
							<div class="col-sm-6">

								<!-- Select type Gender-->
								<div class="form-group">
									<label class="col-md-3 control-label">Gender</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-user"></i></span> <input name="gender"
												id="gender" class="form-control" type="text"
												value='${ employeeObject.gender}' readonly="readonly">
										</div>
									</div>
								</div>

								<!-- Text input email-->
								<div class="form-group">
									<label class="col-md-3 control-label">E-Mail</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-envelope"></i></span> <input
												name="email" placeholder="E-Mail Address"
												class="form-control" type="text"
												value='${ employeeObject.email}' readonly="readonly">
										</div>
									</div>
								</div>

								<!-- Select type Role-->
								<div class="form-group">
									<label class="col-md-3 control-label">Role</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-envelope"></i></span> <input name="role"
												class="form-control" type="text"
												value='${ employeeObject.role}' readonly="readonly">
										</div>
									</div>
								</div>


							</div>
							<!-- /S column  -->
							<div class="form-group row">
								<div class="col-sm-offset-2 col-sm-8">
									<br>
									<br> <input type="submit" value="Reset Password"
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


	<!-- Validator -->
	<script type="text/javascript"
		src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>

</body>
</html>
