<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Error Login</title>

<script src="/resources/bootstrap-3.3.6/js/jquery-3.0.0.min.js"></script>
<script type="text/javascript"
src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/custom/css/login.css" />" />
<body>
	<div class="container">
		<div class="row" id="pwd-container">
			<div class="col-md-4"></div>

			<div class="col-md-6">
				<section class="login-form">
					<form method="post" action="error" role="login">
						<img src="resources/bootstrap-3.3.6/images/logo.jpg"
							class="img-responsive" alt="" />
							<div class="errorLogin">
								 <h2>You are not registered to use the system. Consults Administrator</h2> or <a href="login.html">Login</a> with correct credentials
							</div>				
					</form>
					
					<div class="form-links" style="margin-right: 160px">
						<a href="www.velatp.co.za">www.velatp.co.za</a>
					</div>
				</section>
			</div>
		  <div class="col-md-4"></div>
		</div>
	</div>
  </body>
</html>