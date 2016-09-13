
<%@include file="taglibs.jsp" %>
<script type="text/javascript"src="<c:url value="/resources/bootstrap-3.3.6/js/jquery-2.1.4.min.js" />"></script> 
<script>
$(document).ready(function(){
	//$('ul.nav li.dropdown').hover(function() {
  //$(this).find('.dropdown-menu').stop(true, true).delay(200).fadeIn(500);
//}, function() {
 // $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeOut(500);
//});
});


</script>

<style>
 
 .container {
    width: 100%;
}
 
.dropdown-menu > li.kopie > a {
    padding-left:5px;
}
 
.dropdown-submenu {
    position:relative;
}
.dropdown-submenu>.dropdown-menu {
   top:0;left:100%;
   margin-top:-6px;margin-left:-1px;
   -webkit-border-radius:0 6px 6px 6px;-moz-border-radius:0 6px 6px 6px;border-radius:0 6px 6px 6px;
 }
  
.dropdown-submenu > a:after {
  border-color: transparent transparent transparent #333;
  border-style: solid;
  border-width: 5px 0 5px 5px;
  content: " ";
  display: block;
  float: right;  
  height: 0;     
  margin-right: -10px;
  margin-top: 5px;
  width: 0;
}
 
.dropdown-submenu:hover>a:after {
    border-left-color:#555;
 }

.dropdown-menu > li > a:hover, .dropdown-menu > .active > a:hover {
  text-decoration: underline;
}  
  
@media (max-width: 767px) {

  .navbar-nav  {
     display: inline;
  }
  .navbar-default .navbar-brand {
    display: inline;
  }
  .navbar-default .navbar-toggle .icon-bar {
    background-color: #fff;
  }
  .navbar-default .navbar-nav .dropdown-menu > li > a {
    color: red;
    background-color: #ccc;
    border-radius: 4px;
    margin-top: 2px;   
  }
   .navbar-default .navbar-nav .open .dropdown-menu > li > a {
     color: #333;
   }
   .navbar-default .navbar-nav .open .dropdown-menu > li > a:hover,
   .navbar-default .navbar-nav .open .dropdown-menu > li > a:focus {
     background-color: #ccc;
   }

   .navbar-nav .open .dropdown-menu {
     border-bottom: 1px solid white; 
     border-radius: 0;
   }
  .dropdown-menu {
      padding-left: 10px;
  }
  .dropdown-menu .dropdown-menu {
      padding-left: 20px;
   }
   .dropdown-menu .dropdown-menu .dropdown-menu {
      padding-left: 30px;
   }
   li.dropdown.open {
    border: 0px solid red;
   }

}
 
@media (min-width: 768px) {
  ul.nav li:hover > ul.dropdown-menu {
    display: block;
  }
  #navbar {
    text-align: center;
  }
}  



</style>
<nav class="navbar navbar-default">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="col-md-12 col-sm-8 col-md-8 col-sm-offset-1 col-md-offset-1">
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
      <a class="navbar-brand" href='<c:url value="technicianHome.html"/>' ><span class="glyphicon glyphicon-home"></span> Home</a>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Tickets<span class="caret"></span></a>
          <ul class="dropdown-menu">
          <li><a href='<c:url value="technicianHome.html"/>'>Open Tickets</a></li>
          <li><a href='<c:url value=""/>'>Escalated Tickets</a></li>
          <li><a href='<c:url value=""/>'>Closed Tickets</a></li>
          </ul>
        </li>
        
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Order Spares<span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href='<c:url value="order.html"/>'>Make Order</a></li>
            <li><a href='<c:url value=""/>'>Approved Orders</a></li>
           
          </ul>
        </li>
      </ul>
       <div  class="loggedin">
       <ul class="nav navbar-nav navbar-right">
       <li><span class="glyphicon glyphicon-user btn-lg"> ${loggedInUser}</span></li>
       <li><a href='<c:url value="login.html"></c:url>' ><span class="glyphicon glyphicon-off"></span> Log Out</a></li>
        <!-- <li align="right"><a href="login.html" onclick="login.html">Logout</a></li> -->
      </ul>
      </div>
      
      </div>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>