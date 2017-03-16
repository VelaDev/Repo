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



.form-group-model {
	margin-left: 10%;
}
.groupsparedetails, .groupsearchdetails{
	padding:20px;
}
.groupsparedetails {
	float:left;
	width:50%;
}
.groupsearchdetails {
	overflow:hidden;
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

							<!-- group spare details -->
								<div class="groupsparedetails">
								<legend>Spares</legend>
								
								<div class="row">
									<div class="col-xs-12">
										<div class="col-xs-4 form-control-label">
											<h6>
												<label>Maintain New Spares</label>
											</h6>

										</div>
										<div class="col-xs-8">
											<div class="form-group">
												<div class="input-group">
													<input type="checkbox" class="form-control" readonly="readonly" class="checkSpares" id="checkSpares" name="checkSparess">
												</div>
											</div>
										</div>
									</div>
								</div>
								
								
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
														class="form-control" readonly="readonly" value="${sparePart.partNumber}"
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
														class="form-control" readonly="readonly" value="${sparePart.itemType}">
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
														class="form-control" readonly="readonly" value="${sparePart.description}">
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
	
						<!-- group search details -->
						<div class="groupsearchdetails">
								<legend>Compatible Devices </legend>
								<input type="button" value="Add Row" onclick="addRow('compitableDevice')" />
								<input type="button" value="Delete Row" onclick="deleteRow('compitableDevice')" /><br/><br/>
								<label class="col-md-3 control-label">Action</label>
								<label class="col-md-3 control-label">Model Number</label>
								
								<table id="compitableDevice" class="table table-striped table-bordered table-hover table-condensed">	
									<c:forEach var="compitableDevice" items="${models}">
										<tr>
											<td><input type="checkbox" name="compitableDevice" value=""/></td>
											<td><input type="text" class="form-control" disabled="disabled" name="compitableDevice" value="${compitableDevice}"></td>			
										</tr>				
									</c:forEach>
								</table>								
						</div><!-- //group search details -->	
	
						<div class="form-group row">
							<div class="col-sm-offset-2 col-sm-8">
								<br> <br> <input type="submit" value="Add Spare" class="btn btn-primary btn-block btn-lg" tabindex="9" id="addSpare">
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

<!-- Table for compitable device for partnumber -->
<script language="javascript">

		//add row on table
		function addRow(tableID) {
			
			var table = document.getElementById(tableID);
			var rowCount = table.rows.length;
			var row = table.insertRow(rowCount);
			var colCount = table.rows[0].cells.length;

			for(var i=0; i<colCount; i++) {

				var newcell	= row.insertCell(i);

				newcell.innerHTML = table.rows[0].cells[i].innerHTML;
				alert(newcell.childNodes);
				switch(newcell.childNodes[0].type) {
					case "text":
							newcell.childNodes[0].value = "";
							break;
					case "checkbox":
							newcell.childNodes[0].checked = false;
							break;
					case "select-one":
							newcell.childNodes[0].selectedIndex = 0;
							break;
				}
			}
		}
		//delete row
		function deleteRow(tableID) {
			try {
			var table = document.getElementById(tableID);
			var rowCount = table.rows.length;

			for(var i=0; i<rowCount; i++) {
				var row = table.rows[i];
				var chkbox = row.cells[0].childNodes[0];
				if(null != chkbox && true == chkbox.checked) {
					if(rowCount <= 1) {
						alert("You can not delete all tabele rows.");
						break;
					}
					table.deleteRow(i);
					rowCount--;
					i--;
				}

			}
			}catch(e) {
				alert(e);
			}
		}
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
