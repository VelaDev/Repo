/**
 * Post contact person values to java controller
 */
var firstName;
var lastName;
var email;
var cellNumber;
var telephoneNumber;
var json;

$(document).ready(function() {
	   
	  $('#saveClient').submit(function(event) {
	       
	      firstName = $('#firstName').val();
	      lastName = $('#lastName').val();
	      email = $('#email').val();
	      cellNumber = $('#cellNumber').val();
	      telephoneNumber = $('#telephoneNumber').val();
	      json = { "firstName" : firstName, "lastName" : lastName, "email": email, "cellNumber" : cellNumber, "telephoneNumber" : telephoneNumber};
	       
	    $.ajax({
	        url: $("#saveClient").attr( "action"),
	        data: JSON.stringify(json),
	        type: "POST",
	         
	        beforeSend: function(xhr) {
	            xhr.setRequestHeader("Accept", "application/json");
	            xhr.setRequestHeader("Content-Type", "application/json");
	        },
	        success: function(contactperson) {
	            var respContent = "";	             
	            respContent += "<div class='alert alert-info' role='alert'>Person added Tes: [";
	            respContent += contactperson.firstName + " : ";
	            respContent += contactperson.lastName + " : " ;
	            respContent += contactperson.email + " : " ;
	            respContent += contactperson.cellNumber + " : " ;
	            respContent += contactperson.telephoneNumber + "]</div>";
	            $("#responseFromController").html(respContent);
	            console.log("See Token :" + respContent);
	        }
	    });
	      
	    event.preventDefault();
	  });
	    
	});