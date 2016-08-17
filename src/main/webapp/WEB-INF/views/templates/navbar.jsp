
<%@include file="taglibs.jsp" %>

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
    <!-- <div class="col-xs-12 col-sm-8 col-md-8 col-sm-offset-2 col-md-offset-2"> -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
      <a class="navbar-brand" href='<c:url value="home.html"/>' ><span class="glyphicon glyphicon-home"></span> Home</a>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Employees<span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href='<c:url value="registerEmployee.html"/>'>Add Employee</a></li>
            <!-- <li><a href="#">Update Employee</a></li>
            <li><a href="#">Show All Employees</a></li>
            <li><a href="#">All Technicians</a></li -->
            <!-- <li role="separator" class="divider"></li> -->
          </ul>
        </li>
        
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Customers<span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href='<c:url value="addClient.html"/>'>Add Customer</a></li>
            <li class="dropdown-submenu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Installation<span></span></a>
                <ul class="dropdown-menu">
                  <li><a href='<c:url value="addProduct.html"/>'>Device Installation</a></li>
                <%--   <li><a href='<c:url value="clientInformation.html"/>'>Search Client</a></li> --%>
                </ul>
              </li>
              <li><a href='<c:url value="clientInformation.html"/>'>Search Customer</a></li>
             <!--  <li><a href="#">Update Client</a></li>
            <li><a href="#">Show All Clients</a></li>
            <li><a href="#">Deactivate Client</a></li> -->
            <li role="separator" class="divider"></li>
            <!-- <li><a href="#">Separated link</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="#">One more separated link</a></li> -->
          </ul>
        </li>
        
        <%-- <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Products<span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href='<c:url value="addProduct.html"/>'>Add Product</a></li>
            <li><a href="#">Update Product</a></li>
            <li><a href='<c:url value="showProducts.html"/>'>Show All Products</a></li>
          </ul>
        </li> --%>
        
        
        <li class="dropdown">
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
        <li>
        
      </ul>
      <div  class="loggedin" align="right">
       <ul class="nav navbar-nav navbar-right">
       <li><span class="glyphicon glyphicon-user btn-lg "> ${loggedInUser}</span></li>
       <li><a href='<c:url value="login.html"></c:url>' ><span class="glyphicon glyphicon-off"></span> Log Out</a></li>
        <!-- <li align="right"><a href="login.html" onclick="login.html">Logout</a></li> -->
      </ul>
      </div>
      </div>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>