<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Ticket Details | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

  <link type="text/css" rel="stylesheet" href="<c:url value="/resources/custom/css/vela_custom.css" />">
  <link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
  <link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">	
  <link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">
  <style>
li {
	list-style: none;
}
.machinedetailsfloatright {
    float: left;
    /* margin-right: 40%; */
    padding-left: 23px;
}
.machinedetailsdetailsfloatleft {
	float: left;
	margin-left: 10px;
}
#customerr_container {
    /* padding: 25px; */
    /* margin-bottom: -7em; */
    width: auto;
    display: table;
    font-size: 100%;
    margin-left: -15%;
}
p.contactPerson_title, p.customerAddress_title {
    font-size: 1.1em;
    font-weight: bolder;
    margin-left: -11%;
}
ul.address_list {
    margin-left: -31%;
}
/* STRUCTURE */

#content {
	width: 40%;
	float: left;
	padding: 5px 15px;
}

#middle {
	width: 22%; /* Account for margins + border values */
	float: left;
	padding: 5px 15px;
	margin: 0px 5px 5px 5px;
}

#sidebar {
	width: 35%;
	padding: 5px 15px;
	float: left;
}


/************************************************************************************
MEDIA QUERIES
*************************************************************************************/
@media only screen and (max-width: 760px), (max-device-width: 1024px) and (min-device-width: 768px){
	.machinedetailsfloatright {
		float: left;
		margin-right: -31%;
		padding-left: 9%;
		margin-top: 0%;
	}
}
/* for 980px or less */
@media screen and (max-width: 980px) {
	
	#pagewrap {
		width: 94%;
	}
	#content {
		width: 40%;
		padding: 1% 4%;
	}
	#middle {
		width: 41%;
		padding: 1% 4%;
		margin: 0px 0px 5px 5px;
		float: right;
	}
	
	#sidebar {
		clear: both;
		padding: 1% 4%;
		width: auto;
		float: none;
	}


}

/* for 700px or less */
@media screen and (max-width: 600px) {

	#content {
		width: auto;
		float: none;
	}
	
	#middle {
		width: auto;
		float: none;
		margin-left: 0px;
	}
	
	#sidebar {
		width: auto;
		float: none;
	}

}

/* for 480px or less */
@media screen and (max-width: 480px) {


	#sidebar {
		display: none;
	}

}

header, #content, #middle, #sidebar {
	margin-bottom: 5px;
}

