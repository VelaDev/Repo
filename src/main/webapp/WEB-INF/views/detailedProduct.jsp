<%@ include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Detailed Product | Velaphanda Trading & Projects</title>
</head>

<body>
	<div class="velaphanda_containter">
		<c:import url="templates/navbar.jsp"></c:import>
		<div class="container">
			
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="left">
							<b>Machine Details</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">
						<div class="groupdetails-row-padding">

							<div id="pagewrap">
								<section id="content">
									<div class="groupclientdetails">
										<legend>Machine Details</legend>
											
											
												<div class="machinedetailsdetailsfloatleft">
													<label id="customerName" name="customerName">Company Name </label> <br> 
													<label id="serialNumber" name="serialNumber">Serial No </label> <br> 
													<label id="modelNumber" name="modelNumber">Model Number </label> <br> 
													<label id="modelBrand" name="modelBrand">Model Brand </label> <br> 
													<label id="startDate" name="startDate">Start Date </label> <br> 
													<label id="installationDate" name="installationDate">Installation Date </label> <br> 
													<label id="endDate" name="endDate">End Date </label> <br> 
													<label id="colourReading" name="colourReading">Colour Reading </label> <br> 
													<label id="colourCopyCost" name="colourCopyCost">Colour Copy Cost </label> <br> 
													<label id="monoReading" name="monoReading">Mono Reading </label> <br> 
													<label id="monoCopyCost" name="monoCopyCost">Mono Copy Cost </label> <br> 
												</div>								
												<div class="machinedetailsfloatright ">	
												   <label id="customerName" name="customerName">: ${device.customer.customerName}</label><br> 
												   <label id="serialNumber" name="serialNumber">: ${device.serialNumber}</label><br>
												   <label id="modelNumber" name="modelNumber">: ${device.modelNumber}</label><br> 
												   <label id="modelBrand" name="modelBrand">: ${device.modelBrand}</label><br> 
												   <label id="startDate" name="startDate">: ${device.startDate}</label><br> 
												   <label id="installationDate" name="installationDate">: ${device.installationDate}</label><br> 
												   <label id="endDate" name="endDate">: ${device.endDate}</label><br> 
												   <label id="colourReading" name="colourReading">: ${device.colourReading}</label><br>
												   <label id="colourCopyCost" name="colourCopyCost">: R${device.colourCopyCost}</label><br> 
												   <label id="monoReading" name="monoReading">: ${device.monoReading}</label><br>
												   <label id="monoCopyCost" name="monoCopyCost">: R${device.monoCopyCost}</label><br>
												</div>
									</div>
								</section>

								<section id="middle">

									<div class="groupclientaddress">
										<legend>Address and Contacts</legend>
	
										<div id="customerr_container" style="width: auto; display: table;">
											<p class="customerAddress_title">Address
											<ul class="address_list" style="display: block;">
												<li id="streetName">${device.streetNumber}
													${device.streetName}</li>
												<li id="streetNumber">${device.city_town}</li>
												<li id="city_town">${device.province}</li>	
											</ul>
											</p>
											<p class="customerAddress_title">Contact
											<ul class="address_list" style="display: block;">
												<li id="cellphoneNumber">
													${device.contactPerson.firstName}
													${device.contactPerson.lastName}</li>
												<li id="streetNumber" id="telephoneNumber">${device.contactPerson.cellphone}</li>
												<li id="streetNumber" id="telephoneNumber">${device.contactPerson.email}</li>
												<li id="email"></li>
											</ul>
											</p>
										</div>
	
									</div>
								</section>

								<aside id="sidebar">
								
									<div class="groupproductdetails">
									<legend>Machine Accessories</legend>
											<!-- Below table will be displayed as Data table -->
											<table id="myDatatable" class="display datatable">
												<thead>
													
													<tr>
														<th>Accessory Type</th>
														<th>Serial No</th>
	
													</tr>
												</thead>
												<tbody>
													<!-- Iterating over the list sent from Controller -->
	
													<c:forEach items="${accessories}" var="accessory">
														<tr>
															<td><h6>
																	<c:out value="${accessory.accessotyType}" />
																</h6></td>
															<td><h6>
																	<c:out value="${accessory.serial}" />
																</h6></td>
	
														</tr>
													</c:forEach>
	
												</tbody>
											</table>
										
									</div>
								</aside>
								
							</div>

						</div><!--  -->
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
	<!-- /Script -->
	<script type="text/javascript"
		src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>


	<script>
	$(document).ready(function() {
		$('#myDatatable').DataTable({
			"jQueryUI" : true,
			"pagingType" : "full_numbers",
			"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ]
		/* few more options are available to use */
		});
	});
</script>
</html>

</body>
</html>