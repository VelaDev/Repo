<%@ include file="templates/taglibs.jsp"%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Order</title>
</head>
<c:import url="templates/techniciannavbar.jsp"></c:import>
<body class=".container-fluid">
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
						<b>Make Order</b>
					</div>
				</h3>
			</div>
			<div class="panel-body">
				<form:form method="post" action="makeOrder"
					modelAttribute="makeOrder">
					<br>
					<div class="row">
						<div class="col-xs-12">
							<div class="col-xs-2 form-control-label">
								<label>Serial Number:</label>

							</div>
							<div class="col-xs-3">
								<input type="text" class="form-control" name="device" required="required">
							</div>

							<div class="col-xs-2 form-control-label">
								<label>Part Number:</label>
							</div>
							<div class="col-xs-3">
								<select name="part" class="form-control" tabindex="1" required="required">
									<option value="">Part Number
									<option>
									<option value="CLT-R806K">CLT-R806K</option>
									<option value="CLT-R806X">CLT-R806X</option>
									<option value="CLT-W806">CLT-W806</option>
								</select>
							</div>
						</div>
					</div>
					<br>
					<br>
					<div class="row">
						<div class="col-xs-12">
							<div class="col-xs-2 form-control-label">
								<label>Quantity:</label>

							</div>
							<div class="col-xs-3">
								<input type="text" class="form-control" name="quantity" required="required">
							</div>

							<div class="col-xs-2 form-control-label">
								<label>Delivery:</label>

							</div>
							<div class="col-xs-3">
								<select name="delivery" class="form-control" tabindex="1" required="required">
									<option value="">Delivery
									<option>
									<option value="1">Yes</option>
									<option value="0">No</option>
								</select>
							</div>
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col-xs-12">
							<div class="col-xs-2 form-control-label">
								<label>Description:</label>

							</div>
							<div class="col-xs-3">
								<textarea rows="5" cols="102" name="description" required="required"></textarea>
							</div>
						</div>
					</div>
					<br>
					<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-8">
							<input type="submit" value="Submit"
								class="btn btn-primary btn-block btn-lg" tabindex="9"
								id="submit">
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript"
	src="<c:url value="/resources/bootstrap-3.3.6/js/jquery-2.1.4.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script>
<link
	href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />