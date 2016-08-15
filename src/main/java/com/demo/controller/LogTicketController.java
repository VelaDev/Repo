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
	
	
	Calendar cal = Calendar.getInstance();
	
	@RequestMapping(value="ticket",method=RequestMethod.GET)
	public ModelAndView loadTicket() {
       
		ModelAndView model = new ModelAndView("ticket");
		model.addObject("technicians",employeeServiceInt.getAllTechnicians());
		model.addObject("logTicket", new TicketsBean());
		
		model.setViewName("ticket");
		
		
		return model;     
		
	}	
	
	@RequestMapping(value="/logTicket",method=RequestMethod.POST)
	public String logTicket(@ModelAttribute("logTicket")Tickets logTickets){
	
		String serialNo = (String) session.getAttribute("serialNumber");
		product = productServiceInt.getProductBySerialNumber(serialNo);
			if( product !=null)
			{
				//logTickets.setClient(client);
				logTickets.setProduct(product);
				logTickets.setDateTime(cal);
				logTicketService.logTicket(logTickets);
			}else
			{
				//model.addObject("error", "Invalid username and password!");
				System.out.println("Product not exist");
			}
			
		return "redirect:ticket";
		
	}

	@RequestMapping(value = {"monitoringTickets"})
    public ModelAndView displayLoggedTickets() {
		
		ModelAndView model = new ModelAndView();
		model.addObject("ticketList", logTicketService.getAllOpenTickets());
		model.setViewName("monitoringTickets");
		return model;
       
    }
	@RequestMapping("ticketDetails")
    public ModelAndView loadTicketdetails(@RequestParam int id, @ModelAttribute Tickets ticket) {
		
		@SuppressWarnings("unused")
		ModelAndView model = new ModelAndView();
		ticket = logTicketService.getLoggedTicketByTicketNumber(id);
	    return new ModelAndView("ticketDetails", "ticketObject", ticket);
		
    }
	@RequestMapping(value="/updateTicket",method=RequestMethod.POST)
	public String updateTicket(@ModelAttribute("updateTicket")Tickets updateTicket){
		
		if(updateTicket.getTicketNumber()>0 && updateTicket.isTechnicianAcknowledged()==true){
			
			logTicketService.updateTicket(updateTicket);
		}
		return "redirect:technicianHome";
		
	}
	@RequestMapping("searchTechnician")
    public ModelAndView searchEmployee(@RequestParam("searchName") String searchName) {  
        return new ModelAndView("");      
    }
	
}
