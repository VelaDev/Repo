<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style>
.container {
	width: 100%;
}

.dropdown-menu>li.kopie>a {
	padding-left: 5px;
}

.dropdown-submenu {
	position: relative;
}

.dropdown-submenu>.dropdown-menu {
	top: 0;
	left: 100%;
	margin-top: -6px;
	margin-left: -1px;
	-webkit-border-radius: 0 6px 6px 6px;
	-moz-border-radius: 0 6px 6px 6px;
	border-radius: 0 6px 6px 6px;
}

#navbar {
	margin-left: 4%;
}

.velatp_logo {
	margin-left: 5.5%;
}

.userloggedin {
	margin-right: 6%;
	margin-bottom: 5%;
	margin-top: -4%;
}

.dropdown-submenu>a:after {
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

.loggedin {
	float: right;
}

.dropdown-submenu:hover>a:after {
	border-left-color: #555;
}

.dropdown-menu>li>a:hover, .dropdown-menu>.active>a:hover {
	text-decoration: underline;
}

@media ( max-width : 767px) {
	.navbar-nav {
		display: inline;
	}
	.navbar-default .navbar-brand {
		display: inline;
	}
	.navbar-default .navbar-toggle .icon-bar {
		background-color: #fff;
	}
	.navbar-default .navbar-nav .dropdown-menu>li>a {
		color: red;
		background-color: #ccc;
		border-radius: 4px;
		margin-top: 2px;
	}
	.navbar-default .navbar-nav .open .dropdown-menu>li>a {
		color: #333;
	}
	.navbar-default .navbar-nav .open .dropdown-menu>li>a:hover,
		.navbar-default .navbar-nav .open .dropdown-menu>li>a:focus {
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

@media ( min-width : 768px) {
	ul.nav li:hover>ul.dropdown-menu {
		display: block;
	}
	#navbar {
		text-align: center;
	}
}
</style>

</head>



<body>
	<div id="container">


		<div class="sidebar">
			<ul id="nav">
				<li><a class="selected" href="index.html">Dashboard</a></li>
				<li><a href="ticketdemo.html">Tickets Details</a></li>
			</ul>
		</div>
		<div class="content">

			<div class="container">


				<c:import url="templates/navbar.jsp"></c:import>

				<div class="pie_content">
					<div id="ticket_details_pie" style="width: 500px; height: 300px">

					</div>
				</div>

			</div>
			<!--/Container-->
		</div>
		<!--/Content-->

	</div>


</body>


<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script>

   google.load("visualization", "1", {packages:["corechart"]});

   google.setOnLoadCallback(drawChart);

   function drawChart() {

    // Create and populate the data table.

    var data = google.visualization.arrayToDataTable([

      ['Tickts', 'Percent'],

      ['Open Tickets', 17.36],

      ['Closed Tickets', 15.62],

      ['Logged Tickets', 13.63],

      ['Escalated Tickets', 11.25]
     
    ]);

    var options = {

      title: 'Tickets overall'

    };

     // Create and draw the visualization.

    new google.visualization.PieChart(

      document.getElementById('ticket_details_pie')).draw(data, options);

  }

</script>

<script type="text/javascript"
	src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js" />"></script>
<link
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />

<link href="<c:url value="/resources/custom/css/pie_chart.css" />"
	rel="stylesheet" type="text/css" />

</html>