<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <title>Deactivate Employee | Velaphanda Trading & Projects</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">  
	
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/custom/css/vela_custom.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap-3.3.7/fonts/font-awesome.min.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" />
<link rel="stylesheet" type="text/css" 	href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />" />


</head>
<body >
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
						<c:choose>
						  <c:when test="${employeeObject.status=='INACTIVE' }">
						    <b>Activate Employee</b>
						  </c:when>
						  <c:otherwise>
						     <b>Deactivate Employee</b>
						  </c:otherwise>
						</c:choose>
					</div>
					</h3>
				</div>
				<div class="panel-body">					
				<div class="tab-content">
				
				<form action="searchEmployeeForDeactivation" method="post" id="searchEmployeeForDeactivation">
					<div class="row">
					</div>
					
					<hr>
				</form>
				<br>
				
				<div class="bb-alert alert alert-info" style="display: none;">
					<span>This was logged in the callback: false</span>
				</div>
				
				<form:form class="well form-horizontal" method="post" action="deactivateEmp"
					modelAttribute="deactivateEmp" id="deactivateEmp">
							
					<!--First column-->
					<div class="col-sm-6">
					
						<!-- Text input First Name-->	
						<div class="form-group">
							<label class="col-md-3 control-label">First Name</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-user"></i></span> <input name="firstName"
										placeholder="First Name" class="form-control" type="text" value='${employeeObject.firstName }' readonly="readonly"> 
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
										placeholder="Last Name" class="form-control" type="text" value='${employeeObject.lastName }' readonly="readonly">
								</div>
							</div>
						</div>
						
						<!-- Select type Title-->						
						<div class="form-group">
							<label class="col-md-3 control-label">Title</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-list"></i></span> <select name="title"
										class="form-control selectpicker" >
										<option value="${ employeeObject.title}">${ employeeObject.title}</option>
										<option value="Mr">Mr</option>
										<option value="Miss">Miss</option>
										<option value="Mrs">Mrs</option>
										<option value="Dr">Dr</option>
									</select>
								</div>
							</div>
						</div>
						
						
								
					</div><!-- / F column -->	
					
					<!--Second column-->		
					<div class="col-sm-6">
					
					<!-- Select type Gender-->
						<div class="form-group">
							<label class="col-md-3 control-label">Gender</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-list"></i></span> <select name="gender"
										class="form-control selectpicker">
										<option value=" ${ employeeObject.gender}">${ employeeObject.gender}</option>
										<option value="Mr">Male</option>
										<option value="Miss">Female</option>
										
									</select>
								</div>
							</div>
						</div>
						
					<!-- Text input email-->
						<div class="form-group">
							<label class="col-md-3 control-label">E-Mail</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-envelope"></i></span> <input name="email"
										placeholder="E-Mail Address" class="form-control" type="text" value='${ employeeObject.email}' readonly="readonly">
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
										<option value=" ${ employeeObject.role}">${ employeeObject.role}</option>
										<option value="Admin">Admin</option>
									<option value="Manager">Manager</option>
									<option value="Technician">Technician</option>
									<option value="User">User</option>
										
									</select>
								</div>
							</div>
						</div>
						
					</div><!-- /S column  -->
					
					<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-8">
							<br><br>
							
							<c:choose>
						        <c:when test="${employeeObject.status=='INACTIVE' }">
						            <input type="submit" value="Activate Employee"
								           class="btn btn-success btn-block btn-lg"
								          id="deactivateEmp" name="deactivateEmp" data-confirm="Are are sure you want to activate this employee?">
							
						        </c:when>
						         <c:when test="${employeeObject.status=='BLOCKED' }">
						            <input type="submit" value="Activate Employee"
								           class="btn btn-success btn-block btn-lg"
								          id="deactivateEmp" name="deactivateEmp" data-confirm="Are are sure you want to activate this employee?">
							
						        </c:when>
						     <c:otherwise>
						          <input type="submit" value="Deactivate Employee"
								         class="btn btn-danger btn-block btn-lg"
								         id="deactivateEmp" name="deactivateEmp" data-confirm="Are are sure you want to deactivate this employee?">
						      </c:otherwise>
					      </c:choose>
						</div>
					</div>
					
					</form:form>
					</div><!-- /tab-content -->									
				</div><!-- /panel body -->
			</div><!--/panel success class-->
		</div><!-- /Container -->
		<!-- Footer -->
		<c:import url="templates/footer.jsp"></c:import>
		<!--/ Footer -->
	</div><!-- / velaphanda_containter -->
	
	<script type="text/javascript"
		src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
	<script type="text/javascript"
	src="<c:url value="/resources/jquery/1.13.1/jquery.validate.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
		
	<script type="text/javascript" src="<c:url value="/resources/custom/js/velas_validations.js"/>"></script>

</body>
</html>
