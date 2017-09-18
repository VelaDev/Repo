<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Leave Details | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/custom/css/orderhistory.css"/>">

<link type="text/css" rel="stylesheet"
      href="<c:url value="/resources/custom/css/vela_details.css" />">

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
    margin-left: -15px;
}

.displayNone, .tTakeTicket {
    display:none;
}
.showDIV { display:block; } 
table#orderDetails {
	margin-left: 14%;
	/* margin-right: -9%; */
	width: 73%;
}
table#toOrder thead {
    background-color: #CCCCCC;
    height: 112%;
}

input#updateLeave {
	width: 57%;
}

input#cancelLeave {
	width: 57%;
}

</style>
</head>
<body>

	<div class="velaphanda_containter">
		<c:import url="templates/techniciannavbar.jsp"></c:import>
		<div class="container">
			
				<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Leave No : LV0000000${leave.leaveID}</b>
						</div>
					</h3>
				</div>
				<!-- panel body -->
				<div class="panel-body">
						
					
					<!-- nav sub menu tabs  -->
					<ul class="nav nav-tabs">
						<li class="active"><a href="#LeaveDetails" data-toggle="tab">Leave Details</a></li>
						<li><a href="#updateLeave" data-toggle="tab">Update Leave</a></li>
					</ul>
					<!-- // nav sub menu tabs-->

					<!-- tab content -->
					<div class="tab-content">

						<!--LeaveDetails tab-->
						<div class="tab-pane active" id="LeaveDetails">
							<br /> <br />

							<!-- page wrap -->
							<div id="pagewrap">
								<!-- section content -->
								<section id="content" style="width:35%;">
								<div class="groupclientdetails">
									<legend style="font-size: 12px; line-height: 1.42857143;"> Details </legend>

									<div class="machinedetailsdetailsfloatleft">
										
										<li id="Name" name="Name"><b>Name: ${leave.employee.firstName} ${leave.employee.lastName}</b></li>
										<li id="leaveType" name="leaveType"><b>Leave Type: ${leave.leaveType} </b></li>
										<li id="startDate" name="startDate">Leave Start Date: ${leave.startDate}</li>
										<li id="endDate" name="endDate">Leave End Date: ${leave.endDate}</li>
										<li id="status" name="status">Leave Status: ${leave.status}</li>
										<c:if test="${leave.status == 'Cancelled'}">
												<p id="lebaka">
													<span style="font-weight: bolder">Reason Declined</span>:
													<span style="color: red">${leave.comments}</span>
												</p>
											</c:if>		
																				
									</div>

								</div>
								</section>
								<!-- //section content -->
								
												
								<!-- section middle -->
								<section id="middle">
									<div class="groupclientaddress">
										<legend style="font-size: 12px; line-height: 1.42857143;">Contact Details During Leave</legend>
										<div class="machinedetailsfloatright ">
											<div class="orderDetails">
												<li id="cell">Cell No: ${leave.contactNumber}</li>
												<li id="telephone">Address:	${leave.address}</li>
												<li id="email">Email: ${leave.employee.email}</li>
											</div>
											<br>
										</div>
									</div>
								</section>
								<!-- //section middle -->
								
								
							</div>
							<!-- page wrap -->
						</div>
						<!--LeaveDetails tab-->

						<!--updateLeave Details tab-->
						<div class="tab-pane" id="updateLeave">
						
							<form:form class="well form-horizontal" method="POST" action="updateLeave" modelAttribute="updateLeave" id="updateLeave">

							<c:if test="${leave.status != 'Active'}">
										<div class="form-group row">
											<c:if test="${leave.status != 'Cancelled'}">
											
												<div class="col-sm-offset-3 col-sm-2">
													<input type="submit" value="Update Leave"
														class="btn btn-primary btn-block btn-sm" tabindex="9"
														id="updateLeave">
												</div>												
																							
												<div class="col-sm-2">												
													<a href="leaveCancellation?leaveID=<c:out value='${leave.leaveID}'/>" class="btn btn-danger btn-block btn-sm" tabindex id="cancelUpdate" style="width:54%;margin-left: -36%;">Cancel Leave</a>	
												</div>
												
											</c:if>
										</div>
							</c:if>
							  <input type="hidden" id="leaveID" name="leaveID"	value="${leave.leaveID}" >
							  
						<!-- Select type Leave Type-->
						<div class="form-group">
							<label class="col-md-3 control-label">Type of Leave</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-list"></i></span> <select name="leaveType"
										id="leaveID" class="form-control selectpicker">
										<option value="${leave.leaveType}">${leave.leaveType}</option>
										<option value="Annual Vacation Leave">Annual Vacation
											Leave</option>
										<option value="Sick Leave">Sick Leave</option>
										<option value="Emergency Leave">Emergency Leave</option>
									</select>
								</div>
							</div>
						</div>

						<!-- Text input First Date Leave-->
						<div class="form-group">
							<label class="col-xs-3 control-label">Leave Start Date</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group input-append date" id="startDatePicker">
									<input type='text' class="form-control" name="startDate"
										id="startDate" placeholder="YYYY-MM-DD"
										value="${leave.startDate}" /> <span class="input-group-addon">
										<span class="glyphicon glyphicon-calendar"></span>
									</span>
								</div>
							</div>
						</div>
						<!-- Text input Last Date Leave-->
						<div class="form-group">
							<label class="col-md-3 control-label">Leave End Date</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group input-append date" id="endDatePicker">
									<input type='text' class="form-control" name="endDate"
										id="endDate" placeholder="YYYY-MM-DD" value="${leave.endDate}" />
									<span class="input-group-addon"> <span
										class="glyphicon glyphicon-calendar"></span>
									</span>
								</div>
							</div>
						</div>
						<!-- Text input Contact Number well on leave-->
						<div class="form-group">
							<label class="col-md-3 control-label">Contact Number</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-earphone"></i></span> <input
										id="contactNumber" name="contactNumber"
										placeholder="Contact Number during absence"
										class="form-control" type="text"
										onkeypress="return isNumber(event)"
										value="${leave.contactNumber}">
								</div>
							</div>
						</div>
						<!-- Text input Address well on leave-->
						<div class="form-group">
							<label class="col-md-3 control-label">Address</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-home"></i></span> <input id="address"
										name="address" placeholder="Address during absence"
										class="form-control" type="text" value="${leave.address}">
								</div>
							</div>
						</div>
						<br>
						<!-- <div class="form-group row">
							<div class="col-sm-offset-3 col-sm-6">
								<input type="submit" value="Update Leave"
									class="btn btn-primary btn-block btn-lg" tabindex="9"
									id="updateLeave">
							</div>
						</div> -->
					</form:form>
							
						</div>
						<!--//updateLeave Details tab-->

						
					</div>
					<!-- group details-row-padding -->
				</div>
				<!-- /tab-content -->
			</div>
			<!-- /panel body -->
			
		
		</div>
		<!-- /Container -->
		<!-- Footer -->
		<c:import url="templates/footer.jsp"></c:import>
		<!--/ Footer -->
	</div>
	<!-- / velaphanda_containter -->

<script type="text/javascript" src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jquery/1.13.1/jquery.validate.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>

<!-- Datatables -->
<script type="text/javascript" src="<c:url value="/resources/datatables/datatables.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/datatables/1.10.13/js/jquery-ui.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/datatables/1.10.13/js/dataTables.buttons.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/datatables/1.10.13/js/dataTables.jqueryui.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/datatables/1.10.13/js/dataTables.select.js" />"></script>
<!-- //Datatables -->

<script type="text/javascript" src="<c:url value="/resources/custom/js/velas_ticketdetails.js" />"></script>


</body>
</html>
