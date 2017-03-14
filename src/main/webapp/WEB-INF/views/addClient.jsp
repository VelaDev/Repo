<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Add Client | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
<link
	href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />"
	rel="stylesheet" type="text/css" />
<link type="text/stylesheet"
	src="<c:url value="/resources/custom/css/vela_custom.css" />">

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
			<div id="responseFromController"></div>

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

						<form:form class="well form-horizontal" method="post"
							action="saveClient" id="addClient" modelAttribute="saveClient">

							<!--First column Customer Fields-->
							<div class="col-sm-6">
								<!-- Text input Client Name-->
								<div class="form-group">
									<label class="col-md-3 control-label">Customer Name</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-user"></i></span> <input
												name="customerName" id="clientName"
												placeholder="Customer Name" class="form-control" type="text">
										</div>
									</div>
								</div>

								<!-- Text input Tellphone Number-->
								<div class="form-group">
									<label class="col-md-3 control-label">Telephone No</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-earphone"></i></span> <input
												name="tellphoneNumber" id="tellphoneNumber"
												placeholder="Telephone Number" maxlength="10" class="form-control"
												type="text" onkeypress="return isNumber(event)">
										</div>
									</div>
								</div>

								<!-- Text input Fax Number-->
								<div class="form-group">
									<label class="col-md-3 control-label">Fax Number</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-earphone"></i></span> <input
												name="faxNumber" id="faxNumber" placeholder="Fax Number"
												class="form-control" type="text" maxlength="10" onkeypress="return isNumber(event)">
										</div>
									</div>
								</div>
								
								
								<!-- Text input Email-->
								<div class="form-group">
									<label class="col-md-3 control-label">Company Email</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-envelope"></i></span> <input
												name="emailCompany" id="emailCompany"
												placeholder="Company Email Address" class="form-control"
												type="text">
										</div>
									</div>
								</div>
								
								
								
							</div>
							<!-- / F Customer Fields -->

							<!--Second column Customer Fields-->
							<div class="col-sm-6">
								
								<!-- Text input Street Number-->								
								<div class="form-group">
									<label class="col-md-3 control-label">Street No</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-home"></i></span> <input
												name="streetNumber" id="streetNumber"
												placeholder="Street No" class="form-control" onkeypress="return isNumber(event)"  type="text">
										</div>
									</div>
								</div>								
								
								<!-- Text input Street Name-->
								<div class="form-group">
									<label class="col-md-3 control-label">Street Name</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-home"></i></span> <input
												name="streetName" id="streetName" placeholder="Street Name" class="form-control" type="text">
										</div>
									</div>
								</div>
								<!-- Text input City or Town-->
								<div class="form-group">
									<label class="col-md-3 control-label">City/Town</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-home"></i></span> <input
												name="city_town" id="city_town" placeholder="City / Town"
												class="form-control" type="text">
										</div>
									</div>
								</div>
								<!-- Select type Province-->
								<div class="form-group">
									<label class="col-md-3 control-label">Province</label>
									<div class="col-md-6 selectContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-list"></i></span> <select
												name="province" id="province"
												class="form-control selectpicker">
												<option value="">Select Province</option>
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

								<!-- Text input Area Code-->
								<div class="form-group">
									<label class="col-md-3 control-label">Area Code</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-home"></i></span> <input name="zipcode"
												id="zipcode" placeholder="Area Code" class="form-control"
												type="text" onkeypress="return isNumber(event)">
										</div>
									</div>
								</div>
								

							</div>
							<!--/Second column Customer Fields-->

							
							<!-- Contact Person 1 -->
							<div class="col-sm-6">
								<br>
								<div align="center">
									<b>Contact Person 1</b>
								</div>
								<!-- Text input Contact Person First Name-->
								<div class="form-group">
									<label class="col-md-3 control-label">First Name</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-user"></i></span> <input id="firstName"
												name="firstName" placeholder="First Name"
												class="form-control" type="text">
										</div>
									</div>
								</div>
								<!-- Text input Contact Person  Last Name-->
								<div class="form-group">
									<label class="col-md-3 control-label">Last Name</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-user"></i></span> <input id="lastName"
												name="lastName" placeholder="Last Name" class="form-control"
												type="text">
										</div>
									</div>
								</div>
							</div>

							<div class="col-sm-6">
								<br>
								<br>
								<!-- Text input Contact Person Cellphone Number-->
								<div class="form-group">
									<label class="col-md-3 control-label">Cellphone No</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-earphone"></i></span> <input
												id="cellphoneNumber" name="cellphoneNumber"
												placeholder="Cellphone No" class="form-control" maxlength="10" type="text" onkeypress="return isNumber(event)">
										</div>
									</div>
								</div>
								<!-- Text input Contact Person Tellphone Number-->
								<div class="form-group">
									<label class="col-md-3 control-label">Tellphone No</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-earphone"></i></span> <input
												id="telephoneNumber" name="telephoneNumber"
												placeholder="Telephone No" class="form-control" maxlength="10" type="text" onkeypress="return isNumber(event)">
										</div>
									</div>
								</div>

								<div class="form-group">
									<label class="col-md-3 control-label">Email</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-envelope"></i></span> <input id="email"
												name="email" placeholder="Email Address"
												class="form-control" type="email">
										</div>
									</div>
								</div>

							</div>
							<!-- /Contact Person 1 -->


						<!-- 	<div class="form-group">
								<label class="col-md-3 control-label"><b
									class="optionalFields"> Click to add 2nd Contact Person</b> </label>
								<div class="col-md-6 inputGroupContainer">
									<div class="input-group">
										<input id="contactPerson2" name="contactPerson2"
											type="checkbox" value="true">
									</div>
								</div>
							</div> -->
							<!-- Contact Person 2 -->


							<!-- <div id="contactPerson2checkboxdiv" style="display: none"> -->

								<div class="col-sm-6">
									<br />
									<br />
									<div align="center">
										<b class="optionalFields">Contact Person 2 (Optional
											Fields)</b>
									</div>
									<!-- Text input Contact Person 2 First Name-->
									<div class="form-group">
										<label class="col-md-3 control-label">First Name</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-user"></i></span> <input
													id="firstName1" name="firstName1" placeholder="First Name"
													class="form-control" type="text">
											</div>
										</div>
									</div>
									<!-- Text input Contact Person 2 Last Name-->
									<div class="form-group">
										<label class="col-md-3 control-label">Last Name</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-user"></i></span> <input id="lastName1"
													name="lastName1" placeholder="Last Name"
													class="form-control" type="text">
											</div>
										</div>
									</div>
								</div>

								<div class="col-sm-6">
									<!-- Text input Contact Person 2 Cellphone Number-->
									<br />
									<br />
									<br />
									<div class="form-group">
										<label class="col-md-3 control-label">Cellphone No</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-earphone"></i></span> <input
													id="cellphoneNumber1" name="cellphoneNumber1"
													placeholder="Cellphone No" class="form-control" maxlength="10" type="text" onkeypress="return isNumber(event)">
											</div>
										</div>
									</div>
									<!-- Text input Contact Person 2 Tellphone Number-->
									<div class="form-group">
										<label class="col-md-3 control-label">Tellphone No</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-earphone"></i></span> <input
													id="tellphoneNumber1" name="telephoneNumber1"
													placeholder="Telephone No" class="form-control" maxlength="10" type="text" onkeypress="return isNumber(event)">
											</div>
										</div>
									</div>

									<!-- Text input Contact Person 2 Email-->
									<div class="form-group">
										<label class="col-md-3 control-label">Email</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-envelope"></i></span> <input
													id="email1" name="email1" placeholder="Email Address"
													class="form-control" type="email">
											</div>
										</div>
									</div>
								</div>
								<!--/Contact Person 2 -->

							<!-- </div> -->
							<!--/Hide Contact Person 2 -->


							<div class="form-group row">
								<div class="col-sm-offset-2 col-sm-8">
									<br> <br> <input type="submit" value="Add Customer"
										class="btn btn-primary btn-block btn-lg" tabindex="9"
										id="addClnt">
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
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
	
	<!-- /Script -->
