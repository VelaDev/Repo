<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Error Login | Velaphanda Trading & Projects</title>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/custom/css/login.css" />" />
<link
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
<link
	href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />"
	rel="stylesheet" type="text/css" />
</head>
<body>
	<div class="velaphanda_containter">
		<div class="container">
			<br />
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Error Login | Velaphanda Trading & Projects</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tabContent">
						<div class="vela_motto">
							<p>
								<span class="motto">Velaphanda</span> <span class="techsystem">Technical
									System</span>
							</p>
						</div>
						<div class="login-page">
							<div class="form">

								<div class="mainlogo">
									<img src="resources/images/mainlogo.jpg" class="img-responsive"
										alt="" />
								</div>
								<div class="errorLogin">
									<h2>Something went wrong!!</h2>
									<b>Please report error below to system developer.</b>
									<p>Error Message : ${exception}</p>
									or <a href="login.html">Login</a> with correct credentials
								</div>
							</div>
						</div>
						<!-- Footer -->
						<div class="footerLogin">
							<c:import url="templates/footer.jsp"></c:import>
						</div>
						<!--/ Footer -->
					</div>
					<!-- /tab-content -->
				</div>
				<!-- /panel body -->
			</div>
			<!--/panel success class-->

		</div>
		<!-- /Container -->

	</div>
	<!-- velaphanda_containter -->

</body>
</html>

