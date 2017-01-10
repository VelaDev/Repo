<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title> Delivery Note | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/custom/css/vela_custom.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">
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
<style>
li{
	list-style: none;
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
							<b>Delivery Note</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">
					  <form:form>
							
							<fieldset>
								<div class="col-sm-6">

									<div id="customer_container"
										style="width: auto; display: table;">
										<p class="customerAddress_title"><b>DELIVERY TO</b></p>
										<ul class="address_list" style="display: block;">
										    <li id="streetNumber">${OrderNum.customer.customerName}</li>
											<li id="streetName">${OrderNum.customer.streetNumber} ${OrderNum.customer.streetName}</li>
											<li id="city_town">${OrderNum.customer.city_town}</li>
											<li id="zipcode">${OrderNum.customer.province}</li>
										</ul>
										<ul class="address_list" style="display: block;">
										    <li id="streetNumber">Contact Person : ${contactPerson.firstName} ${contactPerson.lastName}</li>
											<li id="streetName">Contact No: ${contactPerson.cellNumber}</li>
											<li id="city_town">E-Mail: ${contactPerson.email}</li>
										</ul>
									</div>
									<div id="logo_container"
										style="width: auto; display: table;">
										<p class="customerAddress_title" align="center"><b>DELIVERY NOTE</b></p>
										<ul class="address_list" style="display: block;">
										    <lia id="streetNumber" ></lia>
											<li id="streetName">VELAPHANDA TRADING & PROJECTS</li>
											<li id="city_town">REG NO: 2008/164490/23</li>
											<li id="zipcode">POSTNET SUITE 357, PRIVATE BAG X1028</li>
											<li id="zipcode">LYTTLETON 0140</li>
											<li id="zipcode">TEL: 012 765 0200 FAX: 086 430 7955</li>
											<li id="zipcode">E-MAIL: sales@velaphanda.co.za</li>
										</ul>
									</div>
								</div>
								<div class="col-sm-6">
									<div id="payment_container"
										style="width: auto; display: table;">
										<p class="payment_title">PAYMENT INFORMATION</p>
										<ul class="list" style="display: block;">
											<li id="firstName">Delivery Date: </li>
											<li id="lastName">Delivery Note No: </li>
											<li id="email">Customer Order No: ${OrderNum.orderNum}</li>
											<li id="cellphoneNumber">Customer VAT No: </li>
											<li id="telephoneNumber">WAYBILL No: </li>
											<li id="telephoneNumber">Please Remit To: </li>
										</ul>
									</div>
								</div>
							</fieldset><br>
							<!-- Below table will be displayed as Data table -->
						<table id="myDatatable" class="display datatable" border="2%">
							<thead>
								<tr>
									<th><b>Model No</b></th>
									<th><b>Description</b></th>
									<th><b>Qty Ordered</b></th>
									<th><b>Qty Delv</b></th>
										<!-- <th>Stock Type</th> -->
								</tr>
							</thead>
							<tbody>
								<!-- Iterating over the list sent from Controller -->
								<c:forEach var="list" items="${pendingOrderList}">
									<tr>
										<td>${list.model}</td>
										<td>${list.description}</td>
										<td>${list.quantity}</td> 
										<td>${list.quantity}</td>  
									</tr>
								</c:forEach>
							</tbody>
						</table><br>
						<!-- <textarea rows="3" cols="25">Received By: 
						 Date: 
						 Signature
						</textarea> -->
						<!-- <table>
						  <tbody>
						    <tr>
						      <th>Received By:________________________________________</th>
						      <th>PRINT NAME & SURNAME: <u>______________________________</u></th>
						    </tr>
						  </tbody>
						</table> -->
						<!-- Text input Client Name-->
						   <div class="col-sm-12">
								<div class="form-group">
									<label class="col-md-6 control-label">Received By:___________________________________</label>
								</div>

								<!-- Text input Tellphone Number-->
								<div class="form-group">
									<label class="col-md-6 control-label">Print Name & Surname:_____________________________</label>
								</div>
							</div>
								<div class="col-sm-12">
								  <div class="form-group">
									<label class="col-md-6 control-label">Signature:_____________________________________</label>
							      </div>
								
								  <div class="form-group">
									<label class="col-md-6 control-label">Date/Time Received:_______________________________</label>
							      </div>
								</div><br>
								<table border="2%">
								  <tbody>
								     <tr>
								         <th width="2%" height="50%">Notes: </th>
								     </tr>
								  </tbody>
								</table>
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

</body>

<script type="text/javascript"
	src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>
<%-- <script type="text/javascript"src="<c:url value="/resources/datatables/1.10.13/js/datatable.js" />"></script> --%>

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
<script type="text/javascript"
		src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap-datepicker.js" />"></script>
</html>
