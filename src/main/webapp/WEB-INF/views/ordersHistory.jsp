<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Order History | Velaphanda Trading & Projects</title>
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

<style>
li {
	list-style: none;
}

.shippedOrderContainer {
	padding: 25px;
	margin-bottom: -1em;
	width: auto;
	display: table;
}

p.shippedOrder {
	font-size: 1.1em;
	font-weight: bolder;
	margin-left: 19%;
}

ul.shippedListDetails {
	margin-left: -7%;
}

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
    width: 56%;
    padding: 5px 15px;
    float: left;
}

/************************************************************************************
MEDIA QUERIES
*************************************************************************************/
@media only screen and (max-width: 760px) , ( max-device-width : 1024px)
	and (min-device-width: 768px) {
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
							<b>Order History</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">
											 
						<div class="groupdetails-row-padding">

							<div id="pagewrap">
								<section id="content">
								<div class="groupclientdetails">
									<legend>Order Info</legend>

									<div class="machinedetailsdetailsfloatleft">
										<label id="status" name="status">Status</label> <br> 
										<label id="Approved" name="Approved">Approved </label> <br>
										<label id="Pending" name="Pending">Pending </label> <br> 										 
										<label id="Ship Order" name="Ship Order">Ship Order </label> <br>
										<label id="Order Received" name="Order Received">Order Received </label> <br> 
										
									</div>
									<div class="machinedetailsfloatright ">
										<label id="status" name="status">: </label><br>
										<label id="Approved" name="Approved">: </label><br>
										<label id="Pending" name="Pending">: </label><br>
										<label id="Ship Order" name="Ship Order">: </label><br> 
										<label id="Order Received" name="Order Received">: </label><br>
										
									</div>
									<div class="col-sm-6">

							<div id="shippedOrderContainer"
								style="width: auto; display: table;">
								<p class="shippedOrder"></p>
								<ul class="shippedListDetails" style="display: block;">
									<li id="city_town">${customer.city_town}</li>
									<li id="zipcode">${customer.zipcode}</li>
								</ul>

							</div>
						</div> 
								</div>
								</section>

								<aside id="sidebar">

								<div class="groupproductdetails">
									<legend>Order Details</legend>
									
									<form:form modelAttribute="orderHistory" method="post"
										action="orderHistory" id="orderHistory" name="orderHistory">

										<!-- Below table will be displayed as Data table -->
										<table id="myDatatable" class="display datatable">
											<thead>
												<tr>
													
													<th>Order No</th>
													<th>Order Status</th>
													<th>Approved Date</th>
													<th>Stock Type</th>
													<th>Order Details</th>

												</tr>
											</thead>
											<tbody>
												<!-- Iterating over the list sent from Controller -->
												<c:forEach var="list" items="${orderList}">
													<tr>
														
														<td>${list.orderNum}</td>
														<td>${list.status}</td>
														<td>${list.dateOrdered}</td>
														<td>${list.stockType}</td>
														<td><a
															href="orderitemHistory?recordID=<c:out value='${list.recordID}'/>">Details</a></td>

													</tr>
												</c:forEach>
											</tbody>
										</table>



									</form:form>

								</div>
								</aside>

							</div>

						</div>
						<!--  -->


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
			$('#myDatatable').DataTable({
				"jQueryUI" : true,
				"pagingType" : "full_numbers",
				"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ]
			/* few more options are available to use */
			});
		});
</script>
</html>
