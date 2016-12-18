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

import com.demo.bean.CustomerBean;
import com.demo.model.Customer;
import com.demo.model.Device;
import com.demo.model.Employee;
import com.demo.service.AccessoriesInt;
import com.demo.service.CustomerContactDetailsServiceInt;
import com.demo.service.CustomerServiceInt;
import com.demo.service.DeviceServiceInt;




@Controller
public class CustomerController {
	
	@Autowired
	private CustomerServiceInt customerServiceInt;
	@Autowired
	private DeviceServiceInt deviceServiceInt;
	@Autowired
	private CustomerContactDetailsServiceInt contactDetailsServiceInt;
	@Autowired
	private HttpSession session;
	@Autowired
	private AccessoriesInt accessoriesInt;
	private String retMessage = null;
	ModelAndView model = null;
	List<Device> deviceList =null;
	Customer customer = null;
	Employee userName = null;
	
	@RequestMapping(value="addClient",method=RequestMethod.GET)
	public ModelAndView loadAddClient() {
		
	    model = new ModelAndView("addClient");
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			model.addObject("saveClient", new CustomerBean());
			model.setViewName("addClient");
		
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="saveClient",method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView addClient(@ModelAttribute("saveClient")CustomerBean customerBean)
	{
	    model = new ModelAndView();
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			retMessage =customerServiceInt.prepareCustomer(customerBean);
			model.addObject("retMessage",retMessage);
			model.setViewName("addClient");
		}else{
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping(value="clientInformation",method=RequestMethod.GET)
	public ModelAndView loadClientInformation() {
		
	    model = new ModelAndView();
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
		
			model.setViewName("clientInformation");
		}else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="clientInformation")
	public ModelAndView searchClient(@RequestParam("clientName") String clientName,Integer offset, Integer maxResults) {
		model = new ModelAndView();
		
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			deviceList = deviceServiceInt.getAllEmployees(offset, maxResults, clientName);
		      for(Device dev:deviceList){
			       customer = dev.getCustomer();
			      break;
		      }
		
		        model.addObject("clientInformation",deviceList );
				model.addObject("customer", customer);
				model.setViewName("clientInformation");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="searchClientforProduct")
	public ModelAndView searchClientforProduct(@RequestParam("clientName") String clientName,@ModelAttribute Customer customer) {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
		
			customer = customerServiceInt.getClientByClientName(clientName);
			if(customer != null){
				model.addObject("customer", customer);
			}
			else
			{
				model.addObject("retMessage", "Customer : " + clientName + " does not exist");
				model.addObject("customer", null);
			}
		
			model.setViewName("addProduct");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="updateCustomer",method=RequestMethod.GET)
	public ModelAndView loadUpdateCustomerPage(){
		
		model = new ModelAndView("updateCustomer");
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
		
			model.addObject("updateCustomerData", new CustomerBean());
			model.setViewName("updateCustomer");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	@RequestMapping(value="updateCustomerData",method=RequestMethod.POST)
	public ModelAndView updateCustomer(@ModelAttribute("updateCustomerData")CustomerBean customerBean){
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
		
			retMessage =customerServiceInt.prepareCustomer(customerBean); 
			model.addObject("retMessage", retMessage);
			model.setViewName("updateCustomer");
		}
		else
		{
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping(value="searchCustomer")
	public ModelAndView searchCustomer(@RequestParam("customerName") String customerName,@ModelAttribute Customer customer) {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
		
			//customer = customerServiceInt.getClientByClientName(customerName);
			
			model.addObject("customer", customerServiceInt.contactDetails(customerName));
			model.addObject("customerDetails", contactDetailsServiceInt.contactDetails(customerName));
			model.setViewName("updateCustomer");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="displayCustomers",method=RequestMethod.GET)
	public ModelAndView displayCustomers(Integer offset,Integer maxResults){
		model= new ModelAndView();
		Integer count =0;
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
		
			count = customerServiceInt.count();
			model.addObject("count",count);
			model.addObject("offset", offset);
			model.addObject("displayCustomers", customerServiceInt.getClientList());
			model.setViewName("displayCustomers");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
}
