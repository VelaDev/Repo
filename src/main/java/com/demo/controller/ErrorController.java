package com.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class ErrorController {
	
	@RequestMapping(value="error",method=RequestMethod.GET)
	public ModelAndView logTicket(){
		
		ModelAndView model = new ModelAndView();
		
		return model;
	}
	@RequestMapping(value="errorParts",method=RequestMethod.GET)
	public ModelAndView errorParts(){
		
		ModelAndView model = new ModelAndView();
		
		return model;
	}

}
