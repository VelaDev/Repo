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
<style type="text/css">
    .onleave{background:red; color:white;}
</style>
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
			<c:if test="${not empty message }">
				<div class="alert alert-danger" role="alert">
					<c:out value="${ message}">
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
												name="serialNumber" list="serialNumbers"
												class="form-control" type="text"
												onkeydown="upperCaseF(this)"
												placeholder='Search By Serial Number'/>
										</div>
									</div>
									<!-- Iterating over the list sent from Controller -->
									<datalist id="serialNumbers"> <c:forEach var="list"
										items="${serialNumbers}">
										<option value="${list}">
									</c:forEach> </datalist>

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
							
							<!--First Column-->
							<div class="col-md-6">
								<!-- Text input Serial No-->
								<div class="form-group">
									<label class="col-md-3 control-label">Serial No</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-barcode"></i></span> <input
												name="device" id="device" readonly="readonly"
												value="${product.serialNumber }" class="form-control"
												type="text">
										</div>
									</div>
								</div>

								<!-- Text input Machine Model-->
								<div class="form-group">
									<label class="col-md-3 control-label">Model No</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-barcode"></i></span> <input name="modelNumber" id="modelNumber"
												value="${product.modelNumber }" class="form-control"
												type="text" readonly="readonly">
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
												value="${product.customerDevice.customerName }"
												class="form-control" id="customerName" name="customerName" type="text" required="required" readonly="readonly">
										</div>
									</div>
								</div>

								
								<!-- Assign Technician -->
								<div class="form-group">
									<label class="col-md-3 control-label">Assign Technician</label>
									<div class="col-md-6 selectContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-list"></i></span> <select id="selectedTechnician" 
												name="technicianUserName" id="selectedTechnician" class="form-control selectpicker">
												<option value="">Select Technician</option>
												<c:forEach items="${technicians}" var="technician">
												   <c:choose>
												     <c:when test="${technician.leaveStatus =='On Leave'}">
												         <option class="onleave" value="${technician.email}">${technician.firstName}
														${technician.lastName} (On Leave)</option>
												     </c:when>
											          <c:when test="${technician.leaveStatus =='Available'}">
												         <option value="${technician.email}">${technician.firstName}
														${technician.lastName}</option>
												     </c:when>
												   </c:choose>
													
												</c:forEach>
											</select>
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
											<textarea class="form-control" id="subject" name="subject"
												required="required" readonly="readonly">Technical Service Call</textarea>
										</div>
									</div>
								</div>
																
								
								<!-- Text input Contact Person First Name-->
								<div class="form-group">
									<label class="col-md-3 control-label" style="color: red;">Contact Person</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											
										</div>
									</div>
								</div>								
								
									
								<!-- Text input Contact Person First Name-->
								<div class="form-group">
									<label class="col-md-3 control-label">First Name</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-user"></i></span> <input id="firstName"
												name="firstName" placeholder="First Name"
												class="form-control" type="text">
										</div>
									</div>
								</div>
								
								
								<!-- Text input Contact Person  Last Name-->
								<div class="form-group">
									<label class="col-md-3 control-label">Last Name</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-user"></i></span> <input id="lastName"
												name="lastName" placeholder="Last Name" class="form-control"
												type="text">
										</div>
									</div>
								</div>
								
								

							</div>
							<!--/F Column-->

							<!--Second column-->
							<div class="col-sm-6">
								
								<!-- Select type Priority-->
								<div class="form-group">
									<label class="col-md-3 control-label">Priority</label>
									<div class="col-md-6 selectContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-list"></i></span> <select
												name="priority" id="priority" class="form-control selectpicker">
												<option value="">Select Priority</option>
												<option value="High">High</option>
												<option value="Medium">Medium</option>
												<option value="Low">Low</option>
											</select>
										</div>
									</div>
								</div>
								
								<!-- Text area -->
								<div class="form-group">
									<label class="col-md-3 control-label">Description</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-pencil"></i></span>
											<textarea class="form-control" name="description" id="description"
												placeholder="Description" onkeydown="upperCaseF(this)"
												style="margin: 0px; height: 170px;"></textarea>
										</div>
									</div>
								</div>
								
								
								<div class="form-group">
									<label class="col-md-3 control-label">Email</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-envelope"></i></span> <input id="contactEmail"
												name="contactEmail" placeholder="Email Address"
												class="form-control" type="email">
										</div>
									</div>
								</div>
								
								<!-- Text input Contact Person Cellphone Number-->
								<div class="form-group">
									<label class="col-md-3 control-label">Cellphone No</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-earphone"></i></span> <input
												id="contactCellNumber" name="contactCellNumber"
												placeholder="Cellphone No (Optional)" class="form-control" maxlength="10" type="text" onkeypress="return isNumber(event)">
										</div>
									</div>
								</div>
								<!-- Text input Contact Person Tellphone Number-->
								<div class="form-group">
									<label class="col-md-3 control-label">Tellphone No </label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-earphone"></i></span> <input
												id="contactTelephoneNumber" name="contactTelephoneNumber"
												placeholder="Telephone No (Optional)" class="form-control" maxlength="10" type="text" onkeypress="return isNumber(event)">
										</div>
									</div>
								</div>

							</div>
							<!--/S Column-->
							
							

							<div class="form-group row">
								<div class="col-sm-offset-2 col-sm-8">
									<br> <br> <input type="submit" value="Log Ticket"
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
													device : {
														validators : {
															stringLength : {
																min : 3,
															},
															notEmpty : {
																message : 'Serial number is required to search and cannot be empty'
															}
														}
													},
													modelNumber : {
														validators : {
															stringLength : {
																min : 3,
															},
															notEmpty : {
																message : 'Model number is required to search and cannot be empty'
															}
														}
													},
													technicianUserName : {
														validators : {
															notEmpty : {
																message : 'Technician is required and cannot be empty'
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
													customerName : {
														validators : {
															stringLength : {
																min : 2,

															},
															notEmpty : {
																message : 'Customer name is required and cannot be empty'
															},
															regexp: {
											                    regexp: /^[-_ a-zA-Z0-9]+$/,
											                    message: 'Customer name can consist of only alphabetical characters'
											                }
														}
													},
													firstName : {
														validators : {
															stringLength : {
																min : 3,
															},
															notEmpty : {
																message : 'First name is required to search and cannot be empty'
															}
														}
													},
													lastName : {
														validators : {
															stringLength : {
																min : 3,
															},
															notEmpty : {
																message : 'Last name is required to search and cannot be empty'
															}
														}
													},
													contactEmail : {
														validators : {
															notEmpty : {
																message : 'Email address is required and cannot be empty'
															},
															emailAddress : {
																message : 'The email address is not valid'
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
		function upperCaseF(a) {
			setTimeout(function() {
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
		request
				.open(
						'GET',
						'https://s3-us-west-2.amazonaws.com/s.cdpn.io/4621/html-elements.json',
						true);
		request.send();
	</script>
<script type="text/javascript">

function myFunction(){
	
	/* var index =0;
	var onLeaveTechnician =  ${onLeaveTechnicians}
	for (index = 0; index < onLeaveTechnician.length; ++index) {
	    if(onLeaveTechnician[index]==selectedTechnician){
	    	console.log(index);
	    	alert("Technician on leave");	    	
	    }
	} */
	//document.getElementById('selectedTechnician').html;
}
function checkTech(val){
	
	var element=document.getElementById('selectedTechnician');
	var index =0;
	var onLeaveTechnician =  ${onLeaveTechnicians};
	for (index = 0; index < onLeaveTechnician.length; ++index) {
	    if(onLeaveTechnician[index]==selectedTechnician){
	    	console.log(index);
	    	alert("Technician on leave");	    	
	    }
	}
	if(val==selectedTechnician); 
	  alert("Technician on leave");
	  console.log(selectedTechnician);
	}

</script>
</body>
</html>
