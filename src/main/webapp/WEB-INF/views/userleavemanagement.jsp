<%@include file="templates/taglibs.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Leave Management</title>

<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/custom/css/vela_custom.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/fonts/font-awesome.min.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/daterangepicker.css" />" />

<!-- Little Dash-board -->
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/ticketoverview.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/common-9a01e5a5a5a2f97d04552fa65cc3846b.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/fonts/sprites-b23bb97cb281c684a70d957ed91664df.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/app-310c175202e0f34694cea021357db448.css" />" />
<!-- //Little Dash-board -->

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">
<!--/style-->

<style type="text/css">

.selectDate {
    position: relative;
	display: inline-block;
	height: 28px;
	width: 48%;
	margin-left: 25%;    
}
.selectDate input {
    width: 100%; /* Arbitrary number */
    height: 100%;
    padding-right: 40px;
    box-sizing: border-box;
}
#calendar {
    height: 100%;
    width: 40px; 
    background-image: url(resources/images/calendar.png),url(resources/images/down_arrow.png);
	background-repeat: no-repeat;
    background-position: 50% 50%;
    border: none;
    background-color: transparent;
    position: absolute;
    top: 50%;
    right: 0;
    transform: translateY(-50%); /* OR margin-top: -20px (Half of the container's height) if you're supporting older browsers */
}


i.glyphicon.glyphicon-calendar.col-sm-pull-2 {
    right: -29%;
}

input#selectDateRange{
   
  cursor: pointer; 
  
}
.db-summary li:first-child:nth-last-child(4), .db-summary li:first-child:nth-last-child(4) 
	 ~ li {
	width: 10%;
}

.input-group-btn:last-child>.btn, .input-group-btn:last-child>.btn-group
	{
	z-index: 2;
	height: 26px;
	margin-left: -1px;
	padding-bottom: 17px;
}

.db-summary li:first-child {
	border-right: 1px #dfdfdf solid;
}

.db-summary li {
	float: left;
	box-sizing: border-box;
	border-right: 1px #dfdfdf solid;
}
</style>

