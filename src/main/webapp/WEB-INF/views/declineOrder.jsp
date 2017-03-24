<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link type="text/stylesheet" href="<c:url value="/resources/custom/css/vela_custom.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap-3.3.7/fonts/font-awesome.min.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />" />

<title>Decline Order</title>
<style type="text/css">

.declineButton{
	margin-left:25%;
	margin-right:10%;
}
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
			
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Decline Order</b>
						</div>
					</h3>
				</div>

				<div class="panel-body">
					<div class="tab-content">

						<form:form class="well form-horizontal" method="post"
							action="declineOrder" id="decline" modelAttribute="declineOrder">
							
								
								<!-- Text input Order Number-->
								<div class="form-group">
									<label class="col-md-3 control-label">Order Number</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-barcode"></i></span> <input
												id="orderNo" name="orderNo" class="form-control" type="text"
												value='' readonly="readonly">
										</div>
									</div>
								</div>
								
								
								<!-- Text area Decline Reason-->
								<div class="form-group">
									<label class="col-md-3 control-label">Reason for Declining</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-pencil"></i></span>
											<textarea cols="10" rows="10" class="form-control" id="declineReason" name="declineReason"
												required="required"></textarea>
										</div>
									</div>
								</div>
								
								<br>
								<div class="declineButton">
									<div class="form-group row">
										<div class="col-sm-offset-2 col-md-5">
											<input type="submit" value="Decline Order"
												class="btn btn-primary btn-block btn-lg" tabindex="9"
												id="declineOrder" name="declineOrder">
										</div>
									</div>
								</div
								
							
							
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
	
	<!-- /Script -->
	
<!-- Validate decline order -->
		<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$('#decline').bootstrapValidator(
									{
										feedbackIcons : {
											valid : 'glyphicon glyphicon-ok',
											invalid : 'glyphicon glyphicon-remove',
											validating : 'glyphicon glyphicon-refresh'
										},
										fields : {
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
											}
										}
									
						});
				});
</script>


</body>
</html>