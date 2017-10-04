<%@ include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Detailed Product | Velaphanda Trading & Projects</title>

<link type="text/css" rel="stylesheet" href="<c:url value="/resources/custom/css/vela_details.css" />">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">

<style>li { list-style: none; }</style>

</head>

<body>
	<div class="velaphanda_containter">
		<c:import url="templates/usernavbar.jsp"></c:import>
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
													<label id="customerName" name="customerName">Customer Name </label> <br> 
													<label id="serialNumber" name="serialNumber">Serial No </label> <br> 
													<label id="modelNumber" name="modelNumber">Model Number </label> <br> 
													<label id="modelBrand" name="modelBrand">Model Brand </label> <br> 
													<label id="startDate" name="startDate">Start Date </label> <br> 
													<label id="installationDate" name="installationDate">Installation Date </label> <br> 
													<label id="endDate" name="endDate">End Date </label> <br>
																										
													<c:if test="${not empty device.colourReading }">
														<label id="colourReading" name="colourReading">Colour Reading </label> <br> 
													</c:if>
													<c:if test="${empty device.colourReading }">
													</c:if>
													
													<c:if test="${not empty device.colourCopyCost }">
														<label id="colourCopyCost" name="colourCopyCost">Colour Copy Cost </label> <br> 
													</c:if>
													<c:if test="${empty device.colourCopyCost }">
													</c:if>
																																						
													<c:if test="${not empty device.monoReading }">
														<label id="monoReading" name="monoReading">Mono Reading </label> <br>
													</c:if>
													<c:if test="${empty ddevice.monoReading }">
													</c:if>
															
													<c:if test="${not empty device.monoCopyCost }">
													<label id="monoCopyCost" name="monoCopyCost">Mono Copy Cost </label> <br> 
													</c:if>
													<c:if test="${empty device.monoCopyCost }">
													</c:if>
															
													
												</div>								
												<div class="machinedetailsfloatright ">	
												   <label id="customerName" name="customerName">: ${device.customerDevice.customerName}</label><br> 
												   <label id="serialNumber" name="serialNumber">: ${device.serialNumber}</a></label><br>
												   <label id="modelNumber" name="modelNumber">: ${device.modelNumber}</label><br> 
												   <label id="modelBrand" name="modelBrand">: ${device.modelBrand}</label><br> 
												   <label id="startDate" name="startDate">: ${device.startDate}</label><br> 
												   <label id="installationDate" name="installationDate">: ${device.installationDate}</label><br> 
												   <label id="endDate" name="endDate">: ${device.endDate}</label><br>
												   
												   <c:if test="${not empty device.colourReading }">
												   <label id="colourReading" name="colourReading">: ${device.colourReading}</label><br>
												   </c:if>
												   <c:if test="${ empty device.colourReading }">
												   </c:if>
												   
												   <c:if test="${not empty device.colourCopyCost }">
												   <label id="colourCopyCost" name="colourCopyCost">: R${device.colourCopyCost}</label><br> 
												   </c:if>
												   <c:if test="${ empty device.colourCopyCost }">
												   </c:if>
												   
												   <c:if test="${not empty device.monoReading }">
												   <label id="monoReading" name="monoReading">: ${device.monoReading}</label><br>
												   </c:if>
												    <c:if test="${ empty device.monoReading }">
												   </c:if>
												   
												   <c:if test="${not empty device.monoCopyCost }">
												  	 <label id="monoCopyCost" name="monoCopyCost">: R${device.monoCopyCost}</label><br>
												   </c:if>
												    <c:if test="${ empty device.monoCopyCost}">
												    </c:if>
												   
												</div>
									</div>
								</section>

								<section id="middle">

									<div class="groupclientaddress">
										<legend>Address and Contact Person</legend>
	
										<div id="customerr_container" style="width: auto; display: table;">
											<p class="customerAddress_title">Address
											<ul class="address_list" style="display: block;">
												<li id="streetNumberStreetName">${device.streetNumber}	${device.streetName}</li>
												<li id="city_town">${device.city_town}</li>
												<li id="province">${device.province}</li>	
											</ul>
											</p>
											<p class="customerAddress_title">Contact
											<ul class="address_list" style="display: block;">
												<li id="firstNameLastname">${device.contactPerson.firstName} ${device.contactPerson.lastName}</li>
												<li id="cellphone">${device.contactPerson.cellphone}</li>
												<li id="telephone">${device.contactPerson.telephone}</li>
												<li id="email">${device.contactPerson.email}</li>
												
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


<script type="text/javascript">
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