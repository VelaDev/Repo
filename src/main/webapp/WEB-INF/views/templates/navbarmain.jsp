
<%@include file="taglibs.jsp" %>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
			<div class="container-fluid">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target="#bs-example-navbar-collapse-1">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href='<c:url value="index.html"/>' ><span class="glyphicon glyphicon-home"></span> Home</a>
				</div>

				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse"
					id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">
					<security:authorize access="hasRole('ROLE_GROUP_LEADER') or hasRole('ROLE_ADMIN')">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown"><span class="glyphicon glyphicon-user"></span> Manage Group<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href='<c:url value="showMembers.html"/>'>View Members</a></li>
								<li><a href='<c:url value="sendMessage.html"/>'>Send Message To Member</a></li>
								<li class="divider"></li>
								<li><a href='<c:url value="addMember.html" />' >Add Member</a></li>
								<li><a href="#">Remove Member</a></li>
								<li class="divider"></li>
								<li><a href='<c:url value="showMeetings.html" />' >View Meetings</a></li>
								<li><a href='<c:url value="addNewMeeting.html" />' >Add Meeting</a></li>
							</ul></li>
							</security:authorize>
							<security:authorize access="hasRole('ROLE_LEAD_PROGRAMMER') or hasRole('ROLE_GROUP_LEADER') or hasRole('ROLE_PROGRAMMER') or hasRole('ROLE_ADMIN')">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown"><span class="glyphicon glyphicon-tasks"></span> Manage Tasks <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href='<c:url value="addTask.html"/>' ><span class="glyphicon glyphicon-plus"></span> Add Task</a></li>
								<li class="divider"></li>
								<li><a href="#"><span class="glyphicon glyphicon-th-list"></span> View Tasks</a></li>
								<li><a href="#"><span class="glyphicon glyphicon-ok"></span> View Completed Tasks</a></li>
							</ul></li>
							</security:authorize>
					</ul>
					<security:authorize access="hasRole('ROLE_GUEST') or hasRole('ROLE_ADMIN')">
					<form:form class="navbar-form navbar-left" role="search" method="post">
						<div class="form-group">
							<input type="text" class="form-control" placeholder="Search Member" name="query">
						</div>
						<button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search"></span></button>
					</form:form>
					</security:authorize>
					<ul class="nav navbar-nav navbar-right">
					<security:authorize access="isAnonymous() or hasRole('ROLE_ADMIN')">
						<li><a href='<c:url value="/login.html"></c:url>' ><span class="glyphicon glyphicon-pencil"></span> Sign in</a></li>
						<li><p class="navbar-text">or</p></li>
						<li><a href='<c:url value="signUpNow.html"/>'>Sign Up</a></li>
						</security:authorize>
						<security:authorize access="hasRole('ROLE_LEAD_PROGRAMMER') or hasRole('ROLE_GROUP_LEADER') or hasRole('ROLE_PROGRAMMER') or hasRole('ROLE_ADMIN')">
						<li><p class="navbar-text">Signed in as: <a href="showProfile.html" class="navbar-link"><security:authentication property="name"/></a></p></li>
						<li><a href='<c:url value="/logout"></c:url>' ><span class="glyphicon glyphicon-off"></span> Log Out</a></li>
						</security:authorize>
					
							
					</ul>
				</div>
				<!-- /.navbar-collapse -->
			</div>
			<!-- /.container-fluid -->
</nav>