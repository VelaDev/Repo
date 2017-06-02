package com.demo.controller;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.demo.bean.PieChart;
import com.demo.bean.SparePartsBean;
import com.demo.bean.TicketsBean;
import com.demo.model.Customer;
import com.demo.model.Employee;
import com.demo.model.OrderHistory;
import com.demo.model.Tickets;
import com.demo.service.BootStockInt;
import com.demo.service.CustomerContactDetailsServiceInt;
import com.demo.service.CustomerServiceInt;
import com.demo.service.EmployeeServiceInt;
import com.demo.service.LeaveInt;
import com.demo.service.OrderHistoryInt;
import com.demo.service.OrdersServiceInt;
import com.demo.service.SiteStockInt;
import com.demo.service.SpareMasterServiceInt;
import com.demo.service.TicketsServiceInt;
import com.demo.service.DeviceServiceInt;
import com.demo.service.TicketHistoryInt;


@Controller
public class TicketController {
	
	@Autowired
	private TicketsServiceInt logTicketService;
	@Autowired
	private CustomerServiceInt customerServiceInt;
	@Autowired
	private DeviceServiceInt deviceServiceInt;
	@Autowired
	private EmployeeServiceInt employeeServiceInt;
	@Autowired
	private TicketHistoryInt ticketHistoryInt;
	@Autowired
	private OrdersServiceInt ordersServiceInt;
	@Autowired
	private TicketsServiceInt ticketsServiceInt;
	@Autowired
	private SpareMasterServiceInt spareMasterServiceInt;
	@Autowired
	private BootStockInt bootStockint;
	@Autowired
	private SiteStockInt siteStock;
	@Autowired
	private LeaveInt leaveInt;
	@Autowired
	private OrderHistoryInt historyInt;
	private List<PieChart> beanList = null;
	Integer count = 1;
	public String[] getSerialNumbers = null;
	
	@Autowired
	private CustomerContactDetailsServiceInt contactDetailsServiceInt;
	@Autowired
	private HttpSession session = null;
	
	@SuppressWarnings("unused")
	private Customer customer = null;
	private ModelAndView model = null;
	private Employee userName= null;
	private String retMessage ="";
	public String[] getSerials = null;
	
