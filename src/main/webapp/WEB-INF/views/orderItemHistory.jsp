<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Approved Orders | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/custom/css/orderhistory.css"/>">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/custom/css/vela_custom.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/fonts/font-awesome.min.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" />
	

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">
<style type="text/css">

.orderDetails {
    margin-left: -14px;
}
table#orderDetails {
    margin-left: 14%;
    /* margin-right: -9%; */
    width: 73%;
}

</style>
</head>
<body>
	<div class="velaphanda_containter">
		<c:import url="templates/techniciannavbar.jsp"></c:import>
		<div class="container">
		
			<form:form action="searchOrderNumber" method="post"
				id="searchOrderNumber">

			</form:form>
			
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">						
						<div align="center">
							<b>Order No : ${OrderNum.orderNum}</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
						
					<div id="navbar" class="navbar-collapse collapse" style="margin-left:-2%">
						<ul class="nav navbar-nav navbar-left">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">Receive Order<span class="caret"></span></a>
									 <ul class="dropdown-menu">
										<c:choose>
											<c:when test="${OrderNum.status == 'Shipped'}">  
											   <li><a href="receive?recordID=<c:out value='${OrderNum.recordID}'/>">Receive Order</a></li>
											</c:when>											  	
										</c:choose>											
									</ul>
							</li>
							<li class="active"><a href="#">Print</a></li>
							<li><a href="#">Download PDF </a></li>
						</ul>
					</div>
					<legend></legend>
					<ul class="nav nav-tabs">
						<li class="active"><a href="#orderDetails" data-toggle="tab">Order Details</a></li>
						<li><a href="#orderHistoryDetails" data-toggle="tab">History</a></li>
					</ul>
					
					<div class="tab-content">

						<!--#orderDetails tab-->
						<div class="tab-pane active" id="orderDetails">
							<br/><br/>	
							<div id="pagewrap">
								
									<section id="content" style="width:35%;">
										<div class="groupclientdetails">
											<legend style="font-size: 12px;line-height: 1.42857143;">From</legend>
										
												<div class="machinedetailsdetailsfloatleft">
												
													<label id="companyName" name="companyName"><b>${velaphandaAddres.companyName}
													</b></label> <br> 
													<li id="streetNumberStreetName" name="streetNumberStreetName">${velaphandaAddres.streetNumber} ${velaphandaAddres.streetName}</li>
													<li id="city" name="city">${velaphandaAddres.city}</li>
													<li id="areaCode" name="areaCode">${velaphandaAddres.areaCode}</li>
													<li id="telephoneNumber" name="telephoneNumber">Switchboard: ${velaphandaAddres.telephoneNumber}</li>
													<li id="faxNumber" name="faxNumber">Fax :   ${velaphandaAddres.faxNumber}</li> 
													<li id="emailAdress" name="emailAdress">Email :  ${velaphandaAddres.emailAdress}</li> 
													
												</div>								
												
										</div>
									</section>

									<section id="middle">
	
										<div class="groupclientaddress">
											<legend style="font-size: 12px;line-height: 1.42857143;">To</legend>
		
											<div class="machinedetailsfloatright ">	
												  
												  <div class="orderDetails">
													
													<c:if test="${not empty OrderNum.customer.customerName}">
															<li id="siteStock"><b>${OrderNum.customer.customerName}</b></li>
															<li id="streetNumberStreetName">${OrderNum.customer.streetNumber} ${OrderNum.customer.streetName}</li>
															<li id="city_town">${OrderNum.customer.city_town}</li>
															<li id="province">${OrderNum.customer.province}</li>
															<br/>														
															<li id="placedBy ">Placed By : ${OrderNum.employee.firstName} ${OrderNum.employee.lastName}</li>
															<li id="approvedDate">Approved By : ${approver}</li>
													
													</c:if>	
													<c:if test="${empty OrderNum.customer.customerName}">
														<li id="placedBy ">Placed By : ${OrderNum.employee.firstName} ${OrderNum.employee.lastName}</li>
														<li id="Email">Email: ${OrderNum.employee.email}</li>
														<li id="Contact Number">Contact Number: ${OrderNum.employee.cellNumber}</li>
														<li id="approvedDate">Approved By : ${approver}</li>
														
													</c:if>
													
												  </div><br>
											</div>
		
										</div>
										
									</section>

									<aside id="sidebar">
									
										<div class="groupproductdetails">
										<legend style="font-size: 12px;line-height: 1.42857143;">Order</legend>
											<div class="machinedetailsfloatright ">	
												   <div class="orderDetails">
													<li style="font-size:15px;" id="orderNum"><b>${OrderNum.orderNum}</b></li>
													<li id="status">Order Status: ${OrderNum.status}</li>	
													<li id="dateOrdered">Stock Type: ${OrderNum.stockType}</li>												  
													<li id="dateOrdered">Ordered Date: ${OrderNum.dateOrdered}</li>							
													
												  </div><br>
												   
											</div>	
											
										</div>
									</aside>
									
									<div class="limeItems" style="margin-left:1%;">
									
										<legend style="font-size: 12px;line-height: 1.42857143;">Line Items</legend>
										<table id="orderInfo" class="display datatable">
												<thead>
													<tr>
														<th>Part No</th>
														<th>Compatible Devices</th>
														<th>Description</th>
														<th>Quantity</th>
														<!-- <th>Placed By</th>
														<th>Approver</th> -->
	
													</tr>
												</thead>
												<tbody>
													<!-- Iterating over the list sent from Controller -->
													<c:forEach var="list" items="${pendingOrderList}">
														<tr>
															<td>${list.partNumber}</td>
															<td>${list.model}</td>
															<td>${list.itemDescription}</td>
															<td>${list.quantity}</td>
															<%-- <td>${list.technician}</td>
															<td>${list.quantity}</td> --%>
														</tr>
													</c:forEach>
												</tbody>
											</table>
											
										 </div>									
								
							</div>

							
						</div>

						<!--#orderHistoryDetails tab-->
						<div class="tab-pane" id="orderHistoryDetails">

							<div class="groupdetails-row-padding">

								<div class="groupclientdetails">
										<br/>
											<legend>Order Status</legend>
										<form:form modelAttribute="orderHistory" method="post"
											action="orderHistory" id="orderHistory" name="orderHistory">

											<!-- Below table will be displayed as Data table -->
											<table id="orderDetails"
												class="table table-striped table-bordered table-hover table-condensed">
												<thead>
													<tr>
														<th>Order Status</th>
														<th>Date/Time</th>

													</tr>
												</thead>
												<tbody>
													<!-- Iterating over the list sent from Controller -->
													<c:forEach var="list" items="${status}">
														<tr>

															<td>${list.orderStatus}</td>
															<td>${list.statusDateTime}</td>

														</tr>
													</c:forEach>
												</tbody>
											</table>
											<!-- table order History -->

										</form:form>
										<!-- form order History -->										

								</div><!-- group client details -->
							 	 
							</div>
							<!-- group details-row-padding -->

						</div>
						
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
<!-- Paging the table -->
<script type="text/javascript">
	$(document).ready(function() {
		$('#orderInfo').DataTable({
			"jQueryUI" : true,
			"pagingType" : "full_numbers",
			"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ]
		/* few more options are available to use */
		});
	});
</script>
</html>
