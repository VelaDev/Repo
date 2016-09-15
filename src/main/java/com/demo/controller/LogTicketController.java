package com.demo.controller;

import java.util.Calendar;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.demo.bean.TicketsBean;
import com.demo.model.Client;
import com.demo.model.Product;
import com.demo.model.Tickets;
import com.demo.service.ClientServiceInt;
import com.demo.service.EmployeeServiceInt;
import com.demo.service.LogTicketsServiceInt;
import com.demo.service.ProductServiceInt;


@Controller
public class LogTicketController {
	
	@Autowired
	private LogTicketsServiceInt logTicketService;
	@Autowired
	private ClientServiceInt clientServiceInt;
	@Autowired
	private ProductServiceInt productServiceInt;
	@Autowired
	private EmployeeServiceInt employeeServiceInt;
	
	@Autowired
	private HttpSession session = null;
	
	//private Employee employee = null;
	private Product product = null;
	@SuppressWarnings("unused")
	private Client client = null;
	private ModelAndView model = null;
	private String userName= null;
	private String retMessage ="";
	
	
	Calendar cal = Calendar.getInstance();
	
	@RequestMapping(value="ticket",method=RequestMethod.GET)
	public ModelAndView loadTicket() {
       
		model = new ModelAndView();
		userName = (String) session.getAttribute("loggedInUser");
		if(userName !=null){
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
	public ModelAndView logTicket(@ModelAttribute("logTicket")Tickets logTickets){
	
		model = new ModelAndView();
		userName = (String) session.getAttribute("loggedInUser");
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
		userName = (String) session.getAttribute("loggedInUser");
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
		 userName = (String) session.getAttribute("loggedInUser");
			if(userName !=null){
		ticket = logTicketService.getLoggedTicketByTicketNumber(id);
		model.addObject("ticketObject", ticket);
		model.setViewName("ticketDetails");
			}
			else{
				model.setViewName("login");
			}
		return model;
    }
	@RequestMapping(value="/updateTicket",method=RequestMethod.POST)
	public ModelAndView updateTicket(@ModelAttribute("updateTicket")Tickets updateTicket){
		
		model = new ModelAndView();
		userName = (String) session.getAttribute("loggedInUser");
		if(userName !=null){
		/*if(updateTicket.getTicketNumber()>0 && updateTicket.isTechnicianAcknowledged()==true){
			
			logTicketService.updateTicket(updateTicket);
			model.setViewName("technicianHome");
		   }*/
		}else{
			model.setViewName("login");
		}
		
		return model;
		
	}
	@RequestMapping("searchTechnician")
    public ModelAndView searchEmployee(@RequestParam("searchName") String searchName) {  
        return new ModelAndView("");      
    }
	
}
