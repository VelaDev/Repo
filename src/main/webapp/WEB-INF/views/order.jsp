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
		<c:import url="templates/techniciannavbar.jsp"></c:import>
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

							<!-- Text input Technician name-->
							<div class="form-group">
								<label class="col-md-3 control-label">Technician</label>
								<div class="col-md-6 inputGroupContainer">
									<div class="input-group">
										<span class="input-group-addon"><i
											class="glyphicon glyphicon-user"></i></span> <input readOnly
											id="technician" name="technician" placeholder="Technicain"
											class="form-control" type="text"
											value="${loggedInUser.firstName} ${loggedInUser.lastName}">
									</div>
								</div>
							</div>


							<!-- Text input Approver-->
							<div class="form-group">
								<label class="col-md-3 control-label">Approver</label>
								<div class="col-md-6 inputGroupContainer">
									<div class="input-group">
										<span class="input-group-addon"><i
											class="glyphicon glyphicon-user"></i></span> <select id="approver"
											name="approver" class="form-control selectpicker">
											<option value="">Select Approver</option>
											<c:forEach items="${managersList}" var="manager">
												<option value="${manager.email}">${manager.firstName}
													${manager.lastName}</option>
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
											<h5><b>Available HO Stock</b></h5>
											<table class="display" id="availableHOstockForOrder"
												cellspacing="0">
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
										</section>
																<aside id="sidebar" style="width:37%;margin-left: 1%;">
										<div class="groupproductdetails">
											<h5><b>Selected HO Stock To Order</b></h5>
											<table class="display" id="selectedHOStockToOrder">
												<thead>
													<tr>
														<th>Part No</th>														
														<th>Provided Qty</th>
														<th>Selected Item</th>
														<th>Action</th>
													</tr>
												</thead>
												<tbody></tbody>
											</table>
										</div>
										<!-- //groupproductdetails --> </aside>
										<!-- //sidebar -->
									</div>
									<!--// pagewrap -->
								</div>
								<!-- //groupdetails-row-padding -->

							</div><!-- //make order -->

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

	<script type="text/javascript"
		src="<c:url value="/resources/custom/js/velas_validations.js"/>"></script>
	<!-- /Scripts -->

	<!--Order Datatables-->
        <script type="text/javascript">

            // startup and initialize empty tables for appearance
            $(function ($) {
				createDataTableForAvailableHOstock("#availableHOstockForOrder", null);
                createDataTableSelectedHOStock('#selectedHOStockToOrder', null);                
                // set up event handlers for both directrions
                $('#selectedHOStockToOrder').on("click", "tbody button", function (evt) { moveRow(evt, '#selectedHOStockToOrder', '#availableHOstockForOrder'); })
                $('#availableHOstockForOrder').on("click", "tbody button", function (evt) { moveRow(evt, '#availableHOstockForOrder', '#selectedHOStockToOrder'); })
               
            })//end startup and initialize empty tables for appearance
            
            // create data table for createDataTableForAvailableHOstock.
            function createDataTableForAvailableHOstock(target, data) {

                $(target).DataTable({
                	info: true, 
					searching:true, 
					scrollY: "200px",
					scrollCollapse: true,
					paging:false, 
					data: list,
                    columnDefs: [{
                        targets: [-1], render: function () {
                            return "<button type='button' onclick='saveEneteredQuantity();'>" + (target == '#selectedHOStockToOrder' ? 'Remove' : 'Add') + "</button>"
                        }
                    }],
                     columns: [{
                        data: "part no"
                    }, {
                        data: "description"
                    }, {
                        data: "model no"
                    }, {
                        data: "avalaible qty"
                    }, {
                        data: "quantityEntered"
                    },
                    { data: null }],


                });
            }//end create data table for createDataTableForAvailableHOstock.
            
			 // create data table for createDataTableSelectedHOStock.
            function createDataTableSelectedHOStock(target, data) {

                $(target).DataTable({
                	info: true, 
					searching:true, 
					scrollY: "200px",
					scrollCollapse: true,
					paging:false, 					
                    columnDefs: [{
                        targets: [-1], render: function () {
                            return "<button type='button'>" + (target == '#selectedHOStockToOrder' ? 'Remove' : 'Add') + "</button>"
                        }
                    }],
                     columns: [{
                        data: "part no"
                    },                    
                    {
                        data: "quantity"
                    },
                    {
                        data: "selectedItem"
                    },
                    
                    { data: null }],

                });
            } // end create data table for createDataTableSelectedHOStock.
			
			
            //Check saveEneteredQuantity
			function saveEneteredQuantity(){

				/* var getEnteredQuantity;
			    var quantity;			    
        		quantity = document.getElementsByName('quantity')[0].value;
				document.getElementsByName('quantityEntered')[0].value = "C Quantity: " + quantity;
				getEnteredQuantity = quantity;
				console.log("Entered Quantity: ",getEnteredQuantity); */
				
				var quantity;				
				var getEnteredQuantity;
				
				quantity = document.getElementsByName('quantity')[0].value;				
				document.getElementsByName('quantityEntered')[0].value = quantity;
				if(quantity == ''){
					alert("Quantity can not be empty.\n Please enter quantity which is less than available quantity");
					console.log("Q",element.value);
				}
				getEnteredQuantity = quantity;
				console.log("Entered Quantity: ",getEnteredQuantity);				 
				
			}// end Check saveEneteredQuantity
			
			
			
            // function to move rows
            function moveRow(evt, fromTable, toTable) {
                var table1 = $(fromTable).DataTable();
                var table2 = $(toTable).DataTable();
                var tr = $(evt.target).closest("tr");				
                var row = table1.row(tr);
                var data = JSON.parse(JSON.stringify(row.data()));               
                table2.row.add(data).draw();
                row.remove().draw();				
            }//end startup and initialize empty tables for appearance
            
           // this is JavaScript code written in the JSP to access the compatibility HO stock
            var list = [ 
			               	<c:forEach var="list" items="${compatibility}" >
			                  	{
								  	"part no": '${list.partNumber}',
									"description": '${list.itemDescription}',
									"model no": '${list.compitableDevice}',
									"avalaible qty": '<input type="text" id="${list.partNumber}_avaliableQuantity" name="avaliableQuantity" class="form-control" readonly="readonly" value="${list.quantity}">',
									"quantityEntered": '<input type="text" id="${list.partNumber}_quantityEntered" name="quantityEntered" class="form-control" onkeypress="return isNumber(event)" onblur="compareQuantity(this, ${list.quantity})" required="required" value=""  />',
									"quantity": '<input type="text" id="${list.partNumber}_quantity" name="quantity" class="form-control" onkeypress="return isNumber(event)"  readonly=readonly value="" />',
						      		"selectedItem": '<input type="checkbox" id="checkedOrder" name="selectedItem"  value="${list.partNumber},${list.compitableDevice},${list.itemDescription}" checked/>'
						               
			                  	},
						   </c:forEach>
						]
            
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
