<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <title>Update Employee | Velaphanda Trading & Projects</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">  
	<script type="text/javascript" src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
    <script type="text/javascript" src="<c:url value="/resources/jquery/EasyAutocomplete-1.3.5/jquery.easy-autocomplete.js" />"></script>
    <script type="text/javascript" src="<c:url value="/resources/jquery/EasyAutocomplete-1.3.5/jquery.easy-autocomplete.min.js" />"></script> 
    <script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
	
  <link href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" rel="stylesheet" type="text/css" /> 
  <link href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />" rel="stylesheet" type="text/css" /> 
	
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
				
				<form action="searchEmployeeByName" method="post" id="searchEmployee">
					<div class="row">

						
					
					<!-- Text input Search-->
						<div class="form-group">
							<label class="col-md-3 control-label">Search Employee</label>
							<div class="col-md-4 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-user"></i></span> <input name="email" id="email"
										 class="form-control" type="text" placeholder='Search'>									
								</div>								
							</div>
							<div class="col-md-2">
									<input class="btn btn-success" type='submit' name="search" value='Search' />
							</div>
							</div>
					</div>
					
					<hr>
				</form>
				<br>
				<form:form class="well form-horizontal" method="post" action="updateEmployee"
					modelAttribute="updateEmployee" id="updateEmployee">
							
					<!--First column-->
					<div class="col-sm-6">
					
						<!-- Text input First Name-->	
						<div class="form-group">
							<label class="col-md-3 control-label">First Name</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-user"></i></span> <input name="firstName"
										placeholder="First Name" class="form-control" type="text" value='${employeeObject.firstName }'> 
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
										placeholder="Last Name" class="form-control" type="text" value='${employeeObject.lastName }'>
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
										<option value="">${ employeeObject.title}</option>
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
										<option value=" ">${ employeeObject.gender}</option>
										<option value="Male">Male</option>
										<option value="Female">Female</option>
										
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
										placeholder="E-Mail Address" class="form-control" type="text" value='${ employeeObject.email}'>
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
										<option value=" ">${ employeeObject.role}</option>
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
							<input type="submit" value="Update Employee"
								class="btn btn-primary btn-block btn-lg" tabindex="9"
								id="updateEmp" name="updateEmp">
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

<!-- Validate update employee -->
<script>
 $(document).ready(function() {
    $('#updateEmployee').bootstrapValidator({
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
<!--Validate search-->
<script>
 $(document).ready(function() {
    $('#searchEmployee').bootstrapValidator({
         feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	empName: {
                validators: {
					stringLength : {
						min : 2,
					},
                    notEmpty: {
                        message: 'Employee name is required to search and cannot be empty'
                    }
                }
            }
        }
    });
});

</script>
<script>
  $(document).ready(function() {

	$('#empName').autocomplete({
		serviceUrl: '${pageContext.request.contextPath}/getEmployees',
		paramName: "email",
		delimiter: ",",
	   transformResult: function(response) {

		return {
		  //must convert json to javascript object before process
		  suggestions: $.map($.parseJSON(response), function(item) {

		      return { value: item.email, data: item.email };
		   })

		 };

            }

	 });

  });
  </script>

</body>
</html>
