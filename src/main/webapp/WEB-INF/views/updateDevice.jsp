<%@ include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Update Device Installation | Velaphanda Trading &
	Projects</title>
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
												name="serialNumber" id="serialNumber" class="form-control"
												type="text" placeholder='Search By Serial Number'>
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
							action="updateProduct" modelAttribute="updateProduct">

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
												name="clientName" placeholder="Client Name"
												class="form-control" value="${productObject.client.clientName}"
												type="text">
										</div>
									</div>
								</div>

								<!-- Text input Contact Person-->
								<div class="form-group">
									<label class="col-md-3 control-label">Contact Person</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-user"></i></span> <input
												class="form-control" value="${productObject.client.contactPerson}"
												type="text">
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
										<option value=" ">${productObject.client.province}</option>
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
												class="glyphicon glyphicon-home"></i></span> <input
												name="city_town" placeholder="City / Town"
												class="form-control" value="${productObject.client.city_town}" type="text">
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
												name="streetName" placeholder="Street Name"
												class="form-control" value="${productObject.client.streetName}"
												type="text">
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
										placeholder="Area Code" class="form-control" value="${productObject.client.zipcode}" type="text">
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
												class="glyphicon glyphicon-home"></i></span> <input
												name="floorNumber" placeholder="Street No"
												class="form-control" value="${productObject.client.streetNumber}"
												type="text">
										</div>
									</div>
								</div>
								<!-- Text input Floor Number-->
								<div class="form-group">
									<label class="col-md-3 control-label">Contact Person</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-home"></i></span> <input
												name="floorNumber" placeholder="Contact Person (Optional)"
												class="form-control" value="${productObject.client.contactPerson2}"
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
												name="tellphoneNumber" placeholder="Tellphone Number"
												class="form-control" value="${productObject.client.tellphoneNumber}"
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
												name="faxNumber" placeholder="Fax Number"
												class="form-control" value="${productObject.client.faxNumber}" type="text">
										</div>
									</div>
								</div>
								<!-- Text input Cellphone Number-->
								<div class="form-group">
									<label class="col-md-3 control-label">Mobile Number</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-earphone"></i></span> <input
												name="cellNumber" placeholder="Mobile Number"
												class="form-control" value="${productObject.client.cellNumber}"
												type="text">
										</div>
									</div>
								</div>

								<!-- Text input Email-->
								<div class="form-group">
									<label class="col-md-3 control-label">E-Mail</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-envelope"></i></span> <input
												name="email" placeholder="E-Mail Address"
												class="form-control" value="${productObject.client.email}" type="text">
										</div>
									</div>
								</div>
								
							</div><!-- /S Column -->
						<br>
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
												name="serialNumber" placeholder="Serial Number" value="${productObject.serialNumber }"
												class="form-control" type="text">
										</div>
									</div>
								</div>
								
								<!-- Text input Contract Start Date-->
								<div class="form-group">
									<label class="col-md-3 control-label">Contract Start Date</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-calendar"></i></span> <input
												name="startDate" id="startDate" placeholder="YYYY-MM-DD"
												value="${productObject.startDate.toString().substring(0,10) }"
												class="form-control" type="text">
										</div>
									</div>
								</div>
								<!-- Text input Device Location-->
								<div class="form-group">
									<label class="col-md-3 control-label">Device Location</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-home"></i></span> <input
												name="deviceLocation" id="deviceLocation" placeholder="Device Location"
												value="${productObject.deviceLocation }"
												class="form-control" type="text">
										</div>
									</div>
								</div>
								
								<!-- Text checkbox Mono Reading-->
								<div class="form-group">
									<label class="col-md-3 control-label">Mono Reading</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-barcode"></i></span> <input
												name="monoReading" placeholder="Mono Reading"
												value="${productObject.monoReading}"
												class="form-control" type="text">
										</div>
									</div>
								</div>
							
						</div><!--/F Column-->
												
						<!--Second column-->
							<div class="col-sm-6">
								<!-- Text input Machine Model-->
								<div class="form-group">
									<label class="col-md-3 control-label">Model No</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-barcode"></i></span> <input
												name="productModel" placeholder="Product Model"
												value="${productObject.productModel }"
												class="form-control" type="text">
										</div>
									</div>
								</div>

								<!-- Text input Contract End Date-->
								<div class="form-group">
									<label class="col-md-3 control-label">Contract End Date</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-calendar"></i></span> <input
												name="endDate" id="endDate" placeholder="YYYY-MM-DD"
												value="${productObject.endDate.toString().substring(0,10) }"
												class="form-control" type="text">
										</div>
									</div>
								</div>
								<!-- Text input Installation Date-->
								<div class="form-group">
									<label class="col-md-3 control-label">Installation Date</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-calendar"></i></span> <input
												name="installationDate" id="installationDate" placeholder="YYYY-MM-DD"
												value="${productObject.installationDate.toString().substring(0,10) }"
												class="form-control" type="text">
										</div>
									</div>
								</div>
								
								<!-- Select type Mono Colour-->						
								<div class="form-group">
									<label class="col-md-3 control-label">Mono Colour</label>
									<div class="col-md-6 selectContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-list"></i></span> <select name="colour"
												class="form-control selectpicker">
												<option value=" ">Select Colour</option>
												<option value="White">White</option>
												<option value="Blue">Blue</option>										
											</select>
										</div>
									</div>
								</div>
								
							</div><!--/S Column-->
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
											type="text" class="form-control input-sm" id="bridgeunit"
											 name="bridgeUnitSerialTypeSerialNo" value="${AccessoryObject.bridgeUnitSerialTypeSerialNo }"/>
									</div>

									<div class="col-xs-2 form-control-label">
										<label for="serailNo"><input type="checkbox"
											id="faxunit" name="faxUnitSerialType" />&nbsp;Fax Unit:</label>
									</div>
									<div class="col-xs-3">
										<label for="faxunitserial">Serial Number:&nbsp;&nbsp;</label><input
											type="text" class="form-control input-sm" id="faxunitserial"
											value="${AccessoryObject.faxUnitSerialTypeSerialNo }" name="faxUnitSerialTypeSerialNo" />
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
											type="text" class="form-control input-sm" id="onebintray"
											value="${AccessoryObject.oneBinTrayTypeSerialNo }" name="oneBinTrayTypeSerialNo" />
									</div>

									<div class="col-xs-2 form-control-label">
										<label for="serailNo"><input type="checkbox"
											id="finisher" name="finisherType" />&nbsp;Finisher:</label>
									</div>
									<div class="col-xs-3">
										<label for="finisherserial">Serial Number:&nbsp;&nbsp;</label><input
											type="text" class="form-control input-sm" id="finisherserial"
											value="${AccessoryObject.finisherTypeSerialNo }" name="finisherTypeSerialNo" />
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
											type="text" class="form-control input-sm" id="ltc"
											name="ltcTypeSerial" value="${AccessoryObject.ltcTypeSerial }" />
									</div>


									<div class="row">
										<div class="col-xs-2 form-control-label">
											<label for="serailNo"><input type="checkbox"
												id="credenzaserial" name="credenza" />&nbsp;Credenza</label>
										</div>
										<div class="col-xs-3">
											<label for="credenza">Serial Number:&nbsp;&nbsp;</label><input
												type="text" class="form-control input-sm" id="credenza"
												name="credenzaSerialNo" value="${AccessoryObject.credenzaSerialNo }" />
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
											class="form-control input-sm" id="additionalserial"
											name="additionalPaperTraysTypeSerial" value="${AccessoryObject.additionalPaperTraysTypeSerial }" />
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
	<!-- /Script -->

	<script>
		$(document)
				.ready(
						function() {
							$('#searchDeviceSerialNumber')
									.bootstrapValidator(
											{
												container : '#messages',
												feedbackIcons : {
													valid : 'glyphicon glyphicon-ok',
													invalid : 'glyphicon glyphicon-remove',
													validating : 'glyphicon glyphicon-refresh'
												},
												fields : {
													serialNumber : {
														validators : {
															stringLength : {
									    						min : 3,
									    					},
															notEmpty : {
																message : 'Serial number is required to search and cannot be empty'
															}
														}
													},
												}
											});
						});
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
</html>