</style>
</head>
<body>
	<div class="velaphanda_containter">
		<c:import url="templates/techniciannavbar.jsp"></c:import>
		<div class="container">
			<br />
			<div class="panel panel-success">
				<div class="panel-heading">
					<div align="center">
						<b>Ticket Details</b>
					</div>
				</div>
				<div class="panel-body">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#generalDetails"data-toggle="tab">General</a></li>
						<li><a href="#escalationDetails" data-toggle="tab">Escalate</a></li>
						<li><a href="#solutionsDetails" data-toggle="tab">Solution</a></li>
						<li><a href="#historyDetails" data-toggle="tab">History</a></li>

					</ul>
					
					<!-- tab nav -->
					<div class="tab-content">

						<!--general tab-->
						<div class="tab-pane active" id="generalDetails">
							<h4 align="center">General Info</h4>
							
							
							
							<div class="tab-content">
						<div class="groupdetails-row-padding">

							<div id="pagewrap">
								<section id="content">
									<div class="groupclientdetails">
										<legend>General Infomation</legend>
											
											
												<div class="machinedetailsdetailsfloatleft">
													<label id="customerName" name="customerName">Ticket Number </label> <br> 
													<label id="serialNumber" name="serialNumber">Status </label> <br> 
													<label id="modelNumber" name="modelNumber">Subject </label> <br> 
													<label id="modelBrand" name="modelBrand">Description </label> <br> 
													<label id="startDate" name="startDate">Date Time </label> <br> 
													<label id="technician" name="technician">Technician </label> <br>
												</div>								
												<div class="machinedetailsfloatright ">	
												   <label id="customerName" name="customerName">: ${ticketObject.ticketNumber}</label><br> 
												   <label id="serialNumber" name="serialNumber">: ${ticketObject.status}</label><br>
												   <label id="modelNumber" name="modelNumber">: ${ticketObject.subject}</label><br> 
												   <label id="modelBrand" name="modelBrand">: ${ticketObject.description}</label><br> 
												   <label id="startDate" name="startDate">: ${ticketObject.dateTime}</label><br>
												   <label id="technician" name="technician">: ${ticketObject.employee.firstName} ${ticketObject.employee.lastName}</label><br> 
												</div>
									</div>
								</section>

								<section id="middle">

									<div class="groupclientaddress">
										<legend>Customer Details</legend>
	
										<div id="customerr_container" style="width: auto; display: table;">
													<label id="customerName" name="customerName">Customer Name : ${ticketObject.getDevice().getCustomerDevice().getCustomerName()}</label> <br> 
													<label id="serialNumber" name="serialNumber">Street Address :${ticketObject.getDevice().getCustomerDevice().getStreetNumber()} ${ticketObject.getDevice().getCustomerDevice().getStreetName()} </label> <br> 
													<label id="modelNumber" name="modelNumber">City/Town : ${ticketObject.getDevice().getCustomerDevice().getCity_town()} </label> <br> 
													<label id="modelBrand" name="modelBrand">Area Code :  ${ticketObject.getDevice().getCustomerDevice().getZipcode()}</label> <br><br> 
													</div>								
									</div>
										</div>
	
									</div>
								</section>

								<aside id="sidebar">
								
									<div class="groupproductdetails">
									<legend>Device Details</legend>
											<!-- Below table will be displayed as Data table -->
											<div id="customerr_container" style="width: auto; display: table;">
													<label id="customerName" name="customerName">Serial Number : ${ticketObject.getDevice().getSerialNumber()}</label> <br> 
													<label id="serialNumber" name="serialNumber">Model Number : ${ticketObject.device.modelNumber }</label> <br> 
													<label id="modelNumber" name="modelNumber">Brand Name : ${ticketObject.device.modelBrand } </label> <br> <br>
													<label id="startDate" name="startDate">Contact Person:  ${ticketObject.device.contactPerson.firstName} ${ticketObject.device.contactPerson.lastName}</label> <br> 
													<label id="technician" name="technician">Email:  ${ticketObject.device.contactPerson.email }</label> <br>
													<label id="technician" name="technician">Cell Number:  ${ticketObject.device.contactPerson.cellphone }</label> <br>
												 <label id="technician" name="technician">Telephone Number:  ${ticketObject.device.contactPerson.telephone }</label> <br>
												 
													</div>
										
									</div>
								</aside>
								
							</div>

						</div><!--  -->
						<!--/general tab-->
						<!--escalationDetails tab-->
						<div class="tab-pane" id="escalationDetails">
							<h4 align="center">Escalate Ticket</h4>
							<form:form class="well form-horizontal" action="updateTicket"
								modelAttribute="updateTicket" method="post">
								
								<!-- Text input Ticket Number-->
									<div class="form-group">
										<label class="col-md-3 control-label">Ticket Number</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-barcode"></i></span> <input
													name="ticketNumber" id="ticketNumber" class="form-control"
													type="text" value="${ticketObject.ticketNumber}" readonly="readonly">
											</div>
										</div>
									</div>
									
								
								<!-- Text area Escalate-->
								<div class="form-group">
									<label class="col-md-3 control-label">Escalate </label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<input type="checkbox" name="escalate" value="true"
												required="required">
										</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label">Awaiting Spares </label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<input type="checkbox" name="AwaitingSpares" value="true"
												required="required">
										</div>
									</div>
								</div>
								<!-- Select type Assign Technician-->						
									<div class="form-group">
										<label class="col-md-3 control-label">Order No</label>
										<div class="col-md-6 selectContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-list"></i></span> <select name="orderNumber"
													class="form-control selectpicker">
													<option>Select Order No</option> 
													<c:forEach items="${OrderNumber}" var="orders">
														<option value="${orders.orderNum}">${orders.orderNum}
															</option>
													</c:forEach>								
												</select>
											</div>
										</div>
									</div>
								<!-- Text area Escalate Reason-->
								<div class="form-group">
									<label class="col-md-3 control-label">Reason</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-pencil"></i></span>
											<textarea class="form-control" name="escalateReason"
												required="required"></textarea>
										</div>
									</div>
								</div>
								<br>
								<div class="form-group row">
									<div class="col-sm-offset-2 col-md-8">
										<input type="submit" value="Submit"
											class="btn btn-primary btn-block btn-lg"
											id="escalateTickt">
									</div>
								</div>
							</form:form>
						</div>
						<!--/escalationDetails tab-->

						<!--solution tab-->
						<div class="tab-pane" id="solutionsDetails">
							<h4 align="center">Solution Details</h4>
							<form:form class="well form-horizontal">
								
								<!-- Text input Ticket Number-->
									<div class="form-group">
										<label class="col-md-3 control-label">Ticket Number</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-barcode"></i></span> <input
													name="ticketNumber" id="ticketNumber" class="form-control"
													type="text" value="${ticketObject.ticketNumber}">
											</div>
										</div>
									</div>
									
									<!-- Text input Part Number Used-->
									<div class="form-group">
										<label class="col-md-3 control-label">Part Number Used</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-barcode"></i></span> <input
													name="ticketNumber" id="partNumberUsed" class="form-control"
													type="text" value="">
											</div>
										</div>
									</div>
									
																
								<!-- Text area Action Taken-->
								<div class="form-group">
									<label class="col-md-3 control-label"> Action Taken </label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-pencil"></i></span>
											<textarea class="form-control" id="actionTaken" name="actionTaken"
												required="required"></textarea>
										</div>
									</div>
								</div>
								<br />
								<div class="form-group">
									<div class="col-sm-offset-2 col-md-8">
										<input type="submit" value="Solution"
											class="btn btn-primary btn-block btn-lg" tabindex="9"
											id="solution">
									</div>
								</div>
							</form:form>
						</div>
						<!--/solution tab-->

						<!--history tab-->
						<div class="tab-pane" id="historyDetails">
							<h4 align="center">History Details</h4>
								<form:form class="well form-horizontal">
									<div class="panel-body">
											<!-- Below table will be displayed as Data table -->
											<table id="myDatatable" class="display datatable">
											<thead>
											<tr>
												<th>Ticket No <img src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
												<th>Date <img src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
												<th>Assigned To <img src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
												<th>Comment <img src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
												
											</tr>
										</thead>
										<tbody>
											<!-- Iterating over the list sent from Controller -->
											<c:forEach items="${ticketHistoryList}" var="history">
															<tr>
																<td><c:out value="${history.ticketNumber}" /></td>
																<td><c:out value="${history.escalatedDate}" /></td>
																<td><c:out value="${history.employee.firstName} ${history.employee.lastName}" /></td>
																<%-- <th><c:out value="${history.part.modelNumber}" /></td> --%>
																<td><c:out value="${history.escalatedReason}" /></td>


															</tr>
											 </c:forEach>
										</tbody>
									</table>
											
									</div>
								</form:form>
							
						</div>
						<!--/history tab-->

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

<script type="text/javascript"	src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
<script type="text/javascript"	src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>

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

</html>
