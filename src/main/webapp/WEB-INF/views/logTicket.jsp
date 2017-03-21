<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Log a ticket | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	<div class="velaphanda_containter">
		<c:import url="templates/navbar.jsp"></c:import>
		<div class="container">
			<c:if test="${not empty retMessage }">
				<div class="alert alert-info" role="alert">
					<c:out value="${ retMessage}">
					</c:out>
				</div>
			</c:if>
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Log Ticket</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">
						<form action="searchSerialNumberLogtickr" method="post"
							id="searchBylogTicket">
							<div class="row">
								<!-- Text input Search-->
								<div class="form-group">
									<label class="col-md-3 control-label">Search Device </label>
									<div class="col-md-4 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-hdd"></i></span> <input
												name="serialNumber" list="serialNumbers" class="form-control"
												type="text" onkeydown="upperCaseF(this)" placeholder='Search By Serial Number'>
										</div>
									</div>
									<!-- Iterating over the list sent from Controller -->
									<datalist id="serialNumbers"> 
									<c:forEach var="list"
										items="${serialNumbers}">
										<option value="${list}">
									</c:forEach> </datalist>

									<div class="col-md-2">
										<input class="btn btn-success" type='submit' value='Search' />
									</div>
									
									<div class="col-md-2">
										<input class="btn btn-success" type='submit' value='Search' />
									</div>
										
													
					
								</div>
							</div>
							<hr>
						</form>
						<!--Search-->
						<form:form method="post" class="well form-horizontal"
							action="logTicketAdmin" modelAttribute="logTicketAdmin"
							id="logTicket">

							<%-- <form:form method="post" action="logTicketAdmin" role="form" modelAttribute="logTicketAdmin" id="form">
						 --%>
							<!--First Column-->
							<div class="col-md-6">
								<!-- Text input Serial No-->
								<div class="form-group">
									<label class="col-md-3 control-label">Serial No</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-barcode"></i></span> <input
												name="device" readonly="readonly" value="${product.serialNumber }"
												class="form-control" type="text">
										</div>
									</div>
								</div>

								<!-- Text input Contract Start Date-->
								<div class="form-group">
									<label class="col-md-3 control-label">Contract Start
										Date</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-calendar"></i></span> <input
												name="startDate" value="${product.startDate}"
												class="form-control" type="text">
										</div>
									</div>
								</div>

								<!-- Select type Province-->

								<div class="form-group">
									<label class="col-md-3 control-label">Priority</label>
									<div class="col-md-6 selectContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-list"></i></span> <select
												name="priority" class="form-control selectpicker">
												<option value="">Select Priority</option>
												<option value="High">High</option>
												<option value="Medium">Medium</option>
												<option value="Low">Low</option>
											</select>
										</div>
									</div>
								</div>

								<div class="form-group">
									<label class="col-md-3 control-label">Assign Technician</label>
									<div class="col-md-6 selectContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-list"></i></span> <select
												name="technicianUserName" class="form-control selectpicker">
												<option>Select Technician</option>
												<c:forEach items="${technicians}" var="technician">
													<option value="${technician.email}">${technician.firstName} ${technician.lastName}</option>
												</c:forEach>
											</select>
										</div>
									</div>
								</div>

							</div>
							<!--/F Column-->

							<!--Second column-->
							<div class="col-sm-6">

								<!-- Text input Machine Model-->
								<div class="form-group">
									<label class="col-md-3 control-label">Machine Model</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-barcode"></i></span> <input
												value="${product.modelNumber }"
												class="form-control" type="text">
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
												name="endDate" id="endDate" value="${product.endDate }"
												class="form-control" type="text">
										</div>
									</div>
								</div>

								<!-- Text input Customer Name-->
								<div class="form-group">
									<label class="col-md-3 control-label">Customer Name</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-barcode"></i></span> <input
												 value="${product.customer.customerName }"
												class="form-control" type="text">
										</div>
									</div>
								</div>


								<!-- Text area Subject-->
								<div class="form-group">
									<label class="col-md-3 control-label">Subject</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-pencil"></i></span>
											<textarea class="form-control" name="subject"
												required="required"></textarea>
										</div>
									</div>
								</div>
							</div>
							<!--/S Column-->
							
							<!-- Text area -->
								<div class="form-group">
									<label class="col-md-3 control-label">Description</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-pencil"></i></span>
											<textarea class="form-control" name="description"
												placeholder="Description"></textarea>
										</div>
									</div>
								</div>
							
							<div class="form-group row">
								<div class="col-sm-offset-2 col-sm-8">
									<br>
									<br> <input type="submit" value="Log Ticket"
										class="btn btn-primary btn-block btn-lg" tabindex="9"
										id="logTicket">
								</div>
							</div>

						</form:form>


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
	<!-- Validate LogTicket -->
	<script>
		$(document)
				.ready(
						function() {
							$('#logTicket')
									.bootstrapValidator(
											{
												feedbackIcons : {
													valid : 'glyphicon glyphicon-ok',
													invalid : 'glyphicon glyphicon-remove',
													validating : 'glyphicon glyphicon-refresh'
												},
												fields : {
													serialNumber : {
														validators : {
															stringLength : {
																min : 3,
															},
															notEmpty : {
																message : 'Serial number is required to search and cannot be empty'
															}
														}
													},
													priority : {
														validators : {
															notEmpty : {
																message : 'Priority is required and cannot be empty'
															}
														}
													},
													description : {
														validators : {
															stringLength : {
																min : 10,
																max : 200,
																message : 'Please enter at least 10 characters and no more than 200'
															},
															notEmpty : {
																message : 'Descritipn is required and cannot be empty'
															}
														}
													},
												}
											});
						});
	</script>

	<!-- Search By Serial -->
	<script>
		$(document)
				.ready(
						function() {
							$('#searchBylogTicket')
									.bootstrapValidator(
											{
												feedbackIcons : {
													valid : 'glyphicon glyphicon-ok',
													invalid : 'glyphicon glyphicon-remove',
													validating : 'glyphicon glyphicon-refresh'
												},
												fields : {
													serialNumber : {
														validators : {
															stringLength : {
																min : 3,
															},
															notEmpty : {
																message : 'Serial number is required to search and cannot be empty'
															}
														}
													},
												}
											});
						});
	</script>


