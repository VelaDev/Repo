package com.demo.controller;



import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.demo.bean.SparePartsBean;
import com.demo.model.Employee;
import com.demo.model.HOStock;
import com.demo.model.SpareMaster;
import com.demo.service.BootStockInt;
import com.demo.service.CustomerServiceInt;
import com.demo.service.EmployeeServiceInt;
import com.demo.service.OrderDetailsInt;
import com.demo.service.OrdersServiceInt;
import com.demo.service.SiteStockInt;
import com.demo.service.SpareMasterServiceInt;
import com.demo.service.HOStockServeceInt;
import com.demo.service.TicketsServiceInt;

@Controller
public class SparePartsController {
	@Autowired
	private CustomerServiceInt customerServiceInt;
	@Autowired
	private EmployeeServiceInt employeeService;
	@Autowired
	private OrdersServiceInt ordersServiceInt;
	@Autowired
	private HOStockServeceInt hOStockServeceInt;
	@Autowired
	private OrderDetailsInt orderDetailsInt;
	@Autowired
	private SpareMasterServiceInt spareMasterServiceInt;
	@Autowired
	private BootStockInt bootStock;	
	@Autowired
	private SiteStockInt siteStock;
	@Autowired
	private HttpSession session = null;
	@Autowired
	private TicketsServiceInt ticketsServiceInt;
	private String retMessage = null;
	private ModelAndView model = null;
	private Employee userName = null;
	public String[] getSerials = null;
	private String retPage = null;
	private HOStock stock;
	private SpareMaster master;
	
	@RequestMapping(value="addSpares", method=RequestMethod.GET)
	public ModelAndView loadAddSpares()
	{
	    model = new ModelAndView("addSpares");
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			model.addObject("saveSpareParts", new SparePartsBean());
			getSerials = spareMasterServiceInt.getSerials();
			model.addObject("spareParts",getSerials);
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("addSpares");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping(value="addSparesParts", method=RequestMethod.POST)
	public ModelAndView SaveSpareParts(@ModelAttribute("addSparesParts")HOStock spareParts){
		model = new ModelAndView();
		String addSpares = "addSpares";
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			
			retMessage = hOStockServeceInt.saveSpareparts(spareParts);			
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("addSpares", addSpares);
			model.setViewName("confirmations");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping(value="receiveParts", method=RequestMethod.GET)
	public ModelAndView loadSaveSpareParts()
	{
	    model = new ModelAndView("receiveParts");
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			model.addObject("saveSpareParts", new SparePartsBean());
			getSerials = spareMasterServiceInt.getSerials();
			model.addObject("spareParts",getSerials);
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.setViewName("receiveParts");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping(value="saveSpareParts", method=RequestMethod.POST)
	public ModelAndView saveSaveSpareParts(@ModelAttribute("saveSpareParts")HOStock spareParts){
		String receiveSpareParts = "receiveSpareParts";
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			
			retMessage = hOStockServeceInt.saveSpareparts(spareParts);
			
			model.addObject("retMessage", retMessage);
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("receiveSpareParts", receiveSpareParts);
			model.setViewName("confirmations");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping(value="availableSpareParts", method=RequestMethod.GET)
	public ModelAndView getSpareParts(){
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			
			model.addObject("spareParts", hOStockServeceInt.getAllSparePartsWithoutZero());
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("availableSpareParts");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	@RequestMapping(value="bootSite", method=RequestMethod.GET)
	public ModelAndView getSparePartsSite(){
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			
			model.addObject("employees",employeeService.getAllTechnicians());
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("bootSite");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	@RequestMapping(value="loadBootStock")
	public ModelAndView loadBootStock(@RequestParam("technician") String technician){
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			model.addObject("orders",bootStock.getAllOrders(technician));
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("bootSiteOrders");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	@RequestMapping(value="availableSites", method=RequestMethod.GET)
	public ModelAndView getSparePartSite(){
		model = new ModelAndView();
				
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("shipment",	ordersServiceInt.shippedOrders(userName.getEmail()));
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("customer",customerServiceInt.getClientList());			
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
			model.setViewName("availableSites");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}	
	@RequestMapping(value="loadStockSite")
	public ModelAndView loadStockSite(@RequestParam("customerName") String customerName){
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		
		if(userName != null){
			model.addObject("orders", siteStock.getOrdersForCustomer(customerName));
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("stockSiteOrders");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	@RequestMapping(value="loadStockSiteForTechnician")
	public ModelAndView loadStockSiteforTechnician(@RequestParam("customerName") String customerName){
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		
		if(userName != null){
			model.addObject("orders", siteStock.getOrdersForCustomer(customerName));
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("stockSiteOrdersForTechnician");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping(value="searchpartNumber")
	public ModelAndView searchPartNumber(@RequestParam("partNumber") String partNumber) {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			master =spareMasterServiceInt.getSpareMaster(partNumber);
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			if(master !=null){
				model.addObject("sparePart", master);
				model.addObject("models", spareMasterServiceInt.getModelDevice(partNumber));
				
			}else{
				model.addObject("errorRetMessage", "Part Number does not exist.");
			}
		model.setViewName("receiveParts");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="spareToMasterData", method=RequestMethod.POST)
	public ModelAndView addSpareToMAsterData(@ModelAttribute("spareToMasterData")SpareMaster spareMaster){
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){

			retMessage = spareMasterServiceInt.saveSpareMasterData(spareMaster);
			
			if(retMessage.startsWith("Part number already exist")){
				String errorRetMessage = retMessage;
				model.addObject("errorRetMessage", errorRetMessage);
			}else{
				model.addObject("retMessage", retMessage);
			}
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("addSpares");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	
}
