<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Add Spares | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
<link
	href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />"
	rel="stylesheet" type="text/css" />

<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">

<style>
select[multiple], select[size] {
	width: 120%;
	height: 100%;
}

.col-sm-6 {
	width: 50%;
}

.buttonAddSpare {
	padding-left: 10%;
	margin-right: -12%;
}

.form-group-model {
	margin-left: 10%;
}

.buttonsCompitableDevice {
	margin-left: -11%;
}

.groupsparedetails {
	float: left;
	padding-left: 10%;
	margin-top: -12%;
}

.groupsearchdetails {
	float: right;
	margin-right: -9%;
}

.content {
	margin-left: -61%;
	width: 180%;
}
.spareDevice {
	margin-left:42%;
	margin-right:32;
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

			<%-- <c:if test="${empty models}">
				<c:out value="${models}"></c:out>
			</c:if> --%>

			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Receive Spares</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<p id="getme"></p>
					<div class="tab-content">

						<form:form action="searchpartNumber" method="post"
							id="searchpartNumber">
							<div class="row">
								<!-- Text input Search-->
								<div class="form-group">
									<label class="col-md-3 control-label">Part Number </label>
									<div class="col-md-4 inputGroupContainer">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="glyphicon glyphicon-hdd"></i></span> <input
												name="partNumber" list="spareParts"
												onkeydown="upperCaseF(this)" id="partNumber"
												class="form-control" type="text"
												placeholder='Search By Part Number'>
										</div>
									</div>
									<!-- Iterating over the list sent from Controller -->
									<datalist id="spareParts"> <c:forEach var="list"
										items="${spareParts}">
										<option value="${list}">
									</c:forEach> </datalist>

									<div class="col-md-2">
										<input class="btn btn-success" type='submit' value='Search' />
									</div>
								</div>
							</div>
							<hr>
						</form:form>
						<!--Search-->



						<form:form action="saveSpareParts" modelAttribute="saveSpareParts"
							method="post" id="saveSpareParts">

							<div class="col-xs-10">
								<div class="groupdetails-row-padding">

									<div class="content"></div>

									<!-- group search details -->
									<div class="groupsearchdetails">
										<legend>Compatible Devices </legend>
										<div class="buttonsCompitableDevice">
											<div class='spareDevice'>
												<a href="javascript:void(0);" id='anc_add' class="info-button">Add</a> 
												<a href="javascript:void(0);" id='anc_rem' class="info-button-danger">Remove</a>
												<div style="clear: both; margin: 10px 0;"></div>

												<table id="tbl1"
													class="table table-striped table-bordered table-hover table-condensed">
													<thead>
														<tr>
															<th><span id="spn_col_1">Model Number</span></th>
															<th><span id="spn_col_2">Action</span></th>
														</tr>
													</thead>
													<tbody>
													
													<c:forEach var="compitableDevice" items="${models}">
														<tr> 
														    <td class="col_1"><input type="text" name="compitableDevice"
																value="${compitableDevice}"></td>
															<td class="col_2"><input type="checkbox"
																name="compitableDevice" value=""></td>
													 		
														</tr>
													</c:forEach>
													
													</tbody>
												</table>
											</div>
										</div>
									</div>
									<!-- //group search details -->
								</div>
							</div>

							<div class="groupsparedetails">
								<legend>Spares</legend>

								<div class="row">
									<div class="col-xs-12">
										<div class="col-xs-4 form-control-label">
											<h6>
												<label>Part Number</label>
											</h6>

										</div>
										<div class="col-xs-8">
											<div class="form-group">
												<div class="input-group">
													<input type="text" id="partNumber" name="partNumber"
														class="form-control" value="${sparePart.partNumber}"
														class="partNo">
												</div>
											</div>
										</div>
									</div>
								</div>

								<div class="row">
									<div class="col-xs-12">
										<div class="col-xs-4 form-control-label">
											<h6>
												<label>Item Type</label>
											</h6>

										</div>
										<div class="col-xs-8">

											<div class="form-group">
												<div class="input-group">
													<input type="text" id="itemType" name="itemType"
														class="form-control" value="${sparePart.itemType}">
												</div>
											</div>
										</div>
									</div>
								</div>

								<div class="row">
									<div class="col-xs-12">
										<div class="col-xs-4 form-control-label">
											<h6>
												<label>Description</label>
											</h6>

										</div>
										<div class="col-xs-8">
											<div class="form-group">
												<div class="input-group">
													<input type="text" id="description" name="description"
														class="form-control" value="${sparePart.description}">
												</div>
											</div>
										</div>
									</div>
								</div>

								<div class="row">
									<div class="col-xs-12">
										<div class="col-xs-4 form-control-label">
											<h6>
												<label>Quantity</label>
											</h6>

										</div>
										<div class="col-xs-8">
											<div class="form-group">
												<div class="input-group">
													<input type="text" id="quantity" name="quantity"
														class="form-control" onkeypress="return isNumber(event)">
												</div>
											</div>
										</div>
									</div>
								</div>

								<div class="row">
									<div class="col-xs-12">
										<div class="col-xs-4 form-control-label">
											<h6>
												<label>Received By</label>
											</h6>

										</div>
										<div class="col-xs-8">
											<div class="form-group">
												<div class="input-group">
													<input type="text" id="receivedBy" name="receivedBy"
														class="form-control"
														value="${loggedInUser.firstName} ${loggedInUser.lastName}"
														readonly="readonly">
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- //group spare details -->


							<div class="form-group row">
								<div class="col-sm-offset-2 col-sm-8">
									<br> <br> <input type="submit" value="Add Spare"
										class="btn btn-primary btn-block btn-lg" tabindex="9"
										id="addSpare">
								</div>
							</div>

						</form:form>
						<p id="getme"></p>
					</div>

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
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
	<!-- /Scripts -->

<!-- Table for spares -->
<script>
	$(document)
			.ready(
					function() {
						var cnt = 2;
						//var input = $("input[name='modelNumber']").val();
						//input = ${list1}
						$("#anc_add")
								.click(
										function() {
											$('#tbl1 tr')
													.last()
													.after(
															'<tr><td class="col_1"><input type="text" name="compitableDevice'  + $(this).val() +  '" value="'  +  $(this).val() + '"></td><td class="col_2"><input type="checkbox" name="txtbx2' + $(this).val() +  '" value="' + $(this).val()  + '"></td></tr>'
															
														);
											cnt++;
										});

						$("#anc_rem").click(function() {
							$('#tbl1 tr:last-child').remove();
							cnt--;
						});

						$('#chk_col_1').click(
								function() {
									if ($('#chk_col_1').is(':checked')) {
										$("#tbl1 .col_1 input").attr(
												'disabled', 'disabled');
										$('#spn_col_1').text('Enable Col');
									} else {
										$("#tbl1 .col_1 input").removeAttr(
												'disabled');
										$('#spn_col_1').text('Disable Col');
									}
								});

						$('#chk_col_2').click(
								function() {

									if ($('#chk_col_2').is(':checked')) {
										$("#tbl1 .col_2 input").attr(
												'disabled', 'disabled');
										$('#spn_col_2').text('Enable Col');
									} else {
										$("#tbl1 .col_2 input").removeAttr(
												'disabled');
										$('#spn_col_2').text('Disable Col');
									}
								});

						$('#chk_col_3').click(
								function() {
									if ($('#chk_col_3').is(':checked')) {
										$("#tbl1 .col_3 input").attr(
												'disabled', 'disabled');
										$('#spn_col_3').text('Enable Col');
									} else {
										$("#tbl1 .col_3 input").removeAttr(
												'disabled');
										$('#spn_col_3').text('Disable Col');
									}
								});

					});
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
request.open('GET', 'https://s3-us-west-2.amazonaws.com/s.cdpn.io/4621/html-elements.json', true);
request.send();

<script type="text/javascript">
function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}
</script>

	<!-- Make all Serials numbers UpperCase  -->
	<script type="text/javascript">
	function upperCaseF(a){
	    setTimeout(function(){
	        a.value = a.value.toUpperCase();
	    }, 1);
	}
