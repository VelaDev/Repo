<%@include file="templates/taglibs.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Success or Error</title>
</head>
<c:import url="templates/navbar.jsp"></c:import>
<body>
<div class="container myrow-container">
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">
                <div align="left"><b></b> </div>
                <!-- <div align="right"><a href="">Think of something</a></div> -->
            </h3>
        </div>

<div class="panel-body">

            <c:if test="${not empty client}">
						<div class="alert alert-success">
						<c:out value="${client}"></c:out>
						</div>
                 </c:if>
                 
                 </div>
                 </div>
                 </div>
</body>
</html>