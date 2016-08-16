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
                <div align="center"><b>Device Installation</b> </div>
                <!-- <div align="right"><a href="">Think of something</a></div> -->
            </h3>
        </div>
   <div class="panel-body">
    <form action="searchClientforProduct" method="post">
        <div class="row">
        
           <div class="col-xs-2 form-control-label" align="center">Search Client</div>
            <div class="col-xs-3">
                <input type="text" class="form-control input-sm">
            </div>
            <div class="col-xs-2">
               <input class="btn btn-success" type='submit' value='Search'/>
            </div>
  
          </div>
 
   <hr>
   </form>
   <form method="POST" action="account.php">
   
   <fieldset>	<legend>Client Details</legend>					
	<div class="row">
                    <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Company Name:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${client.contactPerson}" disabled="disabled">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Contact Person</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${client.tellphoneNumber}" disabled="disabled">
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
   <input type="text" class="form-control input-sm" value="${client.contactPerson}" disabled="disabled">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Cell</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${client.tellphoneNumber}" disabled="disabled">
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
   <input type="text" class="form-control input-sm" value="${client.contactPerson}" disabled="disabled">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Fax</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${client.tellphoneNumber}" disabled="disabled">
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
   <input type="text" class="form-control input-sm" value="${client.contactPerson}" disabled="disabled">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Street Name</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${client.tellphoneNumber}" disabled="disabled">
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
   <input type="text" class="form-control input-sm" value="${client.contactPerson}" disabled="disabled">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Floor No</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${client.tellphoneNumber}" disabled="disabled">
   </div>
   </div>
	</div>
	</fieldset>	
	<fieldset>
	  <legend>Machine Details</legend>
	  <br>	
	<div class="row">
	  <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Serial No:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Machine Model</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm">
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
        <label for="bridgeunit">Serial Number:</label><input type="text" id="bridgeunit"  disabled/>
        </div>
        
        <div class="col-xs-2 form-control-label">
	    <label for="serailNo"><input type="checkbox" id="faxunit" />Fax Unit:</label>
	    </div>
	    <div class="col-xs-3">
        <label for="faxunitserial">Serial Number:</label><input type="text" id="faxunitserial"  disabled/>
        </div>
	</div>
	<br>
	<div class="row">
	<div class="col-xs-2 form-control-label">
	    <label for="serailNo"><input type="checkbox" id="onebintrayserial" />One bin tray</label>
	    </div>
	    <div class="col-xs-3">
        <label for="onebintray">Serial Number:</label><input type="text" id="onebintray"  disabled/>
        </div>
        
        <div class="col-xs-2 form-control-label">
	    <label for="serailNo"><input type="checkbox" id="finisher" />Finisher:</label>
	    </div>
	    <div class="col-xs-3">
        <label for="finisherserial">Serial Number:</label><input type="text" id="finisherserial"  disabled/>
        </div>
	</div>
	<br>
	<div class="row">
	<div class="col-xs-2 form-control-label">
	    <label for="serailNo"><input type="checkbox" id="ltcserial" />LCT</label>
	    </div>
	    <div class="col-xs-3">
        <label for="ltc">Serial Number:</label><input type="text" id="ltc"  disabled/>
        </div>
        
        
        <div class="row">
	   <div class="col-xs-2 form-control-label">
	    <label for="serailNo"><input type="checkbox" id="credenzaserial" />Credenza</label>
	    </div>
	    <div class="col-xs-3">
        <label for="credenza">Serial Number:</label><input type="text" id="credenza"  disabled/>
        </div>
	
	</div>
        <br>
	<div class="col-xs-2 form-control-label">
	    <label for="serailNo"><input type="checkbox" id="additionalPaperTrays" />Additional paper trays:</label>
	    </div>
	    <div class="col-xs-3">
        <label for="additionalserial">Serial Number:</label><input type="text" id="additionalserial"  disabled/>
        </div>
	</div>
	</fieldset><br>
	<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-8">
							<input type="submit" value="Submit"
								class="btn btn-primary btn-block btn-lg" tabindex="9" id="submit">
						</div>
					</div>
	</form>
						
	



	

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
   </div>
 
  
</body>
<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.6/js/jquery-2.1.4.min.js" />" ></script>
<script type="text/javascript"src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script> 
<link href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
       rel="stylesheet" type="text/css" />
      <%--  <link href="<c:url value="/resources/bootstrap-3.3.6/styles/style.css" />"
       rel="stylesheet" type="text/css" /> --%>
       
       <link href="style.css" rel="stylesheet" type="text/css"/>
    <link href="lib/css/bootstrap.min.css" rel="stylesheet"  type="text/css"/>
       
       
 <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script> 
 --><style type="text/css">
    .bs-example{
    	margin: 20px;
    }
</style>
</html>
