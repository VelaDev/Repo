<%@ include file="templates/taglibs.jsp" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
</head>
<c:import url="templates/navbar.jsp"></c:import>
<body>
<div class="container myrow-container" style="width:90%">
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
      <div class="form-group row">
    <label for="inputEmail3" class="col-sm-2 form-control-label">Client Name</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="clientName">
    </div>
  </div>
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Contact Person</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="contactPerson">
    </div>
  </div>
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Province</label>
    <div class="col-sm-10">
      <select name="province" class="form-control">
        <option value="">Province<option>
								     <option value="Gauteng" >Gauteng</option>
								     <option value="Limpopo" >Limpopo</option>
								     <option value="Nort hWest" >North West</option>
								     <option value="Free State" >Free State</option>
								     <option value="Mpumalanga">Mpumalanga</option>
								     <option value="KwaZulu Natal" >KwaZulu Natal</option>
								     <option value="Northern Cape" >Northern Cape</option>
								     <option value="Eastern Cape" >Eastern Cape</option>
								     <option value="Mpumalanga" >Western Cape</option>
      </select>
    </div>
  </div>
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">City/Town</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="city_town">
    </div>
  </div>
   <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Street Name</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="streetName">
    </div>
  </div>
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Area Code</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="zipcode">
    </div>
  </div>
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Floor No</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="floorNumber">
    </div>
  </div>
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Telephone No</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="tellphoneNumber">
    </div>
  </div>
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Fax No</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="faxNumber">
    </div>
  </div>
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Cell No</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="cellNumber">
    </div>
  </div>
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Email</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="email">
    </div>
  </div>
  <div class="form-group row">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" value="Submit"
								class="btn btn-primary btn-block btn-lg" tabindex="9" id="submit">
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