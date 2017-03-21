package com.demo.controller;



import javax.servlet.http.HttpSession;

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
import com.demo.service.OrderDetailsInt;
import com.demo.service.SpareMasterServiceInt;
import com.demo.service.HOStockServeceInt;

@Controller
public class SparePartsController {
	
	@Autowired
	private HOStockServeceInt hOStockServeceInt;
	@Autowired
	private OrderDetailsInt orderDetailsInt;
	@Autowired
	private SpareMasterServiceInt spareMasterServiceInt;
	@Autowired
	private HttpSession session = null;
	private String retMessage = null;
	private ModelAndView model = null;
	private Employee userName = null;
	public String[] getSerials = null;
	
	@RequestMapping(value="addParts", method=RequestMethod.GET)
	public ModelAndView loadSaveSpareParts()
	{
	    model = new ModelAndView("addParts");
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			model.addObject("saveSpareParts", new SparePartsBean());
			getSerials = spareMasterServiceInt.getSerials();
			model.addObject("spareParts",getSerials);
			model.setViewName("addParts");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping(value="saveSpareParts", method=RequestMethod.POST)
	public ModelAndView saveSaveSpareParts(@ModelAttribute("saveSpareParts")HOStock spareParts){
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
		
			retMessage = hOStockServeceInt.saveSpareparts(spareParts);
			model.addObject("retMessage", retMessage);
			model.setViewName("addParts");
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
			
			model.addObject("spareParts", hOStockServeceInt.getAllSpareParts());
			model.setViewName("availableSpareParts");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	@RequestMapping(value="bootSite", method=RequestMethod.GET)
	public ModelAndView getSparePartsSite(){
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			
			model.addObject("orders",orderDetailsInt.getAllOrderDetails());
			model.setViewName("bootSite");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	@RequestMapping(value="stockSite", method=RequestMethod.GET)
	public ModelAndView getSparePartSite(){
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			
			model.addObject("orders",orderDetailsInt.getAllOrderDetails());
			model.setViewName("stockSite");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	@RequestMapping(value="searchpartNumber")
	public ModelAndView searchPartNumber(@RequestParam("partNumber") String partNumber) {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			
		model.addObject("sparePart", spareMasterServiceInt.getSpareMaster(partNumber));
		model.addObject("models", spareMasterServiceInt.getModelDevice(partNumber));
		model.setViewName("addParts");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	

}
