<%@ include file="templates/taglibs.jsp" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<c:import url="templates/navbar.jsp"></c:import>
<body class=".container-fluid">
<div class="container myrow-container" style="width:90%">
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">
                <div align="center"><b>Machine Details</b> </div>
            </h3>
        </div>
   <div class="panel-body">
     <div class="col-xs-10">  
     
       
   <form action="">
     <div class="groupdetails-row-padding">
        <div class="groupproductdetails">
					<div class="content"> 
					 <legend>Machine Accessories</legend>						                     
							<table class="table table-hover ">
								<thead style="background-color: #D6F1F6;">
								<tr class='clickable-row'>
									<th>Accessory Type</th>
									<th>Serial No</th>
								</tr>
								</thead>
								<tbody>
								<c:forEach items="${accessories}" var="accessory">
									<tr>
										<th><h6><c:out value="${accessory.bridgeUnitSerialType}"/></h6></th>
										<th><h6><c:out value="${accessory.bridgeUnitSerial}"/></h6></th>
																 
									</tr>
								</c:forEach>
								</tbody>
							</table>
								<%-- </c:if> --%>
					</div>					
			    </div>
			    <div class="groupclientdetails">
					<legend>Machine Details</legend>
					   <form:form>
                         <div class="row">
                    <div class="col-xs-12">
                        <div class="col-xs-4 form-control-label">
                        <h6><label >Serial Number:</label></h6>
     
                    </div>
                  <div class="col-xs-8">
                      <input type="text" class="form-control input-sm" value="${productObject.serialNumber}" disabled="disabled">
                  </div>
   </div>
	</div>
	      <div class="row">
                    <div class="col-xs-12">
                        <div class="col-xs-4 form-control-label">
                        <h6><label >Product Model:</label></h6>
     
                    </div>
                  <div class="col-xs-8">
                      <input type="text" class="form-control input-sm" value="${productObject.productModel}" disabled="disabled">
                  </div>
   </div>
	</div>
	<div class="row">
                    <div class="col-xs-12">
                        <div class="col-xs-4 form-control-label">
                        <h6><label >Contract Start Date:</label></h6>
     
                    </div>
                  <div class="col-xs-8">
                      <input type="text" class="form-control input-sm" value="${productObject.startDate.toString().substring(0,10)}" disabled="disabled">
                  </div>
   </div>
	</div>
	<div class="row">
                    <div class="col-xs-12">
                        <div class="col-xs-4 form-control-label">
                        <h6><label >Contract End Date</label></h6>
     
                    </div>
                  <div class="col-xs-8">
                      <input type="text" class="form-control input-sm" value="${productObject.endDate.toString().substring(0,10)}" disabled="disabled">
                  </div>
   </div>
	</div>
	<div class="row">
                    <div class="col-xs-12">
                        <div class="col-xs-4 form-control-label">
                        <h6><label >Company Name</label></h6>
     
                    </div>
                  <div class="col-xs-8">
                      <input type="text" class="form-control input-sm" value="${productObject.client.getClientName()}" disabled="disabled">
                  </div>
   </div>
	</div>
	<div class="row">
                    <div class="col-xs-12">
                        <div class="col-xs-4 form-control-label">
                        <h6><label >Customer Address</label></h6>
     
                    </div>
                  <div class="col-xs-8">
                      <textarea rows="3" cols="29" disabled="disabled">${productObject.client.streetName}, ${productObject.client.city_town},${productObject.client.province}</textarea>
                  </div>
   </div>
	</div>
  
                       </form:form>
					</div>
     
     </div>
   </form>
   </div>
   
   </div>
   
   </div>
  </div>

</body>
<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.6/js/jquery-2.1.4.min.js" />" ></script>
<script type="text/javascript"src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script> 
<link href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
</html>