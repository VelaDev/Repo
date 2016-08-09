<%@include file="templates/taglibs.jsp"%>
<c:import url="templates/navbar.jsp"></c:import>

   <body class=".container-fluid">
<div class="container myrow-container">
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">
                <div align="left"><b>Available Products</b> </div>
            </h3>
        </div>

<div class="panel-body">
            <%-- <c:if test="${empty ticketList}">
                No open tickets
            </c:if>
            <c:if test="${not empty ticketList}">  --%>  
            
               <!--  <form action="searchTechnician">
                    <div class="row">
                      <div class="col-md-6"><div class="col-md-6">Search Technician:</div><div class="col-md-6"> 
                      <input type="text" name="username" id="username" class="form-control"> </div></div>
                      <div class="col-md-4"><input class="btn btn-success" type='submit' value='Search'/></div>
                    </div>
                    <br>
                </form>  -->            
                                
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