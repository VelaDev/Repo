<%@include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Leave | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">


<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet" >
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/bootstrap-3.3.7/css/datepicker.min.css" />">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/bootstrap-3.3.7/css/formValidation.min.css" />"> 

</head>
<body>
	<div class="velaphanda_containter" id="velaphanda_containter">
		<c:import url="templates/techniciannavbar.jsp"></c:import>
		<div class="container">
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<div align="left">
							<b>Make Leave</b>
						</div>
					</h3>
				</div>
				<div class="panel-body">

					<form:form class="well form-horizontal" method="POST"
						action="leave" modelAttribute="leave" id="makeLeave">

							<!-- Select type Leave Type-->
						<div class="form-group">
							<label class="col-md-3 control-label">Type of Leave</label>
							<div class="col-md-6 selectContainer">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-list"></i></span> <select name="leaveID"
										id="leaveID" class="form-control selectpicker">
										<option value="">Select Leave</option>
										<option value="Annual Vacation">Annual Vacation</option>
										<option value="Sick Leave">Sick Leave</option>
										<option value="Family Problems">Family Problems</option>
									</select>
								</div>
							</div>
						</div>

						<!-- Text input First Date Leave-->
						<div class="form-group">
							<label class="col-xs-3 control-label">First Date Leave</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group input-append date" id="startDatePicker">
									<input type='text' class="form-control" name="startDate"
										id="startDate" placeholder="YYYY-MM-DD" /> <span
										class="input-group-addon"> <span
										class="glyphicon glyphicon-calendar"></span>
									</span>
								</div>
							</div>
						</div>
						<!-- Text input Last Date Leave-->
						<div class="form-group">
							<label class="col-md-3 control-label">Last Date Leave</label>
							<div class="col-md-6 inputGroupContainer">
								<div class="input-group input-append date" id="endDatePicker">
									<input type='text' class="form-control" name="endDate"
										id="endDate" placeholder="YYYY-MM-DD" /> <span
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
										class="glyphicon glyphicon-home"></i></span> <input
										id="contactNumber" name="contactNumber"
										placeholder="Contact Number during absence"
										class="form-control" type="text" onkeypress="return isNumber(event)">
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
										class="form-control" type="text">
								</div>
							</div>
						</div>
						<br>
						<div class="form-group row">
							<div class="col-sm-offset-3 col-sm-6">
								<input type="submit" value="Make Leave"
									class="btn btn-primary btn-block btn-lg" tabindex="9"
									id="addLeave">
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
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap-datepicker.min.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/formValidation.min.js"/>"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/bootstrap-3.3.7/js/bootstrap.min.js"/>"></script> 

	<!-- /Scripts -->

	
<script>
$(document).ready(function() {
    $('#startDatePicker')
        .datepicker({
            format: 'yyyy-mm-dd'
        })
        .on('changeDate', function(e) {
            // Revalidate the start date field
            $('#makeLeave').formValidation('revalidateField', 'startDate');
        });

    $('#endDatePicker')
        .datepicker({
            format: 'yyyy-mm-dd'
        })
        .on('changeDate', function(e) {
            $('#makeLeave').formValidation('revalidateField', 'endDate');
        });

    $('#makeLeave')
        .formValidation({
            framework: 'bootstrap',
            icon: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                leaveID: {
                    validators: {
                        notEmpty: {
                            message: 'Leave type is required,and can not be empty'
                        }
                    }
                },
                startDate: {
                    validators: {
                        notEmpty: {
                            message: 'The start date is required'
                        },
                        date: {
                            format: 'YYYY-MM-DD',
                            max: 'endDate',
                            message: 'The start date is not a valid'
                        }
                    }
                },
                endDate: {
                    validators: {
                        notEmpty: {
                            message: 'The end date is required'
                        },
                        date: {
                            format: 'YYYY-MM-DD',
                            min: 'startDate',
                            message: 'The end date is not a valid'
                        }
                    }
                },
				contactNumber : {
					validators : {
						stringLength : {
							max : 10,
							min : 10,
						},
						notEmpty : {
							message : 'Contact Number is required, and can not be empty'
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
        .on('success.field.fv', function(e, data) {
            if (data.field === 'startDate' && !data.fv.isValidField('endDate')) {
                // Revalidate the end date
                data.fv.revalidateField('endDate');
            }

            if (data.field === 'endDate' && !data.fv.isValidField('startDate')) {
                // Need to revalidate the start date
                data.fv.revalidateField('startDate');
            }
        });
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
