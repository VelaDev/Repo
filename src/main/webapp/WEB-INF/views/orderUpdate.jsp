<%@include file="templates/taglibs.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Order Details</title>
</head>
<body>
<c:import url="templates/navbar.jsp"></c:import>
<body class=".container-fluid">
<div class="container myrow-container" style="width:90%">
  <div class="alert alert-info" role="alert">
<c:if test="${not empty retMessage }">
  <c:out value="${ retMessage}">
 </c:out>
 </c:if>
 </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">
                <div align="center"><b>Approve Order</b> </div>
            </h3>
        </div>
   <div class="panel-body">
      <form method="post" action="updateOrder"><br>
         <div class="row">
                    <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Order No:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" name=""class="form-control" name="orderNum" value="${orderObject.orderNum}">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Serial Number:</label>
     
   </div>
   <div class="col-xs-3">
     <input type="text" name=""class="form-control" name="prod" value="${orderObject.product.serialNumber}">
   </div>
   </div>
	</div><br>
	
	<div class="row">
                    <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Part No:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" name=""class="form-control" name="partP" value="${orderObject.part.partNumber}" >
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Quantity:</label>
     
   </div>
   <div class="col-xs-3">
     <input type="text" name=""class="form-control" name="quantity" value="${orderObject.quantity}">
   </div>
   </div>
	</div><br>
	
	<div class="row">
                    <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Customer Name:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control" value="${orderObject.product.client.clientName}">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Ordered By:</label>
     
   </div>
   <div class="col-xs-3">
    <input type="text" class="form-control" name="" value="${orderObject.employee.username} ${orderObject.employee.lastName}">
   </div>
   </div>
	</div><br>
	
	<div class="row">
                    <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Customer Contacts:</label>
     
   </div>
   <div class="col-xs-3">
   <textarea rows="2" cols="38">${orderObject.product.client.email}, ${orderObject.product.client.tellphoneNumber}</textarea>
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Customer Address:</label>
     
   </div>
   <div class="col-xs-3">
    <textarea rows="2" cols="38">${orderObject.product.client.streetName}, ${orderObject.product.client.city_town},${orderObject.product.client.province}</textarea>
   </div>
   </div>
	</div><br>
	
	<div class="row">
                    <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Order Date:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control" name="dateOrdered" value="${orderObject.getDateOrdered().getTime().toLocaleString()}">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Item Type:</label>
     
   </div>
   <div class="col-xs-3">
    <input type="text" class="form-control" value="${orderObject.part.itemType}">
   </div>
   </div>
	</div><br>
	<div class="row">
                    <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Problem Description:</label>
     
   </div>
   <div class="col-xs-3">
   <textarea rows="2" cols="120" name="description">${orderObject.description}</textarea>
   </div>
   </div>
	</div><br>
	
	<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-8">
							<input type="submit" value="Approve Order"
								class="btn btn-primary btn-block btn-lg" tabindex="9" id="submit">						</div>
					</div>
      </form>
  </div>
  </div>
</div>
</body>

<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.6/js/jquery-2.1.4.min.js" />" ></script>
<script type="text/javascript"src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script> 
<link href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
</html>