package com.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.demo.bean.CompatibilityBean;
import com.demo.bean.SparePartsBean;
import com.demo.model.Employee;
import com.demo.model.Spare;
import com.demo.service.OrderDetailsInt;
import com.demo.service.SparePartsServeceInt;

@Controller
public class SparePartsController {
	
	@Autowired
	private SparePartsServeceInt sparePartsServeceInt;
	@Autowired
	private OrderDetailsInt orderDetailsInt;
	@Autowired
	private HttpSession session = null;
	private String retMessage = null;
	private ModelAndView model = null;
	private Employee userName = null;
	
	@RequestMapping(value="addParts", method=RequestMethod.GET)
	public ModelAndView loadSaveSpareParts()
	{
	    model = new ModelAndView("addParts");
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
		
			model.addObject("saveSpareParts", new SparePartsBean());
			model.addObject("saveSpareParts", new CompatibilityBean());
			model.setViewName("addParts");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping(value="saveSpareParts", method=RequestMethod.POST)
	public ModelAndView saveSaveSpareParts(@ModelAttribute("saveSpareParts")Spare spareParts){
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
		
			retMessage = sparePartsServeceInt.saveSpareparts(spareParts);
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
			
			model.addObject("spareParts", sparePartsServeceInt.getAllSpareParts());
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

}
