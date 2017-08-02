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
							method="post" action="makeOrder" id="putInOrder"
							onsubmit="return checkChecked('putInOrder');">


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
										<section id="content" style="width: 61%;">
										<div class="groupclientdetails">
											<table width="100%" class="display"
												id="availableHOstockForOrder" cellspacing="0">
												<thead>
													<tr>
														<th>Part No</th>
														<th>Description</th>
														<th>Model No</th>
														<th>Available QTY</th>
														<th>Quantity</th>
														<th>Add</th>
													</tr>
												</thead>
												<tbody>
													
												</tbody>
											</table>
										</div>
										</section>
										<aside id="sidebar" style="width:35%;margin-left: 3%;">
										<div class="groupproductdetails">
											<table width="100%" class="display"
												id="selectedHOStockToOrder">
												<thead>
													<tr>
														<th>Part No</th>
														<th>Quantity</th>
														<th>Remove</th>
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
	<%--  <script type="text/javascript" src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>
	 --%>
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
           
            $(function ($) {

                var tb = $("#availableHOstockForOrder").DataTable({
                    info: true, 
                    searching:true, 
                    paging: true,
                    columnDefs: [{
                        targets: [-1],
                        render: function () {
                            return "<button type='button'>Add</button>"
                        }
                    }],
                    data: list,
                    columns: [{
                        data: "part no"
                    }, {
                        data: "description"
                    }, {
                        data: "model no"
                    }, {
                        data: "avalaible qty"
                    }, {
                        data: "quantity"
                    },
                    { data: null }],

                    initComplete: function () {
                        $("#availableHOstockForOrder button").on("click", function (evt) {

                            var t1 = $("#availableHOstockForOrder").DataTable();
                            var t2 = $("#selectedHOStockToOrder").DataTable();
                            var tr = $(this).closest("tr");
                            var row = t1.row(tr);
                            var data = JSON.parse(JSON.stringify(row.data()));
                            row.remove().draw();
                            t2.row.add(data).draw();
                        });
                       
                    }
                }) // end table for availableHOstockForOrder
                
                $("#selectedHOStockToOrder").DataTable({ 
                info: true, 
                searching:true, 
                paging: true,
                columns: [{ data: "part no" }, { data: "quantity" },{ data: "null" }],
                columnDefs: [{
                        targets: [-1],
                        render: function () {
                            return "<button type='button'>Remove</button>"
                        }
                }],
              
                initComplete: function () {
                        
                        $("#selectedHOStockToOrder button").on("click", function (evt) {
                            var t1 = $("#selectedHOStockToOrder").DataTable();
                            var t2 = $("#availableHOstockForOrder").DataTable();
                            var tr = $(this).closest("tr");
                            var row = t1.row(tr);
                            var data = JSON.parse(JSON.stringify(row.data()));
                            row.remove().draw();
                            t2.row.add(data).draw();
                        });
                  }
                
                              
                }); //end selectedHOStockToOrder

            }) // end ready document
            
           // this is JavaScript code written in the JSP to access the compatibility HO stock
            var list = [ 
                         <c:forEach var="list" items="${compatibility}" >
				            {
				             	"part no": '${list.partNumber}',
					  			"description": '${list.itemDescription}',
					  			"model no": '${list.compitableDevice}',
					  			"avalaible qty": '<input type="text" id="${list.partNumber}_avaliableQuantity" name="avaliableQuantity" class="form-control" readonly="readonly" value="${list.quantity}">',
					  			"quantity": '<input type="text" id="${list.partNumber}_quantity" name="quantity" class="form-control" onblur="compareQuantity(this, ${list.quantity})" value="" />',
				              
				            },</c:forEach>
				       ]
            
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
