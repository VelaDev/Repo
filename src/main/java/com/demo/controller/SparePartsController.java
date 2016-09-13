package com.demo.controller;

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
	@SuppressWarnings("unused")
	private String retMessage = null;
	ModelAndView model = null;
	
	@RequestMapping(value="addParts", method=RequestMethod.GET)
	public ModelAndView loadSaveSpareParts()
	{
	    model = new ModelAndView("addParts");
		model.addObject("saveSpareParts", new SparePartsBean());
		model.setViewName("addParts");
		return model;
	}
	
	@RequestMapping(value="saveSpareParts", method=RequestMethod.POST)
	public ModelAndView saveSaveSpareParts(@ModelAttribute("saveSpareParts")Parts spareParts){
		model = new ModelAndView();
		retMessage = sparePartsServeceInt.saveSpareparts(spareParts);
		model.addObject("retMessage", retMessage);
		model.setViewName("addParts");
		return model;
	}

}
