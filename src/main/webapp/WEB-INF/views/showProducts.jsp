<%@include file="templates/taglibs.jsp"%>
<c:import url="templates/navbar.jsp"></c:import>

   <body class=".container-fluid">
<div class="container myrow-container" style="width:90%">
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">
                <div align="left"><b>Available Products</b> </div>
            </h3>
        </div>

<div class="panel-body">           
                                
                <table class="table table-hover">
                    <thead style="background-color: #bce8f1;">
                    <tr>
                        <th>Serial Number</th>
                        <th>Product Name</th> 
                        <th>Product Model</th>
                        <th>Description</th>
                        <th>Arrived Date</th> 
                        
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${productList}" var="product">
                        <tr>
                            <th><c:out value="${product.serialNumber}"/></th>
                            <th><c:out value="${product.productName}"/></th> 
                            <th><c:out value="${product.productModel}"/></th>
                            <th><c:out value="${product.prductDescription}"/></th> 
                            <th><c:out value="${product.arrivedDate}"/></th>
                                                     
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            <%-- </c:if> --%>
        </div>
        </div>
        </div>
</body>
</body>

<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.6/js/jquery-2.1.4.min.js" />" ></script>
<script type="text/javascript"src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script> 
<link href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
</html>