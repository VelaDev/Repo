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
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">
                <div align="left"><b>Order Details</b> </div>
            </h3>
        </div>
   <div class="panel-body">
   <div class="form-group row">
   <div class="col-lg-10">
   <form method="post" action="updateOrder">
				    <div class="col-lg-5">
                         <label for="inputEmail3" class="control-label" >Order No</label>
                             
                         <input type="text" name=""class="form-control" name="orderNum" value="${orderObject.orderNum}" disabled="disabled">
                              
                       </div>
                       <div class="col-lg-5">
                       <label for="inputEmail3" class="form-control-label" >Serial Number</label>
                           
                               <input type="text" name=""class="form-control" name="prod" value="${orderObject.product.serialNumber}" disabled="disabled">
                          
                          </div>
                           <div class="col-lg-5">
                       <label for="inputEmail3" class="form-control-label" >Part No</label>
                           
                               <input type="text" name=""class="form-control" name="partP" value="${orderObject.part.partNumber}" disabled="disabled">
                            
                          </div>
                           <div class="col-lg-5">
                       <label for="inputEmail3" class="form-control-label" >Quantity</label>
                            
                               <input type="text" name=""class="form-control" name="quantity" value="${orderObject.quantity}" disabled="disabled">
                           
                          </div>
                       <div class="col-lg-5">
                            <label for="inputEmail3" class="form-control-label" >Customer Name</label>
                              
                                <input type="text" class="form-control" value="${orderObject.product.client.clientName}" disabled="disabled">
                              
                          </div> <div class="col-lg-5">
                       <label for="inputEmail3" class="form-control-label" >Ordered By</label>
                          
                               <input type="text" class="form-control" name="" value="${orderObject.employee.username} ${orderObject.employee.lastName}" disabled="disabled">
                           
                          </div>
             
                  <div class="col-lg-5">
                       <label for="inputEmail3" class="form-control-label" >Customer Contacts</label>
                            
                        
                                <textarea rows="2" cols="50" disabled="disabled">${orderObject.product.client.email}, ${orderObject.product.client.tellphoneNumber}</textarea>
                          </div>
                  <div class="col-lg-5">
                                 <label for="inputEmail3" class="form-control-label" >Customer Address</label>
                                 
                                   <textarea rows="2" cols="50" disabled="disabled">${orderObject.product.client.streetName}, ${orderObject.product.client.city_town},${orderObject.product.client.province}</textarea>
                                 
                               </div>
                           
                          
                           <div class="col-lg-5">
                       <label for="inputEmail3" class="form-control-label" >Order Date</label>
                           
                               <input type="text" class="form-control" name="dateOrdered" value="${orderObject.getDateOrdered().getTime().toLocaleString()}" disabled="disabled">
                           
                          </div>
                           <div class="col-lg-5">
                       <label for="inputEmail3" class="form-control-label" >ItemType</label>
                         
                               <input type="text" class="form-control" value="${orderObject.part.itemType}" disabled="disabled">
                           
                          </div>
                          <br>
                 
                  <div class="col-lg-5">
                       <label for="inputEmail3" class="form-control-label" >Problem Description</label>
                            
                        
                                <textarea rows="2" cols="115" disabled="disabled" name="description">${orderObject.description}</textarea>
                          </div><br><br>
                                                    <div class="form-group row">
						<div class="col-sm-offset-2 col-sm-10"></div></div>
                          <div class="form-group row">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" value="Approve Order"
								class="btn btn-primary btn-block btn-lg" tabindex="9" id="submit">
						</div>
					</div>
  
  
  
				</form>
   </div>
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