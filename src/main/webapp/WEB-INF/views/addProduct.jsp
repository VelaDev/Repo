<%@ include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/custom/css/vela_custom.css" />"  />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap-3.3.7/css/datepicker.min.css" />">
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
						

							<form:form class="well form-horizontal" method="POST" action="saveProduct" modelAttribute="saveProduct" id="addDevice">
							
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
												<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span> 
												<input name="customerName" placeholder="Client Name" readonly="readonly" class="form-control" 
													value="${customer.customerName}" type="text" >
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
												<span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
												<input name="companyEmail" id="companyEmail" readonly="readonly"
												placeholder="Company Email" class="form-control" value="${customer.email}" 
												type="text">
											</div>
										</div>
									</div>
								</div>

								<div class="col-sm-6">
									<div id="customer_container" style="width: auto; display: table;">
										<p class="customerAddress_title">Customer Address</p>
										<ul class="address_list" style="display: block;">
											<li id="streetName">${customer.streetNumber} ${customer.streetName} </li>
											<li id="city_town">${customer.city_town}</li>
											<li id="zipcode">${customer.zipcode}</li>
										</ul>
									</div>
								</div>
								
							</fieldset><!--Customer Details-->
							
							
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
													<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span> 
													<input id="firstName" name="firstName" placeholder="First Name" class="form-control" type="text">
												</div>												
											</div>
									</div>
									
									<!-- Text input Contact Person  Last Name-->																	
									<div class="form-group">
										<label class="col-md-3 control-label">Last Name</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span> 
												<input id="lastName" name="lastName" placeholder="Last Name" class="form-control" type="text" >
											</div>
										</div>
									</div>
								
									<!-- Text input Contact Person 1 Email-->								
									<div class="form-group">
										<label class="col-md-3 control-label">Email</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span> 
												<input id="email" name="email" placeholder="Email Address" class="form-control" type="email" >
											</div>										
										</div>
									</div>
									
								</div><!--//First Column-->
								
								<!--Second Column-->
								<div class="col-sm-6">
									<!-- Text input Contact Person Cellphone Number-->
									<div class="form-group">
										<label class="col-md-3 control-label">Cellphone No</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
												<input id="cellphoneNumber" maxlength="10"  name="cellphoneNumber" placeholder="Cellphone No" class="form-control" type="text" onkeypress="return isNumber(event)" >
											</div>
											
										</div>
									</div>
								
									<!-- Text input Contact Person Tellphone Number-->																	
									<div class="form-group">
										<label class="col-md-3 control-label">Tellphone No</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
												<input id="telephoneNumber" maxlength="10"  name="telephoneNumber" 
												placeholder="Tellphone No" class="form-control" type="text" onkeypress="return isNumber(event)" >
											</div>
										</div>
									</div>
								</div><!--/Second Column-->	
								
							</fieldset><!-- /Contact Person  -->
						
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
												<span class="input-group-addon"><i class="glyphicon glyphicon-barcode"></i></span>
												<input name="serialNumber" id="serialNumber" onkeydown="upperCaseF(this)"
												placeholder="Serial Number" class="form-control" type="text">
											</div>										
										</div>
									</div>
									<!-- Text input Machine Model-->
									<div class="form-group">
										<label class="col-md-3 control-label">Model No</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i class="glyphicon glyphicon-barcode"></i></span> 
												<input name="modelNumber" onkeydown="upperCaseF(this)" id="modelNumber" placeholder="Model Number" class="form-control" type="text" >
											</div>
										</div>
									</div>
									<!-- Text input Contract Start Date-->
									<div class="form-group ">
										<label class="col-xs-3 control-label">Contract Start
											Date</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group input-append date" id="startDatePicker">
												<input type="text" class="form-control" name="startDate" id="startDate" placeholder="YYYY-MM-DD" 
												> <span class="input-group-addon"> <span class="glyphicon glyphicon-calendar"></span>
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
												<input type="text" class="form-control" name="endDate" id="endDate" placeholder="YYYY-MM-DD" >
												<span class="input-group-addon"> <span class="glyphicon glyphicon-calendar"></span>
												</span>
											</div>	
										</div>
									</div>
									<!-- Text input Installation Date-->
									<div class="form-group">
										<label class="col-md-3 control-label">Installation
											Date</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group input-append date" id="installDatePicker">
												<input type="text" class="form-control" id="installationDate" name="installationDate" 
												placeholder="YYYY-MM-DD"> <span class="input-group-addon"> 
												<span class="glyphicon glyphicon-calendar"></span>
												</span>
											</div>
										</div>
									</div>
									<!-- Select type Mono/Colour-->
									<div class="form-group">
										<label class="col-md-3 control-label">Mono/Colour</label>
										<div class="col-md-6 selectContainer">
											<div class="input-group">
												<span class="input-group-addon"><i class="glyphicon glyphicon-list"></i></span>
												<select id="monocolour" name="colour" class="form-control" onchange="CheckColors(this.value);">
													<option>Select Mono/Colour</option>
													<option value="mono">Mono</option>
													<option value="colour">Colour</option>
												</select>
											</div>
										</div>
									</div>


									<div id="colour" style="display: none;">
										<!-- Text checkbox Colour Reading-->
										<div class="form-group">
											<label class="col-md-3 control-label"></label>
											<div class="col-md-6">
												<input type="text" class="form-control" onkeypress="return isNumber(event)" placeholder="Enter Colour Reading" 
												name="colourReading" id="colourReading">
											</div>
											<br>
										</div>
										<!-- Text checkbox Mono Reading-->
										<div class="form-group">
											<label class="col-md-3 control-label"></label>
											<div class="col-md-6">
												<input type="text" class="form-control" onkeypress="return isNumber(event)" placeholder="Enter Mono Reading"
												name="monoReading" id="monoReading">
											</div>
										</div>
									</div>
									<!-- Text checkbox Mono Reading-->
									<div class="form-group">
										<label class="col-md-3 control-label"></label>
										<div class="col-md-6">
											<input type="text" class="form-control" onkeypress="return isNumber(event)" name="mono" placeholder="Enter Mono Reading" 
											id="mono" style="display: none;">
										</div>
									</div>
								</div>
								<!--/First Column-->

								<!--Second column-->
								<div class="col-sm-6">
									
									<!-- Text input Street Number-->
									<div class="form-group">
										<label class="col-md-3 control-label">Street No</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
												<input name="streetNumber" id="streetNumber" placeholder="Street Number" class="form-control" type="text">
											</div>
										</div>
									</div><!--/S Street Number-->
									<!-- Text input Street Name-->
									<div class="form-group">
										<label class="col-md-3 control-label">Street Name</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
												<input id="streetName" name="streetName" placeholder="Street Name" class="form-control" type="text">
											</div>
										</div>
									</div>
									<!-- Text input City or Town-->
									<div class="form-group ">
										<label class="col-md-3 control-label">City/Town</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span> 
												<input name="city_town" id="city_town" placeholder="City / Town" class="form-control" type="text">
											</div>
											</div>
									</div>
									<!-- Select type Province-->
									<div class="form-group ">
										<label class="col-md-3 control-label">Province</label>
										<div class="col-md-6 selectContainer">
											<div class="input-group">
												<span class="input-group-addon"><i class="glyphicon glyphicon-list"></i></span> 
												<select name="province" id="province" class="form-control selectpicker" >
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
												<span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
												<input name="zipcode" id="zipcode" placeholder="Area Code" class="form-control" 
												type="text" onkeypress="return isNumber(event)" >
											</div>
										</div>
									</div>
									
								</div>
									

							</fieldset><!-- /Machine Details  -->
						
							
							<!--Machine Accessories-->
							<fieldset>
								<legend align="left">Machine Accessories</legend>
								
								<div class="tablemachinesacccso">								
									<table id="tableselect" class="table table-striped table-bordered table-hover table-condensed">
	
										<thead>
											<tr>
												<th>Machine Type</th>
												<th>Serial Number</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td><input type="checkbox" id="bridgeunitserial" name="bridgeUnitSerialType"> Bridge
													unit</td>
												<td><input type="text" class="form-control" onkeydown="upperCaseF(this)" id="bridgeunit" name="bridgeUnitSerialTypeSerialNo" disabled="disabled"></td>
											</tr>
											<tr>
												<td><input type="checkbox" class="select" id="finisher" name="finisherType"> Finisher</td>
												<td><input type="text" class="form-control" onkeydown="upperCaseF(this)" id="finisherserial" name="finisherTypeSerialNo" disabled="disabled"></td>
											</tr>
											<tr>
												<td><input type="checkbox" class="select" id="faxunit" name="faxUnitSerialType"> Fax Unit</td>
												<td><input type="text" class="form-control" onkeydown="upperCaseF(this)" id="faxunitserial" name="faxUnitSerialTypeSerialNo" disabled="disabled"></td>
											</tr>
											<tr>
												<td><input type="checkbox" class="select" id="onebintrayserial" name="bridgeUnitSerialType"> One
													bin tray</td>
												<td><input type="text" class="form-control" onkeydown="upperCaseF(this)" id="onebintray" name="OneBinTrayTypeSerialNo" disabled="disabled"></td>
											</tr>											
											<tr>
												<td><input type="checkbox" class="select" id="ltcserial" name="ltcType"> LCT</td>
												<td><input type="text" class="form-control" onkeydown="upperCaseF(this)" id="lct" name="ltcTypeSerial" disabled="disabled"></td>
											</tr>											
											<tr>
												<td><input type="checkbox" class="select" id="creserial" name="creType"> Credenza</td>
												<td><input type="text" class="form-control" onkeydown="upperCaseF(this)" id="cre" name="creTypeserial" disabled="disabled"></td>
											</tr>											
											<tr>
												<td><input type="checkbox" class="select" id="addserial" name="addType"> Additional paper trays</td>
												<td><input type="text" class="form-control" onkeydown="upperCaseF(this)" id="add" name="addTypeserial" disabled="disabled"></td>
											</tr>
										</tbody>
									</table>
								
								<br>
								<div class="row">
								
								<div class="form-group">
										<label class="col-xs-1 control-label">Others</label>
										<div class="col-xs-4">
											<input type="text" class="form-control" name="machinetype" id="machinetype"
												placeholder="Machine Accessory Type" />
										</div>
										<div class="col-xs-4">
											<input type="text" class="form-control"
												onkeydown="upperCaseF(this)" id="serialNumberOtherAcco"
												name="serialNumberOtherAcco" placeholder="Serial Number" />
										</div>
										<div class="col-xs-1">
											<img class="add right"  src="resources/bootstrap-3.3.6/images/add.png" />
										</div>
								</div>
									
								</div>
								
								</div>
							</fieldset><!--Machine Accessories-->
							<br/>
							<div class="centerbutton">
								<div class="form-group row">
									<div class="col-sm-4">
										<input type="submit" id="addProduct" name="addProduct" value="Add Device" class="btn btn-primary btn-block" tabindex="9">
									</div>
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
	<!-- /Scripts -->
  