<!-- Hide contact person 2 -->
<script type="text/javascript">
		$('#contactPerson2').change(function() {
			$('#contactPerson2checkboxdiv').toggle();
		});
</script>

		
<!-- Accept alphabetical characters only -->
<script type="text/javascript">
	function testInput(event) {
	   var value = String.fromCharCode(event.which);
	   var pattern = new RegExp(/[a-zедц ]/i);
	   return pattern.test(value);
	}

	$('#streetName').bind('keypress', testInput);

</script>

<!-- Accept numbers only -->
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

	<!-- Validate add Client -->
		<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$('#addClient').bootstrapValidator(
									{
										feedbackIcons : {
											valid : 'glyphicon glyphicon-ok',
											invalid : 'glyphicon glyphicon-remove',
											validating : 'glyphicon glyphicon-refresh'
										},
										fields : {
											customerName : {
												validators : {
													stringLength : {
														min : 2,

													},
													notEmpty : {
														message : 'Customer name is required and cannot be empty'
													},
													regexp: {
									                    regexp: /^[-_ a-zA-Z0-9]+$/,
									                    message: 'Customer name can consist of only alphabetical characters'
									                }
												}
											},
											tellphoneNumber : {
												validators : {
													notEmpty : {
														message : 'Please enter 10 digits for tellphone number'
													},
													phone : {
														country : 'US',
														message : 'Please enter 10 digits for tellphone number'
													}
												}
											},
											emailCompany : {
												validators : {
													notEmpty : {
														message : 'Company email address is required and cannot be empty'
													},
													emailAddress : {
														message : 'The email address is not valid'
													}
												}
											},
											streetNumber : {
												validators : {
													stringLength : {
														min : 1,
													},
													notEmpty : {
														message : 'Street number is required and cannot be empty'
													}
												}
											},
											streetName : {
												validators : {
													stringLength : {
														min : 3,
													},
													notEmpty : {
														message : 'Street name is required and cannot be empty'
													}
												}
											},
											
											city_town : {
												validators : {
													notEmpty : {
														stringLength : {
															min : 3,
														},
														message : 'City is required and cannot be empty'
													}
												}
											},
											province : {
												validators : {
													notEmpty : {
														message : 'Province is required and cannot be empty'
													}
												}
											},
											zipcode : {
												validators : {
													stringLength : {
														max : 4,
														min : 4,
													},
													notEmpty : {
														message : 'Zipcode is required and cannot be empty'
													}
												}
											},
											faxNumber : {
												validators : {
													phone : {
														country : 'US',
														message : 'Please enter 10 digits for fax number number '
													}
												}
											},
											email : {
												validators : {
													notEmpty : {
														message : 'Email address is required and cannot be empty'
													},
													emailAddress : {
														message : 'The email address is not valid'
													}
												}
											},
											firstName : {
												validators : {
													notEmpty : {
														stringLength : {
															min : 3,
														},
														message : 'First Name is required and cannot be empty'
													},
													regexp: {
									                    regexp: /^[a-z-A-Z]+$/,
									                    message: 'First Name can consist of only alphabetical characters'
									                }
												}
											},
											lastName : {
												validators : {
													notEmpty : {
														stringLength : {
															min : 3,
														},
														message : 'Last Name is required and cannot be empty'
													},
													regexp: {
									                    regexp: /^[a-z-A-Z]+$/,
									                    message: 'Last Name can consist of only alphabetical characters'
									                }
												}
											},
											cellphoneNumber : {
												validators : {
													notEmpty : {
														message : 'Please enter 10 digits for cellphone number'
													},
													phone : {
														country : 'US',
														message : 'Please enter 10 digits for cellphone number'
													}
												}
											},
											telephoneNumber : {
												validators : {
													notEmpty : {
														message : 'Please enter 10 digits for telephone number'
													},
													phone : {
														country : 'US',
														message : 'Please enter 10 digits for telephone number'
													}
												}
											},
											
											email : {
												validators : {
													notEmpty : {
														message : 'Email address is required and cannot be empty'
													},
													emailAddress : {
														message : 'The email address is not valid'
													}
												}
											},
											
											//Contact Person 2(Optional)
											firstName1 : {
												validators : {
													stringLength : {
														min : 3,
													},
													regexp: {
									                    regexp: /^[a-z-A-Z]+$/,
									                    message: 'First Name can consist of only alphabetical characters  '
									                }
												}
											},
											lastName1 : {
												validators : {
													stringLength : {
														min : 3,
													},
													regexp: {
									                    regexp: /^[a-z-A-Z]+$/,
									                    message: 'Last Name can consist of only alphabetical characters '
									                }
												}
											},
											cellphoneNumber1 : {
												validators : {
													phone : {
														country : 'US',
														message : 'Please enter 10 digits for cellphone number'
													}
												}
											},													
											telephoneNumber1 : {
												validators : {
													phone : {
														country : 'US',
														message : 'Please enter 10 digits for telephone number'
													}
												}
											},
											
											email1 : {
												validators : {
													emailAddress : {
														message : 'The email address is not valid'
													}
												}
											},
											
										}
									
									});
				});
</script>



</body>
</body>
</html>
