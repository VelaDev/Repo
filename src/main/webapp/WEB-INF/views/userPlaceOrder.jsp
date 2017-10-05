<%@ include file="templates/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Order | Velaphanda Trading & Projects</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--style-->
<link rel="stylesheet" type="text/css"
      href="<c:url value="/resources/custom/css/vela_custom.css" />" />
<link rel="stylesheet" type="text/css"
      href="<c:url value="/resources/bootstrap-3.3.7/fonts/font-awesome.min.css" />" />
<link rel="stylesheet" type="text/css"
      href="<c:url value="/resources/bootstrap-3.3.7/css/bootstrap.min.css" />" />
<link rel="stylesheet" type="text/css"
      href="<c:url value="/resources/bootstrapValidator-0.5.3/css/bootstrapValidator.min.css" />" />
<link rel="stylesheet" type="text/css"
      href="<c:url value="/resources/bootstrap-3.3.7/css/datepicker.min.css" />">

<link type="text/css" rel="stylesheet"
      href="<c:url value="/resources/custom/css/vela_details.css" />">
<link type="text/css" rel="stylesheet"
      href="<c:url value="/resources/datatables/1.10.13/css/db_site_ui.css" />">
<link type="text/css" rel="stylesheet"
      href="<c:url value="/resources/datatables/1.10.13/css/demo_table_jui.css" />">
<link type="text/css" rel="stylesheet"
      href="<c:url value="/resources/datatables/1.10.13/css/jquery-ui.css" />">

<link type="text/css" rel="stylesheet"
      href="<c:url value="/resources/datatables/1.10.13/css/buttons.dataTables.css" />">

<link type="text/css" rel="stylesheet"
      href="<c:url value="/resources/datatables/1.10.13/css/scroller.dataTables.css" />">
<style>

table#toOrder thead {
    background-color: #CCCCCC;
    height: 112%;
}

</style>

