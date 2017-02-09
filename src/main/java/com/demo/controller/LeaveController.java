package com.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.demo.model.Employee;


@Controller
public class LeaveController {
	
	@Autowired
	private HttpSession session;
	private ModelAndView model = null;
	private String retMessage =null;
	private Employee userName = null;
	
	
	@RequestMapping(value="leave",method=RequestMethod.GET)
	public ModelAndView loadLeave(){
		
		model = new ModelAndView("leave");
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			
		
			model.setViewName("leave");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}

}
