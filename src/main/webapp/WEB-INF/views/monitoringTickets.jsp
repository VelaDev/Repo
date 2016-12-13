<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <title>Monitoring Tickets | Velaphanda Trading & Projects</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">  
</head>
<body>
	<div class="velaphanda_containter">	
		<c:import url="templates/navbar.jsp"></c:import>
		<div class="container">
			<div class="panel panel-success">    
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="left">
						<b>Open Tickets</b>
					</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">
					<c:if test="${empty ticketList}">
						There are no tickets at the moment
					</c:if>
					<c:if test="${not empty ticketList}">
					
					<form action="searchEmployee" id="searchEmp">
						
						<div class="row">
								<!-- Text input Search-->
								<div class="form-group">
									<label class="col-md-3 control-label">Search Technician: </label>
									<div class="col-md-4 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-hdd"></i></span> <input
												name="searchName" id="searchName" class="form-control"
												type="text" placeholder='Search By Name'>
										</div>
									</div>
									<div class="col-md-2">
										<input class="btn btn-success" type='submit' value='Search' />
									</div>
								</div>
							</div>
							<br/>
					</form>

					<table class="table table-hover table-bordered">
						<thead style="background-color: #bce8f1;">
							<tr>
								<th>Ticket No</th>
								<th>Assigned Technician</th>
								<th>Description</th>
								<th>Date</th>
                                <th>Option</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${ticketList}" var="tickets">
								<tr>
									<th><c:out value="${tickets.ticketNumber}" /></th>
									<th><c:out value="${tickets.employee.firstName}  ${tickets.employee.lastName}" /></th>
									<th><c:out value="${tickets.description}" /></th>
									<th><c:out value="${tickets.dateTime}" /></th>
									<th><a href="AssignTicketToOtherTechnician?ticketNumber=<c:out value='${tickets.ticketNumber}'/>">option</a></th>

								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>
						
					</div><!-- /tab-content -->
									
				</div><!-- /panel body -->
			</div><!--/panel success class-->
		</div><!-- /Container -->
		<!-- Footer -->
		<c:import url="templates/footer.jsp"></c:import>
		<!--/ Footer -->
	</div><!-- / velaphanda_containter -->
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
	<!-- Validate By User LogTicket -->
<!-- Search By Serial -->
	<script>
		$(document)
				.ready(
						function() {
							$('#searchEmp')
									.bootstrapValidator(
											{
												feedbackIcons : {
													valid : 'glyphicon glyphicon-ok',
													invalid : 'glyphicon glyphicon-remove',
													validating : 'glyphicon glyphicon-refresh'
												},
												fields : {
													searchName : {
														validators : {
															stringLength : {
																min : 3,
															},
															notEmpty : {
																message : 'Name is required to search and cannot be empty'
															}
														}
													},
												}
											});
						});
	</script>
</body>
</html>
