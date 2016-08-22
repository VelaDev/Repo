<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
 <c:import url="templates/techniciannavbar.jsp"></c:import>
<body>
  
   <body class=".container-fluid">
<div class="container myrow-container" style="width:90%">
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">
                <div align="left"><b>Open tickets</b> </div>
                <!-- <div align="right"><a href="">Think of something</a></div> -->
            </h3>
        </div>
   <div class="panel-body">
            <%-- <c:if test="${empty ticketList}">
                No open tickets
            </c:if>
            <c:if test="${not empty ticketList}">  --%>   
            <form action="">                              
                <table class="table table-hover">
                    <thead style="background-color: #bce8f1;">
                    <tr>
                        <th>Ticket Number</th>
                        <th>Client Name</th>
                        <th>Telephone No</th>
                        <th>Ticket Details</th>
                        
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${technicianTickets}" var="ticket">
                        <tr>
                            <th><c:out value="${ticket.ticketNumber}"/></th>
                            <th><c:out value="${ticket.product.client.clientName}"/></th> 
                            <th><c:out value="${ticket.product.client.getTellphoneNumber()} "/></th>  
                            <th><a href="ticketDetails?id=<c:out value='${ticket.ticketNumber}'/>">Ticket Details</a></th>                 
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                </form> 
            <%-- </c:if> --%>
        </div>
        </div>
        </div>
   
</body>
<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.6/js/jquery-2.1.4.min.js" />" ></script>
<script type="text/javascript"src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script> 
<script type="text/javascript">
/* $(document).ready(function(){
	$('.table > tbody > tr').click(function() {
		 window.location="ticketDetails.html?id";
		
	});
});	 */

</script>
<link href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
	
</html>