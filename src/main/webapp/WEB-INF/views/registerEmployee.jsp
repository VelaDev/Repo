<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <title>Register Employee | Velaphanda Trading & Projects</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">  
	
  <link href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" rel="stylesheet" type="text/css" /> 
  <link href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />" rel="stylesheet" type="text/css" /> 
  <link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap-3.3.7/fonts/font-awesome.min.css" />"  />
  
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
			<c:if test="${not empty retErrorMessage }">
			<div class="alert alert-danger" role="alert">
				<c:out value="${ retErrorMessage}">
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
										class="glyphicon glyphicon-user"></i></span> <input id="firstName" name="firstName"
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
										class="glyphicon glyphicon-list"></i></span> <select name="title" id="title"
										class="form-control selectpicker" onchange="CheckGender(this.value);">
										<option value="">Select Title</option>
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
										class="glyphicon glyphicon-list"></i></span> <select onchange="CheckGender(this.value);" id="gender" name="gender"
										class="form-control selectpicker">
										<option value="">Select Gender</option>
										<option value="Male">Male</option>
										<option value="Female">Female</option>
										
									</select>
								</div>
							</div>
						</div>
								
					</div><!-- / F column -->	
					
					<!--Second column-->		
					<div class="col-sm-6">
					
						 <!-- Text input Cellphone Number-->
						 <div class="form-group">
						 	<label class="col-md-3 control-label">Cellphone No</label>
								<div class="col-md-6 inputGroupContainer">
									<div class="input-group">
										<span class="input-group-addon"><i
											class="glyphicon glyphicon-earphone"></i></span> <input
											id="cellphoneNumber" name="cellNumber" maxlength="10" placeholder="Cellphone No" class="form-control" type="text" onkeypress="return isNumber(event)">
									</div>
								</div>
						</div>
							
					   <!-- Text input email-->
						<div class="form-group">
							<label class="col-md-3 control-label">Email Address</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-envelope"></i></span> <input name="email"
										placeholder="Email Address" class="form-control" type="text">
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
										
						<div class="form-group row">
							<div class="col-sm-offset-2 col-sm-8">
								<br><br>
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
	
<!-- Script -->
<script type="text/javascript" src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script> 
<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
<!-- //Script -->

<!-- Validate register employee -->
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
            cellphoneNumber : {
				validators : {
					notEmpty : {
						message : 'Cellphone number is required and cannot be empty'
					},
					regexp: {
						
						regexp: /^0[0-9].*$/,
						message :'Cellphone number must start with 0 (Zero)'
					}, 
					phone : {
						country : 'US',
						message : 'Please provide a vaild Cellphone Number'
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
            cellNumber : {
				validators : {
					notEmpty : {
						message : 'Please enter 10 numbers'
					},
					regexp: {
						
						regexp: /^0[0-9].*$/,
						message :'Cellphone number must start with 0 (Zero)'
					}, 
					phone : {
						country : 'US',
						message : 'Please provide a vaild Cellphone Number'
					}
					
				}
			},
        }
    });
});
</script>	
	
	<!-- Accept alphanumeric characters only -->
	<script type="text/javascript">
	function isNumber(evt) {
	    evt = (evt) ? evt : window.event;
	    var charCode = (evt.which) ? evt.which : evt.keyCode;
	    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
	        return false;
	    }
	    return true;
	}
	</script>
	
<!-- Check gender selection -->	
<script type="text/javascript">
	
function CheckGender(val){
	
	 var element=document.getElementById('title');
	  
	 if (val=='pick title' || val=='Mr')
	 {
		document.getElementById('gender').value = 'Male';
	 }
	 else if (val=='pick title' || val=="Miss")
	 {
		document.getElementById('gender').value = 'Female'; 
	 }
	 else if (val=='pick title' || val=="Mrs")
	 {
	    document.getElementById('gender').value = 'Female'; 
	 }
	 else
	 {
		 document.getElementById('gender').value = '';  
	 }
	 
}

</script>
	
	</body>
</html>
