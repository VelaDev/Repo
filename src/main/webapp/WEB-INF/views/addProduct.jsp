<%@ include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
<link
	href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />"
	rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link type="text/stylesheet"
	src="<c:url value="/resources/custom/css/vela_custom.css" />">
<link type="text/stylesheet"
	src="<c:url value="/resources/dynamicfields/css/extented_fields.css" />">

<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css"
	rel="stylesheet">

<style>
li {
	list-style: none;
}
</style>

<title>Add Product | Velaphanda Trading & Projects</title>
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
							<b>Device Installation</b>
						</div>
					</h3>
				</div>

				<div class="panel-body">
					<div class="tab-content">
						<form action="searchClientforProduct" method="post"
							id="searchClientforProduct">
							<div class="row">
								<!-- Text input Search-->
								<div class="form-group">
									<label class="col-md-3 control-label">Search Client </label>
									<div class="col-md-4 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-user"></i></span> <input
												name="customerName" id="clientName" class="form-control"
												type="text" placeholder='Search By Client Name'>
										</div>
									</div>
									<div class="col-md-2">
										<input class="btn btn-success" type='submit' value='Search' />
									</div>
								</div>
							</div>
							<hr>
						</form>
						<!--Search-->
						<form:form class="well form-horizontal" method="POST"
							action="saveProduct" modelAttribute="saveProduct"
							id="addOtherDevice">

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
													class="form-control" value="${customer.customerName}"
													type="text">
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
													name="companyEmail" id="companyEmail"
													placeholder="Company Email" class="form-control"
													value="${customer.email}" type="text">
											</div>
										</div>
									</div>
								</div>

								<div class="col-sm-6">

									<div id="customer_container"
										style="width: auto; display: table;">
										<p class="customerAddress_title">Customer Address</p>
										<ul class="address_list" style="display: block;">
											<li id="streetName">${customer.streetName}</li>
											<li id="streetNumber">${customer.streetNumber}</li>
											<li id="city_town">${customer.city_town}</li>
											<li id="zipcode">${customer.zipcode}</li>
										</ul>
									</div>
								</div>
								<%-- <div class="col-sm-6">
									<div id="customer_container"
										style="width: auto; display: table;">
										<p class="contactPerson_title">Contact Person</p>
										<ul class="list" style="display: block;">
											<li id="firstName">${customerContact.firstName }</li>
											<li id="lastName">${customerContact.lastName }</li>
											<li id="email">${customerContact.email }</li>
											<li id="cellphoneNumber">${customerContact.cellphoneNumber }</li>
											<li id="telephoneNumber">${customerContact.telephoneNumber }</li>
										</ul>
									</div>
								</div> --%>
							</fieldset>

							<fieldset>
								<legend>Contact Person</legend>
								<!-- Contact Person  -->
								<div class="col-sm-6">

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
								</div>

								<div class="col-sm-6">

									<!-- Text input Contact Person Cellphone Number-->
									<div class="form-group">
										<label class="col-md-3 control-label">Cellphone No</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-earphone"></i></span> <input
													id="cellphone" name="cellphone" placeholder="Cellphone No"
													class="form-control" type="text">
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
													id="telephone" name="telephone" placeholder="Tellphone No"
													class="form-control" type="text">
											</div>
										</div>
									</div>

								</div>
								<!-- /Contact Person  -->



							</fieldset>
							<br>
							<br>

							<fieldset>
								<legend>Machine Details</legend>
								<br>
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
													name="productModel" placeholder="Model Number"
													class="form-control" type="text">
											</div>
										</div>
									</div>



									<!-- Text input Contract Start Date-->
									<div class="form-group">
										<label class="col-md-3 control-label">Contract Start
											Date</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-calendar"></i></span> <input
													name="startDate" id="startDate" placeholder="YYYY-MM-DD"
													class="form-control" type="text">
											</div>
										</div>
									</div>
									<!-- Text input Contract End Date-->
									<div class="form-group">
										<label class="col-md-3 control-label">Contract End
											Date</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-calendar"></i></span> <input
													name="endDate" id="endDate" placeholder="YYYY-MM-DD"
													class="form-control" type="text">
											</div>
										</div>
									</div>
									<!-- Text input Installation Date-->
									<div class="form-group">
										<label class="col-md-3 control-label">Installation
											Date</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-calendar"></i></span> <input
													name="installationDate" id="installationDate"
													placeholder="YYYY-MM-DD" class="form-control" type="text">
											</div>
										</div>
									</div>

									<!-- Select type Mono/Colour-->
									<div class="form-group">
										<label class="col-md-3 control-label">Mono/Color</label>
										<div class="col-md-6 selectContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-list"></i></span><select name="colour"
													class="form-control" onchange='CheckColors(this.value);'
													class="form-control selectpicker">
													<option>Select Mono/Color</option>
													<option value="mono">Mono</option>
													<option value="colour">Color</option>
												</select>
											</div>
										</div>
									</div>


									<div id="colour" style='display: none;'>
										<!-- Text checkbox Colour Reading-->
										<div class="form-group">
											<label class="col-md-3 control-label"></label>
											<div class="col-md-6">
												<input type="text" class="form-control"
													placeholder="Enter Colour Reading" name="colourReading"
													id="colourReading" />
											</div>
											<br />
										</div>
										<!-- Text checkbox Mono Reading-->
										<div class="form-group">
											<label class="col-md-3 control-label"></label>
											<div class="col-md-6">
												<input type="text" class="form-control"
													placeholder="Enter Mono Reading" name="monoReading"
													id="monoReading" />
											</div>
										</div>
									</div>
									<!-- Text checkbox Mono Reading-->
									<div class="form-group">
										<label class="col-md-3 control-label"></label>
										<div class="col-md-6">
											<input type="text" class="form-control" name="mono"
												placeholder="Enter Mono Reading" id="mono"
												style='display: none;' />
										</div>
									</div>

								</div>
								<!--/F Column-->

								<!--Second column-->
								<div class="col-sm-6">


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
								<!--/S Column-->

							</fieldset>

							<br>
							<br>
							<fieldset>
								<legend align="left">Machine Accessories</legend>
								<div class="row">
									<div class="col-xs-2 form-control-label">
										<label for="serailNo"><input type="checkbox"
											id="bridgeunitserial" name="bridgeUnitSerialType" />&nbsp;Bridge
											unit</label>
									</div>
									<div class="col-xs-3">
										<label for="bridgeunit">Serial Number:&nbsp;&nbsp;</label><input
											type="text" class="form-control input-sm"
											onkeydown="upperCaseF(this)" id="bridgeunit" disabled
											name="bridgeUnitSerialTypeSerialNo" />
									</div>

									<div class="col-xs-2 form-control-label">
										<label for="serailNo"><input type="checkbox"
											id="faxunit" name="faxUnitSerialType" />&nbsp;Fax Unit:</label>
									</div>
									<div class="col-xs-3">
										<label for="faxunitserial">Serial Number:&nbsp;&nbsp;</label><input
											type="text" class="form-control input-sm"
											onkeydown="upperCaseF(this)" id="faxunitserial" disabled
											name="faxUnitSerialTypeSerialNo" />
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-xs-2 form-control-label">
										<label for="serailNo"><input type="checkbox"
											id="onebintrayserial" name="bridgeUnitSerialType" />&nbsp;One
											bin tray</label>
									</div>
									<div class="col-xs-3">
										<label for="onebintray">Serial Number:&nbsp;&nbsp;</label><input
											type="text" class="form-control input-sm"
											onkeydown="upperCaseF(this)" id="onebintray" disabled
											name="OneBinTrayTypeSerialNo" />
									</div>

									<div class="col-xs-2 form-control-label">
										<label for="serailNo"><input type="checkbox"
											id="finisher" name="finisherType" />&nbsp;Finisher:</label>
									</div>
									<div class="col-xs-3">
										<label for="finisherserial">Serial Number:&nbsp;&nbsp;</label><input
											type="text" class="form-control input-sm"
											onkeydown="upperCaseF(this)" id="finisherserial" disabled
											name="finisherTypeSerialNo" />
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-xs-2 form-control-label">
										<label for="serailNo"><input type="checkbox"
											id="ltcserial" name="ltcType" />&nbsp;LCT</label>
									</div>
									<div class="col-xs-3">
										<label for="ltc">Serial Number:&nbsp;&nbsp;</label><input
											type="text" class="form-control input-sm"
											onkeydown="upperCaseF(this)" id="ltc" name="ltcTypeSerial"
											disabled />
									</div>


									<div class="row">
										<div class="col-xs-2 form-control-label">
											<label for="serailNo"><input type="checkbox"
												id="credenzaserial" name="credenza" />&nbsp;Credenza</label>
										</div>
										<div class="col-xs-3">
											<label for="credenza">Serial Number:&nbsp;&nbsp;</label><input
												type="text" class="form-control input-sm"
												onkeydown="upperCaseF(this)" id="credenza"
												name="credenzaSerialNo" disabled />
										</div>

									</div>
									<br>
									<div class="col-xs-2 form-control-label">
										<label for="serailNo"><input type="checkbox"
											id="additionalPaperTrays" name="additionalPaperTrays" />&nbsp;&nbsp;Additional
											paper trays:</label>
									</div>
									<div class="col-xs-3">
										<label for="additionalserial">Serial
											Number:&nbsp;&nbsp;</label><input type="text"
											class="form-control input-sm" onkeydown="upperCaseF(this)"
											id="additionalserial" name="additionalPaperTraysTypeSerial"
											disabled />
									</div>
								</div>

								<br /> <br />
								<div class="row">

									<div class="form-group">
										<label class="col-xs-1 control-label">Others</label>
										<div class="col-xs-4">
											<input type="text" class="form-control" name="machinetype"
												placeholder="Machine Accessory Type" />
										</div>
										<div class="col-xs-4">
											<input type="text" class="form-control"
												onkeydown="upperCaseF(this)" id="serialNumber"
												name="serialNumberM" placeholder="Serial Number" />
										</div>
										<div class="col-xs-1">
											<button type="button" class="btn btn-default addButton">
												<i class="fa fa-plus"></i>
											</button>
										</div>
									</div>

									<!-- The template for adding new field -->
									<div class="form-group hide" id="deviceNewFields">
										<div class="col-xs-4 col-xs-offset-1">
											<input type="text" class="form-control" name="machinetype"
												placeholder="Machine Accessory Type" />
										</div>
										<div class="col-xs-4">
											<input type="text" class="form-control"
												onkeydown="upperCaseF(this)" id="serialNumber"
												name="serialNumberM" placeholder="Serial Number" />
										</div>

										<div class="col-xs-1">
											<button type="button" class="btn btn-default removeButton">
												<i class="fa fa-minus"></i>
											</button>
										</div>
									</div>

								</div>


							</fieldset>
							<br>
							<br>
							<br>
							<div class="form-group row">
								<div class="col-sm-offset-2 col-sm-8">
									<input type="submit" value="Add Device"
										class="btn btn-primary btn-block btn-lg" tabindex="9"
										id="addProduct">
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
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap-datepicker.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/dynamicfields/js/extented_fields.js" />"></script>

	<!-- /Script -->

	<!--Mono and Colour Selection-->
	<script type="text/javascript">

	function CheckColors(val){
	 var element=document.getElementById('mono');
	 if(val=='pick a mono'||val=='mono')
	   element.style.display='block';
	 else  
	   element.style.display='none';
	   
	  var element=document.getElementById('colour');
	 if(val=='pick a colour'||val=='colour')
	   element.style.display='block';
	 else  
	   element.style.display='none';
	   
	}

