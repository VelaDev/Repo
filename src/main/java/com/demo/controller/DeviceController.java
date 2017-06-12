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

import com.demo.bean.DeviceBean;
import com.demo.model.Accessories;
import com.demo.model.Device;
import com.demo.model.Employee;
import com.demo.service.AccessoriesInt;
import com.demo.service.CustomerContactDetailsServiceInt;
import com.demo.service.CustomerServiceInt;
import com.demo.service.EmployeeServiceInt;
import com.demo.service.DeviceServiceInt;
import com.demo.service.OrdersServiceInt;
import com.demo.service.TicketsServiceInt;


@Controller
public class DeviceController {
	
	@Autowired
	private OrdersServiceInt ordersServiceInt;
	@Autowired
	private DeviceServiceInt deviceServiceInt;
    @Autowired
    private CustomerServiceInt customerServiceInt;
    @Autowired
	private EmployeeServiceInt employeeServiceInt;
    @Autowired
    private AccessoriesInt accessoriesInt;
    @Autowired
	private TicketsServiceInt ticketsServiceInt;
    @Autowired
    private CustomerContactDetailsServiceInt contactDetailsServiceInt;
    
    @Autowired 
    HttpSession session;
    
    private List<Accessories> accessories=null;
    private Device device = null; 
    private	ModelAndView model = null;
    private Employee userName = null;
    private String retMessage = null;
	
