<%@ include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <link href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" rel="stylesheet" type="text/css" /> 
  <link href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />" rel="stylesheet" type="text/css" /> 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<link type="text/stylesheet" src="<c:url value="/resources/custom/css/vela_custom.css" />">

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
						<form action="searchClientforProduct" method="post" id="searchClientforProduct">
							<div class="row">
								<!-- Text input Search-->
								<div class="form-group">
									<label class="col-md-3 control-label">Search Client </label>
									<div class="col-md-4 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-user"></i></span> <input
												name="clientName" id="clientName" class="form-control"
												type="text" placeholder='Search By Client Name'>
										</div>
									</div>
									<div class="col-md-2">
										<input class="btn btn-success" type='submit' value='Search' />
									</div>
								</div>
							</div>
							<hr>
						</form><!--Search-->
				<form:form class="well form-horizontal" method="POST" action="saveProduct"
					modelAttribute="saveProduct">

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
												class="form-control" value="${client.clientName}"
												type="text">
										</div>
									</div>
								</div>
									
					
					</div>
					<div class="col-sm-6">
							
							<!-- Text input Street Name-->
								<div class="form-group">
									<label class="col-md-3 control-label">Street Name</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-home"></i></span> <input
												name="streetName" placeholder="Street Name"
												class="form-control" value="${client.streetName}"
												type="text">
										</div>
									</div>
								</div>
					
					</div>
							
				
							
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
										class="glyphicon glyphicon-user"></i></span> <input name="firstName"
										placeholder="First Name" class="form-control" type="text">
								</div>
							</div>
						</div><!-- Text input Contact Person  Last Name-->
						<div class="form-group">
							<label class="col-md-3 control-label">Last Name</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-user"></i></span> <input name="lastName"
										placeholder="Last Name" class="form-control" type="text">
								</div>
							</div>
						</div>
						
						<!-- Text input Contact Person 1 Email-->
						<div class="form-group">
							<label class="col-md-3 control-label">Email</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-envelope"></i></span> <input name="email"
										placeholder="Email Address" class="form-control" type="email">
								</div>
							</div>
						</div>
						
						
						<!-- Text input Contact Person Cellphone Number-->
						<div class="form-group">
							<label class="col-md-3 control-label">Cellphone No</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-earphone"></i></span> <input name="cellphoneNumber"
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
										class="glyphicon glyphicon-earphone"></i></span> <input name="tellphoneNumber"
										placeholder="Tellphone No" class="form-control" type="text">
								</div>
							</div>
						</div>
					
					</div><!-- /Contact Person 1 -->
					
					<!-- Contact Person 2 -->
					<div class="col-sm-6">						
						<div align="center">
						<b class="optionalFields">Contact Person 2 (Optional Fields)</b>
						
						</div>
						<!-- Text input Contact Person First Name-->
						<div class="form-group">
							<label class="col-md-3 control-label">First Nmae</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-user"></i></span> <input name="firstName"
										placeholder="First Name" class="form-control" type="text">
								</div>
							</div>
						</div><!-- Text input Contact Person  Last Name-->
						<div class="form-group">
							<label class="col-md-3 control-label">Last Name</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-user"></i></span> <input name="lastName"
										placeholder="Last Name" class="form-control" type="text">
								</div>
							</div>
						</div>
						
						<!-- Text input Contact Person 1 Email-->
						<div class="form-group">
							<label class="col-md-3 control-label">Email</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-envelope"></i></span> <input name="email"
										placeholder="Email Address" class="form-control" type="email">
								</div>
							</div>
						</div>
						<!-- Text input Contact Person Cellphone Number-->
						<div class="form-group">
							<label class="col-md-3 control-label">Cellphone No</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-earphone"></i></span> <input name="cellphoneNumber"
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
										class="glyphicon glyphicon-earphone"></i></span> <input name="tellphoneNumber"
										placeholder="Tellphone No" class="form-control" type="text">
								</div>
							</div>
						</div>
						
					</div><!-- /Contact Person 2 -->
							
				
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
												name="serialNumber" placeholder="Serial Number"
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
												name="mono" placeholder="Mono Reading"
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
												class="glyphicon glyphicon-list"></i></span> <select name="monoColour"
												class="form-control selectpicker">
												<option value=" ">Select Colour</option>
												<option value="Gauteng">White</option>
												<option value="Limpopo">Blue</option>										
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
									disabled name="bridgeUnitSerialTypeSerialNo" />
							</div>

							<div class="col-xs-2 form-control-label">
								<label for="serailNo"><input type="checkbox"
									id="faxunit" name="faxUnitSerialType" />&nbsp;Fax Unit:</label>
							</div>
							<div class="col-xs-3">
								<label for="faxunitserial">Serial Number:&nbsp;&nbsp;</label><input
									type="text" class="form-control input-sm" id="faxunitserial"
									disabled name="faxUnitSerialTypeSerialNo" />
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
									disabled name="OneBinTrayTypeSerialNo" />
							</div>

							<div class="col-xs-2 form-control-label">
								<label for="serailNo"><input type="checkbox"
									id="finisher" name="finisherType" />&nbsp;Finisher:</label>
							</div>
							<div class="col-xs-3">
								<label for="finisherserial">Serial Number:&nbsp;&nbsp;</label><input
									type="text" class="form-control input-sm" id="finisherserial"
									disabled name="finisherTypeSerialNo" />
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
									name="ltcTypeSerial" disabled />
							</div>


							<div class="row">
								<div class="col-xs-2 form-control-label">
									<label for="serailNo"><input type="checkbox"
										id="credenzaserial" name="credenza" />&nbsp;Credenza</label>
								</div>
								<div class="col-xs-3">
									<label for="credenza">Serial Number:&nbsp;&nbsp;</label><input
										type="text" class="form-control input-sm" id="credenza"
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
								<label for="additionalserial">Serial Number:&nbsp;&nbsp;</label><input
									type="text" class="form-control input-sm" id="additionalserial"
									name="additionalPaperTraysTypeSerial" disabled />
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
			  </div><!-- /tab-content -->
			</div><!-- /panel body -->
		 </div><!--/panel success class-->
		</div><!-- /Container -->
		<!-- Footer -->
		<c:import url="templates/footer.jsp"></c:import>
		<!--/ Footer -->
	</div><!-- / velaphanda_containter -->

	<!-- Script -->
	<script type="text/javascript"
		src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>		
	<script type="text/javascript"  src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap-datepicker.js" />"></script>
	<!-- /Script -->

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
