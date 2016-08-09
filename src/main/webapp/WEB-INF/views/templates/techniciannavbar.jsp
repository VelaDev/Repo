
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