<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <title>Approved Orders | Velaphanda Trading & Projects</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1"> 
  <link
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
</head>
<body>
	<div class="velaphanda_containter">	
		<c:import url="templates/techniciannavbar.jsp"></c:import>
		<div class="container">
		<br/>
			<div class="panel panel-success">    
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
						<b>Approved Orders</b>
					</div>
					</h3>
				</div>
				<div class="panel-body">
					
					<div class="tab-content">
					
							<div class="row">
								<div class="content">
									<table class="table table-hover ">
										<thead style="background-color: #bce8f1;">
											<tr class='clickable-row'>
												<th>Order No</th>
												<th>Order Type</th>
												<th>Quantity</th>
												<th>Approved By</th>
												<th>Approved Date</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${ApprovedOrderList}" var="order">
									<tr>
										<th><c:out value="${order.orderNum}"/></th>
										<th><c:out value="${order.part.itemType}"/></th>
										<th><c:out value="${order.quantity}"/></th> 
										<th><c:out value="${order.approdedBy}"/></th> 
										<th><c:out value="${order.dateApproved}"/></th>
																 
									</tr>
								</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						
					</div><!-- /tab-content -->
									
				</div><!-- /panel body -->
			</div><!--/panel success class-->
		</div><!-- /Container -->
		<!-- Footer -->
		<c:import url="templates/footer.jsp"></c:import>
		<!--/ Footer -->
	</div><!-- / velaphanda_containter -->
	
	

<script type="text/javascript"
	src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js" />"></script>	
</body>
</html>
