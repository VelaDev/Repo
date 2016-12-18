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
							action="saveClient" id="saveClient" modelAttribute="saveClient">
							
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
													placeholder="Customer Name" class="form-control"
													type="text">
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
													placeholder="Tellphone Number" class="form-control"
													type="text">
											</div>
										</div>
									</div>


									<!-- Text input Email-->
									<div class="form-group">
										<label class="col-md-3 control-label">Company E-Mail</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-envelope"></i></span> <input
													name="emailCompany" id="emailCompany"
													placeholder="Compnay E-Mail Address" class="form-control"
													type="text">
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
													class="form-control" type="text">
											</div>
										</div>
									</div>
								</div>
								<!-- / F Customer Fields -->

								<!--Second column Customer Fields-->
								<div class="col-sm-6">
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
													type="text">
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
													class="form-control" type="text">
											</div>
										</div>
									</div>

									<!-- Text input Street Number-->
									<div class="form-group">
										<label class="col-md-3 control-label">Street No</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-home"></i></span> <input
													name="streetNumber" id="streetNumber"
													placeholder="Street Number" class="form-control"
													type="text">
											</div>
										</div>
									</div>

								</div>
								<!--/Second column Customer Fields-->

								<!-- Contact Person 1 -->
								<div class="col-sm-6">
									<div align="center">
										<b>Contact Person 1</b>
									</div>
									<!-- Text input Contact Person First Name-->
									<div class="form-group">
										<label class="col-md-3 control-label">First Nmae</label>
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
													name="lastName" placeholder="Last Name"
													class="form-control" type="text">
											</div>
										</div>
									</div>

									<!-- Text input Contact Person 1 Email-->
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

									<!-- Text input Contact Person Cellphone Number-->
									<div class="form-group">
										<label class="col-md-3 control-label">Cellphone No</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-earphone"></i></span> <input
													id="cellphoneNumber" name="cellphoneNumber"
													placeholder="Cellphone No" class="form-control" type="text">
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
													placeholder="Tellphone No" class="form-control" type="text">
											</div>
										</div>
									</div>

								</div>
								<!-- /Contact Person 1 -->

								<!-- Contact Person 2 -->
								<div class="col-sm-6">
									<div align="center">
										<b class="optionalFields">Contact Person 2 (Optional
											Fields)</b>
									</div>

									<!-- Text input Contact Person 2 First Name-->
									<div class="form-group">
										<label class="col-md-3 control-label">First Nmae</label>
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


									<!-- Text input Contact Person 2 Cellphone Number-->
									<div class="form-group">
										<label class="col-md-3 control-label">Cellphone No</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-earphone"></i></span> <input
													id="cellphoneNumber1" name="cellphoneNumber1"
													placeholder="Cellphone No" class="form-control" type="text">
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
													id="telephoneNumber1" name="telephoneNumber1"
													placeholder="Tellphone No" class="form-control" type="text">
											</div>
										</div>
									</div>

								</div>
								<!--/Contact Person 2 -->


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
	<%-- <script type="text/javascript" src="<c:url value="/resources/custom/js/ajaxController.js"/>"></script>
 --%>
	<!-- /Script -->

	<!-- Validate add Client -->
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$('#saveClient')
									.bootstrapValidator(
											{
												feedbackIcons : {
													valid : 'glyphicon glyphicon-ok',
													invalid : 'glyphicon glyphicon-remove',
													validating : 'glyphicon glyphicon-refresh'
												},
												fields : {
													clientName : {
														validators : {
															stringLength : {
																min : 2,
															},
															notEmpty : {
																message : 'Client name is required and cannot be empty'
															}
														}
													},
													tellphoneNumber : {
														validators : {
															notEmpty : {
																message : 'Tellphone number is required and cannot be empty'
															},
															phone : {
																country : 'US',
																message : 'Please provide a vaild tellphone number'
															}
														}
													},
													emailCompany:{
														validators : {
															notEmpty : {
																message : 'Company email address is required and cannot be empty'
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
															notEmpty : {
																stringLength : {
																	min : 4,
																},
																message : 'Zipcode is required and cannot be empty'
															}
														}
													},
													faxNumber : {
														validators : {
															notEmpty : {
																message : 'Fax number is required and cannot be empty'
															},
															phone : {
																country : 'US',
																message : 'Please provide  a vaild fax number'
															}
														}
													},
													streetNumber : {
														validators : {
															stringLength : {
																min : 3,
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
															notEmpty : {
																message : 'Cell number is required and cannot be empty'
															},
															phone : {
																country : 'US',
																message : 'Please provide a vaild Cell Number with area code'
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
													}
												}
											});
						});
	</script>

</body>
</html>
