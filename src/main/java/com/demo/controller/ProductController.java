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
import com.demo.model.Device;
import com.demo.service.ClientServiceInt;
import com.demo.service.EmployeeServiceInt;
import com.demo.service.DeviceServiceInt;


@Controller
public class ProductController {
	
	@Autowired
	private DeviceServiceInt deviceServiceInt;
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
	public ModelAndView saveProduct(@ModelAttribute("saveProduct")Device device){
		
		model = new ModelAndView();
		 userName = (String) session.getAttribute("loggedInUser");
			if(userName != null){
				retMessage =deviceServiceInt.saveDevice(device);
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
		model.addObject("productList", deviceServiceInt.getDeviceList());
		model.setViewName("showProducts");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
       
    } 
	@RequestMapping(value="detailedProduct")
	public ModelAndView detailedProduct(@RequestParam String serialNumber,@ModelAttribute Device device){
	   model = new ModelAndView();
	   userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
	   device = deviceServiceInt.getDeviceBySerialNumber(serialNumber);
	   model.addObject("accessories", deviceServiceInt.accessories(device));
	   model.addObject("productObject", device);
	   model.setViewName("detailedProduct");
	   }else{
		   model.setViewName("login");
	   }
	   return model;
	}
	@RequestMapping(value="searchSerialNumber")
	public ModelAndView searchClientforProduct(@RequestParam("serialNumber") String serialNumber,@ModelAttribute Device device) {
		model = new ModelAndView();
		userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
		device = deviceServiceInt.getDeviceBySerialNumber(serialNumber);
		if(device != null){
			
			model.addObject("technicians",employeeServiceInt.getAllTechnicians());
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
	public ModelAndView searchDeviceBySerialNo(@RequestParam("serialNumber") String serialNumber,Device device){
		model= new ModelAndView();
		
		userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
		
		device = deviceServiceInt.getDeviceBySerialNumber(serialNumber);
		if(device != null)
		{
		
		    model.addObject("productObject", device);
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
	public ModelAndView searchDeviceBySerialNo1(@RequestParam("SerialNo") String serialNumber,Device device){
		model= new ModelAndView();
		userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
		
		device = deviceServiceInt.getDeviceBySerialNumber(serialNumber);
		if(device != null){
			model.addObject("productObject", device);
		    model.addObject("accessories", deviceServiceInt.accessories(device));
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
	public ModelAndView updateProduct(@ModelAttribute("updateProduct")Device device)
	{
		model = new ModelAndView();
		userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
		retMessage = deviceServiceInt.updateDevice(device);
		model.addObject("retMessage", retMessage);
		model.setViewName("updateDevice");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
}
