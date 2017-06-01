<%@include file="templates/taglibs.jsp"%>
<% String employee = (String)session.getAttribute("addEmployee"); %>
<% String order = (String)session.getAttribute("placeOrder"); %>
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
				 	<c:if test="${not empty retMessage }">
				 	    
							<div class="alert alert-info" role="alert">
								<c:out value="${ retMessage}">
								</c:out>
								. Click here to go<a href="home.html">Home</a> or add another <a
									href="registerEmployee.html">Employee</a>.
							</div>
						</c:if>
						<c:if test="${not empty retErrorMessage }">
							<div class="alert alert-danger" role="alert">
								<c:out value="${ retErrorMessage}">
								</c:out>
								. Click <a href="registerEmployee.html">Here</a>to add employee with different email address.
							</div>
						</c:if>
				 	<c:choose>
					 	 <c:when test="${employee =='addEmployee'}">
					 	    
					 	 </c:when>
				 	</c:choose>
						
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