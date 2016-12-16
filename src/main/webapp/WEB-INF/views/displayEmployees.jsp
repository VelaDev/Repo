<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">


<head>
  <title>Display Employees | Velaphanda Trading & Projects</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">  
</head>
<body>
	<div class="velaphanda_containter">	
		<c:import url="templates/navbar.jsp"></c:import>
		<div class="container">
		<div class="panel panel-success">    
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center"><b>Employees List</b> </div>
					</h3>
				</div>
				<div class="panel-body">
					<div class="tab-content">
							<div class="row">
					<div class="content">
					
                         <table width="70%" style="border: 3px;background: rgb(243, 244, 248);"><tr><td>
	<table id="example" class="display" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th>Name</th>
     			<th>Position</th>
     			
     			<th>Office</th>
     			<th>Phone</th>
     			<th>Start Date</th>
     			<th>Salary</th>
            </tr>
        </thead>       
    </table>
    </td></tr></table>
						<%-- <tag:paginate max="10" offset="${offset}" count="${count}" 
						uri="displayEmployees" next="&raquo;" previous="&laquo;" /> --%>
					</div>
				</div>
						
				</div><!-- /tab-content -->
									
				</div><!-- /panel body -->
			</div><!--/panel success class-->
		</div><!-- /Container -->
		<!-- Footer -->
		<c:import url="templates/footer.jsp"></c:import>
		<!--/ Footer -->
	</div><!-- / velaphanda_containter -->

</body>

	<link type="text/css" href="<c:url value="/resources/datatables/1.10.13/dataTables.responsive.css"/>">
	<link type="text/css" href="<c:url value="/resources/datatables/1.10.13/juery.dataTables.min.css"/>">
	
	<script type="text/javascript" src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
	
	<script type="text/javascript"src="<c:url value="/resources/datatables/1.10.13/js/jquery.dataTables.min.js" />"></script>
	<script type="text/javascript"src="<c:url value="/resources/datatables/1.10.13/js/datatable.js" />"></script>
</html>
