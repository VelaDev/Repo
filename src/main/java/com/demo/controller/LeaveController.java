package com.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.demo.model.Employee;
import com.demo.model.Leave;
import com.demo.service.LeaveInt;
import com.demo.service.OrdersServiceInt;

@Controller
public class LeaveController {

	@Autowired
	private OrdersServiceInt ordersServiceInt;
	@Autowired
	private HttpSession session;
	@Autowired
	private LeaveInt leaveInt;
	private ModelAndView model = null;
	private String retMessage = null;
	private Employee userName = null;

	@RequestMapping(value={"leave", "requestLeave"}, method = RequestMethod.GET)
	public ModelAndView loadLeave() {
		
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		
		if (userName != null) {
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			if(userName.getRole().equalsIgnoreCase("Manager")||userName.getRole().equalsIgnoreCase("Admin")){
				
				model.setViewName("requestLeave");
				
			}else if(userName.getRole().equalsIgnoreCase("Technician")){
				
				model.setViewName("leave");
			}
						
		} else {
			model.setViewName("login");
		}

		return model;
	}
	

	@RequestMapping(value = {"viewLeaveRequests","viewRequestedLeave" }, method = RequestMethod.GET)
	public ModelAndView loadViewLeaveRequestss() {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			if(userName.getRole().equalsIgnoreCase("Manager")||userName.getRole().equalsIgnoreCase("Admin")){
				
				model.setViewName("viewRequestedLeave");
				
			}else if(userName.getRole().equalsIgnoreCase("Technician")){
				
					model.setViewName("viewLeaveRequests");
				}
			
			}
			else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value ={"updateLeave", "updateMakeLeave"}, method = RequestMethod.GET)
	public ModelAndView loadUpdateLeave(@ModelAttribute("updateLeave")Leave leave) {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("restMessage",leaveInt.updateLeaveRequest(leave));			
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));			
			if(userName.getRole().equalsIgnoreCase("Manager")||userName.getRole().equalsIgnoreCase("Admin")){
				
				model.setViewName("updateMakeLeave");
				
			}else if(userName.getRole().equalsIgnoreCase("Technician")){
				
					model.setViewName("updateLeave");
				}
			
			}
			else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "makeLeave",method=RequestMethod.POST)
	public ModelAndView submitLeave(@ModelAttribute("makeLeave")Leave leave) {
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			
			model.addObject("retMessage", leaveInt.leaveRequest(leave));
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			if(userName.getRole().equalsIgnoreCase("Manager")||userName.getRole().equalsIgnoreCase("Admin")){
				
				model.setViewName("requestLeave");
				
			}else if(userName.getRole().equalsIgnoreCase("Technician")){
				
				model.setViewName("leave");
			}
		} else {
			model.setViewName("login");
		}
		return model;
	}
}
