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
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">
                <div align="center"><b>Add Spares</b> </div>
                <!-- <div align="right"><a href="">Think of something</a></div> -->
            </h3>
        </div>
   <div class="panel-body">
   
   <div class="col-lg-10">
   <form:form method="post" action="saveSpareParts"  modelAttribute="saveSpareParts">
      <div class="form-group row">
    <label for="inputEmail3" class="col-sm-2 form-control-label">Part Number</label>
    <div class="col-sm-10">
      <select name="partNumber" class="form-control" tabindex="1">
        <option value="">Part Number<option>
								     <option value="CLT-R806K" >CLT-R806K</option>
								     <option value="CLT-R806X" >CLT-R806X</option>
								     <option value="CLT-W806" >CLT-W806</option>						   
      </select>
    </div>
  </div>
  <div class="form-group row">
    <label for="inputEmail3" class="col-sm-2 form-control-label">Item Type</label>
    <div class="col-sm-10">
      <select name="partNumber" class="form-control" tabindex="1">
        <option value="">Item Type<option>
								     <option value="Toner" >Toner</option>
								     <option value="Spares" >Spares</option>						   
      </select>
    </div>
  </div>
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Model Number</label>
    <div class="col-sm-10" >
      <select name="modelNumber" class="form-control" tabindex="2">
        <option value="">Model Number<option>
								     <option value="MultiXpress X7500LX" >MultiXpress X7500LX</option>

								   
      </select>
    </div>
  </div>
   <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Description</label>
    <div class="col-sm-10">
      <select name="description" class="form-control" tabindex="3">
        <option value="">Description<option>
								     <option value="Black Imaging Unit" >Black Imaging Unit</option>
								      <option value="Color Imaging Unit" >Color Imaging Unit</option>
								       <option value="Waste Toner Bottle" >Waste Toner Bottle</option>

								   
      </select>
    </div>
  </div>
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Quantity</label>
    <div class="col-sm-10">
      <input type="text" name="quantity" class="form-control">
    </div>
  </div>

  <div class="form-group row">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" value="Submit"
								class="btn btn-primary btn-block btn-lg" tabindex="4" id="submit">
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