/**
 * Post values to java controller
 */
var firstName;
var lastName;
var email;
var cellNumber;
var telephoneNumber;

$(document).ready(function() {
	   
	  $('#saveClient').submit(function(event) {
	       
	      firstName = $('#firstName').val();
	      lastName = $('#lastName').val();
	      email = $('#email').val();
	      cellNumber = ('#cellNumber').val();
	      telephoneNumber = ('#telephoneNumber').val();
	      var json = { "firstName" : firstName, "lastName" : lastName, "email": email, "cellNumber" : cellNumber, "telephoneNumber" : telephoneNumber};
	       
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
	             
	            respContent += "<span class='success'>Person added Tes: [";
	            respContent += contactperson.firstName + " : ";
	            respContent += contactperson.lastName + " : " ;
	            respContent += contactperson.email + " : " ;
	            respContent += contactperson.cellNumber + " : " ;
	            respContent += contactperson.telephoneNumber + "]</span>";
	            $("#responseFromController").html(respContent);
	            console.log(respContent);
	        }
	    });
	      
	    event.preventDefault();
	  });
	    
	});