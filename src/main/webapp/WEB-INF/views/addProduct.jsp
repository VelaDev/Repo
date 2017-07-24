<%@ include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Add Device | Velaphanda Trading & Projects</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/custom/css/vela_custom.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap-3.3.7/fonts/font-awesome.min.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap-3.3.7/css/datepicker.min.css" />">

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/custom/css/vela_details.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">	

<style>
li {
	list-style: none;
}

.machinetype {
	margin-left: 3%;
}

.serial {
	margin-left: 41%;
}

.customerDeviceContainer {
	padding: 25px;
	margin-bottom: -1em;
	width: auto;
	display: table;
}

p.customerAddressTitle {
	font-size: 1.1em;
	font-weight: bolder;
	margin-left: 16%;
	margin-right: -25%;
}

ul.addressDeviceList {
	margin-left: -7%;
}

input.currency {
	text-align: right;
	padding-right: 15px;
}

.resize {
	margin-left: 12%;
	margin-right: 12%;
}
</style>



</head>
<body>
	<div class="velaphanda_containter">
		<c:import url="templates/navbar.jsp"></c:import>
		<div class="container">
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Device Installation</b>
						</div>
					</h3>
				</div>

				<div class="panel-body">
					<div class="tab-content">

						<form:form class="well form-horizontal" method="POST"
							action="saveProduct" modelAttribute="saveProduct" id="addDevice">

							<!--Customer Details-->
							<fieldset>
								<legend>Customer Details</legend>

								<!--First column-->
								<div class="col-sm-6">
									<!-- Text input Client Name-->
									<div class="form-group">
										<label class="col-md-3 control-label">Customer Name</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-user"></i></span> <input
													name="customerName" placeholder="Client Name"
													readonly="readonly" class="form-control"
													value="${customer.customerName}" type="text">
											</div>
										</div>
									</div>
								</div>
								<div class="col-sm-6">
									<!-- Text input Street Name-->
									<div class="form-group">
										<label class="col-md-3 control-label">Company Email</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-home"></i></span> <input
													name="companyEmail" id="companyEmail" readonly="readonly"
													placeholder="Company Email" class="form-control"
													value="${customer.email}" type="text">
											</div>
										</div>
									</div>
								</div>

								<div class="col-sm-6">

									<div id="customerDeviceContainer"
										style="width: auto; display: table;">
										<div class="customerDeviceAddressTitle">
											<p class="customerAddressTitle">Customer Address</p>
											<ul class="addressDeviceList" style="display: block;">
												<li id="streetName">${customer.streetNumber}
													${customer.streetName}</li>
												<li id="city_town">${customer.city_town}</li>
												<li id="zipcode">${customer.zipcode}</li>
											</ul>
										</div>
									</div>
								</div>
								<br />

							</fieldset>
							<!--Customer Details-->


							<!-- Contact Person  -->
							<fieldset>
								<legend>Contact Person</legend>

								<!--First Column-->
								<div class="col-sm-6">
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

								</div>
								<!--//First Column-->

								<!--Second Column-->
								<div class="col-sm-6">
									<!-- Text input Contact Person Cellphone Number-->
									<div class="form-group">
										<label class="col-md-3 control-label">Cellphone No</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-earphone"></i></span> <input
													id="cellphoneNumber" maxlength="10" name="cellphone"
													placeholder="Cellphone No" class="form-control" type="text"
													onkeypress="return isNumber(event)">
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
													id="telephoneNumber" maxlength="10" name="telephone"
													placeholder="Telephone No" class="form-control" type="text"
													onkeypress="return isNumber(event)">
											</div>
										</div>
									</div>
								</div>
								<!--/Second Column-->

							</fieldset>
							<!-- /Contact Person  -->

							<!-- /Machine Details  -->
							<fieldset>
								<legend>Machine Details</legend>

								<!--First Column-->
								<div class="col-md-6">

									<!-- Text input Serial No-->
									<div class="form-group">
										<label class="col-md-3 control-label">Serial No</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-barcode"></i></span> <input
													name="serialNumber" id="serialNumber"
													onkeydown="upperCaseF(this)" placeholder="Serial Number"
													class="form-control" type="text">
											</div>
										</div>
									</div>
									<!-- Text input Machine Model-->
									<div class="form-group">
										<label class="col-md-3 control-label">Model No</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-barcode"></i></span> <input
													name="modelNumber" onkeydown="upperCaseF(this)"
													id="modelNumber" placeholder="Model Number"
													class="form-control" type="text">
											</div>
										</div>
									</div>

									<!-- Select type Brand-->
									<div class="form-group">
										<label class="col-md-3 control-label">Brand</label>
										<div class="col-md-6 selectContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-list"></i></span> <select
													id="modelBrand" name="modelBrand" class="form-control">
													<option value="">Select Brand</option>
													<option value="Samsung">Samsung</option>
													<option value="Canon">Canon</option>
													<option value="Oce">Oce</option>
													<option value="HP">HP</option>
													<option value="Kyocera">Kyocera</option>
													<option value="Nasua">Nasua</option>
													<option value="Ricoh">Ricoh</option>
													<option value="Toshiba">Toshiba</option>													

												</select>
											</div>
										</div>
									</div>

									<!-- Text input Contract Start Date-->
									<div class="form-group ">
										<label class="col-xs-3 control-label">Contract Start
											Date</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group input-append date"
												id="startDatePicker">
												<input type="text" class="form-control" name="startDate"
													id="startDate" placeholder="YYYY-MM-DD"> <span
													class="input-group-addon"> <span
													class="glyphicon glyphicon-calendar"></span>
												</span>
											</div>
										</div>
									</div>

									<!-- Text input Contract End Date-->
									<div class="form-group">
										<label class="col-md-3 control-label">Contract End
											Date</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group input-append date" id="endDatePicker">
												<input type="text" class="form-control" name="endDate"
													id="endDate" placeholder="YYYY-MM-DD"> <span
													class="input-group-addon"> <span
													class="glyphicon glyphicon-calendar"></span>
												</span>
											</div>
										</div>
									</div>
									<!-- Text input Installation Date-->
									<div class="form-group">
										<label class="col-md-3 control-label">Installation
											Date</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group input-append date"
												id="installDatePicker">
												<input type="text" class="form-control"
													id="installationDate" name="installationDate"
													placeholder="YYYY-MM-DD"> <span
													class="input-group-addon"> <span
													class="glyphicon glyphicon-calendar"></span>
												</span>
											</div>
										</div>
									</div>
									<!-- Select type Mono/Colour-->
									<div class="form-group">
										<label class="col-md-3 control-label">Mono/Colour</label>
										<div class="col-md-6 selectContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-list"></i></span> <select
													id="monocolour" name="colour" class="form-control"
													onchange="CheckColors(this.value);">
													<option value="">Select Mono/Colour</option>
													<option value="mono">Mono</option>
													<option value="colour">Colour</option>
												</select>
											</div>
										</div>
									</div>

									<!-- Both mono and colour reading  -->
									<div class="colour" id="colour" style="display: none;">

										<!-- Text checkbox Colour Reading-->
										<div class="form-group">
											<label class="col-md-3 control-label">Colour Reading</label>
											<div class="col-md-6">
												<input type="text" class="form-control"
													onkeypress="return isNumber(event)"
													placeholder="Enter Colour Reading" id="colour"
													name="colourReading">
											</div>
											<br>
										</div>

										<!-- Text checkbox Colour Copy Cost-->
										<div class="form-group">
											<label class="col-md-3 control-label">Colour Copy
												Cost</label>
											<div class="col-md-6">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon">$</i></span> <input type="number"
														min="0" step="0.01" data-number-to-fixed="2"
														data-number-stepfactor="100" class="form-control currency"
														placeholder="Enter Colour Copy Cost" id="colour"
														name="colourCopyCost" />
												</div>
											</div>
											<br>
										</div>

									</div>
									<!-- Both mono and colour reading  -->

									<!-- Only mono Reading -->
									<!-- Text checkbox Mono Reading-->
									<div class="mono" id="mono" style="display: none;">
									
										<div class="form-group">
											<label class="col-md-3 control-label">Mono Reading</label>
											<div class="col-md-6">
												<input type="text" class="form-control"
													onkeypress="return isNumber(event)" id="mono"
													name="monoReading" placeholder="Enter Mono Reading">
											</div>
										</div>

										<!-- Text checkbox Mono Copy Cost-->
										<div class="form-group">
											<label class="col-md-3 control-label">Mono Copy Cost</label>
											<div class="col-md-6">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon">$</i></span> <input type="number"
														min="0" step="0.01" data-number-to-fixed="2"
														data-number-stepfactor="100" class="form-control currency"
														placeholder="Enter Mono Copy Cost" id="colour"
														name="monoCopyCost">
												</div>
											</div>
											<br>
										</div>

									</div>
									<!-- //Only mono Reading -->

								</div>
								<!--/First Column-->

								<!--Second column-->
								<div class="col-sm-6">

									<!-- Text input Building Name-->
									<div class="form-group">
										<label class="col-md-3 control-label">Building Name</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-home"></i></span> <input
													name="buildingName" id="buildingName"
													placeholder="Building Name" class="form-control"
													type="text">
											</div>
										</div>
									</div>
									<!-- Text input Floor Number-->
									<div class="form-group">
										<label class="col-md-3 control-label">Floor Number</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-home"></i></span> <input
													name="floorNumber" id="floorNumber"
													placeholder="Floor Number" maxlength="4"
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
									<!--/S Street Number-->
									<!-- Text input Street Name-->
									<div class="form-group">
										<label class="col-md-3 control-label">Street Name</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-home"></i></span> <input
													id="streetName" name="streetName" placeholder="Street Name"
													class="form-control" type="text">
											</div>
										</div>
									</div>

									<!-- Text input City or Town-->
									<div class="form-group ">
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
									<div class="form-group ">
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
													<option value="Western Cape">Western Cape</option>
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
													id="zipcode" placeholder="Area Code" maxlength="4"
													class="form-control" type="text"
													onkeypress="return isNumber(event)">
											</div>
										</div>
									</div>

								</div>

							</fieldset>
							<!-- /Machine Details  -->


						<!--Machine Accessories-->
							<fieldset>
								<legend align="left">Machine Accessories</legend>

								<div class="tablemachinesacccso">
									<table id="accessories" class="table table-striped table-bordered table-hover table-condensed">
										
										<thead>
											<tr>
												<th>Machine Type</th>
												<th>Serial Number</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td><input type="checkbox" id="bridgeunitserial"
													name="bridgeUnitSerialType" value="Bridge unit"> Bridge unit</td>
												<td><input type="text" class="form-control"
													onkeydown="upperCaseF(this)" id="bridgeunit"
													name="bridgeUnitSerialTypeSerialNo" disabled="disabled"></td>
											</tr>
											<tr>
												<td><input type="checkbox" class="select" id="finisher"
													name="finisherType" value="Finisher"> Finisher</td>
												<td><input type="text" class="form-control"
													onkeydown="upperCaseF(this)" id="finisherserial"
													name="finisherTypeSerialNo" disabled="disabled"></td>
											</tr>
											<tr>
												<td><input type="checkbox" class="select" id="faxunit"
													name="faxUnitSerialType"> Fax Unit</td>
												<td><input type="text" class="form-control"
													onkeydown="upperCaseF(this)" id="faxunitserial"
													name="faxUnitSerialTypeSerialNo" disabled="disabled"></td>
											</tr>
											<tr>
												<td><input type="checkbox" class="select"
													id="onebintrayserial" name="oneBinSerialType"> One
													bin tray</td>
												<td><input type="text" class="form-control"
													onkeydown="upperCaseF(this)" id="onebintray"
													name="OneBinTrayTypeSerialNo" disabled="disabled"></td>
											</tr>
											<tr>
												<td><input type="checkbox" class="select"
													id="ltcserial" name="ltcType"> LCT</td>
												<td><input type="text" class="form-control"
													onkeydown="upperCaseF(this)" id="lct" name="ltcTypeSerial"
													disabled="disabled"></td>
											</tr>
											<tr>
												<td><input type="checkbox" class="select"
													id="creserial" name="creType"> Credenza</td>
												<td><input type="text" class="form-control"
													onkeydown="upperCaseF(this)" id="cre" name="creTypeserial"
													disabled="disabled"></td>
											</tr>
											<tr>
												<td><input type="checkbox" class="select"
													id="addserial" name="addType"> Additional paper
													trays</td>
												<td><input type="text" class="form-control"
													onkeydown="upperCaseF(this)" id="add" name="addTypeserial"
													disabled="disabled"></td>
											</tr>
										</tbody>
									</table>
								</div>

								<!-- Other Machine Accessories -->
								<div class="others" id="others">
									<div class="col-sm-12">
										<div class="resize">
											<h5>Other Machine Accessories</h5>
											<p>
												<input type="button" class="btn btn-success"
													value="Add More">
											</p>
											<table id="addOtherMachineAccessories"
												class="table table-striped table-bordered table-hover table-condensed">
												<thead>
													<tr>
														<th>Machine Type</th>
														<th>Serial Number</th>
														<th>Delete</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td><input type="text" class="form-control"
															id="machineType" name="machineType"
															placeholder="Machine Accessory Type" /></td>
														<td><input type="text" class="form-control"
															id="serialNumberOtherAccessory"
															name="serialNumberOtherAccessory"
															onkeydown="upperCaseF(this)" placeholder="Serial Number" />
														</td>
														<td><input type="button" id="remove" name="remove" class="btn btn-danger"
															value="Remove"></td>
													</tr>
													<tbody>
											
											</table>					
										</div>
									</div>									
								</div><!-- //Other Machine Accessories -->
								
							</fieldset>
							<!--//Machine Accessories-->

							<div class="form-group row">
								<div class="col-sm-offset-2 col-sm-8">
									<br>
									<br> <input type="submit" id="addProduct"
										name="addProduct" value="Add Device"
										class="btn btn-primary btn-block btn-lg" tabindex="9"
										id="updateProduct">
								</div>
							</div> 
							
							
						</form:form>
						<!-- /form-content -->
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

	<!-- Scripts -->
	<script type="text/javascript"
		src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
		<script type="text/javascript"
	src="<c:url value="/resources/jquery/1.13.1/jquery.validate.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap-datepicker.min.js" />"></script>

	<!-- Datatables -->
	<script type="text/javascript"
		src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>
	<!-- //Datatables -->
	
	<script type="text/javascript" src="<c:url value="/resources/custom/js/velas_validations.js"/>"></script>
	
	<!--  myDatatable table -->
	<script type="text/javascript">	
	$(document).ready(function() {
	$('#accessoriesTable').DataTable({
		"jQueryUI" : true,
		"pagingType" : "full_numbers",
		"lengthMenu" : [ [ 7, 10, 50, -1 ], [ 7, 10, 50, "All" ] ]
	/* few more options are available to use */
		});
	});
	</script>
	<!-- myDatatable table  -->
	
	
	<!-- /Scripts -->


</body>

</html>
