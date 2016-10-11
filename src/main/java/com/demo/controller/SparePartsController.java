package com.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.demo.bean.SparePartsBean;
import com.demo.model.Parts;
import com.demo.service.SparePartsServeceInt;

@Controller
public class SparePartsController {
	
	@Autowired
	private SparePartsServeceInt sparePartsServeceInt;
	@Autowired
	private HttpSession session = null;
	private String retMessage = null;
	private ModelAndView model = null;
	private String userName = null;
	
	@RequestMapping(value="addParts", method=RequestMethod.GET)
	public ModelAndView loadSaveSpareParts()
	{
	    model = new ModelAndView("addParts");
	    userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
		model.addObject("saveSpareParts", new SparePartsBean());
		model.setViewName("addParts");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping(value="saveSpareParts", method=RequestMethod.POST)
	public ModelAndView saveSaveSpareParts(@ModelAttribute("saveSpareParts")Parts spareParts){
		model = new ModelAndView();
		userName = (String) session.getAttribute("loggedInUser");
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

}
