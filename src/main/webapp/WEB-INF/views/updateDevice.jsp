<%@ include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css"  >
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/bootstrap-3.3.7/css/datepicker.min.css" />">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />"  />
<%-- <link type="text/stylesheet" src="<c:url value="/resources/dynamicfields/css/extented_fields.css" />">
 --%>
<style>
li {
	list-style: none;
}
</style>

<title>Update Device | Velaphanda Trading & Projects</title>
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
							<b>Update Device </b>
						</div>
					</h3>
				</div>

				<div class="panel-body">
					<div class="tab-content">
						<form action="searchDeviceSerialNumber" method="post"
							id="searchDeviceSerialNumber">
							<div class="row">
								<!-- Text input Search-->
								<div class="form-group">
									<label class="col-md-3 control-label">Search Device </label>
									<div class="col-md-4 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-hdd"></i></span> <input
												name="serialNumber" onkeydown="upperCaseF(this)"
												id="serialNumber" class="form-control" type="text"
												placeholder='Search By Serial Number'>
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
							action="updateProduct" modelAttribute="updateProduct"
							id="updateOtherDevice">

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
													class="glyphicon glyphicon-user"></i></span> <input type="text"
													id="customerName" name="customerName" readonly="readonly"
													placeholder="Client Name" class="form-control"
													value="${productObject.customer.customerName}">
											</div>
										</div>
									</div>
								</div>
								<div class="col-sm-6">
									<!-- Text input Company Email-->
									<div class="form-group">
										<label class="col-md-3 control-label">Company Email</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-home"></i></span> <input type="text"
													id="Company Email" name="companyEmail" readonly="readonly"
													placeholder="Company Email" class="form-control"
													value="${productObject.customer.email}">
											</div>
										</div>
									</div>
								</div>

								<div class="col-sm-6">

									<div id="customer_container"
										style="width: auto; display: table;">
										<p class="customerAddress_title">Customer Address <ul class="address_list" style="display: block;">
											<li id="streetName">${productObject.customer.streetName}</li>
											<li id="streetNumber">${productObject.customer.streetNumber}</li>
											<li id="city_town">${productObject.customer.city_town}</li>
											<li id="zipcode">${productObject.customer.zipcode}</li>
										</ul></p>
										
									</div>
								</div>
								<%-- <div class="col-sm-6">
									<div id="customer_container"
										style="width: auto; display: table;">
										<p class="contactPerson_title">Contact Person</p>
										<ul class="list" style="display: block;">
											<li id="firstName">${customer.firstName }</li>
											<li id="lastName">${customer.lastName }</li>
											<li id="email">${customer.email }</li>
											<li id="cellphoneNumber">${customer.cellphoneNumber }</li>
											<li id="telephoneNumber">${customer.telephoneNumber }</li>
										</ul>
									</div>
								</div> --%>

								<br>
							</fieldset>

							<fieldset>
								<legend>Contact Person</legend>
								<!-- Contact Person  -->
								<div class="col-sm-6">

									<!-- Text input Contact Person First Name-->
									<div class="form-group">
										<label class="col-md-3 control-label">First Name</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-user"></i></span> <input id="firstName"
													name="firstName" placeholder="First Name"
													class="form-control" type="text"
													value="${productObject.contactPerson.firstName}">
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
													class="form-control" type="text"
													value="${productObject.contactPerson.lastName}">
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
													class="form-control" type="email"
													value="${productObject.contactPerson.email}">
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
													id="cellphoneNumber" name="cellphoneNumber"
													placeholder="Cellphone No" class="form-control" type="text"
													onkeypress="return isNumber(event)"
													value="${productObject.contactPerson.cellphone}">
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
													id="tellphoneNumber" name="tellphoneNumber"
													placeholder="Tellphone No" class="form-control" type="text"
													onkeypress="return isNumber(event)"
													value="${productObject.contactPerson.telephone}">

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
													class="form-control" type="text"
													value="${productObject.serialNumber}">
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
													class="form-control" type="text"
													value="${productObject.modelNumber}">
											</div>
										</div>
									</div>

									<!-- Text input Contract Start Date-->
									<div class="form-group">
										<label class="col-xs-3 control-label">Contract Start Date</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group input-append date" id="startDatePicker">
												<input type='text' class="form-control" name="startDate"
													id="startDate" placeholder="YYYY-MM-DD" value="${productObject.startDate.toString().substring(0,10) }"/> <span
													class="input-group-addon"> <span
													class="glyphicon glyphicon-calendar"></span>
												</span>
											</div>
										</div>
									</div>
									<!-- Text input Contract End Date-->
									<div class="form-group">
										<label class="col-md-3 control-label">Contract End	Date</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group input-append date" id="endDatePicker">
												<input type='text' class="form-control" name="endDate"
													id="endDate" placeholder="YYYY-MM-DD" value="${productObject.endDate.toString().substring(0,10) }" /> <span
													class="input-group-addon"> <span
													class="glyphicon glyphicon-calendar"></span>
												</span>
											</div>
										</div>
									</div>
									<!-- Text input Installation Date-->
									<div class="form-group">
										<label class="col-md-3 control-label">Installation Date</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group input-append date" id="installDatePicker">
												<input type='text' class="form-control" id="installationDate" name="installationDate"
													id="endDate" placeholder="YYYY-MM-DD" value="${productObject.installationDate.toString().substring(0,10) }"/> <span
													class="input-group-addon"> <span
													class="glyphicon glyphicon-calendar"></span>
												</span>
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
													id="colourReading" value="${productObject.colour}" //>
											</div>
											<br />
										</div>
										<!-- Text checkbox Mono Reading-->
										<div class="form-group">
											<label class="col-md-3 control-label"></label>
											<div class="col-md-6">
												<input type="text" class="form-control"
													placeholder="Enter Mono Reading" name="monoReading"
													id="monoReading" onkeypress="return isNumber(event)" value="${productObject.monoReading}" />
											</div>
										</div>
									</div>
									<!-- Text checkbox Mono Reading-->
									<div class="form-group">
										<label class="col-md-3 control-label"></label>
										<div class="col-md-6">
											<input type="text" class="form-control" name="mono"
												placeholder="Enter Mono Reading" id="mono"
												style='display: none;' onkeypress="return isNumber(event)" value="${productObject.monoReading}" />
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
													name="streetName" id="streetName" onkeypress="return onlyAlphabets(event,this);"  placeholder="Street Name"
													class="form-control" type="text"
													value="${productObject.streetName}">
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
													class="form-control" type="text"
													value="${productObject.streetName}">
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
													<option value="${productObject.province}">${productObject.province}</option>
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
													type="text" onkeypress="return isNumber(event)"
													value="${productObject.areaCode}">
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
													type="text" value="${productObject.streetNumber}">
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
											name="bridgeUnitSerialTypeSerialNo"
											value="${AccessoryObject.bridgeUnitSerialTypeSerialNo }" />
									</div>

									<div class="col-xs-2 form-control-label">
										<label for="serailNo"><input type="checkbox"
											id="faxunit" name="faxUnitSerialType" />&nbsp;Fax Unit:</label>
									</div>
									<div class="col-xs-3">
										<label for="faxunitserial">Serial Number:&nbsp;&nbsp;</label><input
											type="text" class="form-control input-sm"
											onkeydown="upperCaseF(this)" id="faxunitserial" disabled
											name="faxUnitSerialTypeSerialNo"
											value="${AccessoryObject.faxUnitSerialTypeSerialNo }" />
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
											name="OneBinTrayTypeSerialNo"
											value="${AccessoryObject.oneBinTrayTypeSerialNo }" />
									</div>

									<div class="col-xs-2 form-control-label">
										<label for="serailNo"><input type="checkbox"
											id="finisher" name="finisherType" />&nbsp;Finisher:</label>
									</div>
									<div class="col-xs-3">
										<label for="finisherserial">Serial Number:&nbsp;&nbsp;</label><input
											type="text" class="form-control input-sm"
											onkeydown="upperCaseF(this)" id="finisherserial" disabled
											name="finisherTypeSerialNo"
											value="${AccessoryObject.finisherTypeSerialNo }" />
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
											disabled value="${AccessoryObject.ltcTypeSerial }" />
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
												name="credenzaSerialNo" disabled
												value="${AccessoryObject.credenzaSerialNo }" />
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
											disabled
											value="${AccessoryObject.additionalPaperTraysTypeSerial }" />
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
									<input type="submit" value="Update Device"
										class="btn btn-primary btn-block btn-lg" tabindex="9"
										id="updateDevice">
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
	 <script type="text/javascript" src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap-datepicker.min.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.7/js/formValidation.min.js"/>"></script>	
	<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.7/js/framework/bootstrap.min.js"/>"></script>	
	<%-- <script type="text/javascript" src="<c:url value="/resources/dynamicfields/js/extented_fields.js" />"></script>
	 --%>	
	<!-- /Scripts -->


