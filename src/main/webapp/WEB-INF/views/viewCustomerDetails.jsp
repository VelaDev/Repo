<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>View Customer Details | Velaphanda Trading & Projects</title>
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
		<c:import url="templates/techniciannavbar.jsp"></c:import>
		<div class="container">

		
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>View Customer</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">
					 
						<form:form class="well form-horizontal" method="post"
							action="viewCustomerDetails" modelAttribute="viewCustomerDetails"
							id="viewCustomerDetails">
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
												placeholder="Customer Name" class="form-control" type="text" value="${customer.customerName}" readonly="readonly">
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
												name="telephoneNumber" id="telephoneNumber"
												placeholder="Telephone Number" class="form-control"
												type="text" onkeypress="return isNumber(event)" readonly="readonly" value="${customer.telephoneNumber}" >
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
												class="form-control" readonly="readonly" type="text" onkeypress="return isNumber(event)" value="${customer.faxNumber}">
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
												name="email" id="email"
												placeholder="Company Email Address" readonly="readonly" class="form-control"
												type="text" value="${customer.email}" >
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
												placeholder="Street No" class="form-control" readonly="readonly" onkeypress="return isNumber(event)"  type="text" value="${customer.streetNumber}" >
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
												name="streetName" id="streetName" placeholder="Street Name"
												class="form-control" type="text" onkeypress="return onlyAlphabets(event,this);" readonly="readonly" value="${customer.streetName}" >
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
												class="form-control" type="text" readonly="readonly" value="${customer.city_town}">
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
												class="form-control selectpicker" readonly="readonly">
												<option value="${customer.province}">${customer.province}</option>
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
												type="text" onkeypress="return isNumber(event)" readonly="readonly" value="${customer.zipcode}">
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
												class="form-control" type="text" readonly="readonly" value="${customerDetails.firstName}">
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
												type="text" readonly="readonly" value="${customerDetails.lastName}">
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
												id="contactCellNumber" name="contactCellNumber"
												placeholder="Cellphone No" class="form-control" readonly="readonly" type="text" onkeypress="return isNumber(event)" value="${customerDetails.contactCellNumber}">
										</div>
									</div>
								</div>
								<!-- Text input Contact Person Tellphone Number-->
								<div class="form-group">
									<label class="col-md-3 control-label">Telephone No</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-earphone"></i></span> <input
												id="contactTelephoneNumber" name="contactTelephoneNumber"
												placeholder="Tellphone No" class="form-control" readonly="readonly" type="text" onkeypress="return isNumber(event)" value="${customerDetails.contactTelephoneNumber}">
										</div>
									</div>
								</div>

								<div class="form-group">
									<label class="col-md-3 control-label">Email</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-envelope"></i></span> <input id="contactEmail"
												name="contactEmail" placeholder="Email Address"
												class="form-control" type="email" readonly="readonly" value="${customerDetails.contactEmail}">
										</div>
									</div>
								</div>

							</div>
							
							<!-- /Contact Person 1 -->
							<!-- <div class="form-group">
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
													class="form-control" type="text" readonly="readonly" value="${customerDetails.firstName1}">
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
													class="form-control" type="text" readonly="readonly" value="${customerDetails.lastName1}">
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
													id="contactCellNumber1" name="contactCellNumber1"
													placeholder="Cellphone No" readonly="readonly" class="form-control" type="text" value="${customerDetails.contactCellNumber1}"onkeypress="return isNumber(event)">
											</div>
										</div>
									</div>
									<!-- Text input Contact Person 2 Tellphone Number-->
									<div class="form-group">
										<label class="col-md-3 control-label">Telephone No</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-earphone"></i></span> <input
													id="contactTelephoneNumber1" name="contactTelephoneNumber1"
													placeholder="Telephone No" readonly="readonly" class="form-control" type="text" value="${customerDetails.contactTelephoneNumber1}" onkeypress="return isNumber(event)">
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
													id="contactEmail1" name="contactEmail1" placeholder="Email Address"
													class="form-control" readonly="readonly" type="email" value="${customerDetails.contactEmail1}" >
											</div>
										</div>
									</div>
								</div>
								<!--/Contact Person 2 -->
							<!--/Hide Contact Person 2 -->


							<div class="form-group row">
								<!-- <div class="col-sm-offset-2 col-sm-8">
									<br> <br> <input type="submit"
										value="Update Customer"
										class="btn btn-primary btn-block btn-lg" data-confirm="You are about to update the customer information, Make sure all information is correct before updating"
										id="updateClnt">
								</div> -->
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
	
<!-- Hide contact person 2 -->
<script type="text/javascript">
		$('#contactPerson2').change(function() {
			$('#contactPerson2checkboxdiv').toggle();
		});
</script>

<!-- Accept alphabetical character only -->
<script language="Javascript" type="text/javascript">

        function onlyAlphabets(e, t) {
            try {
                if (window.event) {
                    var charCode = window.event.keyCode;
                }
                else if (e) {
                    var charCode = e.which;
                }
                else { return true; }
                if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123))
                    return true;
                else
                    return false;
            }
            catch (err) {
                alert(err.Description);
            }
        }

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
							$('#viewCustomerDetails')
									.bootstrapValidator(
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
															}
														}
													},

													tellphoneNumber : {
														validators : {
															stringLength : {
																max : 10,
																min : 10,
															},

															notEmpty : {
																message : 'Tellphone number is required and cannot be empty'
															},
															phone : {
																country : 'US',
																message : 'Please provide a vaild tellphone number'
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
															stringLength : {
																max : 10,
																min : 10,
															},/* 
															notEmpty : {
																message : 'Fax number is required and cannot be empty'
															} */
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
													firstName : {
														validators : {
															notEmpty : {
																stringLength : {
																	min : 3,
																},
																message : 'First Name is required and cannot be empty'
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
															}
														}
													},
													cellphoneNumber : {
														validators : {
															stringLength : {
																max : 10,
																min : 10,
															},
															notEmpty : {
																message : 'Cellphone Number is required and cannot be empty'
															}
														}
													},
													telephoneNumber: {
														validators : {
															stringLength : {
																max : 10,
																min : 10,
															},
															notEmpty : {
																message : 'Telephone Number is required and cannot be empty'
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
													cellphoneNumber1 : {
														validators : {
															stringLength : {
																max : 10,
																min : 10,
															},
															notEmpty : {
																message : 'Cellphone Number is required and cannot be empty'
															}
														}
													},
													telephoneNumber1 : {
														validators : {
															stringLength : {
																max : 10,
																min : 10,
															}
														}
													}
												}
											});
						});
	</script>

</body>
</html>
