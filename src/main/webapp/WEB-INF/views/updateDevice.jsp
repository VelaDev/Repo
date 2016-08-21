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
                <div align="center"><b>Update Device Installation</b> </div>
                <!-- <div align="right"><a href="">Think of something</a></div> -->
            </h3>
        </div>
   <div class="panel-body">
    <form action="searchDeviceSerialNumber" method="post">
        <div class="row">
        
           <div class="col-xs-2 form-control-label" align="center">Search Device</div>
            <div class="col-xs-3">
                <input type="text" class="form-control input-sm" name="serialNumber" id="serialNumber" placeholder="Serial No">
            </div>
            <div class="col-xs-2">
               <input class="btn btn-success" type='submit' value='Search'/>
            </div>
  
          </div>
   <hr>
   </form>
   <form:form method="POST" action="updateProduct" modelAttribute="updateProduct">
   
   <fieldset>	<legend>Customer Details</legend>					
	<div class="row">
                    <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Company Name:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${productObject.client.clientName}" disabled="disabled">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Contact Person</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${productObject.client.contactPerson}" disabled="disabled">
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
   <input type="text" class="form-control input-sm" value="${productObject.client.tellphoneNumber}" disabled="disabled">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Cell</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${productObject.client.cellNumber}" disabled="disabled">
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
   <input type="text" class="form-control input-sm" value="${productObject.client.email}" disabled="disabled">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Fax</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${productObject.client.faxNumber}" disabled="disabled">
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
   <input type="text" class="form-control input-sm" value="" disabled="disabled">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Street Name</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${productObject.client.streetName}" disabled="disabled">
   </div>
   </div>
	</div>
	<br>	
	<div class="row">
	  <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Surbub:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${productObject.client.city_town}" disabled="disabled">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Floor No</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${productObject.client.floorNumber}" disabled="disabled">
   </div>
   </div>
	</div><br>	
	</fieldset><br><br>	
	<fieldset>
	  <legend>Machine Details</legend>
	  <br>	
	<div class="row">
	  <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Serial No:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" disabled="disabled" value="${productObject.serialNumber }">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Machine Model</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${productObject.productModel }">
   </div>
   </div>
	</div><br>
	 <div class="row">
	  <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label>Contract Start Date:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" id="startDate" name="startDate" value="${productObject.startDate.toString().substring(0,10) }">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label>Contract End Date</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" id="endDate" name="endDate" value="${productObject.endDate.toString().substring(0,10) }">
   </div>
   </div>
	</div>
	</fieldset><br><br><fieldset>
	<legend align="right">Machine Accessories</legend>
	<div class="row">
	<div class="col-xs-2 form-control-label">
	    <label for="serailNo"><input type="checkbox" id="bridgeunitserial" />Bridge unit</label>
	    </div>
	    <div class="col-xs-3">
        <label for="bridgeunit">Serial Number:</label><input type="text" id="bridgeunit" />
        </div>
        
        <div class="col-xs-2 form-control-label">
	    <label for="serailNo"><input type="checkbox" id="faxunit" />Fax Unit:</label>
	    </div>
	    <div class="col-xs-3">
        <label for="faxunitserial">Serial Number:</label><input type="text" id="faxunitserial"  />
        </div>
	</div>
	<br>
	<div class="row">
	<div class="col-xs-2 form-control-label">
	    <label for="serailNo"><input type="checkbox" id="onebintrayserial" />One bin tray</label>
	    </div>
	    <div class="col-xs-3">
        <label for="onebintray">Serial Number:</label><input type="text" id="onebintray"/>
        </div>
        
        <div class="col-xs-2 form-control-label">
	    <label for="serailNo"><input type="checkbox" id="finisher" />Finisher:</label>
	    </div>
	    <div class="col-xs-3">
        <label for="finisherserial">Serial Number:</label><input type="text" id="finisherserial"/>
        </div>
	</div>
	<br>
	<div class="row">
	<div class="col-xs-2 form-control-label">
	    <label for="serailNo"><input type="checkbox" id="ltcserial" />LCT</label>
	    </div>
	    <div class="col-xs-3">
        <label for="ltc">Serial Number:</label><input type="text" id="ltc"/>
        </div>
        
        
        <div class="row">
	   <div class="col-xs-2 form-control-label">
	    <label for="serailNo"><input type="checkbox" id="credenzaserial" />Credenza</label>
	    </div>
	    <div class="col-xs-3">
        <label for="credenza">Serial Number:</label><input type="text" id="credenza"/>
        </div>
	
	</div>
        <br>
	<div class="col-xs-2 form-control-label">
	    <label for="serailNo"><input type="checkbox" id="additionalPaperTrays" />Additional paper trays:</label>
	    </div>
	    <div class="col-xs-3">
        <label for="additionalserial">Serial Number:</label><input type="text" id="additionalserial"/>
        </div>
	</div>
	</fieldset><br>
	<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-8">
							<input type="submit" value="Submit"
								class="btn btn-primary btn-block btn-lg" tabindex="9" id="submit">
						</div>
					</div>
	</form:form>
						
	



	

</div>
 
<script>
	document.getElementById('bridgeunitserial').onchange = function() {
    document.getElementById('bridgeunit').disabled = !this.checked;
};
document.getElementById('faxunit').onchange = function() {
    document.getElementById('faxunitserial').disabled = !this.checked;
};
document.getElementById('onebintrayserial').onchange = function() {
    document.getElementById('onebintray').disabled = !this.checked;
};
document.getElementById('finisher').onchange = function() {
    document.getElementById('finisherserial').disabled = !this.checked;
};
document.getElementById('ltcserial').onchange = function() {
    document.getElementById('ltc').disabled = !this.checked;
};
document.getElementById('additionalPaperTrays').onchange = function() {
    document.getElementById('additionalserial').disabled = !this.checked;
};
document.getElementById('credenzaserial').onchange = function() {
    document.getElementById('credenza').disabled = !this.checked;
};
</script>


   </div>
   </div>
 
  
</body>
<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.6/js/jquery-2.1.4.min.js" />" ></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap-datepicker.js" />" ></script>
<script type="text/javascript"src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script> 
<link href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
       rel="stylesheet" type="text/css" />
       
       <link href="style.css" rel="stylesheet" type="text/css"/>
    <link href="lib/css/bootstrap.min.css" rel="stylesheet"  type="text/css"/>
       
 <script type="text/javascript">
    $(document).ready(function () {
        $('#startDate').datepicker({
            format: "yyyy-mm-dd"
        });
    });
</script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#endDate').datepicker({
            format: "yyyy-mm-dd"
        });
    });
</script>
 <style type="text/css">
    .bs-example{
    	margin: 20px;
    }
</style>
</html>
