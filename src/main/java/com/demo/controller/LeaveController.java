package com.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.demo.bean.CustomerBean;
import com.demo.bean.LeaveBean;
import com.demo.model.Employee;
import com.demo.model.Leave;
import com.demo.service.EmployeeServiceInt;
import com.demo.service.LeaveInt;
import com.demo.service.OrdersServiceInt;
import com.demo.service.TicketsServiceInt;

@Controller
public class LeaveController {

	@Autowired
	private OrdersServiceInt ordersServiceInt;
	@Autowired
	private HttpSession session;
	@Autowired
	private LeaveInt leaveInt;
	@Autowired
	private TicketsServiceInt ticketsServiceInt;
	@Autowired
	private EmployeeServiceInt employeeServiceInt;
	private ModelAndView model = null;
	private String retMessage = null;
	private Employee userName = null;

	@RequestMapping(value = { "leave", "requestLeave", "userMakeLeave" }, method = RequestMethod.GET)
	public ModelAndView loadLeave() {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");

		if (userName != null) {
			
			model.addObject("inboxCount", ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
			
			model.addObject("makeLeave", new LeaveBean());
			
			if (userName.getRole().equalsIgnoreCase("Manager") || userName.getRole().equalsIgnoreCase("Admin")) {
				model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
				model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));			
				model.addObject("technicians",employeeServiceInt.getAllTechnicians());
				model.setViewName("requestLeave");

			} else if (userName.getRole().equalsIgnoreCase("Technician")) {
				model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
				model.addObject("inboxCount",ordersServiceInt.technicianOrdersCount(userName.getEmail()));				
				model.setViewName("leave");
			
			} else if (userName.getRole().equalsIgnoreCase("User")) {
				model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
				model.addObject("inboxCount",ordersServiceInt.technicianOrdersCount(userName.getEmail()));
				model.addObject("technicians",employeeServiceInt.getAllTechnicians());				
				model.setViewName("userMakeLeave");
			}

		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = { "viewLeaveRequests", "viewRequestedLeave" , "viewRequestedUserLeave" }, method = RequestMethod.GET)
	public ModelAndView loadViewLeaveRequestss() {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("inboxCount", ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));			
			if (userName.getRole().equalsIgnoreCase("Manager") || userName.getRole().equalsIgnoreCase("Admin")) {
				model.addObject("leaveList", leaveInt.leaveRequests());
				model.setViewName("viewRequestedLeave");

			} else if (userName.getRole().equalsIgnoreCase("Technician")) {
				model.addObject("inboxCount",ordersServiceInt.technicianOrdersCount(userName.getEmail()));
				model.addObject("leaveList",leaveInt.leaveRequests(userName.getEmail()));
				model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
				model.setViewName("viewLeaveRequests");
				
			} else if (userName.getRole().equalsIgnoreCase("User")) {
				model.addObject("inboxCount",ordersServiceInt.technicianOrdersCount(userName.getEmail()));
				model.addObject("leaveList",leaveInt.leaveRequests(userName.getEmail()));
				model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
				model.setViewName("viewRequestedUserLeave");
			}

		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = { "updateLeave", "updateMakeLeave" , "updateUserMakeLeave" }, method = RequestMethod.GET)
	public ModelAndView loadUpdateLeave(@RequestParam("leaveID") int leaveID,
			@ModelAttribute("updateLeave") Leave leave) {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));			
			model.addObject("updateLeave", new LeaveBean());
			if (userName.getRole().equalsIgnoreCase("Manager") || userName.getRole().equalsIgnoreCase("Admin")) {

				model.addObject("leave", leaveInt.getLeave(leaveID));
				model.setViewName("updateMakeLeave");

			} else if (userName.getRole().equalsIgnoreCase("Technician")) {
				model.addObject("inboxCount",ordersServiceInt.technicianOrdersCount(userName.getEmail()));
				model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
				model.addObject("leave", leaveInt.getLeave(leaveID));
				model.setViewName("updateLeave");
				
			} else if (userName.getRole().equalsIgnoreCase("User")) {
				model.addObject("inboxCount",ordersServiceInt.technicianOrdersCount(userName.getEmail()));
				model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
				model.addObject("leave", leaveInt.getLeave(leaveID));
				model.setViewName("updateUserMakeLeave");
			}

		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = {"makeLeave","userMakeLeave"}, method = RequestMethod.POST)
	public ModelAndView submitLeave(@ModelAttribute("makeLeave") LeaveBean leave) {
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			retMessage = leaveInt.leaveRequest(leave);
			if(retMessage.startsWith("K")){
				String retErrorMessage = retMessage;
				model.addObject("retErrorMessage",retErrorMessage);
			}else{
				model.addObject("retMessage", retMessage);
			}
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));						
			model.addObject("inboxCount", ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			if (userName.getRole().equalsIgnoreCase("Manager") || userName.getRole().equalsIgnoreCase("Admin")) {

				model.setViewName("requestLeave");

			} else if (userName.getRole().equalsIgnoreCase("Technician")) {

				model.setViewName("leave");
				
			} else if (userName.getRole().equalsIgnoreCase("User")) {

				model.setViewName("userMakeLeave");
			}
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping(value = { "updateLeave", "updateMakeLeave" , "updateUserMakeLeave" }, method = RequestMethod.POST)
	public ModelAndView updateLeave(@ModelAttribute("updateLeave") LeaveBean leave) {
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			retMessage = leaveInt.updateLeaveRequest(leave);
			model.addObject("inboxCount", ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));			
			if (userName.getRole().equalsIgnoreCase("Manager")	|| userName.getRole().equalsIgnoreCase("Admin")) {
				
				model.addObject("retMessage", retMessage);
				model.setViewName("updateMakeLeave");

			} else if (userName.getRole().equalsIgnoreCase("Technician")) {

				model.addObject("retMessage", retMessage);
				model.setViewName("updateLeave");
				
			} else if (userName.getRole().equalsIgnoreCase("User")) {

				model.addObject("retMessage", retMessage);
				model.setViewName("updateUserMakeLeave");
			}
		} else {
			model.setViewName("login");
		}
		return model;
	}
}
