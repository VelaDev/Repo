<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:import url="templates/navbar.jsp"></c:import>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="/resources/bootstrap-3.3.6/js/jquery-3.0.0.min.js"></script>
 <script type="text/javascript"src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script> 
 <link rel="stylesheet" type="text/css" href="/resources/bootstrap-3.3.6/css/bootstrap.min.css">
 
 <style type="text/css">
        .myrow-container {
            margin: 20px;
        }
    </style>
</head>
<link href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" /> 
	
	<body class=".container-fluid">
<div class="container myrow-container" style="width:90%">
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">
                <div align="left"><b>Open Tickets</b> </div>
                <div align="right"><a href="">Think of something</a></div>
            </h3>
        </div>

<div class="panel-body">
            <%-- <c:if test="${empty ticketList}">
                No open tickets
            </c:if>
            <c:if test="${not empty ticketList}">  --%>  
            
                <form action="searchTechnician">
                    <div class="row">
                      <div class="col-md-6"><div class="col-md-6">Search Technician:</div><div class="col-md-6"> 
                      <input type="text" name="username" id="username" class="form-control"> </div></div>
                      <div class="col-md-4"><input class="btn btn-success" type='submit' value='Search'/></div>
                    </div>
                    <br>
                </form>             
                                
                <table class="table table-striped custab">
                    <thead style="background-color: #bce8f1;">
                    <tr>
                        <th>Ticket No</th>
                        <th>Description</th>
                        <!-- <th>Date</th> -->
                        <th>Status</th>
                        <th>Technician</th>
                        <th>Edit</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${ticketList}" var="ticket">
                        <tr>
                            <th><c:out value="${ticket.ticketNumber}"/></th>
                            <th><c:out value="${ticket.description}"/></th>
                            <%-- <th><c:out value="${ticket.dateTime}"/></th> --%>
                            <th><c:out value="${ticket.status}"/></th>
                            <th><c:out value="${ticket.employee.getUsername()}"/></th> 
                            <th><a href="editEmployee?id=<c:out value='${emp.id}'/>">Edit</a></th>                          
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            <%-- </c:if> --%>
        </div>
        </div>
        </div>
</body>
</html>