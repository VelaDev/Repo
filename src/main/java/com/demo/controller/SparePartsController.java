package com.demo.controller;



import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.xml.JRPenFactory.Bottom;

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
	private EmployeeServiceInt employeeServiceInt;
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
	private Employee tempEmployee = null;
	private String globalTechnicianName = null;
	private String globalCustomerName = null;
	
	//spare management
	@RequestMapping(value = {"sparemanagement","techsparemanagement","usersparemanagement"}, method = RequestMethod.GET)
	public ModelAndView displayOrderTechManagement() {
			
			model = new ModelAndView();
			globalCustomerName = null;
			globalTechnicianName = null;
		
			userName = (Employee) session.getAttribute("loggedInUser");
			if (userName != null) {
				if(userName.getRole().equalsIgnoreCase("Manager") || (userName.getRole().equalsIgnoreCase("Admin"))){
				//HO Count
				model.addObject("hoCount", hOStockServeceInt.countHeadOfficeStock());
				//Site Count
				model.addObject("siteCount", siteStock.countSiteStock());
				//Boot Count
				model.addObject("bootCount", bootStock.countBootStock());			
				//Load Data of HO 
				model.addObject("spareParts", hOStockServeceInt.getAllSparePartsWithoutZero());			
				//Load Data Boot Site
				model.addObject("employees",employeeService.getAllTechnicians());			
				//Load data of bootSite
				model.addObject("customer",customerServiceInt.getClientList());			
				model.setViewName("sparemanagement");
				
			}else if (userName.getRole().equalsIgnoreCase("Technician")){
				//HO Count
				model.addObject("hoCount", hOStockServeceInt.countHeadOfficeStock());
				//Site Count
				model.addObject("siteCount", siteStock.countSiteStock());
				//Boot Count
				model.addObject("bootCount", bootStock.countBootStock());
				//Load Data of HO 
				model.addObject("firstName", userName.getFirstName());
				model.addObject("lastName", userName.getLastName());
				model.addObject("email", userName.getEmail());
				//Load Data Boot Site
				model.addObject("employees",employeeService.getAllTechnicians());
				//Load data of bootSite
				model.addObject("customer",customerServiceInt.getClientList());			
				model.setViewName("techsparemanagement");
				
			}else if(userName.getRole().equalsIgnoreCase("User")){		
				//Site Count
				model.addObject("siteCount", siteStock.countSiteStock());
				//Boot Count
				model.addObject("bootCount", bootStock.countBootStock());
				//Load Data of HO 
				model.addObject("firstName", userName.getFirstName());
				model.addObject("lastName", userName.getLastName());
				model.addObject("email", userName.getEmail());						
				//Load Data Boot Site
				model.addObject("employees",employeeService.getAllTechnicians());
				//Load data of bootSite
				model.addObject("customer",customerServiceInt.getClientList());
				model.setViewName("usersparemanagement");
			}
				
			}else {
				model.setViewName("login");
			}
			return model;
		}
	
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
	
	@RequestMapping(value={"receiveParts","userRecieveParts"}, method=RequestMethod.GET)
	public ModelAndView loadSaveSpareParts()
	{
	    model = new ModelAndView("receiveParts");
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			if(userName.getRole().equalsIgnoreCase("Manager") || (userName.getRole().equalsIgnoreCase("Admin"))){
				model.addObject("saveSpareParts", new SparePartsBean());
				getSerials = spareMasterServiceInt.getSerials();
				model.addObject("spareParts",getSerials);
				model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
				model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());
				model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
				model.setViewName("receiveParts");
				
			}else if (userName.getRole().equalsIgnoreCase("User")){
				model.addObject("saveSpareParts", new SparePartsBean());
				getSerials = spareMasterServiceInt.getSerials();
				model.addObject("spareParts",getSerials);
				model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
				model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());
				model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
				model.setViewName("userReceiveParts");
			}
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
	public ModelAndView getSparePartBootStock(){
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
	//Removed code by mistake
	@RequestMapping(value="stockSite", method=RequestMethod.GET)
	public ModelAndView getSparePartSiteStock(){
		model = new ModelAndView();
				
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			model.addObject("customer",customerServiceInt.getClientList());			
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());
			model.setViewName("stockSite");
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
	@RequestMapping(value="loadBootStock")
	public ModelAndView loadBootStock(@RequestParam("technician") String technician){
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		globalTechnicianName = technician;
		if(userName != null){
			model.addObject("countPartForTech",bootStock.countPartsForTechnician(technician));
			model.addObject("countTonerForTech",bootStock.countTonerForTechnician(globalTechnicianName));
			model.addObject("orders",bootStock.getAllOrders(technician));
			model.setViewName("bootSiteOrders");
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
		globalTechnicianName = null;
		globalCustomerName = customerName;
		
		if(userName != null){
			model.addObject("orders", siteStock.getOrdersForCustomer(globalCustomerName));
			model.addObject("countPartForCustomer",siteStock.countPartsForCustomer(globalCustomerName));
			model.addObject("countTonerForCustomer",siteStock.countTonerForCustomer(globalCustomerName));
	
			
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
		globalCustomerName = customerName;
		if(userName != null){
			if (userName.getRole().equalsIgnoreCase("Technician"))
			{
				model.addObject("orders", siteStock.getOrdersForCustomer(globalCustomerName));
				model.addObject("countPartForCustomer",siteStock.countPartsForCustomer(globalCustomerName));
				model.addObject("countTonerForCustomer",siteStock.countTonerForCustomer(globalCustomerName));	
				model.setViewName("stockSiteOrdersForTechnician");
			}else if(userName.getRole().equalsIgnoreCase("User")){
				model.addObject("orders", siteStock.getOrdersForCustomer(globalCustomerName));
				model.addObject("countPartForCustomer",siteStock.countPartsForCustomer(globalCustomerName));
				model.addObject("countTonerForCustomer",siteStock.countTonerForCustomer(globalCustomerName));
				model.setViewName("stockSiteOrdersForUser");
			}

		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping(value="loadBootStockForTechnician")
	public ModelAndView loadBootStockForTechnician(@RequestParam("technician") String technician){
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		globalTechnicianName = technician;
		userName = (Employee) session.getAttribute("loggedInUser");
		String techfullname = userName.getFirstName() + " " + userName.getLastName();
		if(userName != null){
			if (userName.getRole().equalsIgnoreCase("Technician"))
			{
				model.addObject("countPartForTech",bootStock.countPartsForTechnician(techfullname));
				model.addObject("countTonerForTech",bootStock.countTonerForTechnician(techfullname));
				model.addObject("orders",bootStock.getAllOrders(techfullname));				
				model.setViewName("bootSiteOrdersForTechnician");
				
			}else if(userName.getRole().equalsIgnoreCase("User")){
				
				model.addObject("countPartForTech",bootStock.countPartsForTechnician(techfullname));
				model.addObject("countTonerForTech",bootStock.countTonerForTechnician(techfullname));
				model.addObject("orders",bootStock.getAllOrders(techfullname));				
				model.setViewName("bootSiteOrdersForUser");
			}
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping(value={"searchpartNumber","userSearchPartNumber"})
	public ModelAndView searchPartNumber(@RequestParam("partNumber") String partNumber) {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			if(userName.getRole().equalsIgnoreCase("Manager") || (userName.getRole().equalsIgnoreCase("Admin"))){
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
		}else if(userName.getRole().equalsIgnoreCase("User")){
			
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
			model.setViewName("userReceiveParts");
		}
		
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
		
	
	
	//Number of parts
	@RequestMapping(value="numberOfParts", method=RequestMethod.GET)
	public ModelAndView getNumberOfSpareParts(){
		model = new ModelAndView();
				
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			
			if (userName.getRole().equalsIgnoreCase("Manager") || userName.getRole().equalsIgnoreCase("Admin"))
			{ 
				if (globalTechnicianName != null){
					model.addObject("countPartForTech",bootStock.countPartsForTechnician(globalTechnicianName));
					model.addObject("countTonerForTech",bootStock.countTonerForTechnician(globalTechnicianName));
					model.addObject("orders", bootStock.getPartsForTechnician(globalTechnicianName));					
					model.setViewName("bootSiteOrders");	
				}
				else if (globalCustomerName != null){
					model.addObject("countPartForCustomer",siteStock.countPartsForCustomer(globalCustomerName));
					model.addObject("countTonerForCustomer",siteStock.countTonerForCustomer(globalCustomerName));
					model.addObject("orders", siteStock.getPartsForCustomer(globalCustomerName));					
					model.setViewName("stockSiteOrders");
				}
				
			}
			else if (userName.getRole().equalsIgnoreCase("Technician"))
			{ 
				String localTechnician = userName.getFirstName() + " " + userName.getLastName();
				if (globalTechnicianName != null)
				{
					if (localTechnician != null){
						model.addObject("countPartForTech",bootStock.countPartsForTechnician(localTechnician));
						model.addObject("countTonerForTech",bootStock.countTonerForTechnician(localTechnician));
						model.addObject("orders", bootStock.getPartsForTechnician(localTechnician));						
						model.setViewName("bootSiteOrdersForTechnician");	
					}
				}
				else if (globalCustomerName != null)
				{
						model.addObject("countPartForCustomer",siteStock.countPartsForCustomer(globalCustomerName));
						model.addObject("countTonerForCustomer",siteStock.countTonerForCustomer(globalCustomerName));
						model.addObject("orders", siteStock.getPartsForCustomer(globalCustomerName));						
						model.setViewName("stockSiteOrdersForTechnician");			
				}
				
			}
			else if (userName.getRole().equalsIgnoreCase("User"))
			{ 
				String localTechnician = userName.getFirstName() + " " + userName.getLastName();
				if (globalTechnicianName != null)
				{
					if (localTechnician != null){
						model.addObject("countPartForTech",bootStock.countPartsForTechnician(localTechnician));
						model.addObject("countTonerForTech",bootStock.countTonerForTechnician(localTechnician));
						model.addObject("orders", bootStock.getPartsForTechnician(localTechnician));						
						model.setViewName("bootSiteOrdersForUser");	
					}
				}
				else if (globalCustomerName != null)
				{
						model.addObject("countPartForCustomer",siteStock.countPartsForCustomer(globalCustomerName));
						model.addObject("countTonerForCustomer",siteStock.countTonerForCustomer(globalCustomerName));
						model.addObject("orders", siteStock.getPartsForCustomer(globalCustomerName));						
						model.setViewName("stockSiteOrdersForUser");			
				}
				
			}
		}
		else{
			model.setViewName("login");
		}
		return model;
	}	
	
	
	//Number of toner
	@RequestMapping(value="numberOfToners", method=RequestMethod.GET)
	public ModelAndView getNumberOfToners(){
	model = new ModelAndView();
					
			userName = (Employee) session.getAttribute("loggedInUser");
			if (userName.getRole().equalsIgnoreCase("Manager") || userName.getRole().equalsIgnoreCase("Admin")) {
				if (globalTechnicianName != null){
					model.addObject("countPartForTech",bootStock.countPartsForTechnician(globalTechnicianName));
					model.addObject("countTonerForTech",bootStock.countTonerForTechnician(globalTechnicianName));
					model.addObject("orders", bootStock.getTonerForTechnician(globalTechnicianName));
					
					model.setViewName("bootSiteOrders");	
				}
				else if (globalCustomerName != null){
					
					model.addObject("countPartForCustomer",siteStock.countPartsForCustomer(globalCustomerName));
					model.addObject("countTonerForCustomer",siteStock.countTonerForCustomer(globalCustomerName));
					model.addObject("orders", siteStock.getTonerForCustomer(globalCustomerName));
					
					model.setViewName("stockSiteOrders");
				}
			}
			else if (userName.getRole().equalsIgnoreCase("Technician"))	{
				String localTechnician = userName.getFirstName() + " " + userName.getLastName();
				if (globalTechnicianName != null)
				{
					if (localTechnician != null){
						model.addObject("countPartForTech",bootStock.countPartsForTechnician(localTechnician));
						model.addObject("countTonerForTech",bootStock.countTonerForTechnician(localTechnician));
						model.addObject("orders", bootStock.getTonerForTechnician(localTechnician));
						
						model.setViewName("bootSiteOrdersForTechnician");	
					}
				}
				else if (globalCustomerName != null)
				{
					model.addObject("countPartForCustomer",siteStock.countPartsForCustomer(globalCustomerName));
					model.addObject("countTonerForCustomer",siteStock.countTonerForCustomer(globalCustomerName));
					model.addObject("orders", siteStock.getTonerForCustomer(globalCustomerName));
					
					model.setViewName("stockSiteOrdersForTechnician");
				}			
			}else if (userName.getRole().equalsIgnoreCase("User"))	{
				String localTechnician = userName.getFirstName() + " " + userName.getLastName();
				if (globalTechnicianName != null)
				{
					if (localTechnician != null){
						model.addObject("countPartForTech",bootStock.countPartsForTechnician(localTechnician));
						model.addObject("countTonerForTech",bootStock.countTonerForTechnician(localTechnician));
						model.addObject("orders", bootStock.getTonerForTechnician(localTechnician));
						
						model.setViewName("bootSiteOrdersForUser");	
					}
				}
				else if (globalCustomerName != null)
				{
					model.addObject("countPartForCustomer",siteStock.countPartsForCustomer(globalCustomerName));
					model.addObject("countTonerForCustomer",siteStock.countTonerForCustomer(globalCustomerName));
					model.addObject("orders", siteStock.getTonerForCustomer(globalCustomerName));
					
					model.setViewName("stockSiteOrdersForUser");
				}			
			}
			else{
				model.setViewName("login");
			}
			return model;
		}	
		

}
	
	

