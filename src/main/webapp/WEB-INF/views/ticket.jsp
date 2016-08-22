<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Log a ticket</title>
<c:import url="templates/usernavbar.jsp"></c:import>
<body>
<div class="container myrow-container" style="width:90%">
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">
                <div align="left"><b>Log Ticket</b> </div>
                <!-- <div align="right"><a href="">Think of something</a></div> -->
            </h3>
        </div>
   <div class="panel-body">
   <div class="col-lg-10">
          <form action="searchSerialNumber" method="post">
                    <div class="form-group row">
                      <div class="col-md-11">
                         <div class="col-sm-2 form-control-label" for="inputEmail3">Serial Number:</div>
                          <div class="col-md-8"> 
                            <input type="text" name="serialNumber" id="serialNumber" class="form-control"> 
                          </div>
                           <div class="col-sm-2"><input class="btn btn-success" type='submit' value='Search'/></div>
                       </div>
                    </div>
                    <br>
                </form>
                </div>
       <div class="col-lg-10">         
   <form:form method="post" action="logTicket" role="form"
					modelAttribute="logTicket" id="form">
     
  
    <div class="form-group row">
    <label for="inputEmail3" class="col-sm-2 form-control-label">Serial No</label>
       <div class="col-sm-10">
        <input class="form-control" name="productS" value="${product.serialNumber }"  id="productS" disabled="disabled">
    </div>
  </div>
  
  <div class="form-group row">
    <label for="inputEmail3" class="col-sm-2 form-control-label">Product Name</label>
       <div class="col-sm-10">
        <input class="form-control" value="${product.productName }" name="serialNumber" disabled="disabled">
    </div>
  </div>
  <div class="form-group row">
    <label for="inputEmail3" class="col-sm-2 form-control-label">Product Model</label>
       <div class="col-sm-10">
        <input class="form-control" value="${product.productModel }" name="serialNumber" disabled="disabled">
    </div>
  </div>
   <div class="form-group row">
    <label for="inputEmail3" class="col-sm-2 form-control-label">Installed Date</label>
       <div class="col-sm-10">
        <input class="form-control" value="${product.arrivedDate.getTime().toString() }" name="serialNumber" disabled="disabled">
    </div>
  </div>
  <div class="form-group row">
    <label for="inputEmail3" class="col-sm-2 form-control-label">Client Name</label>
       <div class="col-sm-10">
        <input class="form-control" value="${product.client.clientName }" name="serialNumber" disabled="disabled">
    </div>
  </div>
  <div class="form-group row">
    <label for="inputEmail3" class="col-sm-2 form-control-label">Priority</label>
       <div class="col-sm-10">
      <select class="form-control" name="priority">
         <option>Select Product</option>
         <option value="High">High</option>
         <option value="Medium">Medium</option>
         <option value="Low">Low</option>
      </select>
    </div>
  </div>
  <div class="form-group row">
    <label for="inputEmail3" class="col-sm-2 form-control-label">Description</label>
    <div class="col-sm-10">
      <textarea rows="5" cols="115" name="description"></textarea>
    </div>
  </div>
   <div class="form-group row">
    <label for="inputEmail3" class="col-sm-2 form-control-label">Assign Technician</label>
       <div class="col-sm-10">
      <select class="form-control" name="technicianUserName">
         <option>Select Technician</option>
          <c:forEach items="${technicians}" var ="technician">
             <option value="${technician.username}">${technician.username}</option>
           </c:forEach>
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

<script src="/resources/bootstrap-3.3.6/js/jquery-3.0.0.min.js"></script>
<script type="text/javascript"
	src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script>
<link rel="stylesheet" type="text/css"
	href="/resources/bootstrap-3.3.6/css/bootstrap.min.css">
</head>
<link
	href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />

</html>