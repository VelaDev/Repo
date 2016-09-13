<%@ include file="templates/taglibs.jsp" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
</head>
<c:import url="templates/navbar.jsp"></c:import>
<body>
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
                <div align="center"><b>Add Client</b> </div>
                <!-- <div align="right"><a href="">Think of something</a></div> -->
            </h3>
        </div>
   <div class="panel-body">
   
   <div class="col-lg-10">
   <form:form method="post" action="saveClient"  modelAttribute="saveClient">
       <div class="row">
                    <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Client Name:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" name="clientName">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Contact Person:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" name="contactPerson">
   </div>
   </div>
	</div><br>
	
	 <div class="row">
                    <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Province:</label>
     
   </div>
   <div class="col-xs-3">
   <select name="province" class="form-control">
        <option value="">Province<option>
								     <option value="Gauteng" >Gauteng</option>
								     <option value="Limpopo" >Limpopo</option>
								     <option value="Nort West" >North West</option>
								     <option value="Free State" >Free State</option>
								     <option value="Mpumalanga">Mpumalanga</option>
								     <option value="KwaZulu Natal" >KwaZulu Natal</option>
								     <option value="Northern Cape" >Northern Cape</option>
								     <option value="Eastern Cape" >Eastern Cape</option>
								     <option value="Mpumalanga" >Western Cape</option>
      </select>
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >City/Town:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" name="city_town">
   </div>
   </div>
	</div> <br>
	
	<div class="row">
                    <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Street Name:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" name="streetName">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Area Code:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" name=zipcode>
   </div>
   </div>
	</div><br>
	<div class="row">
                    <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Floor No:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" name="floorNumber">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Telephone No:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" name=tellphoneNumber>
   </div>
   </div>
	</div><br>
	<div class="row">
                    <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Fax No:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" name="faxNumber">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Cell No:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" name=cellNumber>
   </div>
   </div>
	</div><br>
	<div class="row">
                    <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Email:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" name="email">
   </div>
   
      <!-- <div class="col-xs-2 form-control-label">
    <label  >Cell No:</label>
     
   </div> -->
   <!-- <div class="col-xs-3">
   <input type="text" class="form-control input-sm" name=cellNumber>
   </div> -->
   </div>
	</div><br>
	
	<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-8">
							<input type="submit" value="Submit"
								class="btn btn-primary btn-block btn-lg" tabindex="9" id="submit">						</div>
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