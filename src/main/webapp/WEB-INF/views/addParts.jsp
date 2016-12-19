<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <title>Add Spares | Velaphanda Trading & Projects</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">  
	
  <link href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" rel="stylesheet" type="text/css" /> 
  <link href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />" rel="stylesheet" type="text/css" /> 
	
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
							<b>Spares & Compatibility</b>
						</div>
					</h3>
				</div> 
				<div class="panel-body">
						<!-- tab nav -->
					<ul class="nav nav-tabs">
						<li class="active"><a href="#compatibility"	data-toggle="tab">Compatibility</a></li>
						<li><a href="#spares" data-toggle="tab">Spares</a></li>
						<!-- <li><a href="#tonner" data-toggle="tab">Tonner</a></li> -->
					</ul>					
					<div class="tab-content">
					<div class="tab-pane active" id="compatibility">
					<h4 align="center">Compatibility</h4><br>
							<form:form class="well form-horizontal" method="post" action="saveCompatibility"
					modelAttribute="saveCompatibility" id="saveCompatibility">
							
					<!--First column-->
					<div class="col-sm-6">					
						<!-- Select type Part Number-->						
						<div class="form-group">
							<label class="col-md-3 control-label">Part Number</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-list"></i></span>
										<input name="partNumber" id="partNumber"
											   placeholder="Part Number" class="form-control"type="text">
									
								</div>
							</div>
						</div>
						
					</div><!-- / F column -->	
					
					<!--Second column-->		
					<div class="col-sm-6">
					
					
						<!-- Select type Model Number-->						
						<div class="form-group">
							<label class="col-md-3 control-label">Model Number</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-list"></i></span>
									      <input name="modelNumber" id="modelNumber"
											   placeholder="Model Number" class="form-control"type="text">
								</div>
							</div>
						</div>
					</div><!-- /S column  -->
					
						<br><br><br>
						<div class="form-group row">
							<div class="col-sm-offset-2 col-sm-8">
								<input type="submit" value="Add Compatibility"
									class="btn btn-primary btn-block btn-lg" tabindex="9"
									id="addSpares">
							</div>
						</div>
					</form:form>
					
					</div><!-- /spare  -->
					
					<div class="tab-pane" id="spares">
					<h4 align="center">Spares</h4>
						<form:form class="well form-horizontal" method="post" action="saveSpareParts"
					modelAttribute="saveSpareParts" id="saveSpareParts">
							
					<!--First column-->
					<div class="col-sm-6">
					
						<!-- Select type Part Number-->						
						<div class="form-group">
							<label class="col-md-3 control-label">Part Number</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-list"></i></span>
									<select name="partNumber"
										class="form-control selectpicker">
										<option value="">Select Part Number<option>
										<option value="CLT-R806K">CLT-R806K</option>
										<option value="CLT-R806X">CLT-R806X</option>
										<option value="CLT-W806">CLT-W806</option>
									</select>
								</div>
							</div>
						</div>

						
						<!-- Select type Item Type-->						
						<div class="form-group">
							<label class="col-md-3 control-label">Item Type</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-list"></i></span>
									<select name="itemType"
										class="form-control selectpicker">
										<option value="">Select Item Type<option>
									<option value="Toner">Toner</option>
									<option value="Spares">Spares</option>
									</select>
								</div>
							</div>
						</div>
						
						
					</div><!-- / F column -->	
					
					<!--Second column-->		
					<div class="col-sm-6">
					
					
						<!-- Select type Model Number-->						
						<div class="form-group">
							<label class="col-md-3 control-label">Model Number</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-list"></i></span>
									<select name="modelNumber"
										class="form-control selectpicker">
										<option value="">Select Item Type<option>
										<option value="MultiXpress X7500LX">MultiXpress	X7500LX</option>
									</select>
								</div>
							</div>
						</div>
						
						<!-- Select type Description-->						
						<div class="form-group">
							<label class="col-md-3 control-label">Description</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-list"></i></span>
									<select name="description"
										class="form-control selectpicker">
										<option value="">Select Description<option>
									<option value="Black Imaging Unit">Black Imaging Unit</option>
									<option value="Color Imaging Unit">Color Imaging Unit</option>
									<option value="Waste Toner Bottle">Waste Toner Bottle</option>
									</select>
								</div>
							</div>
						</div>
						
					</div><!-- /S column  -->
					
						<br><br>
						<div class="form-group row">
							<div class="col-sm-offset-2 col-sm-8">
								<input type="submit" value="Add Spares"
									class="btn btn-primary btn-block btn-lg" tabindex="9"
									id="addSpares">
							</div>
						</div>
						</form:form>
					</div><!-- /parts  -->
					
					
			<%-- 	<div class="tab-pane" id="tonner">
					<h4 align="center">Tonner</h4>
				<form:form class="well form-horizontal" method="post" action="saveSpareParts"
					modelAttribute="saveSpareParts" id="saveSpareParts">
							
					<!--First column-->
					<div class="col-sm-6">					
						<!-- Select type Tonner Code-->						
						<div class="form-group">
							<label class="col-md-3 control-label">Tonner Code</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-list"></i></span>
										<input type="text" class="form-control" placeholder="Tonner Code" name="tonnerCode" id="tonnerCode">
								</div>
							</div>
						</div>
						
						<!-- Select type Description-->						
						<div class="form-group">
							<label class="col-md-3 control-label">Description</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-list"></i></span>
									<select name="description"
										class="form-control selectpicker">
										<option value="">Select Description<option>
									<option value="Black Imaging Unit">Black Imaging Unit</option>
									<option value="Color Imaging Unit">Color Imaging Unit</option>
									<option value="Waste Toner Bottle">Waste Toner Bottle</option>
									</select>
								</div>
							</div>
						</div>
						
						
						<!-- Select type Quantity-->						
						<div class="form-group">
							<label class="col-md-3 control-label">Quantity</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-edit"></i></span>
									<input class="form-control" Placeholder="Quantity" id="quantity" type="text">
								</div>
							</div>
						</div>
						
					</div><!-- / F column -->	
					
					<!--Second column-->		
					<div class="col-sm-6">
					
					
						<!-- Select type Supplier Name-->						
						<div class="form-group">
							<label class="col-md-3 control-label">Supplier Name</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-list"></i></span>
									<input type="text" class="form-control" placeholder="Supplier Name" id="supplierName" name="supplierName">
								</div>
							</div>
						</div>
						
						<!-- Select type Received By-->						
						<div class="form-group">
							<label class="col-md-3 control-label">Recieved By</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-edit"></i></span>
									<input class="form-control" id="receivedBy" placeholder="Recieved By" type="text">
								</div>
							</div>
						</div>
						
						
						
					</div><!-- /S column  -->
					
						<br><br>
						<div class="form-group row">
							<div class="col-sm-offset-2 col-sm-8">
								<input type="submit" value="Add Tonner"
									class="btn btn-primary btn-block btn-lg" tabindex="9"
									id="addTonner">
							</div>
						</div>
					</form:form>
					
					</div><!-- /tonner  --> --%>
					
					</div><!-- /tab-content -->									
				</div><!-- /panel body -->
			</div><!--/panel success class-->
		</div><!-- /Container -->
		
		<!-- Footer -->
		<c:import url="templates/footer.jsp"></c:import>
		<!--/ Footer -->
		
	</div><!-- / velaphanda_containter -->
	
<!-- Scripts -->
<script type="text/javascript" src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script> 
<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
<!-- /Scripts -->

<!-- Validate add part -->
<script>
  $(document).ready(function() {
    $('#saveSpareParts').bootstrapValidator({
            feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	partNumber: {
                validators: {
                    notEmpty: {
                        message: 'Part number is required and cannot be empty'
                    }
                }
            },
            itemType: {
                validators: {
                    notEmpty: {
                        message: 'Item type is required and cannot be empty'
                    }
                }
            },
            modelNumber: {
                validators: {
                    notEmpty: {
                        message: 'Model mumber is required and cannot be empty'
                    }
                }
            },
            description: {
                validators: {
                    notEmpty: {
                        message: 'Description is required and cannot be empty'
                    }
                }
            },            
        }
    });
});

</script>


</body>
</html>
