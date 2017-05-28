
<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title> Delivery Note | Velaphanda Trading & Projects</title>


<link type="text/css" rel="stylesheet" href="<c:url value="/resources/custom/css/vela_custom.css" />">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" />

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

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
				<div class="panel-body" id="deliveryNote" style="background-color:white;"> 
					<div class="tab-content">
					   <a href="#" onclick="window.open('C:/VelapandaReports/ORD004.pdf', '_blank', 'fullscreen=yes'); return false;">MyPDF</a><br>
					  <form:form>
							
							<fieldset>
								<div class="col-sm-6">
								  <table id="headerTable" border="2%"  width = "208%" cellpadding="auto">
								  
								   <tr>
									<th>DELIVERY TO</th> 
									<th>DELIVERY NOTE</th> 
									<th>PAYMENT INFORMATION</th>
								   </tr>
								   <tr>
									<td>							
									    <ul>
									        <li id="customer">Madibeng Manucipility</li>
										    <li id="streetNumberAndName">12 Ivin Khoza</li>
											<li id="city_town">Johannesburg</li>
											<li id="zipcode">2080</li>
										</ul>
										<ul>
										    <li id="person">Contact Person : LEONARD TLADI</li>
											<li id="contact">Contact No: 073 6048 769</li>
											<li id="email">E-Mail: leonardtladi@madibeng.gov.co.za</li>
										</ul>
									
									
									</td>
									<td>
							
										<ul>
										    <li id="streetNumber" ><img src="resources/images/mainlogoo.jpg" width="70" height="70"></li>
											<li id="streetName">VELAPHANDA TRADING & PROJECTS</li>
											<li id="city_town">REG NO: 2008/164490/23</li>
											<li id="zipcode">POSTNET SUITE 357, PRIVATE BAG X1028</li>
											<li id="zipcode">LYTTLETON 0140</li>
											<li id="zipcode">TEL: 012 765 0200 FAX: 086 430 7955</li>
											<li id="zipcode">E-MAIL: sales@velaphanda.co.za</li>
										</ul>
									
									</td> 
									<td>
														
										<ul class="list" style="display: block;">
											<li id="firstName">Delivery Date: </li>
											<li id="lastName">Delivery Note No: </li>
											<li id="email">Customer Order No: ${OrderNum.orderNum}</li>
											<li id="cellphoneNumber">Customer VAT No: </li>
											<li id="telephoneNumber">WAYBILL No: </li>
											<li id="telephoneNumber">Please Remit To: </li>
										</ul>
									
									</table>
								</div>
									</td>
								   </tr>
								   
		
								</div>
								
							 </table><br>	
							</fieldset><br>
							<!-- Below table will be displayed as Data table -->
						<table id="myDatatable" class="display datatable" border="2%">
							<thead>
								<tr>
									<th><b>Part No</b></th>
									<th><b>Description</b></th>
									<th><b>QtyOrdered</b></th>
									<th><b>QtyDelv</b></th>
										<!-- <th>Stock Type</th> -->
								</tr>
							</thead>
							<tbody>
								<!-- Iterating over the list sent from Controller -->
								<c:forEach var="list" items="${pendingOrderList}">
									<tr>
										<td>${list.partNumber}</td>
										<td>${list.itemDescription}</td>
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

<script type="text/javascript" src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.2/jspdf.min.js"></script>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script src="http://code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.debug.js"></script>
		

 

</html>

