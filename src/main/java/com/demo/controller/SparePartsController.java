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
	
	@RequestMapping(value="addParts", method=RequestMethod.GET)
	public ModelAndView loadSaveSpareParts()
	{
		ModelAndView model = new ModelAndView("addParts");
		model.addObject("saveSpareParts", new SparePartsBean());
		model.setViewName("addParts");
		return model;
	}
	
	@RequestMapping(value="saveSpareParts", method=RequestMethod.POST)
	public String saveSaveSpareParts(@ModelAttribute("saveSpareParts")Parts spareParts){
		String redirect ="";
		retMessage = sparePartsServeceInt.saveSpareparts(spareParts);
		redirect="redirect:home";
		
		return redirect;
	}

}
