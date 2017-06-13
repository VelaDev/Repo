<%@ include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Update Device | Velaphanda Trading & Projects</title>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/css" rel="stylesheet" href="<c:url value="/resources/custom/css/vela_custom.css" />">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">	
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">
  
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/custom/css/vela_custom.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap-3.3.7/fonts/font-awesome.min.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap-3.3.7/css/datepicker.min.css" />">
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
	margin-left: 23%;
    margin-right: -25%;
}

ul.addressDeviceList {
	margin-left: -7%;
}
input.currency {
    text-align: right;
    padding-right: 15px;
}
.resize{
	margin-left: 12%;
    margin-right: 12%;
}
</style>

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

						<!--Search-->
						<form:form class="well form-horizontal" method="POST"
							action="updateProduct" modelAttribute="updateProduct"
							id="updateDevice">

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
													value="${productObject.customerDevice.customerName}">
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
													id="Company Email" companyEmail id="companyEmail"
													name="companyEmail" readonly="readonly"
													placeholder="Company Email" class="form-control"
													value="${productObject.customerDevice.email}">
											</div>
										</div>
									</div>
								</div>

								<div class="col-sm-6">

									<div id="customerDeviceContainer"
										style="width: auto; display: table;">
										<div class="customerDeviceAddressTitle"><p class="customerAddressTitle">Customer Address</p>
											<ul class="addressDeviceList" style="display: block;">
												<li id="streetName">${productObject.customerDevice.streetNumber}
													${productObject.customerDevice.streetName}</li>
												<li id="city_town">${productObject.customerDevice.city_town}</li>
												<li id="zipcode">${productObject.customerDevice.zipcode}</li>
											</ul>
										</div>
									</div>
								</div>

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
													id="cellphoneNumber" name="cellphone"
													placeholder="Cellphone No" maxlength="10"
													class="form-control" type="text"
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
													id="tellphoneNumber" name="telephone"
													placeholder="Tellphone No" maxlength="10"
													class="form-control" type="text"
													onkeypress="return isNumber(event)"
													value="${productObject.contactPerson.telephone}">

											</div>
										</div>
									</div>

								</div>
								<!-- /Contact Person  -->

							</fieldset>


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
													onkeydown="upperCaseF(this)" readonly="readonly"
													placeholder="Serial Number" class="form-control"
													type="text" value="${productObject.serialNumber}">
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
													name="modelNumber" id="modelNumber"
													onkeydown="upperCaseF(this)" placeholder="Model Number"
													class="form-control" type="text"
													value="${productObject.modelNumber}" readonly>
											</div>
										</div>
									</div>

									<!-- Select type Brand-->
									<div class="form-group">
										<label class="col-md-3 control-label">Brand</label>
										<div class="col-md-6 selectContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-list"></i></span> <select id="modelBrand"
													name="modelBrand" class="form-control">
													<option value="${productObject.modelBrand}">${productObject.modelBrand}</option>
													<option value="Samsung">Samsung</option>
													<option value="Canon">Canon</option>
													<option value="Oce">Oce</option>
													<option value="HP">HP</option>													
													<option value="Kyocera">Kyocera</option>
													<option value="Nasua">Nasua</option>
													<option value="Rico">Rico</option>
													<option value="Riso">Riso</option>
												</select>
											</div>
										</div>
									</div>

									<!-- Text input Contract Start Date-->
									<div class="form-group">
										<label class="col-xs-3 control-label">Contract Start
											Date</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group input-append date"
												id="startDatePicker">
												<input type='text' class="form-control" name="startDate"
													id="startDate" placeholder="YYYY-MM-DD"
													value="${productObject.startDate.toString().substring(0,10) }" />
												<span class="input-group-addon"> <span
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
												<input type='text' class="form-control" name="endDate"
													id="endDate" placeholder="YYYY-MM-DD"
													value="${productObject.endDate.toString().substring(0,10) }" />
												<span class="input-group-addon"> <span
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
												<input type='text' class="form-control"
													id="installationDate" name="installationDate" id="endDate"
													placeholder="YYYY-MM-DD"
													value="${productObject.installationDate.toString().substring(0,10) }" />
												<span class="input-group-addon"> <span
													class="glyphicon glyphicon-calendar"></span>
												</span>
											</div>
										</div>
									</div>
									<c:if test="${not empty productObject.monoReading }">
									  <div class="form-group">
											<label class="col-md-3 control-label">Mono Reading</label>
											<div class="col-md-6">
												<input type="text" class="form-control"
													onkeypress="return isNumber(event)" id="mono"
													name="monoReading" placeholder="Enter Mono Reading"
													value="${productObject.monoReading}">
											</div>
										</div>
										<div class="form-group">
											<label class="col-md-3 control-label">Mono Copy Cost</label>
											<div class="col-md-6">
												<div class="input-group">
													<span class="input-group-addon"><i
														class="glyphicon glyphicon">$</i></span>
													<input type="number" min="0" step="0.01" data-number-to-fixed="2" data-number-stepfactor="100" class="form-control currency"
													placeholder="Enter Mono Copy Cost" id="colour"
													name="monoCopyCost" value="${productObject.monoCopyCost}">
												</div>
											</div>
											<br>
										</div>
									</c:if>
									<c:if test="${not empty productObject.colourReading}">
									  <!-- Text checkbox Colour Reading-->
										<div class="form-group">
											<label class="col-md-3 control-label">Colour Reading</label>
											<div class="col-md-6">
												<input type="text" class="form-control"
													onkeypress="return isNumber(event)" id="colour"
													name="colourReading" placeholder="Enter Colour Reading"
													value="${productObject.colourReading}">
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
														class="glyphicon glyphicon">$</i></span>
												<input type="number" min="0" step="0.01" data-number-to-fixed="2" data-number-stepfactor="100" class="form-control currency"
													placeholder="Enter Mono Copy Cost" id="colour"
													name="colourCopyCost"
													value="${productObject.colourCopyCost}"/>
												</div>
											</div>
											<br>
										</div>
									</c:if>
								</div>
								<!--/F Column-->

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
													type="text" value="${productObject.buildingName}">
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
													placeholder="Floor Number" maxlength="4" class="form-control"
													type="text" value="${productObject.floorNumber}">
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

									<!-- Text input Street Name-->
									<div class="form-group">
										<label class="col-md-3 control-label">Street Name</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-home"></i></span> <input
													id="streetName" name="streetName" placeholder="Street Name"
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
													value="${productObject.city_town}">
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
													onkeypress="return isNumber(event)"
													value="${productObject.areaCode}">
											</div>
										</div>
									</div>

								</div>
								<!--/S Column-->

							</fieldset>


							<c:if test="${not empty accessories}">
							    <!--Machine Accessories-->
							<fieldset>
								<legend align="left">Machine Accessories</legend>

								<div class="tablemachinesacccso">
									<table id="myDatatable" class="display datatable">
										<thead>
											<tr>
												<th>Machine Type</th>
												<th>Serial Number</th>
												<th>Remove Accessory</th>
											</tr>
										</thead>
										<tbody>
											<!-- Iterating over the list sent from Controller -->
											<c:forEach var="list" items="${accessories}">
												<tr>
											
                                                   	<td>${list.accessotyType}</td>
													<td>${list.serial}</td>
													<td><a href="removeAccessory?serial=<c:out value='${list.serial}'/>">Remove</a></td>
                                                    </tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</fieldset>
							
							
							</c:if>
							<!--Machine Accessories-->
							
							
							<!-- Other Machine Accessories -->
								<div class="others" id="others">
									<div class="col-sm-12">
										<div class="resize">
										<h5>Machine Accessories</h5>									
											<p><input type="button" class="btn btn-success"  value="Add More"></p>
											<table id="otherMachineAccessories" class="table table-striped table-bordered table-hover table-condensed">
													<thead>
														<tr>
															<th>Machine Type</th>
															<th>Serial Number</th>
															<th>Delete</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td><select name="machineType" id="machineType"
																class="form-control selectpicker">
																<option value="">Select Machine Type </option>
																<option value="Bridge unit">Bridge unit</option>
																<option value="Finisher">Finisher</option>
																<option value="Fax Unit">Fax Unit</option>
																<option value="One bin tray">One bin tray</option>
																<option value="LCT">LCT</option>
																<option value="Credenza">Credenza</option>
																<option value="Additional paper trays">Additional paper trays</option>
																<option value="Wireless Card">Wireless Card</option>
																<option value="Others">Others</option> 
																 </select>
															</td>
															<td><input type="text" class="form-control" id="serialNumberOtherAccessory" name="serialNumberOtherAccessory" onkeydown="upperCaseF(this)" placeholder="Serial Number"></td>
															<td><input type="button" class="btn btn-danger" value="Remove" ></td>
														</tr>
													<tbody>
											</table>					
										
										</div>
									</div>									
								</div><!-- //Other Machine Accessories -->
							

							<div class="form-group row">
								<div class="col-sm-offset-2 col-sm-8">
									<br>
									<br> <input type="submit" id="updateProduct"
										name="updateProduct" value="Update Device"
										class="btn btn-primary btn-block btn-lg" tabindex="9"
										id="updateProduct">
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
		
	
	<!-- Scripts -->
	<script type="text/javascript" src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>	
	<script type="text/javascript" src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap-datepicker.min.js" />"></script>
	
	<!-- Datatables -->	
	<script type="text/javascript"	src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>
	<!-- //Datatables -->
	
	<!-- /Scripts -->
	
	<!-- Validate update device -->
	<script>
