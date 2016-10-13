<%@ include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Product</title>
</head>
<c:import url="templates/navbar.jsp"></c:import>
<body class=".container-fluid">
	<div class="container myrow-container" style="width: 90%">
		
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
					<!-- <div align="right"><a href="">Think of something</a></div> -->
				</h3>
			</div>
			<div class="panel-body">
				<form action="searchClientforProduct" method="post">
					<div class="row">

						<div class="col-xs-2 form-control-label" align="center">Search
							Customer</div>
						<div class="col-xs-3">
							<input type="text" class="form-control input-sm"
								name="clientName" id="clientName" class="required" required>
						</div>
						<div class="col-xs-2">
							<input class="btn btn-success" type='submit' value='Search' />
						</div>

					</div>
					<hr>
				</form>
				<form:form method="POST" action="saveProduct"
					modelAttribute="saveProduct">

					<fieldset>
						<legend>Customer Details</legend>
						<div class="row">
							<div class="col-xs-12">
								<div class="col-xs-2 form-control-label">
									<label>Company Name:</label>

								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm"
										value="${client.clientName}" name="clientName">
								</div>

								<div class="col-xs-2 form-control-label">
									<label>Contact Person</label>

								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm"
										value="${client.contactPerson}">
								</div>
							</div>
						</div>

						<br>
						<div class="row">
							<div class="col-xs-12">
								<div class="col-xs-2 form-control-label">
									<label>Tel:</label>

								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm"
										value="${client.tellphoneNumber}">
								</div>

								<div class="col-xs-2 form-control-label">
									<label>Cell</label>

								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm"
										value="${client.cellNumber}">
								</div>
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-xs-12">
								<div class="col-xs-2 form-control-label">
									<label>Email:</label>

								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm"
										value="${client.email}">
								</div>

								<div class="col-xs-2 form-control-label">
									<label>Fax</label>

								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm"
										value="${client.faxNumber}">
								</div>
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-xs-12">
								<div class="col-xs-2 form-control-label">
									<label>Street No:</label>

								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm"
										name="streetNumber" value="${client.streetNumber}">
								</div>

								<div class="col-xs-2 form-control-label">
									<label>Street Name</label>

								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm"
										value="${client.streetName}">
								</div>
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-xs-12">
								<div class="col-xs-2 form-control-label">
									<label>Surbub:</label>

								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm"
										value="${client.city_town}">
								</div>

								<div class="col-xs-2 form-control-label">
									<label>Floor No</label>

								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm"
										value="${client.floorNumber}">
								</div>
							</div>
						</div>
						<br>
					</fieldset>
					<br>
					<br>
					<fieldset>
						<legend>Machine Details</legend>
						<br>
						<div class="row">
							<div class="col-xs-12">
								<div class="col-xs-2 form-control-label">
									<label>Serial No:</label>

								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm"
										name="serialNumber" class="required" required>
								</div>

								<div class="col-xs-2 form-control-label">
									<label>Machine Model</label>

								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm"
										name="productModel" class="required" required>
								</div>
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-xs-12">
								<div class="col-xs-2 form-control-label">
									<label>Contract Start Date:</label>

								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm" id="startDate"
										name="startDate" placeholder="YYYY-MM-DD" class="required"
										required="required">
								</div>

								<div class="col-xs-2 form-control-label">
									<label>Contract End Date</label>

								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm" id="endDate"
										name="endDate" placeholder="YYYY-MM-DD" class="required"
										required="required">
								</div>
							</div>
						</div>
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
							<input type="submit" value="Submit"
								class="btn btn-primary btn-block btn-lg" tabindex="9"
								id="submit">
						</div>
					</div>
				</form:form>
			</div>



		</div>
	</div>


</body>
<script type="text/javascript"
	src="<c:url value="/resources/bootstrap-3.3.6/js/jquery-2.1.4.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap-datepicker.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script>
<link
	href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />


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


<style type="text/css">
.bs-example {
	margin: 20px;
}
</style>
</html>
