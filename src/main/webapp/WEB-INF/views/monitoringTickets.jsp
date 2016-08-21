<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <style type="text/css">
        .myrow-container {
            margin: 20px;
        }
    </style>
</head>
 <c:import url="templates/navbar.jsp"></c:import>
<body class=".container-fluid">
<div class="container myrow-container" style="width:90%">
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">
                <div align="left"><b>Monitoring Tickets</b> </div>
            </h3>
        </div>
        <div class="panel-body">
            <c:if test="${empty employeeList}">
                There are no tickets at the moment
            </c:if>
            <c:if test="${not empty employeeList}">   
            
                <form action="searchEmployee">
                    <div class="row">
                      <div class="col-md-6"><div class="col-md-6">Search Technician:</div><div class="col-md-6"> <input type="text" name="searchName" id="searchName"> </div></div>
                      <div class="col-md-4"><input class="btn btn-success" type='submit' value='Search'/></div>
                    </div>
                </form>             
                                
                <table class="table table-hover table-bordered">
                    <thead style="background-color: #bce8f1;">
                    <tr>
                        <th>Id</th>
                        <th>Name</th>
                        <th>Age</th>
                        <th>Salary</th>

                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${employeeList}" var="emp">
                        <tr>
                            <th><c:out value="${emp.id}"/></th>
                            <th><c:out value="${emp.name}"/></th>
                            <th><c:out value="${emp.age}"/></th>
                            <th><c:out value="${emp.salary}"/></th> 
                         
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div></div>

</body>
<link href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
	<script src="/resources/bootstrap-3.3.6/js/jquery-3.0.0.min.js"></script>
        <script type="text/javascript"src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script> 
        <link rel="stylesheet" type="text/css" href="/resources/bootstrap-3.3.6/css/bootstrap.min.css">
</html>