	@RequestMapping(value="addProduct", method=RequestMethod.GET)
	public ModelAndView loadSaveProduct()
	{
	    model = new ModelAndView();
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
		
			model.addObject("saveProduct", new DeviceBean());
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("addProduct");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping(value="saveProduct", method=RequestMethod.POST)
	public ModelAndView saveProduct(@ModelAttribute("saveProduct")DeviceBean deviceBean){
		String addDevice ="addDevice";
		String customerName = deviceBean.getCustomerName();
		model = new ModelAndView();
		 userName = (Employee) session.getAttribute("loggedInUser");
			if(userName != null){
				model.addObject("customer", customerServiceInt.getClientByClientName(customerName));
				retMessage =deviceServiceInt.prepareDeviceData(deviceBean);
		        model.addObject("retMessage", retMessage);
		        model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
		        model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
		        model.addObject("customerName", customerName);
		        model.addObject("addDevice", addDevice);
		        model.setViewName("confirmations");
			}
			else{
				model.setViewName("login");
			}
		return model;
	}
	
	@RequestMapping(value = {"showProducts"})
    public ModelAndView showProducts() {
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
		
			model.addObject("productList", deviceServiceInt.getDeviceList());
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("showProducts");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
       
    } 
	@RequestMapping(value="detailedProduct")
	public ModelAndView detailedProduct(@RequestParam("serialNumber")String serialNumber,@ModelAttribute Accessories accessory){
	   model = new ModelAndView();
	   userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			
			accessories = accessoriesInt.getAccessoriesByDeviceSerial(serialNumber);
			/*for(Accessories devices:accessories){
				device = devices.getDevice();
				break;
			}*/
	        model.addObject("accessories", accessories);
	        model.addObject("device",deviceServiceInt.getDeviceBySerialNumber(serialNumber) );
	        model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
	        model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
	        model.setViewName("detailedProduct");
	   }else{
		   model.setViewName("login");
	   }
	   return model;
	}
	@RequestMapping(value="searchSerialNumber")
	public ModelAndView searchClientforProduct(@RequestParam("serialNumber") String serialNumber,@ModelAttribute Device device) {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
		device = deviceServiceInt.getDeviceBySerialNumber(serialNumber);
		
		if(device != null){
			
			model.addObject("technicians",employeeServiceInt.getAllTechnicians());
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("product", device);
		}
		else{
			model.addObject("product", null);
		}
		
		model.setViewName("ticket");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="updateDevice",method=RequestMethod.GET)
	public ModelAndView updateDevice()
	{
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			model.addObject("updateDevice", new DeviceBean());
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
		    model.setViewName("updateDevice");
		}
		else{
			model.setViewName("login");
		}
		return model;
		
	}
	@RequestMapping(value="searchDevice",method=RequestMethod.GET)
	public ModelAndView searchDevice()
	{
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			model.addObject("deviceList", deviceServiceInt.getDeviceList());
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("searchDevice");
		}
		else{
			model.setViewName("login");
		}
		return model;
		
	}
	@RequestMapping(value="searchDeviceSerialNumber")
	public ModelAndView searchDeviceBySerialNo(@RequestParam("serialNumber") String serialNumber,Device device,DeviceBean deviceBean){
		model= new ModelAndView();
		
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
		
		     device = deviceServiceInt.getDeviceBySerialNumber(serialNumber);
		     deviceBean = deviceServiceInt.getAccessoriesForUpdate(serialNumber);
		     if(device != null)
				{
		    		accessories = accessoriesInt.getAccessoriesByDeviceSerial(serialNumber);
				    model.addObject("customer",contactDetailsServiceInt.contactDetails(device.getCustomerDevice().getCustomerName()));
				    model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
				    model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
				    model.addObject("productObject", device);
				    model.addObject("AccessoryObject", deviceBean);
				    model.addObject("accessories", accessories);
				}
				else{
					model.addObject("retMessage", "Device :" + serialNumber + " does not exist");
				}
				model.setViewName("updateDevice");
		
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping(value="searchDeviceBySerialNo")
	public ModelAndView searchDeviceBySerialNo1(@RequestParam("serialNumber") String serialNumber,Device device){
		model= new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
		
		device = deviceServiceInt.getDeviceBySerialNumber(serialNumber);
		if(device != null){
			accessories = accessoriesInt.getAccessoriesByDeviceSerial(serialNumber);
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("productObject", device);
		    model.addObject("accessories", accessories);
		    
		}
		else{
			model.addObject("retMessage", "Device : "+ serialNumber + " does not exist");
		    
		}
		
		model.setViewName("searchDevice");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping(value="updateProduct")
	public ModelAndView updateProduct(@ModelAttribute("updateProduct")DeviceBean deviceBean)
	{
		
		String udateDevice ="udateDevice";
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
		    deviceBean.setUpdateFlag("YES");
			retMessage = deviceServiceInt.prepareDeviceData(deviceBean);
			model.addObject("retMessage", retMessage);
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("udateDevice", udateDevice);
			 model.setViewName("confirmations");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	// search Serial Number to log ticket as user and admin/manager
	@RequestMapping(value = { "searchSerialNumberLogtickr","searchSerialNumberUserLogticket" })
		public ModelAndView searchProductForLogTicket(@RequestParam("serialNumber") String serialNumber,@ModelAttribute Device device) {
			
			model = new ModelAndView();
			//String tickets ="tickets";		
			userName = (Employee) session.getAttribute("loggedInUser");

			if (userName != null) {

				device = deviceServiceInt.getDeviceBySerialNumber(serialNumber);

				if (device != null) {

					model.addObject("technicians", employeeServiceInt.getAllTechnicians());
					model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
					model.addObject("inboxCount", ordersServiceInt.pendingOrdersCount(userName.getEmail()));
					model.addObject("product", device);
				}else {
					
					model.addObject("message", "Device does not exist.");				
				}
				if (userName.getRole().equalsIgnoreCase("Manager") || userName.getRole().equalsIgnoreCase("Admin")) {
					model.addObject("inboxCount", ordersServiceInt.pendingOrdersCount(userName.getEmail()));
					//model.addObject("tickets", tickets);
					//model.setViewName("confirmations");
					model.setViewName("logTicket");
					
				} else if (userName.getRole().equalsIgnoreCase("User")) {
					//model.addObject("tickets", tickets);
					//model.setViewName("confirm");
					model.setViewName("ticket");
				}
			}else{
				model.setViewName("login");
			}
			return model;
		}

	
	@RequestMapping(value="removeAccessory")
	public ModelAndView removeAccessory(@RequestParam("serial")String serial)
	{
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			model.addObject("retMessage",accessoriesInt.removeAccessory(serial));
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("updateDevice");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
}
