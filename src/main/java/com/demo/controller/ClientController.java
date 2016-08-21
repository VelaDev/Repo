package com.demo.controller;


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
import com.demo.model.Product;
import com.demo.service.ClientServiceInt;
import com.demo.service.ProductServiceInt;




@Controller
public class ClientController {
	
	@Autowired
	private ClientServiceInt clientServiceInt;
	@Autowired
	private ProductServiceInt productServiceInt;
	/*@Autowired
	private HttpSession session;*/
	@SuppressWarnings("unused")
	private String retMessage = null;
	ModelAndView model = null;
	
	@RequestMapping(value="addClient",method=RequestMethod.GET)
	public ModelAndView loadAddClient() {
		
	    model = new ModelAndView("addClient");
		model.addObject("saveClient", new ClientBean());
		model.setViewName("addClient");
		
		return model;
	}
	@RequestMapping(value="saveClient",method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView addClient(@ModelAttribute("saveClient")Client client)
	{
		retMessage =clientServiceInt.saveClient(client);
	    model = new ModelAndView();
		//model.addObject("client",retMessage);
		model.setViewName("redirect:home");
		return model;
	}
	
	@RequestMapping(value="clientInformation",method=RequestMethod.GET)
	public ModelAndView loadClientInformation() {
		
	    model = new ModelAndView("clientInformation.jsp");
		model.setViewName("clientInformation");
		
		return model;
	}
	@RequestMapping(value="searchClient")
	public ModelAndView searchClient(@RequestParam("clientName") String clientName,@ModelAttribute Product product) {
		model = new ModelAndView();
		
		model.addObject("productList", productServiceInt.getProductListByClientName(clientName));
		model.setViewName("clientInformation");
		
		return model;
	}
	@RequestMapping(value="searchClientforProduct")
	public ModelAndView searchClientforProduct(@RequestParam("clientName") String clientName,@ModelAttribute Client client) {
		model = new ModelAndView();
		client = clientServiceInt.getClientByClientName(clientName);
		//session.setAttribute("client", client);
		model.addObject("client", client);
		model.setViewName("addProduct");
		
		return model;
	}
	@RequestMapping(value="updateCustomer",method=RequestMethod.GET)
	public ModelAndView loadUpdateCustomerPage(){
		
		model = new ModelAndView("updateCustomer");
		model.addObject("updateCustomerData", new ClientBean());
		model.setViewName("updateCustomer");
		return model;
	}
	@RequestMapping(value="updateCustomerData",method=RequestMethod.POST)
	public ModelAndView updateCustomer(@ModelAttribute("updateCustomerData")Client client){
		model = new ModelAndView();
		retMessage =clientServiceInt.updateCustomer(client); 
		return model;
	}
	
	@RequestMapping(value="searchCustomer")
	public ModelAndView searchCustomer(@RequestParam("clientName") String clientName,@ModelAttribute Client client) {
		model = new ModelAndView();
		client = clientServiceInt.getClientByClientName(clientName);
		//session.setAttribute("client", client);
		model.addObject("client", client);
		model.setViewName("updateCustomer");
		
		return model;
	}
}
