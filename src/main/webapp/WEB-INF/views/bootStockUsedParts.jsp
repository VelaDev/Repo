<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Boot Stock Used Parts</title>

<link type="text/css" rel="stylesheet" href="<c:url value="/resources/custom/css/vela_custom.css" />">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/custom/css/vela_custom_ticktes.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />" />

<link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">


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
				<div class="alert alert-danger" role="alert">
					<c:out value="${ retErrorMessage}">
					</c:out>

				</div>
			</c:if>
			<div class="panel panel-success">
				<div class="panel-heading">
					<div align="center">
						<b>Boot Stock Used Parts</b>
					</div>
				</div>
				<div class="panel-body">

					<form:form action="bootStockUsedPartsNumbers" method="post"
						modelAttribute="bootStockUsedPartsNumbers">


						<table id="bStock" class="display datatable">
							<thead>
								<tr>
									<th>Part No</th>
									<th>Description</th>
									<!-- <th>Model No</th> -->
									<th>Quantity</th>
									<th>Tick</th>

								</tr>
							</thead>
							<tbody>
								<!-- Iterating over the list sent from Controller -->
								<c:forEach var="list" items="${bootStock}">

									<tr>
										<c:choose>
											<c:when test="${list.itemType == 'part'}">
												<td>${list.partNumber}</td>
												<td>${list.itemDescription}</td>
												<td>${list.quantity}</td>
												<td><input type="checkbox"
													id="${list.partNumber}_selectedItem" name="selectedItem"
													class="form-group" onClick="checkUsedPartNumbers();"
													value="${list.partNumber}"></td>
											</c:when>
											<c:otherwise>
												<td>${list.partNumber}</td>
												<td>${list.itemDescription}</td>
												<td>${list.quantity}</td>
												<td><input type="checkbox"
													id="${list.partNumber}_selectedItem" name="selectedItem"
													class="form-group" onClick="checkUsedPartNumbers();"
													value="${list.partNumber}"></td>
											</c:otherwise>
										</c:choose>
									</tr>

								</c:forEach>
							</tbody>
						</table>
						<!-- display ticked Used Part Numbers-->
						<div class="shitRight">
							<div class="form-group">
								<label class="col-md-5 control-label">Used Part Numbers</label>
								<div class="col-md-8 inputGroupContainer">
									<div class="input-group">
										<span class="input-group-addon"><i
											class="glyphicon glyphicon-barcode"></i></span>
										<textarea id="tickedUsedPartNumbers" class="form-control"
											readonly="readonly"
											style="width: 200px; height: 90px; font-size: 11px;" rows="3"
											name="usedPartNumbers"></textarea>
									</div>
								</div>
							</div>
						</div>
						<!--// display ticked Used Part Numbers-->
					
					<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-8">
						<br/><br/>
							<input type="submit" value="Submit"
								class="btn btn-primary btn-block btn-lg" tabindex="9"
								id="sub">
						</div>
					</div>

		</form:form>

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


	<script type="text/javascript"
		src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>

	<script>
	$(document).ready(function() {
		$('#bStock').DataTable({
			"jQueryUI" : true,
			"pagingType" : "full_numbers",
			"lengthMenu" : [ [ 5, 10, 50, -1 ], [ 5, 10, 50, "All" ] ]
		/* few more options are available to use */
		});
	});
</script>

	<script>
		function checkUsedPartNumbers(){
  
			  var checkboxes = document.getElementsByName('selectedItem');
			  var checkboxesChecked = [];
			  // loop over them all
			  for (var i=0; i<checkboxes.length; i++) {
				 // And stick the checked ones onto an array...
				 if (checkboxes[i].checked) {
					checkboxesChecked.push(checkboxes[i].value);
				 }
			  }
			  document.getElementById("tickedUsedPartNumbers").value = checkboxesChecked;

			}
</script>

</body>
</html>