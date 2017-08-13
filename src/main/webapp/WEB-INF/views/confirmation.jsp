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
			
			<div class="panel panel-success" style="margin-left:25%; margin-right:25%;">
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
				 	 	<!-- Place an Orders -->
				 	  	<c:choose>
					 	    <c:when test="${orders =='orders' }">
					 	       <c:out value="${retMessage}"></c:out> 
					 	         Click<a href="ordertechmanagement.html" class="confirmtions"><b> here</b></a> to place another Order.
					 	                        
					 	    </c:when>
				 	    	</c:choose>
				 	    	<!-- Receive Order -->
				 	    	<c:choose>
					 	    <c:when test="${receiveOrder =='receiveOrder' }">
					 	       <c:out value="${retMessage}"></c:out> 
					 	          or click<a href="ordertechmanagement.html" class="confirmtions"><b> here</b></a> to receive other orders.	                            
					 	    </c:when>
				 	    	</c:choose>
				 	    	<!-- Update Ticket -->
				 	    	<c:choose>
					 	    <c:when test="${techUpdateTicket =='techUpdateTicket' }">
					 	       <c:out value="${retMessage}"></c:out> 
					 	                             
					 	    </c:when>
				 	    	</c:choose>	
				 	    	 <!-- create leave -->
				 	  	<c:choose>
					 	    <c:when test="${techAddLeave =='techAddLeave' }">
					 	       <c:out value="${retMessage}"></c:out> 
					 	           Click<a href="techleavemanagement.html" class="confirmtions"><b> here</b></a> to go to leave management.                         
					 	    </c:when>
				 	    </c:choose>	
				 	     <!-- update leave -->
				 	  	<c:choose>
					 	    <c:when test="${techUpdateLeave =='techUpdateLeave' }">
					 	       <c:out value="${retMessage}"></c:out> 
					 	           Click<a href="techleavemanagement.html" class="confirmtions"><b> here</b></a> to go to leave management.                         
					 	    </c:when>
				 	    </c:choose>	
				 	     <!-- cancel leave -->
				 	  	<c:choose>
					 	    <c:when test="${technicianCancel =='technicianCancel' }">
					 	       <c:out value="${retMessage}"></c:out> 
					 	           Click<a href="techleavemanagement.html" class="confirmtions"><b> here</b></a> to go to leave management.                         
					 	    </c:when>
				 	    </c:choose>	
				 	    <c:choose>
					 	    <c:when test="${techOnLeave =='techOnLeave' }">
					 	       <c:out value="${retMessage}"></c:out> 
					 	           Click<a href="techleavemanagement.html" class="confirmtions"  ><b> here</b></a> to go to leave management.                         
					 	    </c:when>
				 	    </c:choose>					 	    
				 	    
				 	    <!-- performTicketAciton -->
				 	    <c:choose>
				 	    	<c:when test="${performTicketAction == 'performTicketAction'}">
				 	    		<c:out value="${retMessage}"> Click<a href="ticketmanagement.html" class="confirmtions"><b> here</b></a> to go to order management.</c:out>
				 	    	</c:when>
				 	    </c:choose>
				 	    </div>
				 	</c:if><!-- Successful message -->
				 	
				 	<!-- On failure returned message -->
				 	<c:if test="${not empty retErrorMessage}">
				 	    
				 	    <div class="alert alert-danger" role="alert">
				 	   		 <!-- Place an Orders -->
				 	  		<c:choose>
				 	    		<c:when test="${orders =='orders' }">
					 	       		<c:out value="${retErrorMessage}"></c:out> 
					 	        	  Click<a href="order.html" class="confirmtions"> <b> here</b></a> to place another Order.
	                            	
					 	    	</c:when>
					 	    </c:choose>
					 	    <!-- Receive Order -->
				 	    	<c:choose>
						 	    <c:when test="${receiveOrder =='receiveOrder' }">
						 	       <c:out value="${retErrorMessage}"></c:out> 
						 	      	  Click<a href="ordertechmanagement.html" class="confirmtions"><b> here</b></a> to receive other orders.	                            
						 	    </c:when>
				 	    	</c:choose>
				 	    	<!-- Update Ticket -->
				 	    		<c:choose>
					 	    <c:when test="${techUpdateTicket =='techUpdateTicket' }">
					 	       <c:out value="${retErrorMessage}"></c:out> 
					 	                      
					 	    </c:when>
				 	    	</c:choose>
				 	  
				 	    </div>
				 	</c:if><!-- //On failure returned message -->
					
						<a href="technicianHome.html" class="confirmtions"><img src="resources/images/ic_home.png" /></a>        
					
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



</body>
</html>