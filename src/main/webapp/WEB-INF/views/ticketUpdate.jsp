<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Log a ticket | Velaphanda Trading & Projects</title>
<body>
	<div class="velaphanda_containter">	
		<c:import url="templates/navbar.jsp"></c:import>
		<div class="container">
		<br/>
			<div class="panel panel-success">    
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="left"><b>Change Technician</b> </div>
					</h3>
				</div>
				<div class="panel-body">					
					<div class="tab-content">
					
						<form:form method="post" action="updateTicketAdmin" role="form"
					modelAttribute="updateTicketAdmin" id="form">

					<div class="row">
						<div class="col-xs-12">
							<div class="col-xs-2 form-control-label">
								<label>Ticket No:</label>

							</div>
							<div class="col-xs-3">
								<input type="text" class="form-control input-sm" name="ticketNumber"
									value="${ticketupdate.ticketNumber }">
							</div>

							<div class="col-xs-2 form-control-label">
								<label>Machine Serial</label>

							</div>
							<div class="col-xs-3">
								<input type="text" class="form-control input-sm"
									value="${ticketupdate.device.serialNumber}">
							</div>
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col-xs-12">
							<div class="col-xs-2 form-control-label">
								<label>Contract Start Date:</label>

							</div>
							<div class="col-xs-3">
								<input type="text" class="form-control input-sm"
									value="${ticketupdate.device.startDate}">
							</div>

							<div class="col-xs-2 form-control-label">
								<label>Contract End Date:</label>

							</div>
							<div class="col-xs-3">
								<input type="text" class="form-control input-sm"
									value="${ticketupdate.device.endDate}">
							</div>
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col-xs-12">
							<div class="col-xs-2 form-control-label">
								<label>Customer Name:</label>

							</div>
							<div class="col-xs-3">
								<input type="text" class="form-control input-sm"
									value="${ticketupdate.device.customer.clientName }">
							</div>

							<div class="col-xs-2 form-control-label">
								<label>Priority:</label>

							</div>
							<div class="col-xs-3">
								<select class="form-control" name="priority">
									<option>${ticketupdate. priority}</option>
									<option value="High">High</option>
									<option value="Medium">Medium</option>
									<option value="Low">Low</option>
								</select>
							</div>
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col-xs-12">
							<div class="col-xs-2 form-control-label">
								<label>Assign Technician:</label>

							</div>
							<div class="col-xs-3">
								<select class="form-control" name="technicianUserName">
									<option>${ticketupdate.employee.firstName } ${ticketupdate.employee.lastName }</option>
									<c:forEach items="${technicians}" var="technician">
										<option value="${technician.email}">${technician.firstName} ${technician.lastName}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
					<br>

					<div class="row">
						<div class="col-xs-12">
							<div class="col-xs-2 form-control-label">
								<label>Description:</label>

							</div>
							<div class="col-xs-3">
								<textarea rows="3" cols="84" name="description">${ticketupdate.description}</textarea>
							</div>
						</div>
					</div>
					<br>
					<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-8">
							<input type="submit" value="Submit"
								class="btn btn-primary btn-block btn-lg" tabindex="9"
								id="submit">
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

<script src="/resources/bootstrap-3.3.6/js/jquery-3.0.0.min.js"></script>
<script type="text/javascript"
	src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script>
<link rel="stylesheet" type="text/css"
	href="/resources/bootstrap-3.3.6/css/bootstrap.min.css">
</head>
<link
	href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />

</html>