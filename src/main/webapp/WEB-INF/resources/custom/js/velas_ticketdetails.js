/**
 * Purpose: Interact with the html pages and create communication between server side
 * Author : Fenya Tlala
 * Company: Velaphanda 
 * Last Date Modified:29-05-2017
 */

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

// Status Selection-->
function CheckStatus(val) {
	var element = document.getElementById('order');
	if (val == 'pick a status' || val == 'Awaiting Spares')
		element.style.display = 'block';
	else
		element.style.display = 'none';

	var element = document.getElementById('manager');
	if (val == 'pick a status' || val == 'Escalated')
		element.style.display = 'block';
	else
		element.style.display = 'none';

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
											colourReading : {
												required : true
											},
											monoReading : {
												required : true
											},
											usedPartNumbers : {
												required : {
													depends : function(element) {
														if ($("#actionTaken").val() == "Replaced Part"
																|| $("#actionTaken").val() == "Replaced toner") {
															return true;
														} else {
															return false;
														}
													}
												}
											},
											comment : {
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
											colourReading:'Colour reading is required and cannot be empty',
											monoReading:'Mono reading is required and cannot be empty',
											comment: 'Please provide comments on what solution you provided'
											
											
										}
									});
				});

// Select Action Taken -->
$("#actionTaken").on(
		'change',
		function() {

			if ($(this).val() == "Replaced Part"
					|| $(this).val() == "Replaced toner") {
				$('input[type="radio"]:enabled').attr('disabled', true);
				$('#BootStocked, #SiteStocked').attr('disabled', false);
				$('textarea[name="usedPartNumbers"]:enabled').attr('disabled',true);
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
				$('textarea[name="usedPartNumbers"]:enabled').attr('disabled',true);
				$('#usedPartNumbers').attr('disabled', true);
				console.log($(this).val());
			}
		});


//Select hideComent before -->
function Faulty(val) {
	
	var element = document.getElementById('hideIfIsNotPartToner');
	if (val == 'pick a Part or Toner options' || val == 'Replaced Part' || val == 'Replaced toner' )
		element.style.display = 'block';	    
	else
		element.style.display = 'none';
		console.log('Toner or Part:  Give me used part numbers only');
	
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
		console.log('Faulty:  Add Comment on SolutionPop ticket is resolved remove comment');
		
	var element = document.getElementById('actionTakenSubmit');
	if (val == 'pick a show submit' || 
			val == 'Cleared Paper Jam' || 
			val == 'Installed Drivers' || 
			val == 'Configured Drivers'||
			val == 'Configured Printer'||
			val == 'User Error' 	   || 
			val == 'No fault Found'    ||
			val == 'Replaced Part' 	   ||
			val == 'Replaced toner')
		element.style.display = 'block';	    
	else
		element.style.display = 'none';

}

// Select customer before showing add button-->
function ShowCustomer(val) {
	var element = document.getElementById('siteAdd');
	if (val == 'pick a customer' || val == 'customer')
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
  if ($('input[name$=status][value=""]',this).length == 1) { 
    $(this).hide();
    console.log('hiding');
  } else {
    $(this).show();
    console.log('showing');
  }
});
