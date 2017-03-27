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
	width: 42%;
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
	width: 33%;
	padding: 5px 15px;
	float: left;
}


/************************************************************************************
MEDIA QUERIES
*************************************************************************************/
/* for 980px or less */
@media screen and (max-width: 980px) {
	
	#pagewrap {
		width: 94%;
	}
	#content {
		width: 41%;
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
									<form:form>
										<div class="row">
											<div class="col-xs-8">
												<div class="col-xs-4 form-control-label">
													<h6>
														<label>Serial No:</label>
													</h6>

												</div>
												<div class="col-xs-8">
													<input type="text" class="form-control input-sm"
														value="${device.serialNumber}" disabled="disabled">
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-8">
												<div class="col-xs-4 form-control-label">
													<h6>
														<label>Model No:</label>
													</h6>

												</div>
												<div class="col-xs-8">
													<input type="text" class="form-control input-sm"
														value="${device.modelNumber}" disabled="disabled">
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-8">
												<div class="col-xs-4 form-control-label">
													<h6>
														<label>Contract Start Date:</label>
													</h6>

												</div>
												<div class="col-xs-8">
													<input type="text" class="form-control input-sm"
														value="${device.startDate}" disabled="disabled">
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-8">
												<div class="col-xs-4 form-control-label">
													<h6>
														<label>Installation Date</label>
													</h6>

												</div>
												<div class="col-xs-8">
													<input type="text" class="form-control input-sm"
														value="${device.installationDate}" disabled="disabled">
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-8">
												<div class="col-xs-4 form-control-label">
													<h6>
														<label>Contract End Date</label>
													</h6>

												</div>
												<div class="col-xs-8">
													<input type="text" class="form-control input-sm"
														value="${device.endDate}" disabled="disabled">
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-8">
												<div class="col-xs-4 form-control-label">
													<h6>
														<label>Company Name</label>
													</h6>
												</div>
												<div class="col-xs-8">
													<input type="text" class="form-control input-sm"
														value="${device.customer.customerName}"
														disabled="disabled">
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-8">
												<div class="col-xs-4 form-control-label">
													<h6>
														<label>Colour Reading</label>
													</h6>

												</div>
												<div class="col-xs-8">
													<input type="text" class="form-control input-sm"
														id="monoReading" value="${device.colourReading}"
														disabled="disabled">
												</div>												
											</div>
										</div>
										
										<div class="row">
											<div class="col-xs-8">
												<div class="col-xs-4 form-control-label">
													<h6>
														<label>Colour CopyCost</label>
													</h6>

												</div>
												<div class="col-xs-8">
													<input type="text" class="form-control input-sm"
														id="monoReading" value="${device.colourCopyCost}"
														disabled="disabled">
												</div>												
											</div>
										</div>

										<div class="row">
											<br />
											<div class="col-xs-8">
												<div class="col-xs-4 form-control-label">
													<h6>
														<label>Mono Reading</label>
													</h6>

												</div>
												<div class="col-xs-8">
													<input type="text" class="form-control input-sm"
														id="monoReading" value="${device.monoReading}"
														disabled="disabled">
												</div>
											</div>
										</div>
										
										<div class="row">
											<br />
											<div class="col-xs-8">
												<div class="col-xs-4 form-control-label">
													<h6>
														<label>Mono Copy Cost</label>
													</h6>

												</div>
												<div class="col-xs-8">
													<input type="text" class="form-control input-sm"
														id="monoReading" value="${device.monoCopyCost}"
														disabled="disabled">
												</div>
											</div>
										</div>

									</form:form>
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