package com.demo.controller;


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
   /* @Autowired HttpSession session;*/
    
    private String retMessage = null;
    @Autowired
	private EmployeeServiceInt employeeServiceInt;
    
    private	ModelAndView model = null;
	
	
	@RequestMapping(value="addProduct", method=RequestMethod.GET)
	public ModelAndView loadSaveProduct()
	{
	    model = new ModelAndView("addProduct");
		model.addObject("saveProduct", new ProductBean());
		model.setViewName("addProduct");
		return model;
	}
	
	@RequestMapping(value="saveProduct", method=RequestMethod.POST)
	public ModelAndView saveProduct(@ModelAttribute("saveProduct")Product product){
		retMessage =productServiceInt.saveProduct(product);
		model = new ModelAndView();
		model.addObject("retMessage", retMessage);
		model.setViewName("addProduct");
		return model;
	}
	
	@RequestMapping(value = {"showProducts"})
    public ModelAndView showProducts() {
		
		model = new ModelAndView();
		model.addObject("productList", productServiceInt.getProductList());
		model.setViewName("showProducts");
		return model;
       
    } 
	@RequestMapping(value="detailedProduct")
	public ModelAndView detailedProduct(@RequestParam String serialNumber,@ModelAttribute Product product){
	   model = new ModelAndView();
	   product = productServiceInt.getProductBySerialNumber(serialNumber);
	   model.addObject("accessories", productServiceInt.accessories(product));
	   model.addObject("productObject", product);
	   model.setViewName("detailedProduct");
	   return model;
	}
	@RequestMapping(value="searchSerialNumber")
	public ModelAndView searchClientforProduct(@RequestParam("serialNumber") String serialNumber,@ModelAttribute Product product) {
		model = new ModelAndView();
		product = productServiceInt.getProductBySerialNumber(serialNumber);
		if(product != null){
			
			model.addObject("technicians",employeeServiceInt.getAllTechnicians());
			model.addObject("product", product);
		}
		else{
			model.addObject("product", null);
		}
		
		model.setViewName("ticket");
		
		return model;
	}
	@RequestMapping(value="updateDevice",method=RequestMethod.GET)
	public String updateDevice()
	{
		return "updateDevice";
		
	}
	@RequestMapping(value="searchDevice",method=RequestMethod.GET)
	public String searchDevice()
	{
		return "searchDevice";
		
	}
	@RequestMapping(value="searchDeviceSerialNumber")
	public ModelAndView searchDeviceBySerialNo(@RequestParam("serialNumber") String serialNumber,Product product){
		model= new ModelAndView();
		
		product = productServiceInt.getProductBySerialNumber(serialNumber);
		if(product != null)
		{
		
		    model.addObject("productObject", product);
		}
		else{
			model.addObject("retMessage", "Device :" + serialNumber + " does not exist");
		}
		model.setViewName("updateDevice");
		return model;
	}
	
	@RequestMapping(value="searchDeviceBySerialNo")
	public ModelAndView searchDeviceBySerialNo1(@RequestParam("SerialNo") String serialNumber,Product product){
		model= new ModelAndView();
		product = productServiceInt.getProductBySerialNumber(serialNumber);
		if(product != null){
			model.addObject("productObject", product);
		    model.addObject("accessories", productServiceInt.accessories(product));
		}
		else{
			model.addObject("retMessage", "Device : "+ serialNumber + " does not exist");
		    
		}
		
		model.setViewName("searchDevice");
		return model;
	}
	
	@RequestMapping(value="updateProduct")
	public ModelAndView updateProduct(@ModelAttribute("updateProduct")Product product)
	{
		model = new ModelAndView();
		retMessage = productServiceInt.updateProduct(product);
		model.addObject("retMessage", retMessage);
		model.setViewName("updateDevice");
		return model;
	}
}
