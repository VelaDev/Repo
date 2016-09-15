package com.demo.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.demo.bean.ProductBean;
import com.demo.model.Product;
import com.demo.service.ClientServiceInt;
import com.demo.service.EmployeeServiceInt;
import com.demo.service.ProductServiceInt;


@Controller
public class ProductController {
	
	@Autowired
	private ProductServiceInt productServiceInt;
    @Autowired
    private ClientServiceInt clientServiceInt;
   @Autowired 
   HttpSession session;
    
    private String retMessage = null;
    @Autowired
	private EmployeeServiceInt employeeServiceInt;
    
    private	ModelAndView model = null;
    private String userName = null;
	
	
	@RequestMapping(value="addProduct", method=RequestMethod.GET)
	public ModelAndView loadSaveProduct()
	{
	    model = new ModelAndView();
	    userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
		model.addObject("saveProduct", new ProductBean());
		model.setViewName("addProduct");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping(value="saveProduct", method=RequestMethod.POST)
	public ModelAndView saveProduct(@ModelAttribute("saveProduct")Product product){
		
		model = new ModelAndView();
		 userName = (String) session.getAttribute("loggedInUser");
			if(userName != null){
				retMessage =productServiceInt.saveProduct(product);
		model.addObject("retMessage", retMessage);
		model.setViewName("addProduct");
			}
			else{
				model.setViewName("login");
			}
		return model;
	}
	
	@RequestMapping(value = {"showProducts"})
    public ModelAndView showProducts() {
		
		model = new ModelAndView();
		userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
		model.addObject("productList", productServiceInt.getProductList());
		model.setViewName("showProducts");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
       
    } 
	@RequestMapping(value="detailedProduct")
	public ModelAndView detailedProduct(@RequestParam String serialNumber,@ModelAttribute Product product){
	   model = new ModelAndView();
	   userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
	   product = productServiceInt.getProductBySerialNumber(serialNumber);
	   model.addObject("accessories", productServiceInt.accessories(product));
	   model.addObject("productObject", product);
	   model.setViewName("detailedProduct");
	   }else{
		   model.setViewName("login");
	   }
	   return model;
	}
	@RequestMapping(value="searchSerialNumber")
	public ModelAndView searchClientforProduct(@RequestParam("serialNumber") String serialNumber,@ModelAttribute Product product) {
		model = new ModelAndView();
		userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
		product = productServiceInt.getProductBySerialNumber(serialNumber);
		if(product != null){
			
			model.addObject("technicians",employeeServiceInt.getAllTechnicians());
			model.addObject("product", product);
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
		userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
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
		userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
			model.setViewName("searchDevice");
		}
		else{
			model.setViewName("login");
		}
		return model;
		
	}
	@RequestMapping(value="searchDeviceSerialNumber")
	public ModelAndView searchDeviceBySerialNo(@RequestParam("serialNumber") String serialNumber,Product product){
		model= new ModelAndView();
		
		userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
		
		product = productServiceInt.getProductBySerialNumber(serialNumber);
		if(product != null)
		{
		
		    model.addObject("productObject", product);
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
	public ModelAndView searchDeviceBySerialNo1(@RequestParam("SerialNo") String serialNumber,Product product){
		model= new ModelAndView();
		userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
		
		product = productServiceInt.getProductBySerialNumber(serialNumber);
		if(product != null){
			model.addObject("productObject", product);
		    model.addObject("accessories", productServiceInt.accessories(product));
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
	public ModelAndView updateProduct(@ModelAttribute("updateProduct")Product product)
	{
		model = new ModelAndView();
		userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
		retMessage = productServiceInt.updateProduct(product);
		model.addObject("retMessage", retMessage);
		model.setViewName("updateDevice");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
}
