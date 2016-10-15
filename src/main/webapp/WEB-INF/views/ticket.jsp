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
<div class="alert alert-info" role="alert">
<c:if test="${not empty retMessage }">
  <c:out value="${ retMessage}">
 </c:out>
 </c:if>
 </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">
                <div align="center"><b>Log Ticket</b> </div>
                <!-- <div align="right"><a href="">Think of something</a></div> -->
            </h3>
        </div>
   <div class="panel-body">
       <form action="searchSerialNumber" method="post">
        <div class="row">
        
           <div class="col-xs-2 form-control-label" align="center">Serial Number:</div>
            <div class="col-xs-3">
                <input type="text" name="serialNumber" id="serialNumber" class="form-control input-sm">
            </div>
            <div class="col-xs-2">
               <input class="btn btn-success" type='submit' value='Search'/>
            </div>
  
          </div>
   <hr>
   </form>
   
   <form:form method="post" action="logTicket" role="form" modelAttribute="logTicket" id="form">
					
		 <div class="row">
                    <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Serial No:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" name="device" value="${product.serialNumber }">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Machine Model</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${product.productModel}">
   </div>
   </div>
	</div><br>	
	 <div class="row">
                    <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Contract Start Date:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${product.startDate}">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Contract End Date:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${product.endDate}">
   </div>
   </div>
	</div><br>	
	<div class="row">
                    <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Customer Name:</label>
     
   </div>
   <div class="col-xs-3">
   <input type="text" class="form-control input-sm" value="${product.client.clientName }">
   </div>
   
      <div class="col-xs-2 form-control-label">
    <label  >Priority:</label>
     
   </div>
   <div class="col-xs-3">
   <select class="form-control" name="priority">
         <option>Select Product</option>
         <option value="High">High</option>
         <option value="Medium">Medium</option>
         <option value="Low">Low</option>
      </select>
   </div>
   </div>
	</div><br>	
	<div class="row">
                    <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Assign Technician:</label>
     
   </div>
   <div class="col-xs-3">
   <select class="form-control" name="technicianUserName">
         <option>Select Technician</option>
          <c:forEach items="${technicians}" var ="technician">
             <option value="${technician.username}">${technician.username}</option>
           </c:forEach>
      </select>
   </div>
   </div>
	</div><br>
	
	<div class="row">
                    <div class="col-xs-12">
   <div class="col-xs-2 form-control-label">
    <label >Description:</label>
     
   </div>
   <div class="col-xs-3">
     <textarea rows="3" cols="103" name="description"></textarea>
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