<!-- Make all Serials numbers UpperCase  -->
<script type="text/javascript">
	function upperCaseF(a){
	    setTimeout(function(){
	        a.value = a.value.toUpperCase();
	    }, 1);
	}
</script>
	
	
<!-- Create datalist to populate search -->
<script type="text/javascript">

// Get the <datalist> and <input> elements.
var dataList = document.getElementById('json-datalist');
var input = document.getElementById('ajax');

// Create a new XMLHttpRequest.
var request = new XMLHttpRequest();

// Handle state changes for the request.
request.onreadystatechange = function(response) {
  if (request.readyState === 4) {
    if (request.status === 200) {
      // Parse the JSON
      var jsonOptions = JSON.parse(request.responseText);
  
      // Loop over the JSON array.
      jsonOptions.forEach(function(item) {
        // Create a new <option> element.
        var option = document.createElement('option');
        // Set the value using the item in the JSON array.
        option.value = item;
        // Add the <option> element to the <datalist>.
        dataList.appendChild(option);
      });
      
      // Update the placeholder text.
      input.placeholder = "e.g. datalist";
    } else {
      // An error occured :(
      input.placeholder = "Couldn't load datalist options :(";
    }
  }
};

// Update the placeholder text.
input.placeholder = "Loading options...";

// Set up and make the request.
request.open('GET', 'https://s3-us-west-2.amazonaws.com/s.cdpn.io/4621/html-elements.json', true);
request.send();

</script>
	
</body>
</html>
