<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <title>Technician | Velaphanda Trading & Projects</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">  
</head>
<body>
	<div class="velaphanda_containter">	
		<c:import url="templates/techniciannavbar.jsp"></c:import>
		<div class="container">
		<br/>
			<div class="panel panel-success">    
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="left"><b>Open tickets</b> </div>
					</h3>
				</div>
				<div class="panel-body">
					
					<div class="tab-content">
					
					<%-- <c:if test="${empty ticketList}">
					No open tickets
					</c:if>
					<c:if test="${not empty ticketList}">  --%>   
					<form action="">                              
						<table class="table table-hover">
							<thead style="background-color: #bce8f1;">
							<tr>
								<th>Ticket Number</th>
								 <th>Customer Name</th>
								<th>Telephone No</th>
								<th>Ticket Details</th>								
							</tr>
							</thead>
							<tbody>
							<c:forEach items="${technicianTickets}" var="ticket">
								<tr>
									<th><c:out value="${ticket.ticketNumber}"/></th>
									 <th><c:out value="${ticket.device.customer.customerName}"/></th> 
									<th><c:out value="${ticket.device.customer.getTellphoneNumber()} "/></th>  
									 <th><a href="ticketDetails?id=<c:out value='${ticket.ticketNumber}'/>">Ticket Details</a></th>                 
								</tr>
							</c:forEach>
							</tbody>
						</table>
						</form> 
					<%-- </c:if> --%>
						
					</div><!-- /tab-content -->
									
				</div><!-- /panel body -->
			</div><!--/panel success class-->
		</div><!-- /Container -->
		<!-- Footer -->
		<c:import url="templates/footer.jsp"></c:import>
		<!--/ Footer -->
	</div><!-- / velaphanda_containter -->
	
<script type="text/javascript">
/* $(document).ready(function(){
	$('.table > tbody > tr').click(function() {
		 window.location="ticketDetails.html?id";
		
	});
});	 */

</script>
</body>
</html>
