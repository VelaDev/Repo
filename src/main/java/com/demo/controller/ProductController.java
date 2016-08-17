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
    @Autowired HttpSession session;
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
	public String saveProduct(@ModelAttribute("saveProduct")Product product){
		productServiceInt.saveProduct(product);
		return "redirect:home";
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
	   
	   return new ModelAndView("detailedProduct", "productObject", product);
	}
	@RequestMapping(value="searchSerialNumber")
	public ModelAndView searchClientforProduct(@RequestParam("serialNumber") String serialNumber,@ModelAttribute Product product) {
		model = new ModelAndView();
		product = productServiceInt.getProductBySerialNumber(serialNumber);
		if(product != null){
			//session.setAttribute("serialNumber", product.getSerialNumber());
			model.addObject("technicians",employeeServiceInt.getAllTechnicians());
			model.addObject("product", product);
		}
		else{
			model.addObject("product", null);
		}
		
		model.setViewName("ticket");
		
		return model;
	}
}
