package com.demo.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

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
	@Autowired
	private HttpSession session;
	private String retMessage = null;
	
	@RequestMapping(value="addClient",method=RequestMethod.GET)
	public ModelAndView loadAddClient() {
		
		ModelAndView model = new ModelAndView("addClient");
		model.addObject("saveClient", new ClientBean());
		model.setViewName("addClient");
		
		return model;
	}
	@RequestMapping(value="saveClient",method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView addClient(@ModelAttribute("saveClient")Client client)
	{
		retMessage =clientServiceInt.saveClient(client);
		ModelAndView model = new ModelAndView();
		//model.addObject("client",retMessage);
		model.setViewName("redirect:home");
		return model;
	}
	
	@RequestMapping(value="clientInformation",method=RequestMethod.GET)
	public ModelAndView loadClientInformation() {
		
		ModelAndView model = new ModelAndView("clientInformation.jsp");
		model.setViewName("clientInformation");
		
		return model;
	}
	@RequestMapping(value="searchClient")
	public ModelAndView searchClient(@RequestParam("clientName") String clientName,@ModelAttribute Product product) {
		ModelAndView model = new ModelAndView();
		
		model.addObject("productList", productServiceInt.getProductListByClientName(clientName));
		model.setViewName("clientInformation");
		
		return model;
	}
	@RequestMapping(value="searchClientforProduct")
	public ModelAndView searchClientforProduct(@RequestParam("clientName") String clientName,@ModelAttribute Client client) {
		ModelAndView model = new ModelAndView();
		client = clientServiceInt.getClientByClientName(clientName);
		session.setAttribute("client", client);
		model.addObject("client", client);
		model.setViewName("addProduct");
		
		return model;
	}
}
