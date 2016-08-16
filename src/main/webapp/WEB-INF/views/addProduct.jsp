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
                <div align="center"><b>Product Installation</b> </div>
                <!-- <div align="right"><a href="">Think of something</a></div> -->
            </h3>
        </div>
   <div class="panel-body">
    <form action="searchClientforProduct" method="post">
   <div class="row">
  
   <div class="col-sm-12" align="center">
   
    <fieldset class="form-group row col-sm-8">
     <input type="text" name=clientName id="clientName" class="form-control"  placeholder="search"> 
    
    </fieldset>
     <div class="col-sm-4">
      <input class="btn btn-success" class="form-control" type='submit' value='Search'/>
     </div>
    </div>
   </div>
   <br><br>
   <div class="row">
   <div class="col-sm-12">
   <div class="form-group row col-sm-1">
    <label >Contact Person:</label>
     
   </div>
   <div class="col-sm-2">
   <input type="text" class="form-control" value="${client.contactPerson}" disabled="disabled">
   </div>
   
      <div class="form-group row col-sm-1">
    <label  >Tel:</label>
     
   </div>
   <div class="col-sm-2">
   <input type="text" class="form-control" value="${client.tellphoneNumber}" disabled="disabled">
   </div>
  
   
    <div class="form-group row col-sm-1">
    <label >Cell:</label>
     
   </div>
   <div class="col-sm-2">
   <input type="text" class="form-control" value="${client.cellNumber}" disabled="disabled">
   </div>
    <div class="form-group row col-sm-1">
    <label>Email</label>
     
   </div>
   <div class="col-sm-3">
   <input type="text" class="form-control" value="${client.email}" disabled="disabled">
   </div>
   </div>
   
   </div>
   
      <div class="row">
  <div class="col-sm-12">
   <div class="form-group row col-sm-1">
    <label>Fax:</label>
     
   </div>
   <div class="col-sm-2">
   <input type="text" class="form-control" value="${client.faxNumber}" disabled="disabled">
   </div>
   
      <div class="form-group row col-sm-1">
    <label>Street Name:</label>
     
   </div>
   <div class="col-sm-2">
   <input type="text" class="form-control" value="${client.streetName}" disabled="disabled">
   </div>
  
   
    <div class="form-group row col-sm-1">
    <label>Street No:</label>
     
   </div>
   <div class="col-sm-2">
   <input type="text" class="form-control" value="${client.tellphoneNumber}" disabled="disabled">
   </div>
    <div class="form-group row col-sm-1">
    <label>Suburb:</label>
     
   </div>
   <div class="col-sm-3">
   <input type="text" class="form-control" value="${client.city_town}" disabled="disabled">
   </div>
   </div>
   
   </div>
   
    
   <div class="row">
   <div class="col-sm-12">
   <div class="form-group row col-sm-1">
    <label >Floor No:</label>
     
   </div>
   <div class="col-sm-3">
   <input type="text" class="form-control" value="${client.floorNumber}" disabled="disabled">
   </div>
   
      <div class="form-group row col-sm-1">
    <label  >Machine Model:</label>
     
   </div>
   <div class="col-sm-3">
   <input type="text" class="form-control" name="productModel">
   </div>
  
   
    <div class="form-group row col-sm-1">
    <label >Serial Number:</label>
     
   </div>
   <div class="col-sm-3">
   <input type="text" class="form-control" name="serialNumber">
   </div>
    <!-- <div class="form-group row col-sm-1">
    <label>email</label>
     
   </div> -->
   <!-- <div class="col-sm-2">
   <input type="text" class="form-control">
   </div> -->
   </div>
   
   </div>
   <div class="row">
   <div class="col-sm-4">
   </div>
   <div class="col-sm-4">
                                                <input type="submit" value="Submit"
                                                       class="btn btn-primary btn-block btn-lg" tabindex="9"
                                                       id="submit">
                                         </div>
   <div class="col-sm-4">
   </div>
   </div>
   
   </form>
   
   
  <%--  <div class="col-lg-10">
          <form action="searchClientforProduct" method="post">
                    <div class="form-group row">
                      <div class="col-md-11">
                         <div class="col-sm-2 form-control-label" for="inputEmail3">Search Client:</div>
                          <div class="col-md-8"> 
                            <input type="text" name=clientName id="clientName" class="form-control"> 
                          </div>
                           <div class="col-sm-2"><input class="btn btn-success" type='submit' value='Search'/></div>
                       </div>
                    </div>
                    <br>
                </form>
                </div>
            <div class="col-lg-10">    
   <form:form method="post" action="saveProduct"  modelAttribute="saveProduct">
   
    <div class="form-group row">
    <label for="inputEmail3" class="col-sm-2 form-control-label" >Client Name</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="client" value="${client.clientName}" disabled="disabled">
    </div>
 </div>
      <div class="form-group row">
    <label for="inputEmail3" class="col-sm-2 form-control-label">Serial Number</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="serialNumber">
    </div>
  </div>
   <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Product Name</label>
    <div class="col-sm-10">
      <input type="text" name="productName" class="form-control">
    </div>
  </div>
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Product Type</label>
    <div class="col-sm-10">
      <select name="productType" class="form-control">
        <option value="">Product Type<option>
                                                         
                                                            <option value="Printer">Printer</option>
                                                            <option value="Scanner">Scanner</option>
                                                            <option value="Laptop">Laptop</option>
                                                            
      </select>
    </div>
  </div>
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Product Model</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="productModel">
    </div>
  </div>
   
  <div class="form-group row">
                                         <div class="col-sm-offset-2 col-sm-10">
                                                <input type="submit" value="Submit"
                                                       class="btn btn-primary btn-block btn-lg" tabindex="9" id="submit">
                                         </div>
                                  </div>
   </form:form>
   </div> --%>
  
  </div>
  </div>
  
</div>
</body>
<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.6/js/jquery-2.1.4.min.js" />" ></script>
<script type="text/javascript"src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script> 
<link href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
       rel="stylesheet" type="text/css" />
</html>
