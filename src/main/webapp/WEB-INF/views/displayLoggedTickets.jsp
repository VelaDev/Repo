<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Display Logged Tickets | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	<div class="velaphanda_containter">
		<c:import url="templates/navbar.jsp"></c:import>
		<div class="container">
			<br />
			<div class="panel panel-success">
				<div class="panel-heading">
					<div align="left">
						<b>Open Tickets</b>
					</div>
				</div>
				<div class="panel-body">

					<div class="tab-content">

						<%-- <c:if test="${empty ticketList}">
                No open tickets
            </c:if>
            <c:if test="${not empty ticketList}">  --%>

						<form action="searchTechnician">
							<div class="row">
								<div class="col-md-6">
									<div class="col-md-6">Search Technician:</div>
									<div class="col-md-6">
										<input type="text" name="username" id="username"
											class="form-control">
									</div>
								</div>
								<div class="col-md-4">
									<input class="btn btn-success" type='submit' value='Search' />
								</div>
							</div>
							<br>
						</form>

						<table class="table table-striped custab">
							<thead style="background-color: #bce8f1;">
								<tr>
									<th>Ticket No</th>
									<th>Description</th>
									<!-- <th>Date</th> -->
									<th>Status</th>
									<th>Technician</th>
									<th>Edit</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${ticketList}" var="ticket">
									<tr>
										<th><c:out value="${ticket.ticketNumber}" /></th>
										<th><c:out value="${ticket.description}" /></th>
										<%-- <th><c:out value="${ticket.dateTime}"/></th> --%>
										<th><c:out value="${ticket.status}" /></th>
										<th><c:out value="${ticket.employee.getUsername()}" /></th>
										<th><a href="editEmployee?id=<c:out value='${emp.id}'/>">Edit</a></th>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<%-- </c:if> --%>

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