<!-- Check if checkboxes are checked, if checked enable input text -->
	<script type="text/javascript">
		document.getElementById('bridgeunitserial').onchange = function() {
			document.getElementById('bridgeunit').disabled = !this.checked;
			document.getElementById('finisherserial').disabled = !this.checked;
		};
		document.getElementById('finisher').onchange = function() {
			document.getElementById('finisherserial').disabled = !this.checked;
			document.getElementById('bridgeunit').disabled = !this.checked;
		};
		
		document.getElementById('faxunit').onchange = function() {
			document.getElementById('faxunitserial').disabled = !this.checked;
		};
		document.getElementById('onebintrayserial').onchange = function() {
			document.getElementById('onebintray').disabled = !this.checked;
		};
		
		document.getElementById('ltcserial').onchange = function() {
			document.getElementById('lct').disabled = !this.checked;
		};
		document.getElementById('creserial').onchange = function() {
			document.getElementById('cre').disabled = !this.checked;
		};
		document.getElementById('addserial').onchange = function() {
			document.getElementById('add').disabled = !this.checked;
		};
		
</script>


<!-- Add Other Accessories -->
<script type="text/javascript">
</script>

<!-- Validate add device -->
<script>
$(document).ready(function() {
    $('#addDevice').bootstrapValidator({
        //framework: 'bootstrap',
        icon: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
           
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
				companyEmail : {
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
				monocolour: {
					
					validators : {
						stringLenth : {
							min : 4,
							max : 6,
						},
						notEmpty : {
							message : 'Mono Colour is required and cannot be empty'
						}/* ,
						regexp: {
			                    regexp: /^[0-9]+$/,
			                    message: 'Mono colour can only consist of numbers'
			            } */
						
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
						}/* ,
						regexp: {
		                    regexp: /^[0-9]+$/,
		                    message: 'Mono colour can only consist of numbers'
		          	    } */
						
					}
				},
				monocolour: {
					
					validators : {
						stringLenth : {
							min : 4,
							max : 6,
						},
						notEmpty : {
							message : 'Mono colour is required and cannot be empty'
						}/* ,
						regexp: {
		                    regexp: /^[0-9]+$/,
		                    message: 'Mono colour can only consist of numbers'
		           		 } */
						
					}
				},
				
				mono: {
					
					validators : {
						stringLenth : {
							min : 4,
							max : 6,
						},
						notEmpty : {
							message : 'Mono is required and cannot be empty'
						}/* ,regexp: {
		                    regexp: /^[0-9]+$/,
		                    message: 'Mono colour can only consist of numbers'
		           		 } */
						
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
			                    message: 'The Street number can only consist of numbers '
			                }
						}
				},
				machinetype  : {
					validators : {
						stringLength : {
								min : 2,

							},
							/* /* notEmpty : {
								message : 'Machine type is required and cannot be empty'
							} *//*,
							regexp: {
			                    regexp: /^[a-z-A-Z]+$/,
			                    message: 'Machine type is required and cannot be empty'
			                } */
						}
				},
				serialNumberOtherAcco: {
					validators : {
						stringLength : {
								min : 2,

							},
							/* notEmpty : {
								message : 'Serial Number is required and cannot be empty'
							},
							regexp: {
			                    regexp: /^[a-z-A-Z0-9]+$/,
			                    message: 'Serial Number is required and cannot be empty '
			                } */
						}
				},
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

<!--Compare start, end and installation date  between each other-->
<script type="text/javascript">

$("#startDate, #endDate, #installationDate " ).datepicker();

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
        alert("Installation date should be between than contract start date and contract end date");
        document.getElementById("installationDate").value = "";
    }

});
</script>

<!-- Enable datepicker for start, end and install date-->
<script type="text/javascript">
		$(document).ready(function() {
			$('#startDatePicker').datepicker({
				format : "yyyy-mm-dd",
				startDate: 'd0',
		        autoclose: true
			});
		});
</script> 

<script type="text/javascript">
	$(document).ready(function() {
		$('#endDatePicker').datepicker({
			format : "yyyy-mm-dd",
			startDate: 'd0',
	        autoclose: true
		});
	});
</script> 

<script type="text/javascript">
		$(document).ready(function() {
			$('#installDatePicker').datepicker({
				format : "yyyy-mm-dd",
				startDate: 'd0',
		        autoclose: true
			});
		});
</script>


</body>
</html>