</script>

	<script>
		$(document)
				.ready(
						function() {
							$('#searchClientforProduct')
									.bootstrapValidator(
											{
												container : '#messages',
												feedbackIcons : {
													valid : 'glyphicon glyphicon-ok',
													invalid : 'glyphicon glyphicon-remove',
													validating : 'glyphicon glyphicon-refresh'
												},
												fields : {
													clientName : {
														validators : {
															notEmpty : {
																message : 'Client name is required to search and cannot be empty'
															}
														}
													},
												}
											});
						});
</script>

	<!-- Make all Serials numbers UpperCase  -->
	<script type="text/javascript">
	function upperCaseF(a){
	    setTimeout(function(){
	        a.value = a.value.toUpperCase();
	    }, 1);
	}
	</script>

	<script type="text/javascript">
		$(document).ready(function() {
			$('#startDate').datepicker({
				format : "yyyy-mm-dd"
			});
		});
	</script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#endDate').datepicker({
				format : "yyyy-mm-dd"
			});
		});
	</script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#installationDate').datepicker({
				format : "yyyy-mm-dd"
			});
		});
	</script>
	<script type="text/javascript">
		document.getElementById('bridgeunitserial').onchange = function() {
			document.getElementById('bridgeunit').disabled = !this.checked;
		};
		document.getElementById('faxunit').onchange = function() {
			document.getElementById('faxunitserial').disabled = !this.checked;
		};
		document.getElementById('onebintrayserial').onchange = function() {
			document.getElementById('onebintray').disabled = !this.checked;
		};
		document.getElementById('finisher').onchange = function() {
			document.getElementById('finisherserial').disabled = !this.checked;
		};
		document.getElementById('ltcserial').onchange = function() {
			document.getElementById('ltc').disabled = !this.checked;
		};
		document.getElementById('additionalPaperTrays').onchange = function() {
			document.getElementById('additionalserial').disabled = !this.checked;
		};
		document.getElementById('credenzaserial').onchange = function() {
			document.getElementById('credenza').disabled = !this.checked;
		};
	</script>


	<!-- Other new fields -->
	<script>
		$(document)
				.ready(
						function() {

									/*  machinetypeValidators = {
										row : '.col-xs-4',
										validators : {
											 stringLength : {
												min : 2,
											},
											notEmpty : {
												message : 'Machine Accessory Type can not be empty'
											} 
										}
									},
									serialNumberValidators = {
										row : '.col-xs-2',
										validators : {
											 stringLength : {
												min : 2,
											},
											notEmpty : {
												message : 'Serial Number can not be empty'
											} 
										}
									}, */  deviceIndex = 0;

							$('#addOtherDevice')
									/* .formValidation(
											{
												framework : 'bootstrap',
												icon : {
													valid : 'glyphicon glyphicon-ok',
													invalid : 'glyphicon glyphicon-remove',
													validating : 'glyphicon glyphicon-refresh'
												},
												fields : {
													'machinetype' : machinetypeValidators,
													'serialNumber' : serialNumberValidators
												}
											})
 									*/
									// Add button click handler
									.on(
											'click',
											'.addButton',
											function() {
												deviceIndex++;
												var $template = $('#deviceNewFields'), $clone = $template
														.clone()
														.removeClass('hide')
														.removeAttr('id')
														.attr(
																'data-device-index',
																deviceIndex)
														.insertBefore($template);

												// Update the name attributes
												$clone
														.find(
																'[name="machinetype"]')
														.attr(
																'name',
																'device['
																		+ deviceIndex
																		+ '].machinetype')
														.end()
														.find(
																'[name="serialNumber"]')
														.attr(
																'name',
																'device['
																		+ deviceIndex
																		+ '].serialNumber')
														.end();

												// Add new fields
												// Note that we also pass the validator rules for new field as the third parameter
												/* $('#addOtherDevice')
														.formValidation(
																'addField',
																'device['
																		+ deviceIndex
																		+ '].machinetype',
																machinetypeValidators)
														.formValidation(
																'addField',
																'device['
																		+ deviceIndex
																		+ '].serialNumber',
																serialNumberValidators); */

											})

									// Remove button click handler
									.on(
											'click',
											'.removeButton',
											function() {
												var $row = $(this).parents(
														'.form-group'), index = $row
														.attr('data-book-index');

												// Remove fields
												$('#addOtherDevice')
														.formValidation(
																'removeField',
																$row
																		.find('[name="book['
																				+ index
																				+ '].machinetype"]'))
														.formValidation(
																'removeField',
																$row
																		.find('[name="book['
																				+ index
																				+ '].serialNumber"]'));

												// Remove element containing the fields
												$row.remove();
											});
						});
	</script>

	<script>
		$(document).ready(
				function() {
					$('#addOtherDevice').on(
							'added.field.fv removed.field.fv',
							function(e, data) {
								var $body = $('body'), $iframe = $body
										.data('iframe.fv');
								if ($iframe) {
									// Adjust the height of iframe
									$iframe.height($body.height());
								}
							});
				});
	</script>
	<script type="text/javascript">
	
	 $('#startDate')
        .datepicker({
            format: 'mm/dd/yyyy'
        })
        .on('changeDate', function(e) {
            // Revalidate the start date field
            $('#eventForm').formValidation('revalidateField', 'startDate');
        });

    $('#endDate')
        .datepicker({
            format: 'mm/dd/yyyy'
        })
        .on('changeDate', function(e) {
            $('#eventForm').formValidation('revalidateField', 'endDate');
        });

    $('.dateCompare')
        .formValidation({
            framework: 'bootstrap',
            icon: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                name: {
                    validators: {
                        notEmpty: {
                            message: 'The name is required'
                        }
                    }
                },
                startDate: {
                    validators: {
                        notEmpty: {
                            message: 'The start date is required'
                        },
                        date: {
                            format: 'MM/DD/YYYY',
                            max: 'endDate',
                            message: 'The start date is not a valid'
                        }
                    }
                },
                endDate: {
                    validators: {
                        notEmpty: {
                            message: 'The end date is required'
                        },
                        date: {
                            format: 'MM/DD/YYYY',
                            min: 'startDate',
                            message: 'The end date is not a valid'
                        }
                    }
                }
            }
        })
        .on('success.field.fv', function(e, data) {
            if (data.field === 'startDate' && !data.fv.isValidField('endDate')) {
                // We need to revalidate the end date
                data.fv.revalidateField('endDate');
            }

            if (data.field === 'endDate' && !data.fv.isValidField('startDate')) {
                // We need to revalidate the start date
                data.fv.revalidateField('startDate');
            }
        });
});

</script>
</html>
