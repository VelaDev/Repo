<%@ include file="templates/taglibs.jsp" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<c:import url="templates/navbar.jsp"></c:import>
<body class=".container-fluid">
<div class="container myrow-container">
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">
                <div align="center"><b>Product Detail</b> </div>
            </h3>
        </div>
   <div class="panel-body">
     <div class="col-lg-10">    
   <form:form>
   
   <div class="form-group row">
    <label for="inputEmail3" class="col-sm-2 form-control-label" >Serial Number</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" value="${productObject.serialNumber}" disabled="disabled">
    </div>
  </div>
      <div class="form-group row">
    <label for="inputEmail3" class="col-sm-2 form-control-label">Product Name</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" value="${productObject.productName}" disabled="disabled" >
    </div>
  </div>
   <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Product Model</label>
    <div class="col-sm-10">
      <input type="text"  class="form-control" value="${productObject.productModel}" disabled="disabled">
    </div>
  </div>
  
    <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Assigned Date</label>
    <div class="col-sm-10">
      <input type="text"  class="form-control" value="${productObject.arrivedDate}" disabled="disabled">
    </div>
  </div>
  
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Client Name</label>
    <div class="col-sm-10">
      <input type="text"  class="form-control" value="${productObject.client.getClientName()}" disabled="disabled">
    </div>
  </div>
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Client Address</label>
    <div class="col-sm-10">
      <textarea rows="3" cols="115" disabled="disabled">${productObject.client.streetName}, ${productObject.client.city_town},${productObject.client.province}</textarea>
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
</html>