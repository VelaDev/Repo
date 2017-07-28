<%@ include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Order | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!--style-->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/custom/css/vela_custom.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap-3.3.7/fonts/font-awesome.min.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" />
<link rel="stylesheet" type="text/css" 	href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap-3.3.7/css/datepicker.min.css" />">


<link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">
<!--/style-->
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
			<c:if test="${not empty retErrorMessage }">
				<div class="alert alert-info" role="alert">

					<c:out value="${ retErrorMessage}">
					</c:out>
				</div>
			</c:if>
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>New Order</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">
					
						<form:form class="well form-horizontal" modelAttribute="makeOrder"
							method="post" action="makeOrder" id="putInOrder" onsubmit="return checkChecked('putInOrder');">


							<!-- Select type Stock Type-->
							<div class="form-group">
								<label class="col-md-3 control-label">Stock Type</label>
								<div class="col-md-6 selectContainer">
									<div class="input-group">
										<span class="input-group-addon"><i
											class="glyphicon glyphicon-list"></i></span><select id="stockType"
											name="stockType" class="form-control"
											onchange='CheckStockType(this.value);'
											class="form-control selectpicker">
											<option value="">Select Stock Type</option>
											<option value="Boot">Boot</option>
											<option value="Site">Site</option>
										</select>
									</div>
								</div>
							</div>

							<div id="Site" style='display: none;'>								

							<!-- Text input Customer Name-->
							<div class="form-group">
								<label class="col-md-3 control-label">Customer Name</label>
								<div class="col-md-6 inputGroupContainer">
									<div class="input-group">
										<span class="input-group-addon"><i
											class="glyphicon glyphicon-user"></i></span><select id="Site" name="customer"
											class="form-control selectpicker">
											<option value="">Customer Name</option>
											<c:forEach items="${customerList}" var="customer">
												<option value="${customer.customerName}">${customer.customerName}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
							</div>							
							
							
							<div class="form-group">
									<label class="col-md-3 control-label">Technician</label>
									<div class="col-md-6 selectContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-list"></i></span> <select
												name="technicianUserName" id="technicianUserName" class="form-control selectpicker">
												<option value="">Select Technician</option>
												<c:forEach items="${technicianList}" var="technician">
													<option value="${technician.email}">${technician.firstName} ${technician.lastName}</option>
												</c:forEach>
											</select>
										</div>
									</div>
								</div>

							<!-- Text input Approver-->
							<div class="form-group">
								<label class="col-md-3 control-label">Approver</label>
								<div class="col-md-6 inputGroupContainer">
									<div class="input-group">
										<span class="input-group-addon"><i
											class="glyphicon glyphicon-user"></i></span><select
												name="approver" id="approver" class="form-control selectpicker">
												<option value="">Select Manager</option>
												<c:forEach items="${managersList}" var="approver">
													<option value="${approver.email}">${approver.firstName} ${approver.lastName}</option>
												</c:forEach>
												</select>
													
									</div>
								</div>
							</div>

							<br />
							<div id="makeOrders">
								<table id="myDatatable" class="display datatable">
									<thead>
										<tr>
											<th>Part No</th>
											<th>Description</th>
											<th>Model No </th>
											<th>Available QTY</th>
											<th>Tick To Order</th>
											<th>Quantity</th>
											<!-- <th>Edit</th> -->
										</tr>
									</thead>
									<tbody>
										<!-- Iterating over the list sent from Controller -->
										<c:forEach var="list" items="${compatibility}">

											<tr>
												<td>${list.partNumber}</td>
												<td>${list.itemDescription}</td>
												<td>${list.compitableDevice}</td>
												<td><input type="text" id="${list.partNumber}_avaliableQuantity" name="avaliableQuantity" class="form-control" readonly="readonly" value="${list.quantity}"></td>
								                <td><input type="checkbox" class="form-group" id="checkedOrder" name="selectedItem"  value="${list.partNumber},${list.compitableDevice},${list.itemDescription}"></td>
								                <td><input type="text" id="${list.partNumber}_quantity" name="quantity" class="form-control" onblur="compareQuantity(this, ${list.quantity})" value="" /></td>

											</tr>

										</c:forEach>
									</tbody>
								</table>

							</div>

							<div class="form-group row">
								<div class="col-sm-offset-2 col-sm-8">
									<br> <br> <input type="submit" value="Place Order"
										class="btn btn-primary btn-block btn-lg" tabindex="9"
										id="putorder" name="putorder">
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

	<!-- Scripts -->
	<script type="text/javascript"
		src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
		<script type="text/javascript"
	src="<c:url value="/resources/jquery/1.13.1/jquery.validate.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap-datepicker.min.js" />"></script>

	<!-- Datatables -->
	<script type="text/javascript"
		src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>
	<!-- //Datatables -->
	
	<script type="text/javascript" src="<c:url value="/resources/custom/js/velas_validations.js"/>"></script>
	<!-- /Scripts -->
	
<!-- Paging the table -->
<script type="text/javascript">

$(document).ready(function (){
	   var table = $('#myDatatable').DataTable({
		   "jQueryUI" : true,
			"pagingType" : "full_numbers",
			"lengthMenu" : [ [ 10, 50, -1 ], [ 10, 50, "All" ] ]
	   });

	   // Handle form submission event
	   $('#putInOrder').on('submit', function(e){
	      var form = this;

	      // Encode a set of form elements from all pages as an array of names and values
	      var params = table.$('input').serializeArray();

	      // Iterate over all form elements
	      $.each(params, function(){
	         // If element doesn't exist in DOM
	         if(!$.contains(document, form[this.name])){
	            // Create a hidden element
	            $(form).append(
	               $('<input>')
	                  .attr('type', 'hidden')
	                  .attr('name', this.name)
	                  .val(this.value)
	            );
	         }
	      });
	   });
	});

</script>

<script type="text/javascript"> 
function checkChecked(searchForm) {
	    var anyBoxesChecked = false;
	    $('#' + searchForm + ' input[type="checkbox"]').each(function() {
	        if ($(this).is(":checked")) {
				//alert('Your order will be processed by selected Manager');
	            anyBoxesChecked = true;
	        }
	    });
	 
	    if (anyBoxesChecked == false) {
	      alert('You need to tick atleast one checkbox to place an order\n Please tick the checkbox and try again!');
	      return false;
	    } 
	} 
</script>

<script type="text/javascript">
document.getElementById('checkedOrder').onchange = function() {
	document.getElementsByClass('form-control').disabled = !this.checked;
};
</script>

<script type="text/javascript">
$(function(){

	  $('.form-control').keypress(function(e) {
		if(isNaN(this.value+""+String.fromCharCode(e.charCode))) return false;
	  })
	  .on("quantity",function(e){
		e.preventDefault();
	  });

	});
	
</script>

</body>
</html>
