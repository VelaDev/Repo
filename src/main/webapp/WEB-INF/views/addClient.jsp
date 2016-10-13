<%@ include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Add Client</title>
</head>
<c:import url="templates/navbar.jsp"></c:import>
<body>
	<div class="container myrow-container" style="width: 90%">
	
		
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
						<b>Add Client</b>
					</div>
					<!-- <div align="right"><a href="">Think of something</a></div> -->
					<h3>
			</div>
			<div class="panel-body">
				<div class="col-lg-10">
					<form:form method="post" action="saveClient"
						modelAttribute="saveClient" id="saveClient">
						<div class="row">
							<div class="col-xs-12">
								<div class="col-xs-2 form-control-label">
									<label>Client Name:</label>

								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm"
										name="clientName" class="required" required="required">
								</div>

								<div class="col-xs-2 form-control-label">
									<label>Contact Person:</label>

								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm"
										name="contactPerson" class="required" required="required">
								</div>
							</div>
						</div>
						<br>

						<div class="row">

							<div class="col-xs-12">
								<div class="col-xs-2 form-control-label">
									<label>Province:</label>
								</div>
								<div class="col-xs-3">
									<select name="province" class="form-control" class="required"
										required="required">
										<option value="">Province
										<option>
										<option value="Gauteng">Gauteng</option>
										<option value="Limpopo">Limpopo</option>
										<option value="Nort West">North West</option>
										<option value="Free State">Free State</option>
										<option value="Mpumalanga">Mpumalanga</option>
										<option value="KwaZulu Natal">KwaZulu Natal</option>
										<option value="Northern Cape">Northern Cape</option>
										<option value="Eastern Cape">Eastern Cape</option>
										<option value="Mpumalanga">Western Cape</option>
									</select>
								</div>

								<div class="col-xs-2 form-control-label">
									<label>City/Town:</label>

								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm"
										name="city_town" class="required" required="required">
								</div>
							</div>
						</div>
						<br>

						<div class="row">
							<div class="col-xs-12">
								<div class="col-xs-2 form-control-label">
									<label>Street Name:</label>

								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm"
										name="streetName" class="required" required="required">
								</div>

								<div class="col-xs-2 form-control-label">
									<label>Area Code:</label>

								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm" name="zipcode"
										class="required" required>
								</div>
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-xs-12">
								<div class="col-xs-2 form-control-label">
									<label>Floor No:</label>

								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm"
										name="floorNumber" class="required" required="required">
								</div>

								<div class="col-xs-2 form-control-label">
									<label>Telephone No:</label>

								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm"
										name="tellphoneNumber" class="required" required="required">
								</div>
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-xs-12">
								<div class="col-xs-2 form-control-label">
									<label>Fax No:</label>
								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm"
										name="faxNumber" class="required" required="required">
								</div>

								<div class="col-xs-2 form-control-label">
									<label>Cell No:</label>
								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm" name="cellNumber" required="required">
								</div>
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-xs-12">
								<div class="col-xs-2 form-control-label">
									<label>Email:</label>
								</div>
								<div class="col-xs-3">
									<input type="text" class="form-control input-sm" name="email" class="required" required="required">
								</div>
							</div>
						</div>
						<br>
						<div class="form-group row">
							<div class="col-sm-offset-2 col-sm-8">
								<input type="submit" value="Submit"
									class="btn btn-primary btn-block btn-lg" tabindex="9" id="submit">
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</body>




<%-- <script type="text/javascript" 	src="<c:url value="/resources/bootstrap-3.3.6/js/jquery-2.1.4.min.js" />"></script>
<script type="text/javascript" 	src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script>
<link href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />" rel="stylesheet" type="text/css" />
 --%>

<script type="text/javascript" 	src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
<script type="text/javascript" 	src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js" />"></script>
<link href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />"rel="stylesheet" type="text/css" />

<!-- Validator -->
<link href="<c:url value="/resources/bootstrapvalidator/css/bootstrapValidator.min.css" />"rel="stylesheet" type="text/css" />
<link href="<c:url value="/resources/bootstrapvalidator/js/bootstrapValidator.min.js" />"rel="stylesheet" type="text/css" />


</html>