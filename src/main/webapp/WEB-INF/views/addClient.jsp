<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <title>Add Client | Velaphanda Trading & Projects</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">  
  
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
			<div class="panel panel-success">    
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
						<b>Add Customer</b>
					</div>
					</h3>
				</div>
				<div class="panel-body">					
					<div class="tab-content">
					
				<form:form class="well form-horizontal" method="post" action="saveClient"
						modelAttribute="saveClient" id="saveClient">

					
					<!--First column-->
					<div class="col-sm-6">
					
						<!-- Text input Client Name-->	
						<div class="form-group">
							<label class="col-md-3 control-label">Customer Name</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-user"></i></span> <input name="clientName"
										placeholder="Customer Name" class="form-control" type="text">
								</div>
							</div>
						</div>

						<!-- Text input Contact Person-->
						<div class="form-group">
							<label class="col-md-3 control-label">Contact Person</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-user"></i></span> <input name="contactPerson"
										placeholder="Contact Person" class="form-control" type="text">
								</div>
							</div>
						</div>
						
						<!-- Select type Province-->						
						<div class="form-group">
							<label class="col-md-3 control-label">Province</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-list"></i></span> <select name="province"
										class="form-control selectpicker">
										<option value=" ">Select Province</option>
										<option value="Gauteng">Gauteng</option>
										<option value="Limpopo">Limpopo</option>
										<option value="Nort West">North West</option>
										<option value="Free State">Free State</option>
										<option value="Mpumalanga">Mpumalanga</option>
										<option value="KwaZulu Natal">KwaZulu Natal</option>
										<option value="Northern Cape">Northern Cape</option>
										<option value="Eastern Cape">Eastern Cape</option>
										<option value="Mpumalanga">Western Cape</option>
									</select>
								</div>
							</div>
						</div>
						
						<!-- Text input City or Town-->
						<div class="form-group">
							<label class="col-md-3 control-label">City/Town</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-home"></i></span> <input name="city_town"
										placeholder="City / Town" class="form-control" type="text">
								</div>
							</div>
						</div>
												
						<!-- Text input Street Name-->
						<div class="form-group">
							<label class="col-md-3 control-label">Street Name</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-home"></i></span> <input name="streetName"
										placeholder="Street Name" class="form-control" type="text">
								</div>
							</div>
						</div>
						
						<!-- Text input Area Code-->
						<div class="form-group">
							<label class="col-md-3 control-label">Area Code</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-home"></i></span> <input name="zipcode"
										placeholder="Area Code" class="form-control" type="text">
								</div>
							</div>
						</div>
								
					</div><!-- / F column -->	
					
					<!--Second column-->		
					<div class="col-sm-6">
						<!-- Text input Floor Number-->
						<div class="form-group">
							<label class="col-md-3 control-label">Street No</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-home"></i></span> <input name="streetNumber"
										placeholder="Street Number" class="form-control" type="text">
								</div>
							</div>
						</div>
						
						<!-- Text input Contact Person 2-->
						<div class="form-group">
							<label class="col-md-3 control-label">Contact Person </label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-user"></i></span> <input name="contactPerson2"
										placeholder="Contact Person (Optional)" class="form-control" type="text">
								</div>
							</div>
						</div>
						
						<!-- Text input Tellphone Number-->
						<div class="form-group">
							<label class="col-md-3 control-label">Telephone No</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-earphone"></i></span> <input name="tellphoneNumber"
										placeholder="Tellphone Number" class="form-control" type="text">
								</div>
							</div>
						</div>
						<!-- Text input Fax Number-->
						<div class="form-group">
							<label class="col-md-3 control-label">Fax Number</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-earphone"></i></span> <input name="faxNumber"
										placeholder="Fax Number" class="form-control" type="text">
								</div>
							</div>
						</div>
						<!-- Text input Cellphone Number-->
						<div class="form-group">
							<label class="col-md-3 control-label">Mobile Number</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-earphone"></i></span> <input name="cellNumber"
										placeholder="Mobile Number" class="form-control" type="text">
								</div>
							</div>
						</div>
						
						<!-- Text input Email-->
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

						
					</div><!-- /S Column -->
									
					<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-8">
							<br><br>
							<input type="submit" value="Add Customer"
								class="btn btn-primary btn-block btn-lg" tabindex="9"
								id="addClnt">
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
<!-- /Script -->


<!-- Validate add Client -->
<script>

$(document).ready(function() {
    $('#saveClient').bootstrapValidator({
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	clientName: {
                validators: {
                	stringLength : {
						min : 2,
					},
                    notEmpty: {
                        message: 'Client name is required and cannot be empty'
                    }
                }
            },
            contactPerson: {
                validators: {
                	stringLength : {
						min : 2,
					},
                    notEmpty: {
                        message: 'Contact person is required and cannot be empty'
                    }
                }
            },
            province: {
                validators: {
                    notEmpty: {
                        message: 'Province is required and cannot be empty'
                    }
                }
            },
            city_town: {
                validators: {
                    notEmpty: {
                    	stringLength : {
    						min : 3,
    					},
                        message: 'City is required and cannot be empty'
                    }
                }
            },
            streetName: {
                validators: {
                	stringLength : {
						min : 3,
					},
                    notEmpty: {
                        message: 'Street name is required and cannot be empty'
                    }
                }
            },
            zipcode: {
                validators: {
                    notEmpty: {
                    	stringLength : {
    						min : 4,
    					},
                        message: 'Zipcode is required and cannot be empty'
                    }
                }
            },
            floorNumber: {
                validators: {
                    notEmpty: {
                    	stringLength : {
    						min : 1,
    					},
                        message: 'Floor number is required and cannot be empty'
                    }
                }
            },
            tellphoneNumber: {
                validators: {
                    notEmpty: {
                        message: 'Tellphone number is required and cannot be empty'
                    },
					phone : {
							country : 'US',
							message : 'Please provide a vaild tellphone number'
					}
                }
            },
            faxNumber: {
                validators: {
                    notEmpty: {
                        message: 'Fax number is required and cannot be empty'
                    },
					phone : {
							country : 'US',
							message : 'Please provide  a vaild fax number'
					}
                }
            },
            cellNumber: {
                validators: {
                    notEmpty: {
                        message: 'Cell number is required and cannot be empty'
                    },
					phone : {
							country : 'US',
							message : 'Please provide a vaild Cell Number with area code'
					}
                }
            },
            email: {
                validators: {
                    notEmpty: {
                        message: 'Email address is required and cannot be empty'
                    },
                    emailAddress: {
                        message: 'The email address is not valid'
                    }
                }
            }
        }
    });
});


</script>

</body>
</html>
