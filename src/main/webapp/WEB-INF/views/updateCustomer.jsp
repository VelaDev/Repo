<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
        .myrow-container {
            margin: 20px;
           
        }
    </style>

   <c:import url="templates/navbar.jsp"></c:import>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>

<body class=".container-fluid">
<div class="container myrow-container" style="width:90%">
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">
                <div align="center"><b>Update Customer</b> </div>
                <!-- <div align="right"><a href="">Think of something</a></div> -->
            </h3>
        </div>
   <div class="panel-body">
    <form action="searchCustomer" method="post">
        <div class="row">
        
           <div class="col-xs-2 form-control-label" align="center">Search Customer</div>
            <div class="col-xs-3">
                <input type="text" class="form-control input-sm" name="clientName" id="clientName" placeholder="Company Name">
            </div>
            <div class="col-xs-2">
               <input class="btn btn-success" type='submit' value='Search'/>
            </div>
  
          </div>
   <hr>
   </form>
   <form:form method="post" action="updateCustomerData" modelAttribute="updateCustomerData">
   
   <fieldset>	<legend>Customer Details</legend>					
	<div class="row">
                    <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Company Name:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${client.clientName}" name="clientName">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Contact Person</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${client.contactPerson}" name="contactPerson">
   </div>
   </div>
	</div>
	
	<br>	
	<div class="row">
	  <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Tel:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${client.tellphoneNumber}" name="tellphoneNumber">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Cell</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${client.cellNumber}" name="cellNumber">
   </div>
   </div>
	</div>
	<br>	
	<div class="row">
	  <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Email:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${client.email}" name="email">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Fax</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${client.faxNumber}" name="faxNumber">
   </div>
   </div>
	</div>
	<br>	
	<div class="row">
	  <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Street No:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Street Name</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${client.streetName}" name="streetName">
   </div>
   </div>
	</div>
	<br>	
	<div class="row">
	  <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Town/Surbub:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${client.city_town}" name="city_town">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Floor No</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${client.floorNumber}" name="floorNumber">
   </div>
   </div>
	</div><br>	
	</fieldset><br><br>	
	
<br>
	<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-8">
							<input type="submit" value="Submit"
								class="btn btn-primary btn-block btn-lg" tabindex="9" id="submit">
						</div>
					</div>
	</form:form>
						
	



	

</div>
 



   </div>
   </div>
 
  
</body>

<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.6/js/jquery-2.1.4.min.js" />" ></script>
<script type="text/javascript"src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script> 
<link href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
</html>