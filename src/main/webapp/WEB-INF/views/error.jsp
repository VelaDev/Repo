<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Error Page</title>
<script src="/resources/bootstrap-3.3.6/js/jquery-3.0.0.min.js"></script>
        <script type="text/javascript"src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script> 
        <link rel="stylesheet" type="text/css" href="/resources/bootstrap-3.3.6/css/bootstrap.min.css">
</head>
<body>
<form action="error" method="post">
 <table>
       <tr>
           <td>
            <h2>You are not registered to use the system. Consults Administrator</h2>
           </td>
       </tr>
 </table>
 </form>
</body>
</html>