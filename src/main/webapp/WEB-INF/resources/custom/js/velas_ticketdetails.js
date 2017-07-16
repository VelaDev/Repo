/**
 * Purpose: Interact with the html pages and create communication between server and client side 
 * Author : Fenya Tlala
 * Company: Velaphanda 
 * Last Date Modified:09-06-2017
 */
/*Data tables on the system*/

// myDatatable table -->
$(document).ready(function() {
	$('#myDatatable').DataTable({
		"jQueryUI" : true,
		"pagingType" : "full_numbers",
		"lengthMenu" : [ [ 5, 10, 50, -1 ], [ 5, 10, 50, "All" ] ]
	/* few more options are available to use */
	});
});

// resolved Details table -->
$(document).ready(function() {
	$('#resolvededDetails').DataTable({
		"jQueryUI" : true,
		"pagingType" : "full_numbers",
		"lengthMenu" : [ [ 5, 10, 50, -1 ], [ 5, 10, 50, "All" ] ]
	/* few more options are available to use */
	});
});

// Boot Stock Table -->
$(document).ready(function() {
	$('#bStock').DataTable({
		"jQueryUI" : true,
		"pagingType" : "full_numbers",
		"lengthMenu" : [ [ 5, 10, 50, -1 ], [ 5, 10, 50, "All" ] ]
	/* few more options are available to use */
	});
});

// Site Stock Table -->
$(document).ready(function() {
	$('#sStock').DataTable({
		"jQueryUI" : true,
		"pagingType" : "full_numbers",
		"lengthMenu" : [ [ 5, 10, 50, -1 ], [ 5, 10, 50, "All" ] ]
	/* few more options are available to use */
	});
});

// Show solution details when status change to resolved -->
$('#status').change(function() {
	var opval = $(this).val();
	if (opval == "Resolved") {
		$('#solutionDetails').modal("show");
	}
});

$('#status').change(function() {
	var opval = $(this).val();
	if (opval == "Escalated") {
		$('#escalatedSolutions').modal("show");
	}
});

$('#status').change(function() {
	var opval = $(this).val();
	if (opval == "Awaiting Spares") {
		$('#awaitingSparesSolutions').modal("show");
	}
});

//"order Status" Table -->
$(document).ready(function() {
	$('#orderSts').DataTable({
		"jQueryUI" : true,
		"pagingType" : "full_numbers",
		"lengthMenu" : [ [ 5, 10, 50, -1 ], [ 5, 10, 50, "All" ] ]
	/* few more options are available to use */
	});
});

// Show solution details when status change to resolved -->
$(function(){

	$('#orderNumber').click(function(){
	  $('#orderNo').modal('show');
	  return false;
	})

});

/* End Data tables on the system*/



// Take selected used part numbers only -->
function checkUsedPartNumbers() {

	var checkboxes = document.getElementsByName('selectedItem');
	var checkboxesChecked = [];
	// loop over them all
	for (var i = 0; i < checkboxes.length; i++) {
		// And stick the checked ones onto an array...
		if (checkboxes[i].checked) {
			checkboxesChecked.push(checkboxes[i].value);
		}
	}
	document.getElementById("usedPartNumbers").value = checkboxesChecked;

}

// Validate action and used part numbers -->
$(document)
		.ready(
				function() {

					$('#updateResolved')
							.validate(
									{
										errorClass : "error-class",
										validClass : "valid-class",
										rules : {

											actionTaken : {
												required : true
											},
											usedPartNumbers : {
												required : {
													depends : function(element) {
														if ($("#actionTaken").val() == "Replaced Part/Toner"){
															return true;
														} else {
															return false;
														}
													}
												}
											},
											comment : {
												max:150,
												required : {
													depends : function(element) {
														if ($("#actionTaken").val() == "Cleared Paper Jam"
																|| $("#actionTaken").val() == "Installed Drivers"
																|| $("#actionTaken").val() == "Configured Drivers"
																|| $("#actionTaken").val() == "Configured Printer"
																|| $("#actionTaken").val() == "User Error"
																|| $("#actionTaken").val() == "No fault Found") 
															
														{
															return true;
														} else {
															return false;
														}
													}
												}
											}
											
											
											
										},
										
										messages : {
											usedPartNumbers : 'Used part numbers is required check boot or site stock for used part numbers',
											actionTaken : 'Action taken is required and can not be empty',											
											comment : 'Please provide comments on what solution you provided'
											
											
										}
									});
				});


$(document)
		.ready(
				function() {
					$('#updateResolved')
							.bootstrapValidator(
									{
										feedbackIcons : {
											valid : 'glyphicon glyphicon-ok',
											invalid : 'glyphicon glyphicon-remove',
											validating : 'glyphicon glyphicon-refresh'
										},
										fields : {
											orderNum : {
												validators : {
													notEmpty : {
														message : 'Order number is required and cant not be empty'
													}
												}
											},
											escalatedTo : {
												validators : {
													notEmpty : {
														message : 'Manager is required and cant not be empty'
													}
												}
											},
											colourReading : {
												validators : {
													notEmpty : {
														message : 'Colour reading is required and can not be empty'
													}
												}
											},
											monoReading : {
												validators : {
													notEmpty : {
														message : 'Mono reading is required and can not be empty'
													}
												}
											}
											,
											comments : {
												validators : {
													notEmpty : {
														message : 'Comments is required and can not be empty'
													}
												}
											}

											
										}
									});
				});


