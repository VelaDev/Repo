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
					<form action="searchEmployee">
						<div class="row">
							<div class="col-md-6">
								<div class="col-md-6">Search Technician:</div>
								<div class="col-md-6">
									<input type="text" name="searchName" id="searchName">
								</div>
							</div>
							<div class="col-md-4">
								<input class="btn btn-success" type='submit' value='Search' />
							</div>
						</div>
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

</body>
</html>