</script>


	<script>
		$(document)
				.ready(
						function() {
							$('#searchpartNumber')
									.bootstrapValidator(
											{
												feedbackIcons : {
													valid : 'glyphicon glyphicon-ok',
													invalid : 'glyphicon glyphicon-remove',
													validating : 'glyphicon glyphicon-refresh'
												},
												fields : {
													partNumber : {
														validators : {
															stringLength : {
																min : 3,
															},
															notEmpty : {
																message : 'Part number is required to search and cannot be empty'
															}
														}
													},
												}
											});
						});
	</script>

	<!-- Validate add part -->
	<script>
		$(document)
				.ready(
						function() {
							$('#saveSpareParts')
									.bootstrapValidator(
											{
												feedbackIcons : {
													valid : 'glyphicon glyphicon-ok',
													invalid : 'glyphicon glyphicon-remove',
													validating : 'glyphicon glyphicon-refresh'
												},
												fields : {
													partNumber : {
														validators : {
															notEmpty : {
																message : 'Part number is required and cannot be empty'
															}
														}
													},
													itemType : {
														validators : {
															notEmpty : {
																message : 'Item type is required and cannot be empty'
															}
														}
													},
													quantity : {
														validators : {
															notEmpty : {
																message : 'Quantity is required and cannot be empty'
															}
														}
													},
													description : {
														validators : {
															notEmpty : {
																message : 'Description is required and cannot be empty'
															}
														}
													},
												}
											});
						});
	</script>

</body>

</html>
