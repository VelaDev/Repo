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

import com.demo.bean.ClientBean;
import com.demo.model.Client;
import com.demo.model.Device;
import com.demo.service.AccessoriesInt;
import com.demo.service.ClientServiceInt;
import com.demo.service.DeviceServiceInt;




@Controller
public class ClientController {
	
	@Autowired
	private ClientServiceInt clientServiceInt;
	@Autowired
	private DeviceServiceInt deviceServiceInt;
	@Autowired
	private HttpSession session;
	@Autowired
	private AccessoriesInt accessoriesInt;
	private String retMessage = null;
	ModelAndView model = null;
	List<Device> deviceList =null;
	Client client = null;
	String userName = null;
	
	@RequestMapping(value="addClient",method=RequestMethod.GET)
	public ModelAndView loadAddClient() {
		
	    model = new ModelAndView("addClient");
	    userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
			model.addObject("saveClient", new ClientBean());
			model.setViewName("addClient");
		
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="saveClient",method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView addClient(@ModelAttribute("saveClient")Client client)
	{
		retMessage =clientServiceInt.saveClient(client);
	    model = new ModelAndView();
	    userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
		
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
	    userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
		
			model.setViewName("clientInformation");
		}else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="searchClient")
	public ModelAndView searchClient(@RequestParam("clientName") String clientName,@ModelAttribute Device Device) {
		model = new ModelAndView();
		
		userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
			deviceList = deviceServiceInt.getDeviceListByClientName(clientName);
		      for(Device dev:deviceList){
			       client = dev.getClient();
			      break;
		      }
		
		        model.addObject("deviceList",deviceList );
				model.addObject("client", client);
				model.setViewName("clientInformation");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="searchClientforProduct")
	public ModelAndView searchClientforProduct(@RequestParam("clientName") String clientName,@ModelAttribute Client client) {
		model = new ModelAndView();
		userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
		
			client = clientServiceInt.getClientByClientName(clientName);
			if(client != null){
				model.addObject("client", client);
			}
			else
			{
				model.addObject("retMessage", "Customer : " + clientName + " does not exist");
				model.addObject("client", null);
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
		userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
		
			model.addObject("updateCustomerData", new ClientBean());
			model.setViewName("updateCustomer");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	@RequestMapping(value="updateCustomerData",method=RequestMethod.POST)
	public ModelAndView updateCustomer(@ModelAttribute("updateCustomerData")Client client){
		model = new ModelAndView();
		userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
		
			retMessage =clientServiceInt.updateCustomer(client); 
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
	public ModelAndView searchCustomer(@RequestParam("clientName") String clientName,@ModelAttribute Client client) {
		model = new ModelAndView();
		userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
		
			client = clientServiceInt.getClientByClientName(clientName);
			model.addObject("client", client);
			model.setViewName("updateCustomer");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="displayCustomers",method=RequestMethod.GET)
	public ModelAndView displayCustomers(){
		model= new ModelAndView();
		userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
		
			model.addObject("customerList", clientServiceInt.getClientList());
			model.setViewName("displayCustomers");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
}
