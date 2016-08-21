
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



<div id="navbar">    
  <nav class="navbar navbar-default navbar-static-top" role="navigation">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
              <a class="navbar-brand glyphicon glyphicon-home"  href='<c:url value="home.html"/>'>Home</a>
            </div>
            
            <div class="collapse navbar-collapse" id="navbar-collapse-1">
                <ul class="nav navbar-nav">
                 <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Employees<span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href='<c:url value="registerEmployee.html"/>'>Add Employee</a></li>
          
          </ul>
        </li>
                   <!--  <li class="active"><a href="#">Active Link</a></li>
                    <li><a href="#">Link</a></li> -->
                  
                    <li class="dropdown">
                      <a href="#" class="dropdown-toggle" data-toggle="dropdown">Customers <b class="caret"></b></a> 
                      
                        <ul class="dropdown-menu">
              
                            <li class="dropdown dropdown-submenu"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Customer Management</a>
								<ul class="dropdown-menu">
                                   
									<li><a href='<c:url value="addClient.html"/>'>Add Customer</a></li>
									<li><a href='<c:url value="updateCustomer.html"/>'>Update Customer</a></li>
									<li><a href='<c:url value="displayCustomers.html"/>'>Display Customers</a></li>
									<li><a href='<c:url value="clientInformation.html"/>'>Search Devices for a customer</a></li>
                                     <li><a href="#">Delete Customer</a></li>                                 
								</ul>
							</li>
                          
                            <li class="dropdown dropdown-submenu"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Device Management</a>
								<ul class="dropdown-menu">
                                    <li><a href='<c:url value="addProduct.html"/>'>Add Device</a></li>
									<li><a href='<c:url value="updateDevice.html"/>'>Update Device</a></li>
									<li><a href='<c:url value="searchDevice.html"/>'>Search Device</a></li>
									<li><a href="#">Delete Device</a></li>
								                         
								</ul>
							</li>                                   
                        </ul>
                    </li>
               
               
                 <li class="dropdown" >
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Spare Parts<span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href='<c:url value="addParts.html"/>'>Add Spares</a></li>
            <li><a href="#">Approved Orders</a></li>
          </ul>
        </li>
        
          <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Tickets<span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href='<c:url value="monitoringTickets.html"/>'>Escalated Tickets</a></li>
            <li><a href='<c:url value="#"/>'>Log Ticket</a></li>
          </ul>
        </li>
        
         
        <li class="dropdown">
        <div  class="loggedin" align="right">
       <ul class="nav navbar-nav navbar-right"  style="margin-left: 884px;">
       <li> <span class="glyphicon glyphicon-user btn-lg "> ${loggedInUser}</span></li>
       <li >
      
       <a href='<c:url value="login.html" ></c:url>' ><span class="glyphicon glyphicon-off"></span> Log Out</a></li>
        <!-- <li align="right"><a href="login.html" onclick="login.html">Logout</a></li> -->
      </ul>
      </div>
        </li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </nav>
</div>