</head>
<body>

	<div class="velaphanda_containter">
		<c:import url="templates/usernavbar.jsp"></c:import>
		<div class="container">
			<form:form action="searchOrderNumber" method="post"
				id="searchOrderNumber" modelAttribute="searchOrderNumber">

				<div style="margin-bottom: -3px; margin-left: -1px;" align=left>

					<!-- Select type selectDateRange-->
				   					<!-- Select type selectDateRange-->
					<div class="form-group ">
						<div class="col-md-3 selectContainer">
							<div class="input-group">
								<span class="input-group-addon"><i
									class="glyphicon glyphicon-list"></i></span> <select
									name="selectDateRange" id="selectDateRange"
									class="form-control selectpicker" onchange="location = this.value;">
									<c:if test="${empty newDate }">
									   <option>Select a date</option>
									</c:if>
									<c:if test="${not empty newDate }">
									   <option value="${ newDate}">${ newDate}</option>
									</c:if>
									     <c:forEach items="${dates}" var="date">
										   <option value="getUserSelectedLeaveDate?selectedDate=<c:out value='${date}'/>">${date}</option>
									 </c:forEach>		
								</select>

							</div>
						</div>
					</div>
				</div>

			</form:form>

			<div class="panel panel-success">
				<!--Search-->
				<div class="panel-heading">
					<h3 class="panel-title">
						<br /> <br />
						<div align="left">
							<b>Leave Management</b>
						</div>
					</h3>
				</div>

				<div class="panel-body">
					<div class="tab-content">

						<div class="ticket-summary row-fluid">

							<ul class="db-summary clearfix pb20 pt20 clear"
								id="ticket-summary" class="nav nav-tabs">

								<li><a href='userMakeLeave.html' data-parallel-url=""
									data-parallel-placeholder="#ticket-leftFilter"
									class="summery-filter clearfix" data-pjax="#body-container">

										<div class="summary-count pull-left ml20"
											style="margin-left: 28%">
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
											<br /> <br />
											<p align="center">Create Leave</p>
										</div>
								</a></li>

								<li><a href='<c:url value="pendingLeave"/>'
									class="summery-filter clearfix"
									data-parallel-url="PendingLeave"
									data-parallel-placeholder="#ticket-leftFilter"
									data-pjax="#body-container">

										<div class="summary-count pull-left ml20"
											style="margin-left: 4%">
											<h4 align="center">${countPendingLeave}</h4>
											<p align="center">Pending Leave</p>
										</div>
								</a></li>

								<li><a href='<c:url value="activeLeave"/>'
									class="summery-filter clearfix"
									data-parallel-url="ActiveLeave"
									data-parallel-placeholder="#ticket-leftFilter"
									data-pjax="#body-container">

										<div class="summary-count pull-left ml20"
											style="margin-left: 4%">
											<h4 align="center">${countActiveLeave}</h4>
											<p align="center">Active Leave</p>
										</div>
								</a></li>

								<li><a href='leaveHistory'
									data-parallel-url="LeaveHistory"
									data-parallel-placeholder="#ticket-leftFilter"
									class="summery-filter clearfix" data-pjax="#body-container">

										<div class="summary-count pull-left ml20"
											style="margin-left: 9%">
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
											<br /> <br />
											<p align="center">Leave History</p>
										</div>
								</a></li>

							</ul>
						</div>

						<form:form class="well form-horizontal" method="post"
							action="orderManage" id="orderManage"
							modelAttribute="orderManage">

							<!-- tab nav -->
							<div class="tab-content">

								<div class="tab-pane active" id="createOrder">

									<form:form modelAttribute="orderHistory" method="post"
										action="orderHistory" id="orderHistory" name="orderHistory">

										<!-- Below table will be displayed as Data table -->
										<table id="createLeaveDatatable" class="display datatable">
											<thead>
												<tr>
													<th>Leave Number</th>
													<th>Full Name</th>
													<th>Email</th>
													<th>Leave Status</th>
													<th>Leave Type</th>
													<th>Start Date</th>
													<th>End Date</th>
													<th>Contact</th>
													<th>Address During Leave</th>
													<!-- <th>Order Details</th> -->
												</tr>
											</thead>
											<tbody>
												<!-- Iterating over the list sent from Controller -->
												<c:forEach items="${leaveList}" var="leave" varStatus="itr">
													<tr>
														<td><a
															href="updateLeave?leaveID=<c:out value='${leave.leaveID}'/>">LV0000000${leave.leaveID}</a></td>
														<td><c:out
																value="${leave.employee.firstName} ${leave.employee.lastName}" /></td>
														<td><c:out value="${leave.employee.email}" /></td>
														<td><c:out value="${leave.status}" /></td>
														<td><c:out value="${leave.leaveType}" /></td>
														<td><c:out value="${leave.startDate}" /></td>
														<td><c:out value="${leave.endDate}" /></td>
														<td><c:out value="${leave.contactNumber}" /></td>
														<td><c:out value="${leave.address}" /></td>
														
													</tr>
												</c:forEach>
											</tbody>
										</table>
										<!-- table order -->
									</form:form>
									<!-- form order -->

								</div>

								<div class="tab-pane" id="pendingLeave">
									<legend align=center>Pending Leave</legend>
									<form:form modelAttribute="orderHistory" method="post"
										action="orderHistory" id="orderHistory" name="orderHistory">

										<!-- Below table will be displayed as Data table -->
										<table id="pendingLeaveDatatable" class="display datatable">
												<thead>
												<tr>
													<th>Leave Number</th>
													<th>Full Name</th>
													<th>Email</th>
													<th>Leave Status</th>
													<th>Leave Type</th>
													<th>Start Date</th>
													<th>End Date</th>
													<th>Contact</th>
													<th>Address During Leave</th>
													<!-- <th>Order Details</th> -->
												</tr>
											</thead>
											<tbody>
												<!-- Iterating over the list sent from Controller -->
												<c:forEach items="${leaveList}" var="leave" varStatus="itr">
													<tr>
														<td><a
															href="updateLeave?leaveID=<c:out value='${leave.leaveID}'/>">LV0000000${leave.leaveID}</a></td>
														<td><c:out
																value="${leave.employee.firstName} ${leave.employee.lastName}" /></td>
														<td><c:out value="${leave.employee.email}" /></td>
														<td><c:out value="${leave.status}" /></td>
														<td><c:out value="${leave.leaveType}" /></td>
														<td><c:out value="${leave.startDate}" /></td>
														<td><c:out value="${leave.endDate}" /></td>
														<td><c:out value="${leave.contactNumber}" /></td>
														<td><c:out value="${leave.address}" /></td>
														
													</tr>
												</c:forEach>
											</tbody>
										</table>
										<!-- table order -->
									</form:form>
									<!-- form order -->

								</div>
								
								<div class="tab-pane" id="activeLeave">
									<legend align=center>Active Leave</legend>
									<form:form modelAttribute="orderHistory" method="post"
										action="orderHistory" id="orderHistory" name="orderHistory">

										<!-- Below table will be displayed as Data table -->
										<table id="pendingLeaveDatatable" class="display datatable">
												<thead>
												<tr>
													<th>Leave Number</th>
													<th>Full Name</th>
													<th>Email</th>
													<th>Leave Status</th>
													<th>Leave Type</th>
													<th>Start Date</th>
													<th>End Date</th>
													<th>Contact</th>
													<th>Address During Leave</th>
													<!-- <th>Order Details</th> -->
												</tr>
											</thead>
											<tbody>
												<!-- Iterating over the list sent from Controller -->
												<c:forEach items="${leaveList}" var="leave" varStatus="itr">
													<tr>
														<td><a
															href="updateLeave?leaveID=<c:out value='${leave.leaveID}'/>">LV0000000${leave.leaveID}</a></td>
														<td><c:out
																value="${leave.employee.firstName} ${leave.employee.lastName}" /></td>
														<td><c:out value="${leave.employee.email}" /></td>
														<td><c:out value="${leave.status}" /></td>
														<td><c:out value="${leave.leaveType}" /></td>
														<td><c:out value="${leave.startDate}" /></td>
														<td><c:out value="${leave.endDate}" /></td>
														<td><c:out value="${leave.contactNumber}" /></td>
														<td><c:out value="${leave.address}" /></td>
														
													</tr>
												</c:forEach>
											</tbody>
										</table>
										<!-- table order -->
									</form:form>
									<!-- form order -->

								</div>

								<div class="tab-pane" id="leaveHistory">
									<legend align=center>Active Leave</legend>
									<form:form modelAttribute="orderHistory" method="post"
										action="orderHistory" id="orderHistory" name="orderHistory">

										<!-- Below table will be displayed as Data table -->
										<table id="pendingLeaveDatatable" class="display datatable">
												<thead>
												<tr>
													<th>Leave Number</th>
													<th>Full Name</th>
													<th>Email</th>
													<th>Leave Status</th>
													<th>Leave Type</th>
													<th>Start Date</th>
													<th>End Date</th>
													<th>Contact</th>
													<th>Address During Leave</th>
													<!-- <th>Order Details</th> -->
												</tr>
											</thead>
											<tbody>
												<!-- Iterating over the list sent from Controller -->
												<c:forEach items="${leaveList}" var="leave" varStatus="itr">
													<tr>
														<td><a
															href="updateLeave?leaveID=<c:out value='${leave.leaveID}'/>">LV0000000${leave.leaveID}</a></td>
														<td><c:out
																value="${leave.employee.firstName} ${leave.employee.lastName}" /></td>
														<td><c:out value="${leave.employee.email}" /></td>
														<td><c:out value="${leave.status}" /></td>
														<td><c:out value="${leave.leaveType}" /></td>
														<td><c:out value="${leave.startDate}" /></td>
														<td><c:out value="${leave.endDate}" /></td>
														<td><c:out value="${leave.contactNumber}" /></td>
														<td><c:out value="${leave.address}" /></td>
														
													</tr>
												</c:forEach>
											</tbody>
										</table>
										<!-- table order -->
									</form:form>
									<!-- form order -->

								</div>
								
								
								</div>

							</div>
							<!-- /tab-content -->

						</form:form>

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
			src="<c:url value="/resources/bootstrap-3.3.7/js/daterangepicker.js"/>"></script>

		<script type="text/javascript"
			src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>


		<!-- Datatables -->
		<script type="text/javascript"
			src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>
		<!-- /Scripts -->

		<!-- Paging the table -->
		<script type="text/javascript">
			$(document).ready(function() {
				$('#createLeaveDatatable').DataTable({
					"jQueryUI" : true,
					"pagingType" : "full_numbers",
					"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ]
				/* few more options are available to use */
				});
			});
		</script>

		<script type="text/javascript">
			$(document).ready(function() {
				$('#OrderToApproveDatatable').DataTable({
					"jQueryUI" : true,
					"pagingType" : "full_numbers",
					"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ]
				/* few more options are available to use */
				});
			});
		</script>

		<script type="text/javascript">
			$(document).ready(function() {
				$('#closedOrderDatatable').DataTable({
					"jQueryUI" : true,
					"pagingType" : "full_numbers",
					"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ]
				/* few more options are available to use */
				});
			});
		</script>

		<script type="text/javascript">
			$(document).ready(function() {
				$('#OrderToShipDatatable').DataTable({
					"jQueryUI" : true,
					"pagingType" : "full_numbers",
					"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ]
				/* few more options are available to use */
				});
			});
		</script>


		<script type="text/javascript">
			$(document).ready(function() {
				$('#pendingLeaveDatatable').DataTable({
					"jQueryUI" : true,
					"pagingType" : "full_numbers",
					"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ]
				/* few more options are available to use */
				});
			});
		</script>
</body>
</html>
