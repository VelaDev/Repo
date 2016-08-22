<%@ include file="templates/taglibs.jsp" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<c:import url="templates/navbar.jsp"></c:import>
<body class=".container-fluid">
<div class="container myrow-container" style="width:90%">
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">
                <div align="center"><b>Add Employee</b> </div>
                <!-- <div align="right"><a href="">Think of something</a></div> -->
            </h3>
        </div>
   <div class="panel-body">
   
   <div class="col-lg-10">
   <form:form method="post" action="addEmployee"  modelAttribute="addEmployee">
      <div class="form-group row">
    <label for="inputEmail3" class="col-sm-2 form-control-label">First Name</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="firstName">
    </div>
  </div>
   <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Last Name</label>
    <div class="col-sm-10">
      <input type="text" name="lastName" class="form-control">
    </div>
  </div>
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Title</label>
    <div class="col-sm-10">
      <select name="title" class="form-control">
        <option value="">Title<option>
								  
								     <option value="Mr" >Mr</option>
								     <option value="Miss" >Miss</option>
								     <option value="Mrs" >Mrs</option>
								     <option value="Doc" >Doc</option>
      </select>
    </div>
  </div>
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Gender</label>
    <div class="col-sm-10">
      <select name="gender" class="form-control">
        <option value="">Gender<option>
								   
								     <option value="Male" >Male</option>
								     <option value="Female" >Female</option>
      </select>
    </div>
  </div>
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Username</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="username">
    </div>
  </div>
   <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Password</label>
    <div class="col-sm-10">
      <input type="password" class="form-control" name="password">
    </div>
  </div>
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Email</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="email">
    </div>
  </div>
  
  <div class="form-group row">
    <label for="inputPassword3" class="col-sm-2 form-control-label">Role</label>
    <div class="col-sm-10">
      <select name="role" class="form-control">
        <option value="">Role<option>
								  
								     <option value="Admin" >Admin</option>
								     <option value="Manager" >Manager</option>
								     <option value="Technician" >Technician</option>
								     <option value="User" >User</option>
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
<script type="text/javascript" src="<c:url value="/resources/bootstrap-3.3.6/js/jquery-2.1.4.min.js" />" ></script>
<script type="text/javascript"src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script> 
<link href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
</html>