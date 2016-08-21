<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
</head>
<style type="text/css">
        .myrow-container {
            margin: 20px;
           
        }
    </style>

   <c:import url="templates/navbar.jsp"></c:import>
   <body class=".container-fluid">
<div class="container myrow-container" style="width:90%">
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">
                <div align="left"><b>Pending Orders</b> </div>
            </h3>
        </div>

<div class="panel-body">
                 <div class="row">   
                 <div class="content">                     
                <table class="table table-hover ">
                    <thead style="background-color: #bce8f1;">
                    <tr class='clickable-row'>
                        <th>Order No</th>
                        <th>Description</th>
                        <th>Product Type</th>
                         <th>Quantity</th>
                        <th>Ordered By</th>
                        <th>Approve</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${orderList}" var="order">
                        <tr>
                            <th><c:out value="${order.orderNum}"/></th>
                            <th><c:out value="${order.description}"/></th>
                             <%-- <th><c:out value="${ticket.getDateTime()}"/></th> --%>
                            <th><c:out value="${order.part.modelNumber}"/></th>
                            <th><c:out value="${order.quantity}"/></th> 
                            <th><c:out value="${order.employee.firstName}"/></th> 
                            <th><a href="approveOrder?id=<c:out value='${order.orderNum}'/>">approve</a></th>
                                                     
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                </div>
                </div>
            <%-- </c:if> --%>
        </div>
        </div>
        </div>
</body>
<!-- <script type="text/javascript">
$(document).ready(function(){
	$('.table > tbody > tr').click(function() {
		 window.location="orderUpdate.html";
		
	});
});	

</script> -->
<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.6/js/jquery-2.1.4.min.js" />" ></script>
<script type="text/javascript"src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script> 
<link href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
</html>