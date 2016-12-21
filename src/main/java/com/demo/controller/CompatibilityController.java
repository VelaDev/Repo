package com.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.demo.bean.CompatibilityBean;
import com.demo.model.Compatibility;
import com.demo.model.Employee;
import com.demo.model.Spare;
import com.demo.service.CompatibilityServiceInt;


@Controller
public class CompatibilityController {

	@Autowired
	private CompatibilityServiceInt compatibilityServiceInt;
	@Autowired
	private HttpSession session = null;
	private String retMessage = null;
	private ModelAndView model = null;
	private Employee userName = null;
	
	
	@RequestMapping(value="saveCompatibility", method=RequestMethod.POST)
	public ModelAndView saveSaveSpareParts(@ModelAttribute("saveCompatibility")CompatibilityBean compatibility){
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
		
			retMessage = compatibilityServiceInt.saveCompitability(compatibility);
			model.addObject("retMessage", retMessage);
			model.setViewName("addParts");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}

}
