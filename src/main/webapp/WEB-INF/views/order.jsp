<%@ include file="templates/taglibs.jsp" %> 


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<c:import url="templates/techniciannavbar.jsp"></c:import>
<body class=".container-fluid">
<div class="container myrow-container" style="width:90%">
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">
                <div align="center"><b>Make Order</b> </div>
                <!-- <div align="right"><a href="">Think of something</a></div> -->
            </h3>
        </div>
   <div class="panel-body">
   
   <div class="col-lg-10">
   <form:form method="post" action="makeOrder"  modelAttribute="makeOrder">
   
    <div class="form-group row">
    <label for="inputEmail3" class="col-sm-2 form-control-label">Serial Number</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="prod">
    </div>
  </div>
      <div class="form-group row">
    <label for="inputEmail3" class="col-sm-2 form-control-label">Part Number</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="partP">
    </div>
  </div>
   <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Description</label>
    <div class="col-sm-10">
    <textarea rows="5" cols="115" name="description"></textarea>
    </div>
  </div>
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Quantity</label>
    <div class="col-sm-10">
      <input type="number" class="form-control" name="quantity">
    </div>
  </div>
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Delivery</label>
    <div class="col-sm-10">
      <select name="delivery" class="form-control">
        <option value="">Delivery<option>
		<option value="1">Yes</option>
		<option value="0">No</option>
								     
      </select>
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
</html>
<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.6/js/jquery-2.1.4.min.js" />" ></script>
<script type="text/javascript"src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script> 
<link href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />