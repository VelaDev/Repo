<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
 


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Login</title>
        
        <script src="/resources/bootstrap-3.3.6/js/jquery-3.0.0.min.js"></script>
        <script type="text/javascript"src="<c:url value="/resources/bootstrap-3.3.6/js/bootstrap.min.js" />"></script> 
        <link rel="stylesheet" type="text/css" href="/resources/bootstrap-3.3.6/css/bootstrap.min.css">
       
	    <style type="text/css">
	    @CHARSET "UTF-8";

.progress-bar {
    color: #333;
} 

 {
    -webkit-box-sizing: border-box;
	   -moz-box-sizing: border-box;
	        box-sizing: border-box;
	outline: none;
}

    .form-control {
	  position: relative;
	  font-size: 16px;
	  height: auto;
	  padding: 10px;
		@include box-sizing(border-box);

		&:focus {
		  z-index: 2;
		}
	}

body {
	background: url(http://i.imgur.com/GHr12sH.jpg) no-repeat center center fixed;
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;
}

.login-form {
	margin-top: 60px;
}

form[role=login] {
	color: #5d5d5d;
	background: #f2f2f2;
	padding: 26px;
	border-radius: 10px;
	-moz-border-radius: 10px;
	-webkit-border-radius: 10px;
	width: 380px;
}
	form[role=login] img {
		display: block;
		margin: 0 auto;
		margin-bottom: 35px;
	}
	form[role=login] input,
	form[role=login] button {
		font-size: 20px;
		margin: 18px 0;
	}
	form[role=login] > div {
		text-align: center;
	}
	
.form-links {
	text-align: center;
	margin-top: 1em;
	margin-bottom: 50px;
}
	.form-links a {
		color: #fff;
	}
</style> 
<link href="<c:url value="/resources/bootstrap-3.3.6/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" /> 
	
    <body >
    <div class="container">
  
  <div class="row" id="pwd-container">
    <div class="col-md-4"></div>
    
    <div class="col-md-6">
      <section class="login-form">
        <form:form method="post" action="authenticate" role="login" modelAttribute="authenticate">
          <img src="resources/bootstrap-3.3.6/images/image001.jpg" class="img-responsive" alt="" width="110" />
          
          <input type="text" id="txtUsername" name="username" placeholder="Username" required class="form-control input-lg" />
          
          <input type="password" class="form-control input-lg" name ="password"id="password" placeholder="Password" required="" />
       
          <button type="submit" name="go" class="btn btn-lg btn-primary btn-block">Sign in</button>
          <div>
          </div>
          
						
          
        </form:form>
        
        <div class="form-links" style="margin-right:160px">
          <a href="www.velatp.co.za">www.velatp.co.za</a>
        </div>
      </section>  
      </div>
      
      <div class="col-md-4"></div>
      

  </div>     
 
</div>
</body>
</html>