$(document).ready(function() {
    $('#updateDevice').bootstrapValidator({
        //framework: 'bootstrap',
        icon: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            
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
			//Contact Person
			firstName : {
				validators : {
					notEmpty : {
						stringLength : {
							min : 3,
						},
						message : 'First Name is required and cannot be empty'
					},
					regexp: {
						regexp :/^[-_ a-zA-Z]+$/,
	                    message: 'First Name must only consist of letters'
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
						regexp :/^[-_ a-zA-Z]+$/,			                   
	                    message: 'Last Name must only consist of letters'
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
					},
					regexp: {
						
						regexp: /^0[0-9].*$/,
						message :'Cellphone number must start with 0 (Zero)'
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
					},
					regexp: {
						
						regexp: /^0[0-9].*$/,
						message :'Tellphone number must start with 0 (Zero)'
					}
				}
			},
			
			cellphone : {
				validators : {
					notEmpty : {
						message : 'Please enter 10 digits for cellphone number'
					},
					phone : {
						country : 'US',
						message : 'Please enter 10 digits for cellphone number'
					},
					regexp: {
						
						regexp: /^0[0-9].*$/,
						message :'Cellphone number must start with 0 (Zero)'
					}
				}
			},
			telephone : {
				validators : {
					notEmpty : {
						message : 'Please enter 10 digits for telephone number'
					},
					phone : {
						country : 'US',
						message : 'Please enter 10 digits for telephone number'
					},
					regexp: {
						
						regexp: /^0[0-9].*$/,
						message :'Tellphone number must start with 0 (Zero)'
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
			},//Contact Person
			
			
			//Machine Details
			
            serialNumber : {
				validators : {
					stringLength : {
							min : 2,

						},
						notEmpty : {
							message : 'Serial Number is required and cannot be empty'
						},
						regexp: {
		                    regexp: /^[a-z-A-Z0-9]+$/,
		                    message: 'Serial Number can only consist of numbers '
		                }
					}
			},
			modelNumber : {
				validators : {
					stringLength : {
						min : 2,

					},
					notEmpty : {
						message : 'Model number is required and cannot be empty'
					}
				}
			},
			modelBrand : {
				validators : {
					notEmpty : {
						message : 'Brand is required and cannot be empty'
					}
				}
			},
			startDate: {
                validators: {
                    notEmpty: {
                        message: 'Contract start date is required'
                    },
                    date: {
                        format: 'YYYY-MM-DD',
                        //max: 'endDate',
                        message: 'Contract start date is not a valid'
                    }
                }
            },
            endDate: {
                validators: {
                    notEmpty: {
                        message: 'Contract end date is required'
                    },
                    date: {
                        format: 'YYYY-MM-DD',
                       // min: 'startDate',
                        message: 'Contract end date is not a valid'
                    }
                }
            },
            installationDate: {
                validators: {
                    notEmpty: {
                        message: 'The installation date is required'
                    },
                    date: {
                    	format: 'YYYY-MM-DD',
                       // min: 'endDate',
                        message: 'The installation date is not a valid'
                    }
                }
            },
            buildingName : {            	
            	validators : {            		
				stringLength : {
					min : 2,
				},
				notEmpty : {
					message : 'Building name is required and cannot be empty'
					}
				}
			},            
			floorNumber : {
				validators : {
					stringLength : {
						//min : 3,
					},
					notEmpty : {
						message : 'Floor number is required and cannot be empty'
					},
	                regexp: {
	                    regexp: /^[0-9]+$/,
	                    message: 'Floor number can only consist of numbers '
	                }
				}
			},
            streetNumber : {
				validators : {
					stringLength : {
						//min : 3,
					},
					notEmpty : {
						message : 'Street number is required and cannot be empty'
					},
	                regexp: {
	                    regexp: /^[0-9]+$/,
	                    message: 'The Street number can only consist of numbers '
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
					},
	                regexp: {
	                	 regexp: /^[-_ a-zA-Z]+$/,			                   
	                    message: 'Street name must only consist of letters'
	                }
					
				}
			},
			city_town : {
				validators : {
					stringLength : {
						min : 3,							
					},
					notEmpty : {
						message : 'City is required and cannot be empty'						
						
					},
					 regexp: {
	                	 regexp: /^[-_ a-zA-Z]+$/,			                   
	                    message: 'City or Town must only consist of letters'
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
			
			colourReading: {
				
				validators : {
					stringLenth : {
						min : 4,
						max : 6,
					},
					notEmpty : {
						message : 'Colour reading is required and cannot be empty'
					}
					
				}
			},
			
			colourCopyCost: {
				
				validators : {
					stringLenth : {
						min : 4,
						max : 6,
					},
					notEmpty : {
						message : 'Colour Copy Cost is required and cannot be empty'
					}
					
				}
			},
			
			monoReading: {
				
				validators : {
					stringLenth : {
						min : 4,
						max : 6,
					},
					notEmpty : {
						message : 'Mono reading is required and cannot be empty'
					}
					
				}
			},
			monoCopyCost: {
				
				validators : {
					stringLenth : {
						min : 4,
						max : 6,
					},
					notEmpty : {
						message : 'Mono Copy Cost is required and cannot be empty'
					}
					
				}
			},
			//Machine Details
			
			
			//Machine Accesories
			
			bridgeunit : {
				validators : {
					stringLength : {
						min : 2,

					},
					notEmpty : {
						message : 'Bridge unit is required and cannot be empty'
					}
				}
			},
			
			faxunitserial : {
				validators : {
					stringLength : {
						min : 2,

					},
					notEmpty : {
						message : 'Fax unit is required and cannot be empty'
					}
				}
			},
			
			onebintray : {
				validators : {
					stringLength : {
						min : 2,

					},
					notEmpty : {
						message : 'One bintray is required and cannot be empty'
					}
				}
			},
			
			finisherserial : {
				validators : {
					stringLength : {
						min : 2,

					},
					notEmpty : {
						message : 'Finisher is required and cannot be empty'
					}
				}
			},
			
			lct : {
				validators : {
					stringLength : {
						min : 2,

					},
					notEmpty : {
						message : 'LCT is required and cannot be empty'
					}
				}
			},
			
			credenza : {
				validators : {
					stringLength : {
						min : 2,

					},
					notEmpty : {
						message : 'Credenza is required and cannot be empty'
					}
				}
			},
			
			additionalserial : {
				validators : {
					stringLength : {
						min : 2,

					},
					notEmpty : {
						message : 'Additional paper tray is required and cannot be empty'
					}
				}
			}
    }
});
});
</script>

<!---Script to add other Accossory-->
<script type="text/javascript">

$('#otherMachineAccessories').on('click', 'input[type="button"]', function () {
    $(this).closest('tr').remove();
	})
$('p input[type="button"]').click(function () {
    $('#otherMachineAccessories').append('<tr><td><select name="machineType" id="machineType" class="form-control selectpicker"> <option value="">Select Machine Type </option><option value="Bridge unit">Bridge unit</option> <option value="Finisher">Finisher</option><option value="Fax Unit">Fax Unit</option><option value="One bin tray">One bin tray</option><option value="LCT">LCT</option><option value="Credenza">Credenza</option><option value="Additional paper trays">Additional paper trays</option><option value="Wireless Card">Wireless Card</option><option value="Others">Others</option> </select></td><td><input type="text" class="form-control" id="serialNumberOtherAccessory" name="serialNumberOtherAccessory" onkeydown="upperCaseF(this)" placeholder="Serial Number"/></td><td><input type="button" class="btn btn-danger" value="Remove" /></td></tr>')
});

</script>
<!--Create a table to add other accessories-->
<script type="text/javascript">
var element=document.getElementById('others');
		if (val=='pick machine type' || val=='Other Machine Accessories')
			 element.style.display='block';
		 else  
		   element.style.display='none';
</script>

<!--Mono and Colour Selection-->
<script type="text/javascript">

function CheckColors(val){
 var element=document.getElementById('mono');
 if(val=='pick a mono'||val=='mono'  || val == 'colour')
   element.style.display='block';
 else  
   element.style.display='none';
   
 var element=document.getElementById('colour');
 if(val=='pick a colour'|| val=='colour')
   element.style.display='block';
 else  
   element.style.display='none';
   
}

</script>

<!-- Make all Serials numbers UpperCase  -->
<script type="text/javascript">
function upperCaseF(a){
    setTimeout(function(){
        a.value = a.value.toUpperCase();
    }, 1);
}
</script>

<!-- Accept alphabetical characters only -->
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
            if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123 ))
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

	<!--Compare start, end and installation date between each other-->
	<script type="text/javascript">

$("#startDate, #endDate, #installationDate").datepicker();

$("#endDate").change(function () {

var startDate = document.getElementById("startDate").value;
var endDate = document.getElementById("endDate").value;

if ((Date.parse(endDate) <= Date.parse(startDate))) {
    alert("Contract end date should be greater than Contract start date");
    document.getElementById("endDate").value = "";
}

});
$("#installationDate").change(function () {

var startDate = document.getElementById("startDate").value;
var endDate = document.getElementById("endDate").value;
var installationDate = document.getElementById("installationDate").value;

if ((Date.parse(installationDate) >= Date.parse(endDate)  &&  Date.parse(startDate))) {
    alert("Installation date should be between contract start date and contract end date");
    document.getElementById("installationDate").value = "";
}

});
</script>

	<!-- Enable datepicker for start, end and install date-->
	<script type="text/javascript">
	$(document).ready(function() {
		$('#startDatePicker').datepicker({
			format : "yyyy-mm-dd",
			//startDate: 'd0',
	        autoclose: true
		});
	});
</script>

	<script type="text/javascript">
$(document).ready(function() {
	$('#endDatePicker').datepicker({
		format : "yyyy-mm-dd",
		//startDate: 'd0',
        autoclose: true
	});
});
</script>

	<script type="text/javascript">
	$(document).ready(function() {
		$('#installDatePicker').datepicker({
			format : "yyyy-mm-dd",
			//startDate: 'd0',
	        autoclose: true
		});
	});
</script>

<script>
	$(document).ready(function() {
		$('#myDatatable').DataTable({
			"jQueryUI" : true,
			"pagingType" : "full_numbers",
			"lengthMenu" : [ [ 5, 10, 50, -1 ], [ 5, 10, 50, "All" ] ]
		/* few more options are available to use */
		});
	});
</script>

</body>

</html>