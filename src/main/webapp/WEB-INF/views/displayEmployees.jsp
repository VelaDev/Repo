<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Display Employees | Velaphanda Trading & Projects</title>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style class="anchorjs"></style>
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/custom/css/vela_custom.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">



</head>
<body class="bb-js" >
	<div class="velaphanda_containter">
		<c:import url="templates/navbar.jsp"></c:import>
		<div class="container">
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Employees List</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">

						<!-- Below table will be displayed as Data table -->
						<table id="myDatatable" class="display datatable">
							<thead>
								<tr>
									<th>First Name</th>
									<th>Last Name</th>
									<th>Email</th>
									<th>Cell No</th>
									<th>Status</th>
									<th>Role</th>
									<th>Login Activities</th>
									<th>Update</th>
									<th>Reset</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<!-- Iterating over the list sent from Controller -->
								<c:forEach var="list" items="${displayEmployees}">
									<tr>
										<td>${list.firstName}</td>
										<td>${list.lastName}</td>
										<td>${list.email}</td>
										<td>${list.cellNumber}</td>
										<td>${list.status}</td>
										<td>${list.role}</td>
										<td>
											<a	href="searchEmployeeByNameForActivities?email=<c:out value='${list.email}'/>">Login	Activities</a>
										</td>
										<td>
											<a href="searchEmployeeByName?email=<c:out value='${list.email}'/>">
											
											<c:choose>
											  <c:when test="${list.status=='ACTIVE'}"> Update </c:when>											  	
											</c:choose>
											
											<c:choose>
											  <c:when test="${list.status=='INACTIVE'}">  </c:when>											  	
											</c:choose>
											
											</a>
										</td>
										<td>
											<a href="searchEmployeeForPasswordReset?email=<c:out value='${list.email}'/>">
												 
												<c:choose>
													<c:when test="${list.status=='ACTIVE'}"> 
												        Reset
										 	         </c:when> 
										 	         <c:when test="${list.status=='BLOCKED'}"> 
												      	Reset
											         </c:when>
											  		<c:when test="${list.status=='INACTIVE'}">  </c:when>	
											  		
											  		<c:when test="${list.status=='INACTIVE'}"> </c:when>										  	
												</c:choose>
												
											</a>
										</td>
										<td>
											<a 	href="searchEmployeeForDeactivation?email=<c:out value='${list.email}'/>">
												<c:choose>
													<c:when test="${list.status=='ACTIVE'}"> 
												        Deactivate
										 	         </c:when>
										 	         
													<c:when test="${list.status=='BLOCKED'}"> 
												      
											         </c:when>
											         										          
													 <c:when test="${list.status=='INACTIVE'}">
													 	Activate	
													 </c:when>
													 
   												 	 <c:when test="${list.status=='INACTIVE'}">
											          
											         </c:when>
											         
												</c:choose>
												
													
											</a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<br>

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
<!-- Scripts -->
<script type="text/javascript"
	src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />">
	
</script>

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

<!-- Deactivate script -->
<script>
	$(document).on('click', ':not(form)[data-confirm]', function(e) {
		if (!confirm($(this).data('confirm'))) {
			e.stopImmediatePropagation();
			e.preventDefault();
		}
	});
</script>

<!-- /Scripts -->

</html>