<!-- Validate update Device -->
<script>
$(document).ready(function() {
    $('#startDatePicker')
        .datepicker({
            format: 'yyyy-mm-dd'
        })
        .on('changeDate', function(e) {
            // Revalidate the start date field
            $('#updateOtherDevice').formValidation('revalidateField', 'startDate');
        });
    
   
    $('#endDatePicker')
        .datepicker({
            format: 'yyyy-mm-dd'
        })
        .on('changeDate', function(e) {
            $('#updateOtherDevice').formValidation('revalidateField', 'endDate');
        });

    $('#updateOtherDevice')
        .formValidation({
            framework: 'bootstrap',
            icon: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
            	startDate: {
                    validators: {
                        notEmpty: {
                            message: 'The start date is required'
                        },
                        date: {
                            format: 'YYYY-MM-DD',
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
                            format: 'YYYY-MM-DD',
                            min: 'startDate',
                            message: 'The end date is not a valid'
                        }
                    }
                },
                installationDate: {
                    validators: {
                        notEmpty: {
                            message: 'The end date is required'
                        },
                        date: {
                        	format: 'YYYY-MM-DD',
                            min: 'endDate',
                            message: 'The installation date is not a valid'
                        }
                    }
                },
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

				serialNumber : {
					validators : {
						stringLength : {
							min : 2,

						},
						notEmpty : {
							message : 'Serial Number is required and cannot be empty'
						}
					}
				},
				productModel : {
					validators : {
						stringLength : {
							min : 2,

						},
						notEmpty : {
							message : 'Model number is required and cannot be empty'
						}
					}
				}
			
            }
        })
        .on('success.field.fv', function(e, data) {
            if (data.field === 'startDate' && !data.fv.isValidField('endDate')) {
                // Revalidate the end date
                data.fv.revalidateField('endDate');
            }

            if (data.field === 'endDate' && !data.fv.isValidField('startDate')) {
                // Need to revalidate the start date
                data.fv.revalidateField('startDate');
            }
        });
});
</script>



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

<!-- Validate search DeviceSerialNumber -->
<script>
		$(document)
				.ready(
						function() {
							$('#searchDeviceSerialNumber')
									.formValidation({
							            framework: 'bootstrap',
							            icon: {
							                valid: 'glyphicon glyphicon-ok',
							                invalid: 'glyphicon glyphicon-remove',
							                validating: 'glyphicon glyphicon-refresh'
							            },
											fields : {
											customerName : {
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

<!-- Enable datepicker -->
<script type="text/javascript">
		$(document).ready(function() {
			$('#installationDate').datepicker({
				format : "yyyy-mm-dd"
			});
		});
</script>

<!-- Check if checkboxes are checked, if checked enable input text -->
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


</html>
