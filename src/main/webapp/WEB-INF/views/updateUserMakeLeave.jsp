<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Update Leave | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/custom/css/vela_custom.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/css/datepicker.min.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap-3.3.7/fonts/font-awesome.min.css" />" />
	
</head>
<body>
	<div class="velaphanda_containter" id="velaphanda_containter">
		<c:import url="templates/usernavbar.jsp"></c:import>
		<div class="container">
		<c:if test="${not empty retMessage }">
				<div class="alert alert-info" role="alert">
					<c:out value="${ retMessage}">
					</c:out>
				</div>
			</c:if>
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="center">
							<b>Update Leave</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">

					<form:form class="well form-horizontal" method="POST"
						action="updateUserMakeLeave" modelAttribute="updateUserMakeLeave" id="updateUserMakeLeave">
						
						<!-- Text input Leave ID-->
						<div class="form-group">
							<label class="col-xs-3 control-label">Leave ID</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
								  <span
										class="input-group-addon"> <span
										class="glyphicon glyphicon-barcode"></span></span>
									<input type='text' class="form-control" name="leaveID"
										id="leaveID"  value="${leave.leaveID}" readonly="readonly"/>
								</div>
							</div>
						</div>
						
						<!-- Text input Leave ID-->
						<div class="form-group">
							<label class="col-xs-3 control-label">Email</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
								  <span
										class="input-group-addon"> <span
										class="glyphicon glyphicon-barcode"></span></span>
									<input type='text' class="form-control" name="technicianUserName"
										id="leaveID"  value="${leave.employee.email}" readonly="readonly"/>
								</div>
							</div>
						</div>
						<!-- Select type Leave Type-->
						<div class="form-group">
							<label class="col-md-3 control-label">Type of Leave</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-list"></i></span> <select name="leaveType"
										id="leaveID" class="form-control selectpicker">
										<option value="${leave.leaveType}">${leave.leaveType}</option>
										<option value="Annual Vacation Leave">Annual Vacation Leave</option>
										<option value="Sick Leave">Sick Leave</option>
										<option value="Emergency Leave">Emergency Leave</option>
									</select>
								</div>
							</div>
						</div>

						<!-- Text input First Date Leave-->
						<div class="form-group">
							<label class="col-xs-3 control-label">Leave Start Date</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group input-append date" id="startDatePicker">
									<input type='text' class="form-control" name="startDate"
										id="startDate" placeholder="YYYY-MM-DD" value="${leave.startDate}" /> <span
										class="input-group-addon"> <span
										class="glyphicon glyphicon-calendar"></span>
									</span>
								</div>
							</div>
						</div>
						<!-- Text input Last Date Leave-->
						<div class="form-group">
							<label class="col-md-3 control-label">Leave End Date</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group input-append date" id="endDatePicker">
									<input type='text' class="form-control" name="endDate"
										id="endDate" placeholder="YYYY-MM-DD" value="${leave.endDate}"/> <span
										class="input-group-addon"> <span
										class="glyphicon glyphicon-calendar"></span>
									</span>
								</div>
							</div>
						</div>
						<!-- Text input Contact Number well on leave-->
						<div class="form-group">
							<label class="col-md-3 control-label">Contact Number</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-earphone"></i></span> <input
										id="contactNumber" name="contactNumber"
										placeholder="Contact Number during absence"
										class="form-control" type="text" onkeypress="return isNumber(event)" value="${leave.contactNumber}">
								</div>
							</div>
						</div>
						<!-- Text input Address well on leave-->
						<div class="form-group">
							<label class="col-md-3 control-label">Address</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-home"></i></span> <input id="address"
										name="address" placeholder="Address during absence"
										class="form-control" type="text" value="${leave.address}">
								</div>
							</div>
						</div>
						<br>
						<div class="form-group row">
							<div class="col-sm-offset-3 col-sm-6">
								<input type="submit" value="Update Leave"
									class="btn btn-primary btn-block btn-lg" tabindex="9"
									id="updateLeave">
							</div>
						</div>


					</form:form>

				</div>
				<!-- /panel body -->
			</div>
			<!--/panel success class-->
		</div>
		<!-- /Container -->
		<!-- Footer -->
		<c:import url="templates/footer.jsp"></c:import>
		<!--/ Footer -->
	</div>
	<!-- / velaphanda_containter -->


	<!-- Scripts -->
	<script type="text/javascript"
		src="<c:url value="/resources/jquery/1.12.4/jquery.min.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrapValidator-0.5.3/js/bootstrapValidator.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap-datepicker.min.js" />"></script>
	<!-- /Scripts -->

<!--Compare start, end and installation date between each other-->
<script type="text/javascript">

$("#startDate, #endDate").datepicker();

$("#endDate").change(function () {

var startDate = document.getElementById("startDate").value;
var endDate = document.getElementById("endDate").value;

if ((Date.parse(endDate) < Date.parse(startDate))) {
    alert("Leave End Date should not be a past date");
    document.getElementById("endDate").value = "";
} 


});


</script>


<script type="text/javascript">
		$(document).ready(function() {
			$('#startDatePicker').datepicker({
				format : "yyyy-mm-dd",
				//startDate: 'd0',
		        autoclose: true
			});
		});
</script>

<script type="text/javascript">
	$(document).ready(function() {
		$('#endDatePicker').datepicker({
			format : "yyyy-mm-dd",
			//startDate: 'd0',
	        autoclose: true
		});
	});
</script>

<script>
$(document).ready(function() {
	$('#updateUserMakeLeave').bootstrapValidator({
	   //framework: 'bootstrap',
    icon: {
        valid: 'glyphicon glyphicon-ok',
        invalid: 'glyphicon glyphicon-remove',
        validating: 'glyphicon glyphicon-refresh'
    },
        fields: {
        	leaveType: {
                validators: {
                    notEmpty: {
                        message: 'Leave type is required,and can not be empty'
                    }
                }
            },
            startDate: {
                validators: {
                    notEmpty: {
                        message: 'Leave start date is required'
                    },
                    date: {
                        format: 'YYYY-MM-DD',
                        //max: 'endDate',
                        message: 'Leave start date is not a valid'
                    }
                }
            },
            endDate: {
                validators: {
                    notEmpty: {
                        message: 'Leave end date is required'
                    },
                    date: {
                        format: 'YYYY-MM-DD',
                        //min: 'startDate',
                        message: 'Leave end date is not a valid'
                    }
                }
            },
            contactNumber : {
				validators : {
					notEmpty : {
						message : 'Please enter 10 digits for contact number'
					},
					phone : {
						country : 'US',
						message : 'Please enter 10 digits for contact number'
					},
					regexp: {
						
						regexp: /^0[0-9].*$/,
						message :'Tellphone number must start with 0 (Zero)'
					}
				}
			},			
			address: {
                validators: {
				stringLength : {
							min : 3,
					}, 					
                    notEmpty: {
                        message: 'Address is required, and can not be empty'
                    }
                }
            }
        }
    })        
}); 

</script>

<script type="text/javascript">

	function isNumber(evt) {
	    evt = (evt) ? evt : window.event;
	    var charCode = (evt.which) ? evt.which : evt.keyCode;
	    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
	        return false;
	    }
	    return true;
	}
	
</script>

</body>
</html>
