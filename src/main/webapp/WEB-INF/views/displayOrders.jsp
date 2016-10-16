<%@ include file="templates/taglibs.jsp"%>
<html>
<head>
<style type="text/css">
.myrow-container {
	margin: 20px;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Approved Orders</title>
</head>
<c:import url="templates/navbar.jsp"></c:import>
<body class=".container-fluid">
	<div class="container" style="width: 90%">
		<div class="panel panel-success">
			<div class="panel-heading">
				<h3 class="panel-title">
					<div align="center">
						<b>Orders</b>
					</div>
				</h3>
			</div>

			<div class="panel-body">
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
								<%-- <c:forEach items="${orderList}" var="order">
                        <tr>
                            <th><c:out value="${order.orderNum}"/></th>
                            <th><c:out value="${order.description}"/></th>
                            <th><c:out value="${order.part.modelNumber}"/></th>
                            <th><c:out value="${order.quantity}"/></th> 
                            <th><c:out value="${order.employee.firstName}"/></th> 
                            <th><a href="approveOrder?id=<c:out value='${order.orderNum}'/>">approve</a></th>
                                                     
                        </tr>
                    </c:forEach> --%>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

	</div>

</body>

<%-- <script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.6/js/jquery-2.1.4.min.js" />" ></script>
<script type="text/javascript"src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script> 
<link href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" /> --%>

<script type="text/javascript"
	src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js" />"></script>
<link
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />

</html>