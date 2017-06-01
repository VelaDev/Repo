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
		<c:import url="templates/navbar.jsp"></c:import>
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
				 	       <c:out value="${retMessage}"></c:out> 
				 	        Click<a href="displayEmployees.html" class="confirmtions"><b> here</b></a> to view employee you have added, or 
                            Click <a href="registerEmployee.html" class="confirmtions"> <b> here</b></a> to add another new Employee.
				 	    </c:when></c:choose>
				 	     <!-- Update employee -->
				 	    <c:choose>
				 	     <c:when test="${updateEmployee =='updateEmployee' }">
				 	         <c:out value="${retMessage}"></c:out> 
				 	          Click<a href="home.html" class="confirmtions"> <b> here</b></a> to go to Home, or 
                              Click <a href="displayEmployees.html" class="confirmtions"> <b> here</b></a> to view employees list. 
				 	    </c:when>
				 	    </c:choose> 
				 	     <!-- Change password -->
				 	    <c:choose>
				 	    <c:when test="${changePassword =='changePassword' }">
                           <c:out value="${retMessage}"></c:out>
                                Click <a href="displayEmployees.html" class="confirmtions"> <b> here</b></a>  to view employees list.        
                           </c:when>
				 	    </c:choose>
				 	   <!--  Reset Password -->
				 	    <c:choose>
				 	       <c:when test="${resetPassword =='resetPassword' }">             
                           <c:out value="${retMessage}"></c:out>
                                  Click <a href="displayEmployees.html" class="confirmtions"> <b> here</b></a> to view employees list.    
                           </c:when>
				 	    </c:choose>
				 	    </div>
				 	</c:if>
				 	
				 	
				 	<c:if test="${not empty retErrorMessage}">
				 	    <!-- Add employee -->
				 	    <div class="alert alert-danger" role="alert">
				 	  <c:choose>
				 	    <c:when test="${addEmployee =='addEmployee' }">
				 	       <c:out value="${retErrorMessage}"></c:out> 
				 	        Click<a href="displayEmployees.html" class="confirmtions"> <b> here</b></a> to view employees list or 
                            Click <a href="registerEmployee.html" class="confirmtions"> <b> here</b></a> to add another new Employee.
				 	    </c:when>
				 	    </c:choose>
				 	     <!-- Update employee -->
				 	    <c:choose>
				 	     <c:when test="${updateEmployee =='updateEmployee' }">
				 	         <c:out value="${retErrorMessage}"></c:out> 
				 	          Click<a href="home.html" class="confirmtions"> <b> here</b></a> to go to Home, or 
                              Click <a href="displayEmployees.html" class="confirmtions"> <b> here</b></a> to view employees list. 
				 	    </c:when>
				 	    </c:choose> 
				 	     <!-- Change password -->
				 	    <c:choose>
				 	    <c:when test="${changePassword =='changePassword' }">
                           <c:out value="${retErrorMessage}"></c:out>
                                Click <a href="displayEmployees.html" class="confirmtions"> <b> here</b></a>  to view employees list.        
                           </c:when>
				 	    </c:choose>
				 	   <!--  Reset Password -->
				 	    <c:choose>
				 	       <c:when test="${resetPassword =='resetPassword' }">             
                           <c:out value="${retErrorMessage}"></c:out>
                                  Click <a href="displayEmployees.html" class="confirmtions"><b> here</b></a> to view employees list.    
                           </c:when>
				 	    </c:choose>
				 	    </div>
				 	</c:if>
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