<!--/style-->
</head>
<body>
	<div class="velaphanda_containter">
	<c:import url="templates/usernavbar.jsp"></c:import> 
		 <div class="container">

                  <c:if test="${not empty retMessage }">
                        <div class="alert alert-info" role="alert">

                              <c:out value="${ retMessage}">
                              </c:out>
                        </div>
                  </c:if>
                  <c:if test="${not empty retErrorMessage }">
                        <div class="alert alert-info" role="alert">

                              <c:out value="${ retErrorMessage}">
                              </c:out>
                        </div>
                  </c:if>
                  <div class="panel panel-success">
                        <div class="panel-heading">
                              <h3 class="panel-title">
                                    <div align="center">
                                          <b>New Order</b>
                                    </div>
                              </h3>
                        </div>
                        <div class="panel-body">
                              <div class="tab-content">

                                    <form:form class="well form-horizontal" modelAttribute="makeOrder"
                                          method="post" action="makeOrder" id="putInOrder">


                                          <!-- Select type Stock Type-->
                                          <div class="form-group">
                                                <label class="col-md-3 control-label">Stock Type</label>
                                                <div class="col-md-6 selectContainer">
                                                      <div class="input-group">
                                                            <span class="input-group-addon"><i
                                                                  class="glyphicon glyphicon-list"></i></span><select id="stockType"
                                                                  name="stockType" class="form-control"
                                                                  onchange='CheckStockType(this.value);'
                                                                  class="form-control selectpicker">
                                                                  <option value="">Select Stock Type</option>
                                                                  <option value="Boot">Boot</option>
                                                                  <option value="Site">Site</option>
                                                            </select>
                                                      </div>
                                                </div>
                                          </div>

                                          <div id="Site" style='display: none;'>

                                                <!-- Text input Customer Name-->
                                                <div class="form-group">
                                                      <label class="col-md-3 control-label">Customer Name</label>
                                                      <div class="col-md-6 inputGroupContainer">
                                                            <div class="input-group">
                                                                  <span class="input-group-addon"><i
                                                                        class="glyphicon glyphicon-user"></i></span><select id="Site"
                                                                        name="customer" class="form-control selectpicker">
                                                                        <option value="">Customer Name</option>
                                                                        <c:forEach items="${customerList}" var="customer">
                                                                              <option value="${customer.customerName}">${customer.customerName}</option>
                                                                        </c:forEach>
                                                                  </select>
                                                            </div>
                                                      </div>
                                                </div>
                                          </div>


                                          <div class="form-group">
                                                <label class="col-md-3 control-label">Technician</label>
                                                <div class="col-md-6 selectContainer">
                                                      <div class="input-group">
                                                            <span class="input-group-addon"><i
                                                                  class="glyphicon glyphicon-list"></i></span> <select
                                                                  name="technicianUserName" id="technicianUserName"
                                                                  class="form-control selectpicker">
                                                                  <option value="">Select Technician</option>
                                                                  <c:forEach items="${technicianList}" var="technician">
                                                                        <option value="${technician.email}">${technician.firstName}
                                                                              ${technician.lastName}</option>
                                                                  </c:forEach>
                                                            </select>
                                                      </div>
                                                </div>
                                          </div>

                                          <!-- Text input Approver-->
                                          <div class="form-group">
                                                <label class="col-md-3 control-label">Approver</label>
                                                <div class="col-md-6 inputGroupContainer">
                                                      <div class="input-group">
                                                            <span class="input-group-addon"><i
                                                                  class="glyphicon glyphicon-user"></i></span><select name="approver"
                                                                  id="approver" class="form-control selectpicker">
                                                                  <option value="">Select Manager</option>
                                                                  <c:forEach items="${managersList}" var="approver">
                                                                        <option value="${approver.email}">${approver.firstName}
                                                                              ${approver.lastName}</option>
                                                                  </c:forEach>
                                                            </select>

                                                      </div>
                                                </div>
                                          </div>

                                 
                                          <div id="makeOrders">

                                                <div class="groupdetails-row-padding">

                                                      <div id="pagewrap">
                                                            <div class="content" style="width: 87%;">
                                                            <div class="groupclientdetails">
                                                            	<h5 align="center"><b>Available Head Office Stock</b></h5>
                                                            	
                                                                  <table id="stockForOrder" class="display">
                                                                        <thead>
                                                                              <tr>
                                                                                    <th>Part No</th>
                                                                                    <th>Description</th>
                                                                                    <th>Model No</th>
                                                                                    <th>Available QTY</th>
                                                                                    <th>Provide QTY</th>
                                                                                    <th>Action</th>
                                                                              </tr>
                                                                        </thead>

                                                                        <tbody>
                                                                              <c:forEach var="list" items="${compatibility}">
                                                                                    <tr>

                                                                                          <td>${list.partNumber}</td>
                                                                                          <td>${list.itemDescription}</td>
                                                                                          <td>${list.compitableDevice}</td>
                                                                                          <td><input type="text"
                                                                                                id="${list.partNumber}_avaliableQuantity"
                                                                                                name="avaliableQuantity" class="form-control"
                                                                                                readonly="readonly" value="${list.quantity}"></td>
                                                                                          <td><input type="text"
                                                                                                id="${list.partNumber}_quantity" name="quantity" 
                                                                                                class="form-control" onkeypress="return isNumber(event)"
                                                                                                onblur="compareQuantity(this, ${list.quantity})"
                                                                                                value="" /></td>
                                                                                          <td><input class="addLineItem" type="button"
                                                                                                value="Add"></td>
                                                                                    </tr>
                                                                              </c:forEach>

                                                                        </tbody>
                                                                  </table>
                                                            </div>

                                                            </div>
                                                            <div class="content" style="width: 87%;">
                                                            <div class="groupproductdetails">
                                                            	</br>
                                                            	<h5 align="center"><b>Selected Order Line Items</b></h5>
                                                            	<div class="dataTables_scroll">
                                                                  <table id="toOrder" class="display toOrder">
                                                                        <thead>
                                                                              <tr>
                                                                                    <th>Part No</th>
                                                                                    <th>Description</th>
                                                                                    <th>Model No</th>
                                                                                    <th>Available QTY</th>
                                                                                    <th>QTY Provided</th>
                                                                                    <th>Action</th>
                                                                              </tr>
                                                                        </thead>
													                     <tbody >
		                                                                 </tbody>
	                                                                   
	                                                              </table>
                                                                  </div>
                                                            </div>
                                                            <!-- //groupproductdetails --> 
                                                            </div><!-- //sidebar -->
                                                      </div>
                                                      <!--// pagewrap -->

                                                </div>
                                                <!-- //groupdetails-row-padding -->

                                                <!-- part Number and Quantity Entered -->
                                                <input type="hidden" id="quantityList" name="quantityList"
                                                      class="form-control" value="" /> <input type="hidden"
                                                      id="partNumberList" name="partNumberList" class="form-control"
                                                      value="" />


                                          </div>
                                          <!-- //make order -->
                                          
										  <div class="orderSubmit" id="orderSubmit" style="display:none;">											
	                                          <div class="form-group row">
	                                                <div class="col-sm-offset-2 col-sm-8">
	                                                      <br> <br> <input type="submit" value="Place Order"
	                                                            class="btn btn-primary btn-block btn-lg" tabindex="9"
	                                                            id="putorder" name="putorder">
	                                                </div>
	                                          </div>
										  </div>
											
                                    </form:form>

                              </div>
                              <!-- /tab-content -->
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
            src="<c:url value="/resources/datatables/datatables.min.js" />"></script>
      <script type="text/javascript"
            src="<c:url value="/resources/datatables/1.10.13/js/jquery-ui.js" />"></script>
      <script type="text/javascript"
            src="<c:url value="/resources/datatables/1.10.13/js/dataTables.buttons.js" />"></script>
      <script type="text/javascript"
            src="<c:url value="/resources/datatables/1.10.13/js/dataTables.jqueryui.js" />"></script>
      <script type="text/javascript"
            src="<c:url value="/resources/datatables/1.10.13/js/dataTables.select.js" />"></script>
      <!-- //Datatables -->

      <script type="text/javascript"
            src="<c:url value="/resources/custom/js/velas_validations.js"/>"></script>
      <!-- /Scripts -->


    <!--Order avalialable head office stock-->
    <script type="text/javascript">
      
    $(document).ready(function() {
            $('#stockForOrder').DataTable({
                  info: true, 
                  searching:true, 
                  scrollY: "200px",
                  scrollCollapse: true,
                  paging:false,
            /* few more options are available to use */
          });
    });
                  
    var partNumberList = [];
    var quantityList = [];
    //move selected line items to table 2
    $('#stockForOrder').on('click', '.addLineItem', function() {
    
       var quantity;
       row = $(this).closest("tr").clone(); 
       quantity = $(this).closest('tr').find('td:eq(4)').find('input').val();
       console.log("Check the grapped quantity on table of Selected Line Items to Order : ",quantity);
       
       if(quantity == '' || quantity== 0){
           alert("Quantity can not be zero.\n Please enter quantity which is less than available quantity"); 
         }
       if (quantity > 0){
            var items = [];
            row = $(this).closest("tr").clone();
            var partNumber = $(this).closest('tr').find('td:eq(0)').text();
            var quantity = $(this).closest('tr').find('td:eq(4)').find('input').val();
            
            document.getElementById("quantityList").value = quantityList;
            document.getElementById("partNumberList").value = partNumberList;
                                    
            items.push(row);
            row.appendTo($("#toOrder"));
            debugger;
            $(this).closest('tr').remove();
            $('input[type="button"]', row).removeClass('AddNew').addClass('RemoveRow').val('Remove');
        }
     });
    //remove selected line items from table 1 to table 2
    $('#toOrder').on('click', '.RemoveRow', function(){
    	 debugger;
    	row = $(this).closest("tr").clone();
        row.appendTo($("#stockForOrder"));
         $(this).closest('tr').remove();
        $('input[type="button"]', row).removeClass('RemoveRow').addClass('addLineItem').val('Add');
         //hide the all of the element class oderSumbmit
        
    });
     
    //send selected items when user clicks submit button
     $('#putorder').on('click', function(){
           var row;
           $('#toOrder tr').each(function(row, tr){
             partNumberList[row]=[$(tr).find('td:eq(0)').text()];
             quantityList[row]=[$(this).closest('tr').find('td:eq(4)').find('input').val()];
      }); 
      partNumberList.shift();
      quantityList.shift();
      document.getElementById("quantityList").value = quantityList;
      document.getElementById("partNumberList").value = partNumberList;
    }); 
           
</script>

<!-- Hide element of orderSubmit if quantity is empty  -->
<script type="text/javascript">

//Bind the keyup event on quantity input 
$('input[name$=quantity]').keyup(function() {

    // If value is not empty
	if ($(this).val().length == 0) {
    // Hide the element
 	$('.orderSubmit').hide();
     console.log("Hide the submit button if quantity is not entered");
	} else {
    // Otherwise show it
 	$('.orderSubmit').show();
 	 console.log("Show the submit button if quantity is entered");
	}
}).keyup(); // Trigger the keyup event, thus running the handler on page load
	
</script>



</body>
</html>