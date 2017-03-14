<%@ include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Order | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!--style-->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/custom/css/vela_custom.css" />"  />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap-3.3.7/fonts/font-awesome.min.css" />"  />

<link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">
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
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Make Order</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">
						<form:form class="well form-horizontal" modelAttribute="makeOrder"
							method="post" action="makeOrder" id="putInOrder" name="makeOrder" >


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
											<option>Select Stock Type</option>
											<option value="Boot">Boot</option>
											<option value="Site">Site</option>
										</select>
									</div>
								</div>
							</div>

							<div id="Site" style='display: none;'>
								<!-- Text input Location-->
								<div class="form-group">
									<label class="col-md-3 control-label">Location</label>
									<div class="col-md-6 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="	glyphicon glyphicon-map-marker"></i></span> <input
												type="text" class="form-control" id="location" name="Site"
												placeholder="Enter Location" id="Site" />
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
											class="glyphicon glyphicon-user"></i></span> <input id="technician"
											name="technician" placeholder="Technicain"
											class="form-control" type="text"
											value="${loggedInUser.firstName} ${loggedInUser.lastName}">
									</div>
								</div>
							</div>


							<!-- Text input Customer Name-->
							<div class="form-group">
								<label class="col-md-3 control-label">Customer Name</label>
								<div class="col-md-6 inputGroupContainer">
									<div class="input-group">
										<span class="input-group-addon"><i
											class="glyphicon glyphicon-user"></i></span> <select id="customer" name="customer"
											class="form-control selectpicker">
											<option>Customer Name</option>
											<c:forEach items="${customerList}" var="customer">
												<option value="${customer.customerName}">${customer.customerName}</option>
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
											class="glyphicon glyphicon-user"></i></span> <select id="approver" name="approver"
											class="form-control selectpicker">
											<option>Select Approver</option>
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
								<table id="myDatatable" class="display datatable">
									<thead>
										<tr>
											<th>Part No <img
												src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
											<th>Description <img
												src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
											<th>Model No <img
												src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
											<th>Available QTY <img
												src="resources/bootstrap-3.3.6/images/sort_both.png"></th>
											<th>Tick To Order</th>
											<th>Quantity</th>
											<!-- <th>Edit<img
										src="resources/bootstrap-3.3.6/images/sort_both.png"></th> -->
										</tr>
									</thead>
									<tbody>
										<!-- Iterating over the list sent from Controller -->
										<c:forEach var="list" items="${compatibility}">

											<tr>
												<td>${list.partNumber}</td>
												<td>${list.description}</td>
												<td>${list.compitableDevice}</td>
												<td>${list.quantity}</td>
												<td><input type="checkbox" class="form-group"
													id="checkedOrder" name="selectedItem" 
													value="${list.partNumber},${list.compitableDevice},${list.description}"></td>
												<td><input type="text" class="form-group" id="quantity"
													name="quantity"></td>
												<%-- 	<th>
											<a href="detailedProduct?serialNumber=<c:out value='${list.partNumber}'/>">details</a></th>
											--%>

											</tr>

										</c:forEach>
									</tbody>
								</table>

							</div>

							<div class="form-group row">
								<div class="col-sm-offset-2 col-sm-8">
									<br> <br> <input type="submit" value="Make Order"
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
	<script type="text/javascript" src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
	<!-- Datatables -->
	<script type="text/javascript" src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>	
	<!-- /Scripts -->
	
	<!-- Paging the table -->
	<script>
		$(document).ready(function() {
			$('#myDatatable').DataTable({
				"jQueryUI" : true,
				"pagingType" : "full_numbers",
				"lengthMenu" : [ [ 5, 10, 50, -1 ], [ 5, 10, 50, "All" ] ]
			/* few more options are available to use */
			});
		});
	</script>
		
<!-- Validate Make Order -->
<script>
 $(document).ready(function() {
    $('#putInOrder').bootstrapValidator({
         feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	stockType: {
                validators: {
					notEmpty: {
                        message: 'Stoke type is required and cannot be empty'
                    }
                }
            },
            location: {
                validators: {
					stringLength : {
						min : 2,
					},
                    notEmpty: {
                        message: 'location is required and cannot be empty'
                    }
                }
            },
            technician: {
                validators: {
                    notEmpty: {
                        message: 'Technician is required and cannot be empty'
                    }
                }
            },
            customer: {
                validators: {
                    notEmpty: {
                        message: 'customer is required and cannot be empty'
                    }
                }
            },
            approver: {
                validators: {
                    notEmpty: {
                        message: 'Approver is required and cannot be empty'
                    }
                }
            }
            
            
        }
    });
});

</script>
	

<script>
$('#putorder').click(function () {
    if (!$('#checkedOrder').is(':checked')) {
        alert('You need to tick checkbox to make an order\n Please tick the box and try again');
        return false;
    }
});

</script>

	<!--Stock type Selection-->
	<script type="text/javascript">
	
		function CheckStockType(val){
		 var element=document.getElementById('Site');
		 if(val=='select stock type'||val=='Site')
		   element.style.display='block';
		 else  
		   element.style.display='none';
		   
		  var element=document.getElementById('Boot');
		 if(val=='select stock type'||val=='Boot')
		   element.style.display='block';
		 else  
		   element.style.display='none';
		   
		}
	
	</script>

	


</body>
</html>
