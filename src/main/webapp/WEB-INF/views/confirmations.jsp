<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Confirmation | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/custom/css/vela_custom.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/custom/css/vela_custom_ticktes.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">

<style type="text/css">

a.confirmtions {
    color: blue;
}

</style>
</head>
<body>
	<div class="velaphanda_containter">
		<c:import url="templates/confirmationPopup.jsp"></c:import>
		<div class="container">

			<div class="panel panel-success"  style="margin-left:25%; margin-right:25%;">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Confirmation</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
				 	<div class="tab-content">
				 	<!-- Successful message -->
				 	<c:if test="${not empty retMessage }">
				 	<div class="alert alert-info" role="alert">
				 	 <!-- Add employee -->
				 	  <c:choose>
				 	    <c:when test="${addEmployee =='addEmployee' }">
				 	       <c:out value="${retMessage}"></c:out> Click<a href="displayEmployees.html" class="confirmtions"><b> here</b></a> to view list of employees or 
                            Click <a href="registerEmployee.html" class="confirmtions"> <b> here</b></a> to add another Employee.
                        </c:when>
				 	    </c:choose>
				 	     <!-- Update employee -->
				 	    <c:choose>
				 	     <c:when test="${updateEmployee =='updateEmployee' }">
				 	         <c:out value="${retMessage}"></c:out>  .
                              Click <a href="displayEmployees.html" class="confirmtions"> <b> here</b></a> to view list of Employees 
				 	    </c:when>
				 	    </c:choose> 
				 	     <!-- Change password -->
				 	    <c:choose>
				 	    <c:when test="${changePassword =='changePassword' }">
                           <c:out value="${retMessage}"></c:out>  Click <a href="displayEmployees.html" class="confirmtions"> <b> here</b></a>  to view list of Employees.       
                           </c:when>
				 	    </c:choose>
				 	   <!--  Reset Password -->
				 	    <c:choose>
				 	       <c:when test="${resetPassword =='resetPassword' }">             
                           <c:out value="${retMessage}"></c:out> Click <a href="displayEmployees.html" class="confirmtions"> <b> here</b></a> to view list of Employees.   
                           </c:when>
				 	    </c:choose>
				 	    <!-- Deactivate employee -->
				 	  <c:choose>
				 	    <c:when test="${deactivateEmployee =='deactivateEmployee' }">
				 	       <c:out value="${retMessage}"></c:out> Click<a href="displayEmployees.html" class="confirmtions"><b> here</b></a> to view list of Employees.
				 	    </c:when>
				 	    </c:choose>
				 	    <!-- add Customer -->
				 	  <c:choose>
				 	    <c:when test="${addCustomer =='addCustomer' }">
				 	       <c:out value="${retMessage}"></c:out> Click<a href="displayCustomers.html" class="confirmtions"><b> here</b></a> to view list of Customers. or click <a href="addClient.html" class="confirmtions"><b> here</b></a> to add another Customer.
				 	    </c:when>
				 	    </c:choose>
				 	    <!-- update Customer -->
				 	   <c:choose>
				 	    <c:when test="${updateCustomer =='updateCustomer' }">
				 	       <c:out value="${retMessage}"></c:out> Click<a href="displayCustomers.html" class="confirmtions"><b> here</b></a> to view list of Customers.
				 	    </c:when>
				 	    </c:choose>
				 	    <!-- add Device -->
				 	  <c:choose>
				 	    <c:when test="${addDevice =='addDevice' }">
				 	       <c:out value="${retMessage}"></c:out>  Click<a href="searchDevice.html" class="confirmtions"><b> here</b></a> to view list of Devices or click <a href="searchClientforProduct?customerName=<c:out value='${customerName}'/>" class="confirmtions"><b> here</b></a> to add another Device for ${customerName}.
				 	    </c:when>
				 	    </c:choose>
				 	    <!-- update Device -->
				 	  <c:choose>
				 	    <c:when test="${updateDevice =='updateDevice' }">
				 	       <c:out value="${retMessage}"></c:out> Click<a href="searchDevice.html" class="confirmtions"><b> here</b></a> to view list of Devices.
				 	   		     
				 	    </c:when>
				 	    </c:choose>
				 	    <c:choose>
				 	    <c:when test="${removeAcessory =='removeAcessory' }">
				 	       <c:out value="${retMessage}"></c:out> Click<a  class="confirmtions" href="searchDeviceSerialNumber?serialNumber=<c:out value="${serial }"/>"><b> ${serial}</b></a> to update Device.
				 	   		     
				 	    </c:when>
				 	    </c:choose>
				 	    <!-- Log a Ticket -->
						 <c:choose>
						 	   <c:when test="${tickets =='tickets' }">
						 	       <c:out value="${retMessage}"></c:out>  Click<a href="logTicket.html" class="confirmtions"><b> here</b></a> to log another Ticket.
							   </c:when>
						 </c:choose>
						 <c:choose>
						 	   <c:when test="${tickets =='tickets' }">
						 	      <c:if test="${not empty message}">
						 	       <c:out value="${message}"></c:out>  Click<a href="logTicket.html" class="confirmtions" class="danger"><b> here</b></a> to log another Ticket.
							   </c:if>
							   </c:when>
						 </c:choose>
						 
						 <!-- Place an Orders -->
				 	  	<c:choose>
					 	    <c:when test="${orders =='orders' }">
					 	       <c:out value="${retMessage}"></c:out> 
					 	         Click<a href="ordermanagement.html" class="confirmtions"><b> here</b></a> to go to order management.
					 	                           
					 	    </c:when>
				 	    </c:choose>
				 	    
				 	     <!-- Approver Orders -->
				 	  	<c:choose>
					 	    <c:when test="${approverOrders =='approverOrders' }">
					 	       <c:out value="${retMessage}"></c:out> 
					 	       Click<a href="ordermanagement.html" class="confirmtions"><b> here</b></a> to go to order management.					 	                                
					 	    </c:when>
				 	    </c:choose>
				 	    <!-- Approver Orders -->
				 	  	<c:choose>
					 	    <c:when test="${shipOrder =='shipOrder' }">
					 	       <c:out value="${retMessage}"></c:out> 
					 	        Click<a href="ordermanagement.html" class="confirmtions"><b> here</b></a> to go to order management.    
					 	    </c:when>
				 	    </c:choose>
				 	     <!-- Decline Order -->
				 	  	<c:choose>
					 	    <c:when test="${declineOrder =='declineOrder' }">
					 	       <c:out value="${retMessage}"></c:out> 
					 	          Click<a href="ordermanagement.html" class="confirmtions"><b> here</b></a> to go to order management.	                            
					 	    </c:when>
				 	    </c:choose>
				 	    
				 	     <!-- update tickets -->
				 	  	<c:choose>
					 	    <c:when test="${managerUpdateTicket =='managerUpdateTicket' }">
					 	       <c:out value="${retMessage}"></c:out> 
					 	                                    
					 	    </c:when>
				 	    </c:choose>
				 	     <!-- create leave -->
				 	  	<c:choose>
					 	    <c:when test="${managerAddLeave =='managerAddLeave' }">
					 	       <c:out value="${retMessage}"></c:out> 
					 	           Click<a href="leavemanagement.html" class="confirmtions"><b> here</b></a> to go to leave management.                         
					 	    </c:when>
				 	    </c:choose>
				 	     <c:choose>
					 	    <c:when test="${managerCancel =='managerCancel' }">
					 	       <c:out value="${retMessage}"></c:out> 
					 	           Click<a href="leavemanagement.html" class="confirmtions"><b> here</b></a> to go to leave management.                         
					 	    </c:when>
				 	    </c:choose>
				 	    <c:choose>
					 	    <c:when test="${managerOnLeave =='managerOnLeave' }">
					 	       <c:out value="${retMessage}"></c:out> 
					 	           Click<a href="leavemanagement.html" class="confirmtions"><b> here</b></a> to go to leave management.                         
					 	    </c:when>
				 	    </c:choose>
				 	     <!-- update leave -->
				 	  	<c:choose>
					 	    <c:when test="${updateLeave =='updateLeave' }">
					 	       <c:out value="${retMessage}"></c:out> 
					 	           Click<a href="leavemanagement.html" class="confirmtions"><b> here</b></a> to go to leave management.                         
					 	    </c:when>
				 	    </c:choose>
				 	    <!-- Add Spares -->
				 	  	<c:choose>
					 	    <c:when test="${addSpares =='addSpares' }">
					 	       <c:out value="${retMessage}"></c:out> Click<a href="addSpares.html" class="confirmtions"><b> here</b></a> to add another Spare/Part or Click <a href="availableSpareParts.html" class="confirmtions"><b> here</b></a> to view available stock in HO.                            
					 	    </c:when>
				 	    </c:choose>				 	    
				 	    <!-- Receive Spares -->
				 	  	<c:choose>
					 	    <c:when test="${receiveSpareParts =='receiveSpareParts' }">
					 	       <c:out value="${retMessage}"></c:out> Click<a href="receiveParts.html" class="confirmtions"><b> here</b></a> to add another Spare/Part or Click <a href="availableSpareParts.html" class="confirmtions"><b> here</b></a> to view available stock in HO.                            
					 	    </c:when>
				 	    </c:choose>
				 	    <!-- performTicketAction -->
				 	    <c:choose>
				 	    	<c:when test="${performTicketAction =='performTicketAction' }">
					 	       <c:out value="${retMessage}"></c:out> 
					 	          Click<a href="ticketmanagement.html" class="confirmtions"><b> here</b></a> to go to ticket management.	                            
					 	    </c:when>
				 	    </c:choose>
				 	    
				 	    </div>
				 	</c:if><!-- Successful message -->
				 	
				 					 	
				 	<!-- On failure returned message -->
				 	<c:if test="${not empty retErrorMessage}">
				 	    <!-- Add employee -->
				 	    <div class="alert alert-danger" role="alert">
				 	    <c:choose>
				 	    <c:when test="${addEmployee =='addEmployee' }">
				 	       <c:out value="${retErrorMessage}"></c:out> 
				 	        Click<a href="displayEmployees.html" class="confirmtions"> <b> here</b></a> to view list of Employees or 
                            Click <a href="registerEmployee.html" class="confirmtions"> <b> here</b></a> to add another new Employee.
				 	    </c:when>
				 	    </c:choose>
				 	     <!-- Update employee -->
				 	    <c:choose>
				 	     <c:when test="${updateEmployee =='updateEmployee' }">
				 	         <c:out value="${retErrorMessage}"></c:out> 
				 	          Click <a href="displayEmployees.html" class="confirmtions"> <b> here</b></a> to view list of Employees. 
				 	    </c:when>
				 	    </c:choose> 
				 	     <!-- Change password -->
				 	    <c:choose>
				 	    <c:when test="${changePassword =='changePassword' }">
                           <c:out value="${retErrorMessage}"></c:out>
                                  Click <a href="displayEmployees.html" class="confirmtions"> <b> here</b></a>  to view list of Employees.       
                           </c:when>
				 	    </c:choose>
				 	   <!--  Reset Password -->
				 	    <c:choose>
				 	       <c:when test="${resetPassword =='resetPassword' }">             
                           <c:out value="${retErrorMessage}"></c:out>
                                   Click <a href="displayEmployees.html" class="confirmtions"><b> here</b></a> to view list of Employees. 
                           </c:when>
				 	    </c:choose>
				 	     <!--  Deactivate Employee -->
				 	    <c:choose>
				 	       <c:when test="${deactivateEmployee =='deactivateEmployee' }">             
                           <c:out value="${retErrorMessage}"></c:out>
                                    Click <a href="displayEmployees.html" class="confirmtions"><b> here</b></a> to view list of Employees.
                           </c:when>
				 	    </c:choose>
				 	   <!--  Add Customer -->
				 	    <c:choose>
				 	    <c:when test="${addCustomer =='addCustomer' }">
				 	       <c:out value="${retErrorMessage}"></c:out> 
				 	          Click<a href="displayCustomers.html" class="confirmtions"><b> here</b></a> to view list of Customers or Click <a href="addClient.html" class="confirmtions"><b> here</b></a> to add another Customer.
				 	    </c:when>
				 	    </c:choose>
				 	     <!-- update Customer -->
				 	  <c:choose>
				 	    <c:when test="${updateCustomer =='updateCustomer' }">
				 	       <c:out value="${retErrorMessage}"></c:out> 
				 	          Click<a href="displayCustomers.html" class="confirmtions"><b> here</b></a> to display list of Customers.
				 	    </c:when>
				 	    </c:choose>
				 	    <!-- add Device -->
				 	  <c:choose>
				 	    <c:when test="${addDevice =='addDevice' }">
				 	       <c:out value="${retErrorMessage}"></c:out> 
				 	         Click<a href="searchDevice.html" class="confirmtions"><b> here</b></a> to view list of Devices.
				 	    </c:when>
				 	    </c:choose>
				 	    <!-- update Device -->
				 	  <c:choose>
				 	    <c:when test="${updateCustomer =='updateCustomer' }">
				 	       <c:out value="${retErrorMessage}"></c:out> 
				 	       Click<a href="displayCustomers.html" class="confirmtions"><b> here</b></a> to view list of customers.
				 	    </c:when>
				 	    </c:choose>
				 	     	<!-- Place an Orders -->
				 	  		<c:choose>
				 	    		<c:when test="${orders =='orders' }">
					 	       		<c:out value="${retErrorMessage}"></c:out> 
					 	        	 Click<a href="placeOrderForTechnician.html" class="confirmtions"> <b> here</b></a> to place anoher order again.
	                            	
					 	    	</c:when>
					 	    </c:choose>
					 	    
					 	    <!-- Approver Orders-->
				 	  		<c:choose>
				 	    		<c:when test="${approverOrders =='approverOrders' }">
					 	       		<c:out value="${retErrorMessage}"></c:out> 
					 	        	 Click<a href="ordermanagement.html" class="confirmtions"> <b> here</b></a> to approve other orders.
	                            	
					 	    	</c:when>
					 	    </c:choose>
					 	    <!-- Ship Orders-->
				 	  		<c:choose>
				 	    		<c:when test="${shipOrder =='shipOrder' }">
					 	       		<c:out value="${retErrorMessage}"></c:out> 
					 	        	 Click<a href="ordermanagement.html" class="confirmtions"> <b> here</b></a> to approve other orders.
	                            	
					 	    	</c:when>
					 	    </c:choose>
					 	    <!-- Decline Order -->
				 	  	<c:choose>
					 	    <c:when test="${declineOrder =='declineOrder' }">
					 	       <c:out value="${retErrorMessage}"></c:out> 
					 	      . Click<a href="pendingOrders.html" class="confirmtions"><b> here</b></a> to view list of pending Orders.                            
					 	    </c:when>
				 	    </c:choose>
				 	    
				 	     <!-- update tickets -->
				 	  	<c:choose>
					 	    <c:when test="${managerUpdateTicket =='managerUpdateTicket' }">
					 	       <c:out value="${retErrorMessage}"></c:out> 
					 	                                   
					 	    </c:when>
				 	    </c:choose>
				 	    <!-- Add Spares -->
				 	  	<c:choose>
					 	    <c:when test="${addSpares =='addSpares' }">
					 	       <c:out value="${retErrorMessage}"></c:out> Click<a href="addSpares.html" class="confirmtions"><b> here</b></a> to add another Spare/Part or Click <a href="availableSpareParts.html" class="confirmtions"><b> here</b></a> to view available stock in HO.                            
					 	    </c:when>
				 	    </c:choose>				 	    
				 	    <!-- Receive Spares -->
				 	  	<c:choose>
					 	    <c:when test="${receiveSpareParts =='receiveSpareParts' }">
					 	       <c:out value="${retErrorMessage}"></c:out> Click<a href="receiveParts.html" class="confirmtions"><b> here</b></a> to add another Spare/Part or Click <a href="availableSpareParts.html" class="confirmtions"><b> here</b></a> to view available stock in HO.                          
					 	    </c:when>
				 	    </c:choose>
				 	    <!-- performTicketAciton -->
				 	    <c:choose>
				 	    	<c:when test="${performTicketAction == 'performTicketAction'}">
				 	    		<c:out value="${retErrorMessage}"> Click<a href="ticketmanagement.html" class="confirmtions"><b> here</b></a> to go to order management.</c:out>
				 	    	</c:when>
				 	    </c:choose>
				 	    
				 	    </div>
				 	    
				 	</c:if><!-- //On failure returned message -->
				 	 <a href="home.html" class="confirmtions"><img src="resources/images/ic_home.png" /></a>
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
	src="<c:url value="/resources/jquery/1.13.1/jquery.validate.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>

<script type="text/javascript"
	src="<c:url value="/resources/custom/js/velas_ticketdetails.js" />"></script>


</html>