	@RequestMapping(value="ticket",method=RequestMethod.GET)
	public ModelAndView loadTicket() {
       
		model = new ModelAndView();
		String retPage = null;
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			System.out.println("We here");
			model.addObject("ticket", new TicketsBean());
			getSerialNumbers = deviceServiceInt.getSerials();
			model.addObject("technicians",employeeServiceInt.getAllTechnicians());
			model.addObject("serialNumbers",getSerialNumbers);
			model.addObject("onLeaveTechnicians",leaveInt.techniciansOnLeave());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			/*retPage = "redirect:ticket";*/
			model.setViewName("ticket");
		}
		else{
			model.setViewName("login");
		}
		return model;     
		
	}	
	
	@RequestMapping(value="logTicketAdmin",method=RequestMethod.POST)
	public ModelAndView logTicketAdmin(@ModelAttribute("logTicketAdmin")TicketsBean logTickets){
	
		model = new ModelAndView();
		String tickets = "tickets";
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			retMessage = logTicketService.logTicket(logTickets);
			
			if(retMessage.startsWith("K")){
			 String	message =retMessage;
			 model.addObject("message",message );
			}else{
				model.addObject("retMessage",retMessage );
				
			}
			 model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));	 
			 model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));			
			 model.addObject(tickets, "tickets");
			 model.setViewName("confirmations");
		    //model.setViewName("logTicket");
		}
		else{
			
			model.setViewName("login");
		}
		return model;
		
	}

	@RequestMapping(value="UserlogTicket",method=RequestMethod.POST)
	public ModelAndView userLogTicket(@ModelAttribute("UserlogTicket")TicketsBean logTickets){
	
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		String tickets ="tickets";	
		if(userName !=null){
			retMessage = logTicketService.logTicket(logTickets);
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));			
			
			if(retMessage.startsWith("C")){
			 String	message =retMessage;
			 model.addObject("message",message );
			}else{
				model.addObject("retMessage",retMessage );
				model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));			
				model.addObject("tickets",tickets);
				 
			}
			model.setViewName("confirm");
		   //model.setViewName("ticket");
		}
		else{
			model.setViewName("login");
		}
		return model;
		
	}
			
	@RequestMapping(value = {"monitoringTickets"})
    public ModelAndView displayLoggedTickets() {
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		
			model.addObject("ticketList", logTicketService.getAllOpenTickets());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("monitoringTickets");
		}
		else{
			model.setViewName("login");
		}
		return model;
       
    }
	@RequestMapping("ticketDetails")
    public ModelAndView loadTicketdetails(@RequestParam int id, @ModelAttribute Tickets ticket) {
		
	    model = new ModelAndView();
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		    String technician = userName.getFirstName()+ " "+userName.getLastName();
			ticket = logTicketService.getLoggedTicketByTicketNumber(id);
			model.addObject("ticketObject", ticket);
			model.addObject("saveSpareParts", new SparePartsBean());
			getSerials = spareMasterServiceInt.getSerials();
			model.addObject("spareParts",getSerials);
			model.addObject("contactPerson",contactDetailsServiceInt.getContactPerson(ticket.getDevice().getCustomerDevice().getCustomerName()));
			model.addObject("ticketHistoryList", ticketHistoryInt.getHistoryByTicketNumber(id));
			model.addObject("OrderNumber",ordersServiceInt.getAllOrders(userName.getEmail()));
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("managersList",employeeServiceInt.getAllManagers());
			model.addObject("customerList",customerServiceInt.getClientList());
			model.addObject("bootStock", bootStockint.getAllOrders(technician,id));
			/*model.addObject("siteStock",siteStock.getOrdersForCustomer(ticket.getDevice().getCustomerDevice().getCustomerName(),id));*/
			model.addObject("siteStock", siteStock.getOrdersForCustomer(ticket.getDevice().getCustomerDevice().getCustomerName(), id));
			model.setViewName("ticketDetails");
		}
		else{
			model.setViewName("login");
		}
		return model;
    }
	@RequestMapping(value="viewCustomerDetails")
	public ModelAndView viewCustomerDetails(@RequestParam("customerName") String customerName,@ModelAttribute Customer customer) {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			model.addObject("customer", customerServiceInt.contactDetails(customerName));
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));			
			model.addObject("customerDetails", contactDetailsServiceInt.contactDetails(customerName));
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("viewCustomerDetails");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	
	@RequestMapping("updateTicket")
	public ModelAndView updateTicket(@ModelAttribute("updateTicket")TicketsBean updateTicket){
		String managerUpdateTicket = "managerUpdateTicket";
		String techUpdateTicket = "techUpdateTicket";
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		    
			retMessage = logTicketService.updateTicket(updateTicket);
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
			if(retMessage.startsWith("The part number")){
				String retErrorMessage = retMessage;
				model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
				model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));				
				model.addObject("retErrorMessage", retErrorMessage);
			}else{
				model.addObject("retMessage", retMessage);
			}
		    
		    model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
		    
		    if (userName.getRole().equalsIgnoreCase("Manager") || userName.getRole().equalsIgnoreCase("Admin")) {				
		    	model.addObject("managerUpdateTicket", managerUpdateTicket);
		    	model.setViewName("confirmations");
		    }
		    
		    else if (userName.getRole().equalsIgnoreCase("Technician")){
		    	model.addObject("techUpdateTicket", techUpdateTicket);
		    	model.setViewName("confirmation");
		    }
		
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping("updateTicketUser")
	public ModelAndView userUpdateTicket(@ModelAttribute("updateTicket")TicketsBean updateTicket){
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		     
			retMessage = logTicketService.updateTicket(updateTicket);
		    model.addObject("retMessage", retMessage);
		    model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("userUpdateTicket");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
		
	}
	@RequestMapping("searchTechnician")
    public ModelAndView searchEmployee(@RequestParam("searchName") String searchName) {  
		model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
        return new ModelAndView("");      
    }
	
	@RequestMapping("clientInfo")
	public ModelAndView clientInfo(){
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			model.addObject("", "");
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("clientInfo");
		}
		else{
			  model.setViewName("login");
		}
		return model;
	}
	@RequestMapping(value="logTicket",method=RequestMethod.GET)
	public ModelAndView loadTicketAdmin() {
       
		model = new ModelAndView("logTicket");
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			System.out.println("We here");
			model.addObject("logTicket", new TicketsBean());
			getSerialNumbers = deviceServiceInt.getSerials();
			model.addObject("technicians",employeeServiceInt.getAllTechnicians());
			model.addObject("serialNumbers",getSerialNumbers);
			model.addObject("onLeaveTechnicians",leaveInt.techniciansOnLeave());
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));			
			
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("logTicket");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping("AssignTicketToOtherTechnician")
    public ModelAndView assignTicketToAnotherTechnicia(@RequestParam int ticketNumber, @ModelAttribute Tickets ticket) {
		
	    model = new ModelAndView();
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			ticket = logTicketService.getLoggedTicketByTicketNumber(ticketNumber);
			model.addObject("ticketupdate", ticket);
			model.addObject("technicians",employeeServiceInt.getAllTechnicians());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("ticketUpdate");
		}
		else{
			model.setViewName("login");
		}
		return model;
    }
	@RequestMapping("userAssignTicketToOtherTechnician")
    public ModelAndView userAssignTicketToAnotherTechnicia(@RequestParam int ticketNumber, @ModelAttribute Tickets ticket) {
		
	    model = new ModelAndView();
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			ticket = logTicketService.getLoggedTicketByTicketNumber(ticketNumber);
			model.addObject("ticketupdate", ticket);
			model.addObject("technicians",employeeServiceInt.getAllTechnicians());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("userUpdateTicket");
		}
		else{
			model.setViewName("login");
		}
		return model;
    }
	
	@RequestMapping("updateTicketAdmin")
	public ModelAndView updateTicketAdmin(@ModelAttribute("updateTicket")TicketsBean updateTicket){
		String managerUpdateTicket = "managerUpdateTicket";
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		     
			retMessage = logTicketService.updateTicket(updateTicket);
		    model.addObject("retMessage", retMessage);
		    model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));			
			model.addObject("managerUpdateTicket", managerUpdateTicket);
			model.setViewName("confirmations");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	
	

	@RequestMapping(value="userTicket",method=RequestMethod.GET)
	public ModelAndView loadUserTicket(Integer offset, Integer maxResults ) {
       
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			beanList = ticketsServiceInt.ticketsResults();
			model.addObject("ticketResults",beanList);
			model.addObject("count",count);
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));	
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("userTicket");
		}
		else{
			model.setViewName("login");
		}
		return model;  
		
	}
	@RequestMapping("openTickets")
	public ModelAndView openTickets(){
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		     
		    model.addObject("retMessage", retMessage);
		    model.addObject("ticketList", logTicketService.getAllOpenTickets());			
		    model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("openTickets");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	
	@RequestMapping("openTicketsDetails")
    public ModelAndView loadOpenTicketsDetails(@RequestParam int id, @ModelAttribute Tickets ticket) {
		
	    model = new ModelAndView();
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			
			if (userName.getRole().equalsIgnoreCase("Manager") || userName.getRole().equalsIgnoreCase("Admin")){
				ticket = logTicketService.getLoggedTicketByTicketNumber(id);
				model.addObject("ticketObject", ticket);
				model.addObject("contactPerson",contactDetailsServiceInt.getContactPerson(ticket.getDevice().getCustomerDevice().getCustomerName()));
				model.addObject("ticketHistoryList", ticketHistoryInt.getHistoryByTicketNumber(id));
				model.addObject("OrderNumber",ordersServiceInt.getAllOrders(userName.getEmail()));
				model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
				model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
				model.addObject("managersList",employeeServiceInt.getAllManagers());
				model.setViewName("openTicketsDetails");
			}
		}
		else{
			model.setViewName("login");
		}
		return model;
    }
	
	@RequestMapping(value={"closedTickets", "closedTechTickets"})
	public ModelAndView closedTickets(){
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		     
		    model.addObject("retMessage", retMessage);
		    model.addObject("ticketList", logTicketService.getAllClosedTickets());
		    model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));			
		    model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
		    
		    if (userName.getRole().equalsIgnoreCase("Manager") || userName.getRole().equalsIgnoreCase("Admin")) {				
		    	
		    	model.setViewName("closedTickets");
		    }
		    
		    else if (userName.getRole().equalsIgnoreCase("Technician")){
		    	model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));			
				model.addObject("ticketList", logTicketService.getAllClosedTickets(userName.getEmail()));				
		    	model.setViewName("closedTechTickets");
		    }			
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping( value={"closedTicketsDetails", "closedTechTicketsDetails"})
    public ModelAndView loadClosedTicketsDetails(@RequestParam int id, @ModelAttribute Tickets ticket) {
		
	    model = new ModelAndView();
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			
			
			ticket = logTicketService.getLoggedTicketByTicketNumber(id);
			model.addObject("ticketObject", ticket);
			model.addObject("contactPerson",contactDetailsServiceInt.getContactPerson(ticket.getDevice().getCustomerDevice().getCustomerName()));
			model.addObject("ticketHistoryList", ticketHistoryInt.getHistoryByTicketNumber(id));
			model.addObject("OrderNumber",ordersServiceInt.getAllOrders(userName.getEmail()));
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("managersList",employeeServiceInt.getAllManagers());
			
			
			 if (userName.getRole().equalsIgnoreCase("Manager") || userName.getRole().equalsIgnoreCase("Admin")) {				
			    	
			    	model.setViewName("closedTicketsDetails");
			    }
			    
			    else if (userName.getRole().equalsIgnoreCase("Technician")){
			    	
			    	model.setViewName("closedTechTicketsDetails");
			    }			
			}
			else{
				model.setViewName("login");
			}
			
			return model;
	}
	
	
	@RequestMapping("awaitingSpares")
	public ModelAndView awaitingSparesTickes(){
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		     
		    model.addObject("retMessage", retMessage);
		    model.addObject("ticketList", logTicketService.getAllAwaitingSpares());			   
		    model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("awaitingSpares");
		}
		else{
			model.setViewName("login");
		}		
		return model;
	}
	@RequestMapping("awaitingSparesDetails")
    public ModelAndView loadAwaitingSparesTicketdetails(@RequestParam int id, @ModelAttribute Tickets ticket) {
		
	    model = new ModelAndView();
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			String technician = userName.getFirstName()+ " "+userName.getLastName();
			ticket = logTicketService.getLoggedTicketByTicketNumber(id);
			model.addObject("ticketObject", ticket);
			model.addObject("saveSpareParts", new SparePartsBean());
			getSerials = spareMasterServiceInt.getSerials();
			model.addObject("spareParts",getSerials);
			model.addObject("contactPerson",contactDetailsServiceInt.getContactPerson(ticket.getDevice().getCustomerDevice().getCustomerName()));
			model.addObject("ticketHistoryList", ticketHistoryInt.getHistoryByTicketNumber(id));
			model.addObject("OrderNumber",ordersServiceInt.getAllOrders(userName.getEmail()));
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("managersList",employeeServiceInt.getAllManagers());
			model.addObject("customerList",customerServiceInt.getClientList());
			model.addObject("bootStock", bootStockint.getAllOrders(technician));
			model.addObject("orderStatus", historyInt.getAllOrderHistoryTicketNumber(id));
			model.addObject("siteStock",siteStock.getOrdersForCustomer(ticket.getDevice().getCustomerDevice().getCustomerName()));
			
			model.setViewName("awaitingSparesDetails");
		}
		else{
			model.setViewName("login");
		}
		return model;
    }
	
	@RequestMapping("awaitSpares")
	public ModelAndView awaitSpares(){
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		     
			 model.addObject("retMessage", retMessage);
			 model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));				
			 model.addObject("ticketList", logTicketService.getAllAwaitingSpares());			   
			 model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			 model.setViewName("awaitSpares");
		}
		else{
			 model.setViewName("login");
		}		
		return model;
	}
	@RequestMapping("awaitingSparesTechDetails")
    public ModelAndView loadAwaitingSparesTechdetails(@RequestParam int id, @ModelAttribute Tickets ticket) {
		
	    model = new ModelAndView();
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		
			
			ticket = logTicketService.getLoggedTicketByTicketNumber(id);
			model.addObject("ticketObject", ticket);
			model.addObject("contactPerson",contactDetailsServiceInt.getContactPerson(ticket.getDevice().getCustomerDevice().getCustomerName()));
			model.addObject("ticketHistoryList", ticketHistoryInt.getHistoryByTicketNumber(id));
			model.addObject("OrderNumber",ordersServiceInt.getAllOrders(userName.getEmail()));
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("managersList",employeeServiceInt.getAllManagers());
			model.addObject("orderStatus", historyInt.getAllOrderHistoryTicketNumber(id));
			model.setViewName("awaitingSparesTechDetails");
		}
		else{
			model.setViewName("login");
		}
		return model;
    }
	
	@RequestMapping("bridgedTickets")
	public ModelAndView bridgedTickets(){
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		     
		    model.addObject("retMessage", retMessage);
		    model.addObject("ticketList", logTicketService.getAllBridgedTickets());
		    model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("bridgedTickets");
		}
		else{
			model.setViewName("login");
		}		
		return model;
	}
	@RequestMapping("bridgedTicketsDetails")
    public ModelAndView loadBridgedTicketsDetails(@RequestParam int id, @ModelAttribute Tickets ticket) {
		
	    model = new ModelAndView();
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		
			ticket = logTicketService.getLoggedTicketByTicketNumber(id);
			model.addObject("ticketObject", ticket);
			model.addObject("contactPerson",contactDetailsServiceInt.getContactPerson(ticket.getDevice().getCustomerDevice().getCustomerName()));
			model.addObject("ticketHistoryList", ticketHistoryInt.getHistoryByTicketNumber(id));
			model.addObject("OrderNumber",ordersServiceInt.getAllOrders(userName.getEmail()));
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("managersList",employeeServiceInt.getAllManagers());
			model.setViewName("bridgedTicketsDetails");
		}
		else{
			model.setViewName("login");
		}
		return model;
    }
	
	@RequestMapping("slaBridged")
	public ModelAndView slaBridged(){
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){		    
			
			model.addObject("retMessage", retMessage);
			model.addObject("ticketList", logTicketService.getAllBridgedTickets(userName.getEmail()));
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));			
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("slaBridged");
		}
		else{
			model.setViewName("login");
		}		
		return model;
	}
	@RequestMapping("bridgedTechDetails")
    public ModelAndView loadBridgedTechDetails(@RequestParam int id, @ModelAttribute Tickets ticket) {
		
	    model = new ModelAndView();
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			String technician = userName.getFirstName()+ " "+userName.getLastName();
			ticket = logTicketService.getLoggedTicketByTicketNumber(id);
			model.addObject("ticketObject", ticket);
			model.addObject("contactPerson",contactDetailsServiceInt.getContactPerson(ticket.getDevice().getCustomerDevice().getCustomerName()));
			model.addObject("ticketHistoryList", ticketHistoryInt.getHistoryByTicketNumber(id));
			model.addObject("OrderNumber",ordersServiceInt.getAllOrders(userName.getEmail()));
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("siteStock",siteStock.getOrdersForCustomer(ticket.getDevice().getCustomerDevice().getCustomerName()));
			model.addObject("bootStock", bootStockint.getAllOrders(technician));
			model.addObject("managersList",employeeServiceInt.getAllManagers());
			model.setViewName("bridgedTechDetails");
		}
		else{
			model.setViewName("login");
		}
		return model;
    }

	@RequestMapping("escalatedTickes")
	public ModelAndView escalatedTickes(){
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		     
		    model.addObject("retMessage", retMessage);		    
		    model.addObject("ticketList", logTicketService.getAllEscalatedTickets());
		    model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("escalatedTickes");
		}
		else{
			model.setViewName("login");
		}		
		return model;
	}
	@RequestMapping("escalatedTickesDetails")
    public ModelAndView loadEscalatedTickesDetails(@RequestParam int id, @ModelAttribute Tickets ticket) {
		
	    model = new ModelAndView();
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		
			ticket = logTicketService.getLoggedTicketByTicketNumber(id);
			model.addObject("ticketObject", ticket);
			model.addObject("contactPerson",contactDetailsServiceInt.getContactPerson(ticket.getDevice().getCustomerDevice().getCustomerName()));
			model.addObject("ticketHistoryList", ticketHistoryInt.getHistoryByTicketNumber(id));
			model.addObject("OrderNumber",ordersServiceInt.getAllOrders(userName.getEmail()));
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("managersList",employeeServiceInt.getAllManagers());
			model.setViewName("escalatedTickesDetails");
		}
		else{
			model.setViewName("login");
		}
		return model;
    }
	
	@RequestMapping("escalatedTech")
	public ModelAndView escalatedTech(){
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		     
			 model.addObject("retMessage", retMessage);		    
			 model.addObject("ticketList", logTicketService.getAllEscalatedTickets());
			 model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));				
			 model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			 model.setViewName("escalatedTech");
		}
		else{
			model.setViewName("login");
		}		
		return model;
	}
	@RequestMapping("escalatedTechDetails")
    public ModelAndView loadEscalatedTechDetails(@RequestParam int id, @ModelAttribute Tickets ticket) {
		
	    model = new ModelAndView();
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			ticket = logTicketService.getLoggedTicketByTicketNumber(id);
			model.addObject("ticketObject", ticket);
			model.addObject("contactPerson",contactDetailsServiceInt.getContactPerson(ticket.getDevice().getCustomerDevice().getCustomerName()));
			model.addObject("ticketHistoryList", ticketHistoryInt.getHistoryByTicketNumber(id));
			model.addObject("OrderNumber",ordersServiceInt.getAllOrders(userName.getEmail()));
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("managersList",employeeServiceInt.getAllManagers());
			model.addObject("manager",employeeServiceInt.getEmployeeByEmpNumber(ticket.getEscalatedTo()));
			model.setViewName("escalatedTechDetails");
		}
		else{
			model.setViewName("login");
		}
		return model;
    }
	
	@RequestMapping(value={"resolvedTickets", "userResolvedTickets"})
	public ModelAndView resolvedTicket(){
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		     
			 model.addObject("retMessage", retMessage);		    
			 model.addObject("ticketList", logTicketService.getAllResolvedTickets());
			 model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));				
			 model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			 
			 if (userName.getRole().equalsIgnoreCase("Manager") || userName.getRole().equalsIgnoreCase("Admin")) {				
			    	
				 	model.setViewName("resolvedTickets");
				 	
			  }else if (userName.getRole().equalsIgnoreCase("User")){
			    	
			    	model.setViewName("userResolvedTickets");
			  }			
			}else{
			model.setViewName("login");
		}		
		return model;
	}
	@RequestMapping(value={"resolvedTickectDetails", "userResolvedTickectDetails"})
    public ModelAndView loadResolvedTicketDetails(@RequestParam int id, @ModelAttribute Tickets ticket) {
		
	    model = new ModelAndView();
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		
			ticket = logTicketService.getLoggedTicketByTicketNumber(id);
			model.addObject("ticketObject", ticket);
			model.addObject("contactPerson",contactDetailsServiceInt.getContactPerson(ticket.getDevice().getCustomerDevice().getCustomerName()));
			model.addObject("ticketHistoryList", ticketHistoryInt.getHistoryByTicketNumber(id));
			model.addObject("OrderNumber",ordersServiceInt.getAllOrders(userName.getEmail()));
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("managersList",employeeServiceInt.getAllManagers());
			
			if(userName.getRole().equalsIgnoreCase("Manager") || userName.getRole().equalsIgnoreCase("Admin") )
				
			model.setViewName("resolvedTickectDetails");
		  }else if (userName.getRole().equalsIgnoreCase("User")){
		    	
		    	model.setViewName("userResolvedTickets");
		  }else{
			   model.setViewName("login");
		  }		
		
		return model;
	}
	
	@RequestMapping("resolvedTechTickets")
	public ModelAndView resolvedTechTicket(){
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		     
			 model.addObject("retMessage", retMessage);	
			 
			 model.addObject("ticketList", logTicketService.getAllResolvedTickets(userName.getEmail()));
			 model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));				
			 model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			 model.setViewName("resolvedTechTickets");
		}
		else{
			model.setViewName("login");
		}		
		return model;
	}
	@RequestMapping("resolvedTechTicketsDetails")
    public ModelAndView loadResolvedTechTicketsDetails(@RequestParam int id, @ModelAttribute Tickets ticket) {
		
	    model = new ModelAndView();
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		
			ticket = logTicketService.getLoggedTicketByTicketNumber(id);
			model.addObject("ticketObject", ticket);
			model.addObject("contactPerson",contactDetailsServiceInt.getContactPerson(ticket.getDevice().getCustomerDevice().getCustomerName()));
			model.addObject("ticketHistoryList", ticketHistoryInt.getHistoryByTicketNumber(id));
			model.addObject("OrderNumber",ordersServiceInt.getAllOrders(userName.getEmail()));
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("managersList",employeeServiceInt.getAllManagers());
			model.setViewName("resolvedTechTicketsDetails");
		}
		else{
			model.setViewName("login");
		}
		return model;
    }
	
	@RequestMapping("technicianDashboard")
	public ModelAndView bridgedTicketsForTech(){
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		    
			model.addObject("shipment",	ordersServiceInt.shippedOrders(userName.getEmail()));
		    model.addObject("ticketList", logTicketService.getAllBridgedTickets());
		    model.addObject("inboxCount",	ordersServiceInt.pendingOrdersCount(userName.getEmail()));		   
		    model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
		    model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets(userName.getEmail()));
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets(userName.getEmail()));
			model.addObject("bridgedTickets", ticketsServiceInt.countBridgedTickets(userName.getEmail()));
			model.addObject("resolvedTickets", ticketsServiceInt.countResolvedTickets(userName.getEmail()));
			model.addObject("closedTickets", ticketsServiceInt.countClosedTickets(userName.getEmail()));
			model.setViewName("technicianDashboard");
		}
		else{
			model.setViewName("login");
		}		
		return model;
	}
	
	@ExceptionHandler({DataIntegrityViolationException.class})
    public ModelAndView dataIntegrity(Exception ex) {
        ModelAndView model = new ModelAndView("405");
 
        model.addObject("exception", ex.getMessage());
         
        return model;
    }
	
}
