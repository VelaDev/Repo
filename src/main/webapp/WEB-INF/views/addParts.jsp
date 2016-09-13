<%@ include file="templates/taglibs.jsp" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
                <div align="center"><b>Add Spares</b> </div>
                <!-- <div align="right"><a href="">Think of something</a></div> -->
            </h3>
        </div>
   <div class="panel-body">
     <form:form method="post" action="saveSpareParts"  modelAttribute="saveSpareParts">
     <br>
         <div class="row">
                    <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Part Number:</label>
     
   </div>
   <div class="col-xs-3">
   <select name="partNumber" class="form-control" tabindex="1">
        <option value="">Part Number<option>
								     <option value="CLT-R806K" >CLT-R806K</option>
								     <option value="CLT-R806X" >CLT-R806X</option>
								     <option value="CLT-W806" >CLT-W806</option>						   
      </select>
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Item Type:</label>
     
   </div>
   <div class="col-xs-3">
   <select name="itemType" class="form-control" tabindex="1">
        <option value="">Item Type<option>
								     <option value="Toner" >Toner</option>
								     <option value="Spares" >Spares</option>						   
      </select>
   </div>
   </div>
	</div><br><br>
	<div class="row">
                    <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Model Number:</label>
     
   </div>
   <div class="col-xs-3">
   <select name="modelNumber" class="form-control" tabindex="2">
        <option value="">Model Number<option>
								     <option value="MultiXpress X7500LX" >MultiXpress X7500LX</option>

								   
      </select>
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Description:</label>
     
   </div>
   <div class="col-xs-3">
   <select name="description" class="form-control" tabindex="3">
        <option value="">Description<option>
								     <option value="Black Imaging Unit" >Black Imaging Unit</option>
								      <option value="Color Imaging Unit" >Color Imaging Unit</option>
								       <option value="Waste Toner Bottle" >Waste Toner Bottle</option>

								   
      </select>
   </div>
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
</body>   
<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.6/js/jquery-2.1.4.min.js" />" ></script>
<script type="text/javascript"src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script> 
<link href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
</html>