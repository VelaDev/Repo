<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <title>Register Employee | Velaphanda Trading & Projects</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">  
	
  <link href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" rel="stylesheet" type="text/css" /> 
  <link href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />" rel="stylesheet" type="text/css" /> 
	
</head>
<body>
	<div class="velaphanda_containter">	
		<c:import url="templates/navbar.jsp"></c:import>
		<div class="container">
		<br/>
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
						<b>Add Employee</b>
					</div>
					</h3>
				</div>
				<div class="panel-body">					
					<div class="tab-content">
					
				<form:form class="well form-horizontal" method="post" action="addEmployee"
					modelAttribute="addEmployee" id="addEmployee">

					
					<!--First column-->
					<div class="col-sm-6">
					
						<!-- Text input First Name-->	
						<div class="form-group">
							<label class="col-md-3 control-label">First Name</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-user"></i></span> <input name="firstName"
										placeholder="First Name" class="form-control" type="text">
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
										placeholder="Last Name" class="form-control" type="text">
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
										class="form-control selectpicker">
										<option value=" ">Select Title</option>
										<option value="Mr">Mr</option>
										<option value="Miss">Miss</option>
										<option value="Mrs">Mrs</option>
										<option value="Doc">Dr</option>
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
										class="glyphicon glyphicon-list"></i></span> <select name="gender"
										class="form-control selectpicker">
										<option value=" ">Select Gender</option>
										<option value="Mr">Male</option>
										<option value="Miss">Female</option>
										
									</select>
								</div>
							</div>
						</div>
								
					</div><!-- / F column -->	
					
					<!--Second column-->		
					<div class="col-sm-6">
					
					<!-- Text input Username-->
						<div class="form-group">
							<label class="col-md-3 control-label">Username</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-envelope"></i></span> <input name="username"
										placeholder="Username" class="form-control" type="text">
								</div>
							</div>
						</div>
						
					<!-- Text input password-->
						<div class="form-group">
							<label class="col-md-3 control-label">Password</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-lock"></i></span> <input name="password"
										placeholder="Password" class="form-control" type="password">
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
										placeholder="E-Mail Address" class="form-control" type="text">
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
										<option value=" ">Select Role</option>
										<option value="Admin">Admin</option>
									<option value="Manager">Manager</option>
									<option value="Technician">Technician</option>
									<option value="User">User</option>
										
									</select>
								</div>
							</div>
						</div>
						
					</div><!-- S .Column -->
					
					<br>
					<br>
					<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-8">
							<input type="submit" value="Register Employee"
								class="btn btn-primary btn-block btn-lg" tabindex="9"
								id="registere">
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
	
<!-- Validator -->
<script type="text/javascript" src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script> 
<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>


<!-- Validatev register employee -->
<script>
 $(document).ready(function() {
    $('#addEmployee').bootstrapValidator({
         feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	firstName: {
                validators: {
					stringLength : {
						min : 2,
					},
                    notEmpty: {
                        message: 'First Name is required and cannot be empty'
                    }
                }
            },
            lastName: {
                validators: {
					stringLength : {
						min : 2,
					},
                    notEmpty: {
                        message: 'Last Name is required and cannot be empty'
                    }
                }
            },
            title: {
                validators: {
                    notEmpty: {
                        message: 'Title is required and cannot be empty'
                    }
                }
            },
            gender: {
                validators: {
                    notEmpty: {
                        message: 'Gender is required and cannot be empty'
                    }
                }
            },
            username: {
                validators: {
                    notEmpty: {
					stringLength : {
						min : 2,
					},
                        message: 'Username is required and cannot be empty'
                    }
                }
            },
            password: {
                validators: {
                    notEmpty: {
					stringLength : {
						min : 4,
					},
                        message: 'Password is required and cannot be empty'
                    }
                }
            },
            email: {
                validators: {
                    notEmpty: {
                        message: 'The email address is required and cannot be empty'
                    },
                     emailAddress: {
                        message: 'The email address is not valid'
                    } 
                }
            },
            role: {
                validators: {
                    notEmpty: {
                        message: 'Role is required and cannot be empty'
                    }
                }
            },
        }
    });
});

</script>

</body>
</html>
