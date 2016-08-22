<%@include file="templates/taglibs.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
<style>
.groupclientdetails{
	float	: left;	
}
.groupproductdetails{
	float	: right;
	margin-right: +10%;
}
.content{
	margin-left: -61%;
    width: 180%;
}

</style>
</head>
<c:import url="templates/navbar.jsp"></c:import>

<script type="text/javascript">

</script>
<html>
<body class=".container-fluid">

<div class="container myrow-container" style="width:90%">
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">
                <div align="left"><b>Machine Details</b> </div>
                <!-- <div align="right"><a href="">Think of something</a></div> -->
            </h3>
        </div>
        <div class="panel-body">
        <div class="col-lg-10">
          <form action="searchClient" method="post">
                    <div class="row">
                      <div class="col-xs-11">
                         <div class="col-xs-4 form-control-label" for="inputEmail3">Search Customer</div>
                          <div class="col-xs-5"> 
                            <input type="text" name=clientName id="clientName" class="form-control"> 
                          </div>
                           <div class="col-xs-2"><input class="btn btn-success" type='submit' value='Search'/></div>
                       </div>
                    </div>
                    <br>
                </form>
                </div>
                
                
                <div class="col-lg-12">
           
           
           <form:form method="get">
	         <div class="groupdetails-row-padding">
				<div class="groupproductdetails">
					<div class="content"> 
					 <legend>Devices</legend>						                     
							<table class="table table-hover ">
								<thead style="background-color: #D6F1F6;">
								<tr class='clickable-row'>
									<th>Serial No</th>
									<th>Product Name</th>
									<th>Option</th>
								</tr>
								</thead>
								<tbody>
								<c:forEach items="${productList}" var="product">
									<tr>
										<th><c:out value="${product.serialNumber}"/></th>
										<th><c:out value="${product.productModel}"/></th>
										<th><a href="detailedProduct?serialNumber=<c:out value='${product.serialNumber}'/>">Detail</a></th>
																 
									</tr>
								</c:forEach>
								</tbody>
							</table>
								<%-- </c:if> --%>
					</div>					
			    </div>
			    <div class="groupclientdetails">
					<legend>Customer Details</legend>
				<form action="">
				    <div class="form-group row">
                         <label for="inputEmail3" class="col-sm-6 form-control-label" >Company Name</label>
                             <div class="col-sm-10">
                                <input type="text" class="form-control" name="client" value="${client.clientName}" disabled="disabled">
                              </div>
                       </div>
                       <div class="form-group row">
                            <label for="inputEmail3" class="col-sm-6 form-control-label" >Tell</label>
                              <div class="col-sm-10">
                                <input type="text" class="form-control" name="client" value="${client.tellphoneNumber}" disabled="disabled">
                               </div>
                          </div>
             
                  <div class="form-group row">
                       <label for="inputEmail3" class="col-sm-6 form-control-label" >Email</label>
                            <div class="col-sm-10">
                               <input type="text" class="form-control" name="client" value="${client.email}" disabled="disabled">
                             </div>
                          </div>
                  <div class="form-group row">
                                 <label for="inputEmail3" class="col-sm-4 form-control-label" >Address</label>
                                 <div class="col-sm-10">
                                   <textarea rows="3" cols="50" disabled="disabled">${client.streetName}, ${client.city_town},${client.province}</textarea>
                                   </div>
                               </div>
				</form>
				</div>
		  </div>
    </form:form>
           </div>
         
     </div>
     </div>
    </div>
</body>

<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.6/js/jquery-2.1.4.min.js" />" ></script>
<script type="text/javascript"src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script> 
<link href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
	<link href="<c:url value="/resources/bootstrap-3.3.6/css/Custombootstrap.css" />"
	rel="stylesheet" type="text/css" />
	
	
</html>