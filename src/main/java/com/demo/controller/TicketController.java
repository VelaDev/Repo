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
import com.demo.bean.TicketsBean;
import com.demo.model.Customer;
import com.demo.model.Employee;
import com.demo.model.Tickets;
import com.demo.service.CustomerContactDetailsServiceInt;
import com.demo.service.CustomerServiceInt;
import com.demo.service.EmployeeServiceInt;
import com.demo.service.LeaveInt;
import com.demo.service.OrdersServiceInt;
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
	private LeaveInt leaveInt;
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
	
	@RequestMapping(value="ticket",method=RequestMethod.GET)
	public ModelAndView loadTicket() {
       
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			model.addObject("technicians",employeeServiceInt.getAllTechnicians());
			model.addObject("logTicket", new TicketsBean());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("ticket");
		}
		else{
			model.setViewName("login");
		}
		
		
		return model;     
		
	}	
	
	@RequestMapping(value="logTicket",method=RequestMethod.POST)
	public ModelAndView logTicket(@ModelAttribute("logTicket")TicketsBean logTickets){
	
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		   retMessage = logTicketService.logTicket(logTickets);
		   model.addObject("retMessage", retMessage);
		   model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
		   model.setViewName("ticket");
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
    public ModelAndView loadTicketdetails(@RequestParam String id, @ModelAttribute Tickets ticket) {
		
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
			model.addObject("customerList",customerServiceInt.getClientList());
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
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		     
			retMessage = logTicketService.updateTicket(updateTicket);
			  
			if(retMessage.startsWith("The part number")){
				String retErrorMessage = retMessage;
				model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));				
				model.addObject("retErrorMessage", retErrorMessage);
			}else{
				model.addObject("retMessage", retMessage);
			}
		    
		    model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("ticketDetails");
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
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("logTicket");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping("AssignTicketToOtherTechnician")
    public ModelAndView assignTicketToAnotherTechnicia(@RequestParam String ticketNumber, @ModelAttribute Tickets ticket) {
		
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
    public ModelAndView userAssignTicketToAnotherTechnicia(@RequestParam String ticketNumber, @ModelAttribute Tickets ticket) {
		
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
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		     
			retMessage = logTicketService.updateTicket(updateTicket);
		    model.addObject("retMessage", retMessage);
		    model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("ticketUpdate");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	
	@RequestMapping(value="logTicketAdmin",method=RequestMethod.POST)
	public ModelAndView logTicketAdmin(@ModelAttribute("logTicketAdmin")TicketsBean logTickets){
	
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			retMessage = logTicketService.logTicket(logTickets);
			
			if(retMessage.startsWith("C")){
			 String	message =retMessage;
			 model.addObject("message",message );
			}else{
				model.addObject("retMessage",retMessage );
				
			}
			 model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));	 
		  
		   model.setViewName("logTicket");
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
    public ModelAndView loadOpenTicketsDetails(@RequestParam String id, @ModelAttribute Tickets ticket) {
		
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
			model.setViewName("openTicketsDetails");
		}
		else{
			model.setViewName("login");
		}
		return model;
    }
	
	@RequestMapping("closedTickets")
	public ModelAndView closedTickets(){
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		     
		    model.addObject("retMessage", retMessage);
		    model.addObject("ticketList", logTicketService.getAllClosedTickets());			   
		    model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("closedTickets");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping("closedTicketsDetails")
    public ModelAndView loadClosedTicketsDetails(@RequestParam String id, @ModelAttribute Tickets ticket) {
		
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
			model.setViewName("closedTicketsDetails");
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
    public ModelAndView loadBridgedTicketsDetails(@RequestParam String id, @ModelAttribute Tickets ticket) {
		
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

	
	@RequestMapping("technicianDashboard")
	public ModelAndView bridgedTicketsForTech(){
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		     
		    model.addObject("retMessage", retMessage);
		    model.addObject("ticketList", logTicketService.getAllBridgedTickets());
		    model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("technicianDashboard");
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
    public ModelAndView loadEscalatedTickesDetails(@RequestParam String id, @ModelAttribute Tickets ticket) {
		
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
    public ModelAndView loadAwaitingSparesTicketdetails(@RequestParam String id, @ModelAttribute Tickets ticket) {
		
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
			model.setViewName("awaitingSparesDetails");
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
		     
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));		   
		    model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
			model.setViewName("slaBridged");
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
		     
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));		   
		    model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
			model.setViewName("escalatedTech");
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
		     
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));		   
		    model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
			model.setViewName("awaitSpares");
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
