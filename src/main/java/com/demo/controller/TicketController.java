package com.demo.controller;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
		
			getSerialNumbers = deviceServiceInt.getSerials();
			model.addObject("serialNumbers",getSerialNumbers);
			model.addObject("technicians",employeeServiceInt.getAllTechnicians());
			model.addObject("logTicket", new TicketsBean());
			
			model.setViewName("ticket");
		}
		else{
			model.setViewName("login");
		}
		
		
		return model;     
		
	}	
	
	@RequestMapping(value="/logTicket",method=RequestMethod.POST)
	public ModelAndView logTicket(@ModelAttribute("logTicket")TicketsBean logTickets){
	
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			retMessage = logTicketService.logTicket(logTickets);
		   model.addObject("retMessage", retMessage);
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
			model.addObject("contactPerson",contactDetailsServiceInt.getContactPerson(ticket.getDevice().getCustomer().getCustomerName()));
			model.addObject("ticketHistoryList", ticketHistoryInt.getHistoryByTicketNumber(id));
			model.addObject("OrderNumber",ordersServiceInt.getAllOrders(userName.getEmail()));
			model.setViewName("ticketDetails");
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
		    model.addObject("retMessage", retMessage);
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
			model.setViewName("userUpdateTicket");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
		
	}
	@RequestMapping("searchTechnician")
    public ModelAndView searchEmployee(@RequestParam("searchName") String searchName) {  
        return new ModelAndView("");      
    }
	
	@RequestMapping("clientInfo")
	public ModelAndView clientInfo(){
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			model.addObject("", "");
			model.setViewName("clientInfo");
		}
		else{
			  model.setViewName("login");
		}
		return model;
	}
	@RequestMapping(value="logTicket",method=RequestMethod.GET)
	public ModelAndView loadTicketAdmin() {
       
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
		
			model.addObject("technicians",employeeServiceInt.getAllTechnicians());
			model.addObject("logTicket", new TicketsBean());
			
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
			model.setViewName("ticketUpdate");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	
	@RequestMapping(value="/logTicketAdmin",method=RequestMethod.POST)
	public ModelAndView logTicketAdmin(@ModelAttribute("logTicketAdmin")TicketsBean logTickets){
	
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			retMessage = logTicketService.logTicket(logTickets);
		   model.addObject("retMessage", retMessage);
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
			count = ticketsServiceInt.count();
			beanList = ticketsServiceInt.ticketsResults();
			model.addObject("home", ticketsServiceInt.getAllLoggedTickets(offset, maxResults));
			model.addObject("ticketResults",beanList);
			model.addObject("count",count);
			model.setViewName("userTicket");
		}
		else{
			model.setViewName("login");
		}
		return model;  
		
	}

}
