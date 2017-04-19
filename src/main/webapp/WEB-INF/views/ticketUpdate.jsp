<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">

</head>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />"  />
<title>Update ticket | Velaphanda Trading & Projects</title>
<body>
	<div class="velaphanda_containter">	
		<c:import url="templates/navbar.jsp"></c:import>
		<div class="container">
		
			<div class="panel panel-success">    
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="left"><b>Change Technician</b> </div>
					</h3>
				</div>
				<div class="panel-body">					
					<div class="tab-content">
					
						<form:form class="well form-horizontal" method="post" action="updateTicketAdmin" role="form"
					modelAttribute="updateTicketAdmin" id="form">

					<!--First Col-->
							<div class="col-sm-6">
							
								<!-- Text input Ticket No:-->
								<div class="form-group">
									<label class="col-md-3 control-label">Ticket No</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-calendar"></i></span> <input
												class="form-control" readonly="readonly" name="ticketNumber" value="${ticketupdate.ticketNumber }" type="text">
										</div>
									</div>
								</div>
							
								<!-- Text input Contract Start Date-->
								<div class="form-group">
									<label class="col-md-3 control-label">Contract Start Date</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-calendar"></i></span> <input
												name="startDate" id="startDate" readonly="readonly" class="form-control" value="${ticketupdate.device.startDate}" type="text">
										</div>
									</div>
								</div>	
						
								<!-- Text input Customer Name-->
									<div class="form-group">
										<label class="col-md-3 control-label">Customer Name</label>
										<div class="col-md-6 inputGroupContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-user"></i></span> <input
													name="clientName" placeholder="Client Name"
													class="form-control" readonly="readonly" value="${ticketupdate.device.customerDevice.customerName }"
													type="text">
											</div>
										</div>
									</div>
									
									<!-- Select type Assign Technician-->						
									<div class="form-group">
										<label class="col-md-3 control-label">Assign Technician</label>
										<div class="col-md-6 selectContainer">
											<div class="input-group">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-list"></i></span> <select name="technicianUserName"
													class="form-control selectpicker">
													<option>${ticketupdate.employee.firstName }
															${ticketupdate.employee.lastName }</option>
													<c:forEach items="${technicians}" var="technician">
														<option value="${technician.email}">${technician.firstName}
															${technician.lastName}</option>
													</c:forEach>								
												</select>
											</div>
										</div>
									</div>
					
							</div><!--/First Col-->
							
							
							<!--Second Col-->
							<div class="col-sm-6">
							
								<!-- Text input Ticket No:-->
								<div class="form-group">
									<label class="col-md-3 control-label">Machine Serial</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-calendar"></i></span> <input
												class="form-control" readonly="readonly" name="serialNumber" value="${ticketupdate.device.serialNumber}" type="text">
										</div>
									</div>
								</div>
				
					
								<!-- Text input Contract End Date-->
								<div class="form-group">
									<label class="col-md-3 control-label">Contract End Date</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-calendar"></i></span> <input
												name="endDate" id="endDate" readonly="readonly" value="${ticketupdate.device.endDate}"
												class="form-control" type="text">
										</div>
									</div>
								</div>
							
								<!-- Select type Priority-->						
								<div class="form-group">
									<label class="col-md-3 control-label">Priority</label>
									<div class="col-md-6 selectContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-list"></i></span> <select readonly="readonly" name="priority"
												class="form-control selectpicker">
												<option>${ticketupdate. priority}</option>
												<option value="High">High</option>
												<option value="Medium">Medium</option>
												<option value="Low">Low</option>									
											</select>
										</div>
									</div>
								</div>
								<!-- Text area Description-->
								<div class="form-group">
									<label class="col-md-3 control-label">Description</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-pencil"></i></span>
											<textarea class="form-control" readonly="readonly" name="description"
												>${ticketupdate.description}</textarea>
										</div>
									</div>
								</div>
							</div><!--Second Col-->
							
							
							<!-- Text area Subject-->
								<div class="form-group">
									<label class="col-md-3 control-label">Subject</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-pencil"></i></span>
											<textarea class="form-control" readonly="readonly" name="subject"
												required="required">${ticketupdate.subject} </textarea>
										</div>
									</div>
							</div>
							
					<br>
					<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-8">
							<input type="submit" value="Ticket Update"
								class="btn btn-primary btn-block btn-lg" tabindex="9"
								id="ticketUpdate">
						</div>
					</div>
				</form:form>
						
						
					</div><!-- /tab-content -->
									
				</div><!-- /panel body -->
			</div><!--/panel success class-->
		</div><!-- /Container -->
		<!-- Footer -->
		<c:import url="templates/footer.jsp"></c:import>
		<!--/ Footer -->
	</div><!-- / velaphanda_containter -->

</body>

<!-- Script -->
	<script type="text/javascript"
		src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap-datepicker.js" />"></script>
<!-- /Script -->
	


</html>