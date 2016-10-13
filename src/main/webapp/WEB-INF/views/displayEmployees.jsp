<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
        .myrow-container {
            margin: 20px;
           
        }
    </style>

   <c:import url="templates/navbar.jsp"></c:import>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<div class="container myrow-container" style="width:90%">
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">
                <div align="center"><b>Customer List</b> </div>
                <!-- <div align="right"><a href="">Think of something</a></div> -->
            </h3>
        </div>
   <div class="panel-body">
   
      <div class="row">   
                 <div class="content">                     
                <table class="table table-hover ">
                    <thead style="background-color: #bce8f1;">
                    <tr class='clickable-row'>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Email</th>
                        <th>Role</th>
                         
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${employeeList}" var="employee">
                        <tr>
                            <th><c:out value="${employee.firstName}"/></th>
                            <th><c:out value="${employee.lastName}"/></th>
                            <th><c:out value="${employee.email}"/></th>
                            <th><c:out value="${employee.role}"/></th> 
                                                     
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                </div>
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