<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Three login attempt with wrong Credentials | Velaphanda Trading & Projects</title>

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/custom/css/login.css" />" />
<link href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" rel="stylesheet" type="text/css" />

<body>

	<div class="velaphanda_containter">
		<div class="container">
			<br />
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Login attempt with wrong Credentials | Velaphanda Trading & Projects</b>
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
								<form method="post" action="loginattempted" role="login">
									<div class="mainlogo">
										<img src="resources/images/mainlogo.jpg"
											class="img-responsive" alt="" />
									</div>
									<div class="errorLogin"> 
										  <c:if test="${not empty attempMessage }">
				                              <div class="alert alert-danger" role="alert">
					                              <c:out value="${ attempMessage}">
					                              </c:out>
				                              </div>
			                              </c:if>
									</div>
								</form>
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