$(document)
.ready(
		function() {
			$('#updataTckt')
					.bootstrapValidator(
							{
								feedbackIcons : {
									valid : 'glyphicon glyphicon-ok',
									invalid : 'glyphicon glyphicon-remove',
									validating : 'glyphicon glyphicon-refresh'
								},
								fields : {
									status : {
										validators : {
											notEmpty : {
												message : 'Status is required and cant not be empty'
											}
										}
									}
									
								}
							});
		});



// Select Action Taken -->
$("#actionTaken").on(
		'change',
		function() {

			if ($(this).val() == "Replaced Part/Toner") {
				$('input[type="radio"]:enabled').attr('disabled', true);
				$('#BootStocked, #SiteStocked').attr('disabled', false);
				$('textarea[name="usedPartNumbers"]:enabled').attr('disabled',false);							
				$('#usedPartNumbers').attr('disabled', false);
				console.log($(this).val());
			} else if ($(this).val() == ""
					|| $(this).val() == "Cleared Paper Jam"
					|| $(this).val() == "Installed Drivers"
					|| $(this).val() == "Configured Drivers"
					|| $(this).val() == "Configured Printer"
					|| $(this).val() == "User Error"
					|| $(this).val() == "No fault Found") {
				$('input[type="radio"]:enabled').attr('disabled', true);
				$('#BootStocked, #SiteStocked').attr('disabled', true);
				$('textarea[name="usedPartNumbers"]:enabled').attr('disabled',false);				
				$('#usedPartNumbers').attr('disabled', false);
				console.log($(this).val());
			}
		});


//Select hideComent before -->
function Faulty(val) {
	
	
	var element = document.getElementById('hideUsedPartNumbersHidding');
	if (val == 'pick a Part or Toner options' || val == 'Replaced Part/Toner' )
		element.style.display = 'block';	    
	else
		element.style.display = 'none';
		console.log('Hide heading if Replaced Part/Toner is not selected ');
	
	
	var element = document.getElementById('hideIfIsNotPartToner');
	if (val == 'pick a Part or Toner options' || val == 'Replaced Part/Toner' )
		element.style.display = 'block';	    
	else
		element.style.display = 'none';
		console.log('Toner or Part:  For getting list of Parts or Toners');
	
	var element = document.getElementById('hideComent');	
	if (val == 'pick a fualty options' || 
			val == 'Cleared Paper Jam' || 
			val == 'Installed Drivers' || 
			val == 'Configured Drivers'||
			val == 'Configured Printer'||
			val == 'User Error' 	   || 
			val == 'No fault Found')
		element.style.display = 'block';	    
	else
		element.style.display = 'none';
		console.log('Other Action Taken, beside Replace Part or Toner:  Add Comment on Solution Modal ticket, is resolved remove comment');
		
	var element = document.getElementById('actionTakenSubmit');
	if (val == 'pick a show submit' || 
			val == 'Cleared Paper Jam' || 
			val == 'Installed Drivers' || 
			val == 'Configured Drivers'||
			val == 'Configured Printer'||
			val == 'User Error' 	   || 
			val == 'No fault Found'    ||
			val == 'Replaced Part/Toner')
		element.style.display = 'block';	    
	else
		element.style.display = 'none';
	    console.log('Submit Hidden:  Hide submit buttons if nothing was selected from Acton Taken');
	    
	var element = document.getElementById('hideMonoAndColour');
	if (val == 'pick a show submit' || 
			val == 'Cleared Paper Jam' || 
			val == 'Installed Drivers' || 
			val == 'Configured Drivers'||
			val == 'Configured Printer'||
			val == 'User Error' 	   || 
			val == 'No fault Found'    ||
			val == 'Replaced Part/Toner')
		element.style.display = 'block';	    
	else
		element.style.display = 'none';
	    console.log('hide Mono And Colour:  Hide Mono and Colour Reading if action ');
}

// Select Open before showing comment-->
function CheckStatus(val) {
	var element = document.getElementById('comments');
	if (val == 'pick a customer' || val == 'Open')
		element.style.display = 'block';
	else
		element.style.display = 'none';
}

// Accept alphanumeric characters only -->
function isNumber(evt) {
	evt = (evt) ? evt : window.event;
	var charCode = (evt.which) ? evt.which : evt.keyCode;
	if (charCode > 31 && (charCode < 48 || charCode > 57)) {
		return false;
	}
	return true;
}

// Make all Serials numbers UpperCase -->
function upperCaseF(a) {
	setTimeout(function() {
		a.value = a.value.toUpperCase();
	}, 1);
}

//hide the all of the element class usedPartNumbersDetails
$(".usedPartNumbersDetails").each(function (i) {
  if ($('input[name$=usedPartNumbers][value=""]',this).length == 1) { 
    $(this).hide();
    console.log('hiding toner or part');
  } else {
    $(this).show();
    console.log('showing toner or part');
  }
});

//if action taken is not Replace part or toner, show the all of the element class showComment
$(".actionTaken").each(function (i) {
  if ($("#status").val() == "Installed Drivers" || 
	  $("#status").val() == 'Cleared Paper Jam' || 
	  $("#status").val() == 'Configured Drivers'||
	  $("#status").val() == 'Configured Printer'||
	  $("#status").val() == 'User Error' 	    || 
	  $("#status").val() == 'No fault Found') { 
    $('.showComment').hide();
    console.log('hiding comment');
  } else {
    $('.showComment').show();
    console.log('show comment');
  }
  var getComment = document.getElementById('status').value;
  if(getComment = "Installed Drivers"){
  	 console.log('show comment');
  	 console.log(getComment);
  }
});

