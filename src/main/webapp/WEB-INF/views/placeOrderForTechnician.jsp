<%@ include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Order | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!--style-->
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/custom/css/vela_custom.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/fonts/font-awesome.min.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/datepicker.min.css" />">

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/custom/css/vela_details.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/buttons.dataTables.css" />">

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/scroller.dataTables.css" />">


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
							method="post" action="makeOrder" id="putInOrder">


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
												class="glyphicon glyphicon-user"></i></span><select id="Site"
												name="customer" class="form-control selectpicker">
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
											name="technicianUserName" id="technicianUserName"
											class="form-control selectpicker">
											<option value="">Select Technician</option>
											<c:forEach items="${technicianList}" var="technician">
												<option value="${technician.email}">${technician.firstName}
													${technician.lastName}</option>
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
											class="glyphicon glyphicon-user"></i></span><select name="approver"
											id="approver" class="form-control selectpicker">
											<option value="">Select Manager</option>
											<c:forEach items="${managersList}" var="approver">
												<option value="${approver.email}">${approver.firstName}
													${approver.lastName}</option>
											</c:forEach>
										</select>

									</div>
								</div>
							</div>

							<br />
							<div id="makeOrders">

								<div class="groupdetails-row-padding">
									<div id="pagewrap">
										<section id="content" style="width: 63%;margin-left: -1%;">
										<div class="groupclientdetails">
											<h5>Available HO Stock</h5>
											<table id="availableHOstockForOrder" class="display">
												<thead>
													<tr>
														<th>Part No</th>
														<th>Description</th>
														<th>Model No</th>
														<th>Available QTY</th>
														<th>Quantity</th>
														<th>Action</th>
													</tr>
												</thead>
												<tbody>

														<c:forEach var="list" items="${compatibility}">
														<tr>
													
															<td><input type="text"
																class="form-control readonly="
																readonly" value="${list.partNumber}"></td>
															<td>${list.itemDescription}</td>
															<td>${list.compitableDevice}</td>
															<td><input type="text"
																id="${list.partNumber}_avaliableQuantity"
																name="avaliableQuantity" class="form-control"
																readonly="readonly" value="${list.quantity}"></td>
															<td><input type="text"
																id="${list.partNumber}_quantity" name="quantity"
																class="form-control" onkeypress="return isNumber(event)"
																onblur="compareQuantity(this, ${list.quantity})"
																value="" /></td>
															<td><input class="addLineItemToOrder" type="button"
															onclick="saveEneteredQuantity();" value="Add"></td>
																
														</tr>
														</c:forEach>
													

												</tbody>
											</table>

										</div>
										</section>
										<aside id="sidebar" style="width: 37%; margin-left: 1%;">
										<div class="groupproductdetails">
											<h5>Selected Line Items to Order</h5>
											<table id="selectedHOStockToOrder" class="display">
												<thead>
													<tr>
														<th>Part No</th>
														<th>Description</th>
														<th>Model No</th>
														<th>Available QTY</th>
														<th>Quantity</th>
														<th>Action</th>

													</tr>
												</thead>
												<tbody>
												</tbody>
											</table>
										</div>
										<!-- //groupproductdetails --> </aside>
										<!-- //sidebar -->
									</div>
									<!--// pagewrap -->
								</div>
								<!-- //groupdetails-row-padding -->
							  <input type="hidden"id="quantityList" name="quantityList" class="form-control"value="" />
							  <input type="hidden"id="partNumberList" name="partNumberList" class="form-control"value="" />
							  
							  
							</div>
							<!-- //make order -->

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

	<script type="text/javascript"
		src="<c:url value="/resources/datatables/datatables.min.js" />"></script>

	<script type="text/javascript"
		src="<c:url value="/resources/datatables/datatables.min.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/datatables/1.10.13/js/jquery-ui.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/datatables/1.10.13/js/dataTables.buttons.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/datatables/1.10.13/js/dataTables.jqueryui.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/datatables/1.10.13/js/dataTables.select.js" />"></script>
	<!-- //Datatables -->

	<script type="text/javascript"
		src="<c:url value="/resources/custom/js/velas_validations.js"/>"></script>
	<!-- /Scripts -->
	<script type="text/javascript">	
			$(document).ready(function() {
				$('#availableHOstockForOrder').DataTable({
					info: true, 
					searching:true, 
					scrollY: "200px",
					scrollCollapse: true,
					paging:false,
				/* few more options are available to use */
				});
			});
			</script>
	<!--Order Datatables-->
	<script type="text/javascript">
			
	        var partNumberList = [];
	        var quantityList = [];
	        debugger;
			
			function saveEneteredQuantity(){
				
				var quantity;
				var quantityName;				
				var getEnteredQuantity;	
				var enteredQuatity;
				var getIndex;
				var textvalue = "";
				
        		
				quantity = document.getElementsByName("quantity").length;
				quantityName = document.getElementsByName('quantity').value;	
				console.log("Count the lenght of the input textbox on the HO Stock : ",quantity);
				document.getElementsByName("quantityEntered").value = quantityName;
				getEnteredQuantity = quantity;
				for (var i = 0; i < quantity ; i++) {
				  textvalue = textvalue + document.getElementsByName("quantity").item(i).value; 
				}
				$('[name="quantity"]' ).each( function( index ) {
					 getIndex = $( this ).val();
					 enteredQuatity = $( '[name="quantity"]' ).eq( index ).val();					  
				});				
				quantity = textvalue;
				alert("This was provided: ",quantity);
				
				debugger;
				console.log("Check the grapped quantity on table of Selected Line Items to Order : ",quantity);
				if(quantity == '' || quantity== 0){
					alert("Quantity can not 0.\n Please enter quantity which is less than available quantity");	
				}
				console.log("Entered Quantity: ",quantity);
			}
			$(".addLineItemToOrder").on("click", function() {
				
			    debugger;
			    var items = [];
				var data;
				data = items;
				var row = $(this).closest("tr").clone(); 
				
				var partNumber = $(this).closest('tr').find('td:eq(0)').find('input').val();
				var quantity = $(this).closest('tr').find('td:eq(4)').find('input').val();
				
				partNumberList [partNumberList.length] = [partNumber];
				quantityList [quantityList.length]= [quantity];
				
				document.getElementById("quantityList").value = quantityList;
				document.getElementById("partNumberList").value = partNumberList;
			

				
				
				debugger;
				
				items.push(row);
				row.appendTo($("#selectedHOStockToOrder"));
				console.debug("Check itmes: ",items);				
			    data = JSON.parse(JSON.stringify(items.data));
	            console.log("My list: ",items.data());				
				var newSelectedItem = {partNumber:row.data().partNo, nQuantity:row.data().quantityEntered}
				console.log("My list: ",newSelectedItem);
			
				
			});
			          
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
