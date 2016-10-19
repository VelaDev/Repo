<%@ include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Register Employee</title>
</head>
<c:import url="templates/navbar.jsp"></c:import>

<body class=".container-fluid">
	<div class="container" style="width: 90%">
	
		
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
				<form:form method="post" action="addEmployee"
					modelAttribute="addEmployee" id="addEmployee">

					<div class="row">
						<div class="col-xs-12">
							<div class="col-xs-2 form-control-label">
								<label>First Name:</label>

							</div>
							<div class="col-xs-3">
								<input type="text" class="form-control input-sm"
									name="firstName">
							</div>

							<div class="col-xs-2 form-control-label">
								<label>Last Name:</label>

							</div>
							<div class="col-xs-3">
								<input type="text" class="form-control input-sm" name="lastName" >
							</div>
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col-xs-12">
							<div class="col-xs-2 form-control-label">
								<label>Title:</label>

							</div>
							<div class="col-xs-3">
								<select name="title" class="form-control">
									<option value="">Title
									<option>
									<option value="Mr">Mr</option>
									<option value="Miss">Miss</option>
									<option value="Mrs">Mrs</option>
									<option value="Doc">Doc</option>
								</select>
							</div>

							<div class="col-xs-2 form-control-label">
								<label>Gender:</label>

							</div>
							<div class="col-xs-3">
								<select name="gender" class="form-control">
									<option value="">Gender
									<option>
									<option value="Male">Male</option>
									<option value="Female">Female</option>
								</select>
							</div>
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col-xs-12">
							<div class="col-xs-2 form-control-label">
								<label>Username:</label>

							</div>
							<div class="col-xs-3">
								<input type="text" class="form-control input-sm" name="username">
							</div>

							<div class="col-xs-2 form-control-label">
								<label>Password:</label>

							</div>
							<div class="col-xs-3">
								<input type="password" class="form-control input-sm"
									name="password">
							</div>
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col-xs-12">
							<div class="col-xs-2 form-control-label">
								<label>Email:</label>

							</div>
							<div class="col-xs-3">
								<input type="text" class="form-control input-sm" name="email" >
							</div>

							<div class="col-xs-2 form-control-label" >
								<label>Role:</label>

							</div>
							<div class="col-xs-3">
								<select name="role" class="form-control" >
									<option value="">Role
									<option>
									<option value="Admin">Admin</option>
									<option value="Manager">Manager</option>
									<option value="Technician">Technician</option>
									<option value="User">User</option>
								</select>
							</div>
						</div>
					</div>
					<br>
					 <div class="form-group">
					  <div class="col-md-9 col-md-offset-3">
						<div id="messages"></div><br>
					  </div>
				    </div> 
					
					<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-8">
							<input type="submit" value="Register Employee"
								class="btn btn-primary btn-block btn-lg" tabindex="9"
								id="registerEmployee">
						</div>
					</div>
					
					
				</form:form>

			</div>
		</div>
	</div>
</body>

<!-- Validatev register employee -->

<script>
/* $(document).ready(function() {
    $('#addEmployee').bootstrapValidator({
       container: '#messages',
       feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	firstName: {
                validators: {
                    notEmpty: {
                        message: 'First Name is required and cannot be empty'
                    }
                }
            },
            lastName: {
                validators: {
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
                        message: 'Username is required and cannot be empty'
                    }
                }
            },
            password: {
                validators: {
                    notEmpty: {
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
}); */

</script>

<!-- Validator -->
<script type="text/javascript" src="<c:url value="/resources/jquery/1.10.2/jquery-1.10.2.js" />"></script> 
 <script type="text/javascript" src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
 
<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.5/js/bootstrap.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
<link href="<c:url value="/resources/bootstrap-3.3.5/css/bootstrap.min.css" />"	rel="stylesheet" type="text/css" /> 
<link href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />" rel="stylesheet" type="text/css" /> 

</html>

