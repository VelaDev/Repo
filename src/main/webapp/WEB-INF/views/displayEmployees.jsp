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
						<table class="table table-hover ">
							<thead style="background-color: #bce8f1;">
								<tr class='clickable-row'>
								   <th>#</th>
									<th>First Name</th>
									<th>Last Name</th>
									<th>Email</th>
									<th>Role</th>
									<th>Edit</th>
									<th>Deactivate</th>

								</tr>
							</thead>
							<tbody>
								<c:forEach items="${displayEmployees}" var="employee" varStatus="itr">
									<tr>
									   <th><c:out value="${offset + itr.index +1 }"></c:out>
										<th><c:out value="${employee.firstName}" /></th>
										<th><c:out value="${employee.lastName}" /></th>
										<th><c:out value="${employee.email}" /></th>
										<th><c:out value="${employee.role}" /></th>

										<th><a href="updateEmployee?email=<c:out value='${employee.email}'/>">edit</a></th>
                                        <th><a href="deactivateEmployee?email=<c:out value='${employee.email}'/>" >deactivate</a></th>
									</tr>
								</c:forEach>
							</tbody>
					
						</table>
						<tag:paginate max="10" offset="${offset}" count="${count}" 
						uri="displayEmployees" next="&raquo;" previous="&laquo;" />
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
</html>
